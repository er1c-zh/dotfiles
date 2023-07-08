#!/bin/sh

curl https://api.openai.com/v1/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
  "model": "text-davinci-003",
  "prompt": "Split this into grammatical structure :\n\n'"$1"'",
  "temperature": 0,
  "max_tokens": 600,
  "top_p": 1,
  "frequency_penalty": 0,
  "presence_penalty": 0
}'

