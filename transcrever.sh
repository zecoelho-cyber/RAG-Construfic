#!/bin/bash
# ==============================================
# Transcritor Whisper — Construfic
# Uso: bash transcrever.sh "caminho/do/audio.m4a"
# ==============================================

AUDIO_FILE="$1"
API_KEY="OPENAI_API_KEY_AQUI"
LANGUAGE="pt"
PROMPT="Reunião sobre mentoria de TI e IA na Construfic, loja de materiais de construção em Avaré SP. Participantes: Antonio Figueiredo (CEO), Zé Coelho (mentor), Daniel (TI), Diogo (gerente). Termos: ERP Santri, RAG, Data Lake, Metabase, dashboard, LGPD, WhatsApp Business, NF-e, chatbot, embeddings."
MAX_SIZE=24000000  # 24MB em bytes

if [ -z "$AUDIO_FILE" ]; then
    echo "Uso: bash transcrever.sh \"caminho/do/audio.m4a\""
    exit 1
fi

if [ ! -f "$AUDIO_FILE" ]; then
    echo "Erro: Arquivo não encontrado: $AUDIO_FILE"
    exit 1
fi

# Nome base para output
BASENAME=$(basename "$AUDIO_FILE" | sed 's/\.[^.]*$//')
OUTPUT_DIR=$(dirname "$AUDIO_FILE")
OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}_transcricao.txt"

# Verificar tamanho
FILE_SIZE=$(stat -f%z "$AUDIO_FILE" 2>/dev/null || stat -c%s "$AUDIO_FILE" 2>/dev/null)
FILE_SIZE_MB=$((FILE_SIZE / 1048576))

echo "========================================"
echo "  Transcritor Whisper — Construfic"
echo "========================================"
echo "Arquivo: $AUDIO_FILE"
echo "Tamanho: ${FILE_SIZE_MB}MB"
echo ""

if [ "$FILE_SIZE" -le "$MAX_SIZE" ]; then
    # Arquivo pequeno — transcrever direto
    echo "Transcrevendo..."
    RESULT=$(curl -s -X POST "https://api.openai.com/v1/audio/transcriptions" \
        -H "Authorization: Bearer $API_KEY" \
        -F "file=@$AUDIO_FILE" \
        -F "model=whisper-1" \
        -F "language=$LANGUAGE" \
        -F "response_format=text" \
        -F "prompt=$PROMPT")

    echo "$RESULT" > "$OUTPUT_FILE"
else
    # Arquivo grande — dividir e transcrever
    echo "Arquivo acima de 24MB. Dividindo em partes..."

    # Verificar ffmpeg
    if ! command -v ffmpeg &> /dev/null; then
        echo "Erro: ffmpeg não está instalado."
        echo "Instale com: brew install ffmpeg"
        exit 1
    fi

    # Obter duração
    DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$AUDIO_FILE" 2>/dev/null)
    DURATION_INT=${DURATION%.*}
    DURATION_MIN=$((DURATION_INT / 60))
    echo "Duração: ${DURATION_MIN} minutos"

    # Calcular chunks (cada ~20min para ficar seguro)
    CHUNK_SECS=1200
    NUM_CHUNKS=$(( (DURATION_INT + CHUNK_SECS - 1) / CHUNK_SECS ))
    echo "Dividindo em $NUM_CHUNKS partes de ~20 minutos..."
    echo ""

    TMPDIR=$(mktemp -d)
    PREV_TEXT=""

    for ((i=0; i<NUM_CHUNKS; i++)); do
        START=$((i * CHUNK_SECS))
        CHUNK_FILE="$TMPDIR/chunk_$(printf '%03d' $i).mp3"

        echo -n "  Parte $((i+1))/$NUM_CHUNKS: cortando... "
        ffmpeg -i "$AUDIO_FILE" -ss $START -t $CHUNK_SECS -y -b:a 64k "$CHUNK_FILE" 2>/dev/null
        CHUNK_SIZE=$(stat -f%z "$CHUNK_FILE" 2>/dev/null || stat -c%s "$CHUNK_FILE" 2>/dev/null)
        CHUNK_MB=$((CHUNK_SIZE / 1048576))
        echo -n "${CHUNK_MB}MB... transcrevendo... "

        # Usar texto anterior como contexto para continuidade
        if [ -n "$PREV_TEXT" ]; then
            CONTEXT="$PROMPT $PREV_TEXT"
        else
            CONTEXT="$PROMPT"
        fi

        RESULT=$(curl -s -X POST "https://api.openai.com/v1/audio/transcriptions" \
            -H "Authorization: Bearer $API_KEY" \
            -F "file=@$CHUNK_FILE" \
            -F "model=whisper-1" \
            -F "language=$LANGUAGE" \
            -F "response_format=text" \
            -F "prompt=$CONTEXT")

        # Verificar erro
        if echo "$RESULT" | grep -q '"error"'; then
            echo "ERRO!"
            echo "$RESULT"
            rm -rf "$TMPDIR"
            exit 1
        fi

        WORD_COUNT=$(echo "$RESULT" | wc -w | tr -d ' ')
        echo "OK ($WORD_COUNT palavras)"

        # Salvar
        if [ $i -eq 0 ]; then
            echo "$RESULT" > "$OUTPUT_FILE"
        else
            echo "" >> "$OUTPUT_FILE"
            echo "$RESULT" >> "$OUTPUT_FILE"
        fi

        # Guardar últimas 200 chars para contexto
        PREV_TEXT=$(echo "$RESULT" | tail -c 200)
    done

    # Limpar
    rm -rf "$TMPDIR"
fi

# Estatísticas
TOTAL_WORDS=$(wc -w < "$OUTPUT_FILE" | tr -d ' ')
echo ""
echo "========================================"
echo "  Transcrição completa!"
echo "  Palavras: $TOTAL_WORDS"
echo "  Salvo em: $OUTPUT_FILE"
echo "========================================"
