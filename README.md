# Paseo (+ OpenCode + mise) self-hosted en Coolify

Despliega [Paseo](https://paseo.sh) con el agente **OpenCode** instalado y
**mise** (version manager para Node/Python/Go). Todo en un repo para Coolify.

## Contenido
- `Dockerfile` — imagen hija de `ghcr.io/getpaseo/paseo:latest` + `opencode-ai` + mise.
- `agents/AGENTS.md` — rule global de OpenCode para gestionar runtimes con mise (se instala en `~/.config/opencode/AGENTS.md`).
- `docker-compose.yml` — construye la imagen hija y expone el daemon en `6767`.

## Despliegue en Coolify
1. Sube/crea este repo en GitHub.
2. Coolify: **+ New Resource → Docker Compose** (conectar repo).
3. Define `PASEO_PASSWORD` en Settings del recurso (o edítala en compose).
4. Deploy. Coolify construye desde el `Dockerfile`.
5. Abre `https://<tu.dominio>:6767`. Usa `PASEO_PASSWORD` al conectar el cliente/web.

## Configurar OpenCode por primera vez
```bash
docker exec -it --user paseo paseo opencode auth login
```
Las credenciales persisten en el volumen `paseo-state`.

## Gestionar toolchains con mise
```bash
# Instalar/fijar Node LTS y Python
docker exec -it --user paseo paseo mise use -g node@22 python@3.12
docker exec -it --user paseo paseo mise install
```
Los runtimes viven en `/home/paseo/.local/share/mise` (volumen `paseo-state`),
así que persisten. La rule `agents/AGENTS.md` ya instruye a OpenCode a usar
`mise x`/`mise exec` en vez de instalar binarios globales.

## Notas
- El agente corre como no-root `paseo` (uid/gid `1000:1000`).
- El código vive en el volumen `workspace` (`/workspace`).
- Cambia `PASEO_PASSWORD` antes de publicar. HTTPS en el reverse proxy de Coolify.