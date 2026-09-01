FROM ghcr.io/getpaseo/paseo:latest

USER root

RUN npm install -g opencode-ai

# Descomenta para añadir otros agentes:
# RUN npm install -g @openai/codex @anthropic-ai/claude-code opencode-ai
