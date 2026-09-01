FROM ghcr.io/getpaseo/paseo:latest

USER root

RUN npm install -g opencode-ai

# Descomenta para añadir otros agentes:
# RUN npm install -g @openai/codex @anthropic-ai/claude-code opencode-ai

# --- mise (gestor de versiones: node, python, go, ...) ---
# Método oficial actual (mise.run, binario single). Se instala en
# /usr/local/bin para que esté en el PATH de cualquier usuario (incluido el
# no-root `paseo` que corre los agentes).
RUN (command -v curl >/dev/null 2>&1 || (apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*)) \
    && curl -fsSL https://mise.run | MISE_INSTALL_PATH=/usr/local/bin/mise sh \
    && mise --version

# --- Rule global de OpenCode: gestionar toolchains con mise ---
# Se copia a ~/.config/opencode/AGENTS.md para que aplique a CUALQUIER proyecto
# que OpenCode abra en /workspace, no solo a un repo concreto.
COPY agents/AGENTS.md /tmp/opencode-agents.md
RUN mkdir -p /home/paseo/.config/opencode \
    && cp /tmp/opencode-agents.md /home/paseo/.config/opencode/AGENTS.md \
    && rm /tmp/opencode-agents.md \
    && chown -R paseo:paseo /home/paseo/.config