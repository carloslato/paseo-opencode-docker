# Toolchains (Node, Python, Go, etc.)

Gestiona TODA la instalación de lenguajes/runtimes usando **mise**. No
instales nodo/python ni sus paquetes de forma global con apt, curl, o scripts
sueltos, salvo que no exista alternativa con mise.

## Comandos básicos de mise
- `mise use node@22`          # fija la versión para el proyecto actual (crea .mise.toml)
- `mise use -g node@22`       # fija la versión global (recomendado en este entorno)
- `mise install node@22`      # instala un runtime a la versión especificada
- `mise install`              # instala todo lo que pide .mise.toml / .tool-versions
- `mise current`              # muestra versiones activas
- `mise ls`                   # lista herramientas instaladas
- `mise exec -- <comando>`    # ejecuta un comando con la toolchain activa

## Workflow recomendado
1. Si el proyecto pide Node/Python/etc., activa mise:
   `mise install` (lee .mise.toml o .tool-versions)
2. Para un proyecto nuevo, fija las versiones:
   `mise use node@22` y `mise use python@3.12`
3. Usa siempre la herramienta via mise (p. ej. `mise exec -- npm install`,
   `mise exec -- python script.py`) para garantizar que corre con la versión
   correcta.
4. Verifica antes de empezar: `mise current` y `node --version` / `python --version`.

## Notas
- mise guarda los runtimes en el volumen `paseo-state` (/home/paseo), por lo
  que persisten entre reinicios del contenedor.
- Prefiere versiones LTS estables (node: 22.x; python: 3.12+).
- No uses `sudo` ni modifiques rutas de sistema: `USER root` no aplica al agente
  (corre como `paseo`). Todo dentro de mise y del usuario `paseo`.