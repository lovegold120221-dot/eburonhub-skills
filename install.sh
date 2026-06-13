#!/usr/bin/env bash
set -euo pipefail

# ─── EburonHub Skills Installer ──────────────────────────────────────
# Installs 139+ AI agent skills from the EburonHub skills repository.
# Repository: https://github.com/lovegold120221-dot/eburonhub-skills.git
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/lovegold120221-dot/eburonhub-skills/main/install.sh | bash
#
#   # Or run locally:
#   chmod +x install.sh && ./install.sh
#
#   # Options:
#   ./install.sh --fresh          # Clean install (removes existing skills first)
#   ./install.sh --backup         # Backup existing skills before installing
#   ./install.sh --dry-run        # Show what would be installed without doing it
#   ./install.sh --with-ollama    # Also install Ollama + pull Eburon model
#   ./install.sh --ollama-only    # Only install Ollama + model (skip skills)
#   ./install.sh --help           # Show help
# ───────────────────────────────────────────────────────────────────────

# ── Colors ──
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ── Configuration ──
REPO_URL="https://github.com/lovegold120221-dot/eburonhub-skills.git"
REPO_NAME="eburonhub-skills"
TEMP_DIR="${TMPDIR:-/tmp}/$REPO_NAME-$$"
AGENTS_DIR="${HOME}/.agents/skills"
OPENCODE_DIR="${HOME}/.opencode/skills"
BACKUP_DIR="${HOME}/.agents/skills-backup-$(date +%Y%m%d-%H%M%S)"

# Eburon model configuration
EBURON_MODEL="media-pipe/eburon-sandbox-worker"
OLLAMA_INSTALL_URL="https://ollama.com/install.sh"
OPENCODE_INSTALL_URL="https://opencode.ai/install"
OPENCODE_CONFIG_DIR="${HOME}/.config/opencode"

# ── Flags ──
FRESH=false
BACKUP=false
DRY_RUN=false
VERBOSE=false
WITH_OLLAMA=false
OLLAMA_ONLY=false
SKIP_SKILLS=false

# ── Banner ──
banner() {
    echo -e "${CYAN}${BOLD}"
    echo "  ╔═══════════════════════════════════════════╗"
    echo "  ║      🎯 EburonHub Skills Installer       ║"
    echo "  ║     AI Agent Skills · 139+ Skills        ║"
    echo "  ╚═══════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ── Help ──
show_help() {
    banner
    echo -e "${BOLD}Usage:${NC}"
    echo "  curl -fsSL https://raw.githubusercontent.com/lovegold120221-dot/eburonhub-skills/main/install.sh | bash"
    echo "  ./install.sh [options]"
    echo ""
    echo -e "${BOLD}Options:${NC}"
    echo "  --fresh          Clean install — removes existing skills first"
    echo "  --backup         Backup existing skills to ~/.agents/skills-backup-YYYYMMDD-HHMMSS/"
    echo "  --dry-run        Show what would be installed without actually doing it"
    echo "  --verbose        Show detailed output"
    echo "  --with-ollama    Also install Ollama + pull Eburon model (media-pipe/eburon-sandbox-worker)"
    echo "  --ollama-only    Only install Ollama + pull Eburon model (skip skills)"
    echo "  --help           Show this help message"
    echo ""
    echo -e "${BOLD}What this installs:${NC}"
    echo "  ~/.agents/skills/     — 85+ agent skills (Azure, edge LLM, workflow, design, etc.)"
    echo "  ~/.opencode/skills/   — 18+ opencode skills (video, browser, PWA, etc.)"
    echo ""
    echo -e "${BOLD}With --with-ollama also installs:${NC}"
    echo "  ollama                — Local LLM runner (auto-detects macOS/Linux/WSL)"
    echo "  opencode              — OpenCode CLI (AI coding agent in terminal)"
    echo "  $EBURON_MODEL         — Eburon AI sandbox model (1GB, vision + tools, 256K ctx)"
    echo "  ~/.config/opencode/   — Configured to use Eburon model as default"
    echo "  eburoncode            — Launch command: 'eburoncode' anywhere to start"
    echo ""
    echo -e "${BOLD}After install:${NC}"
    echo "  Skills load automatically in your AI agents when you invoke them by name."
    echo "  Run: ls ~/.agents/skills/ && ls ~/.opencode/skills/"
}

# ── Parse Arguments ──
for arg in "$@"; do
    case "$arg" in
        --fresh)        FRESH=true ;;
        --backup)       BACKUP=true ;;
        --dry-run)      DRY_RUN=true ;;
        --verbose)      VERBOSE=true ;;
        --with-ollama)  WITH_OLLAMA=true ;;
        --ollama-only)  OLLAMA_ONLY=true; SKIP_SKILLS=true ;;
        --help)         show_help; exit 0 ;;
        *)              echo -e "${RED}Unknown option: $arg${NC}"; show_help; exit 1 ;;
    esac
done

# ── Check Dependencies ──
check_deps() {
    local missing=()
    command -v git >/dev/null 2>&1 || missing+=("git")
    command -v cp >/dev/null 2>&1 || missing+=("cp")
    command -v mkdir >/dev/null 2>&1 || missing+=("mkdir")

    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${RED}✗ Missing dependencies: ${missing[*]}${NC}"
        echo "Please install them and try again."
        exit 1
    fi
}

# ── Detect Platform ──
detect_platform() {
    local os="$(uname -s)"
    case "$os" in
        Darwin)  echo "macOS" ;;
        Linux)   echo "Linux" ;;
        MINGW*|MSYS*|CYGWIN*) echo "Windows" ;;
        *)       echo "Unknown" ;;
    esac
}

# ── Check if Ollama is Installed ──
ollama_installed() {
    command -v ollama >/dev/null 2>&1
}

# ── Check if Ollama is Running ──
ollama_running() {
    curl -s --max-time 2 http://localhost:11434/api/tags >/dev/null 2>&1
}

# ── Install Ollama ──
install_ollama() {
    local platform=$(detect_platform)

    echo ""
    echo -e "${CYAN}${BOLD}  ─── Installing Ollama ──────────────────────────${NC}"

    if ollama_installed; then
        local ollama_version=$(ollama --version 2>/dev/null || echo "unknown")
        success "Ollama already installed (version: $ollama_version)"
    else
        step "Installing Ollama on $platform..."

        if [ "$DRY_RUN" = true ]; then
            info "[DRY RUN] Would install Ollama via: curl -fsSL $OLLAMA_INSTALL_URL | sh"
            return
        fi

        case "$platform" in
            macOS|Linux)
                curl -fsSL "$OLLAMA_INSTALL_URL" | sh || {
                    warn "Ollama install script failed — trying manual install..."
                    if [ "$platform" = "macOS" ] && command -v brew >/dev/null 2>&1; then
                        brew install ollama 2>/dev/null || fail "Failed to install Ollama"
                    else
                        fail "Failed to install Ollama. Install manually: https://ollama.com/download"
                    fi
                }
                ;;
            Windows)
                warn "Windows detected — install Ollama manually: winget install Ollama.Ollama"
                ;;
            *)
                fail "Unsupported platform: $platform. Install manually: https://ollama.com/download"
                ;;
        esac

        success "Ollama installed"
    fi

    if ! ollama_running; then
        step "Starting Ollama..."
        if [ "$DRY_RUN" = true ]; then
            info "[DRY RUN] Would start Ollama service"
        elif pgrep -x ollama >/dev/null 2>&1; then
            success "Ollama is already running"
        else
            ollama serve >/dev/null 2>&1 &
            sleep 2
            ollama_running && success "Ollama started" || warn "Ollama may still be starting..."
        fi
    else
        success "Ollama is running"
    fi
}

# ── Pull Eburon Model ──
pull_eburon_model() {
    echo ""
    echo -e "${CYAN}${BOLD}  ─── Pulling Eburon Model ───────────────────────${NC}"

    local model="$EBURON_MODEL"
    step "Model: $model (1GB, vision + tools, 256K context)"

    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would run: ollama pull $model"
        return
    fi

    if ollama list 2>/dev/null | grep -q "$model"; then
        success "Model already downloaded: $model"
        return
    fi

    step "Downloading model (1GB — this may take a few minutes)..."
    if ollama pull "$model" 2>&1; then
        success "Model pulled: $model"
    else
        warn "Model pull failed. Pull it manually: ollama pull $model"
        return
    fi

    echo ""
    echo -e "  ${CYAN}Run the model:${NC}"
    echo "    ollama run $model"
    echo ""
    echo -e "  ${CYAN}Use with coding agents:${NC}"
    echo "    ollama launch claude --model $model"
    echo "    ollama launch opencode --model $model"
    echo "    ollama launch codex --model $model"
    echo "    ollama launch hermes --model $model"
}

# ── Install OpenCode CLI ──
install_opencode() {
    echo ""
    echo -e "${CYAN}${BOLD}  ─── Installing OpenCode CLI ─────────────────────${NC}"

    if command -v opencode >/dev/null 2>&1; then
        local ver=$(opencode --version 2>/dev/null || echo "unknown")
        success "OpenCode CLI already installed (version: $ver)"
    else
        step "Installing OpenCode CLI..."

        if [ "$DRY_RUN" = true ]; then
            info "[DRY RUN] Would run: curl -fsSL $OPENCODE_INSTALL_URL | bash"
            return
        fi

        curl -fsSL "$OPENCODE_INSTALL_URL" | bash || {
            warn "OpenCode install failed. Install manually:"
            info "  curl -fsSL $OPENCODE_INSTALL_URL | bash"
            return
        }
        success "OpenCode CLI installed"
    fi

    # Ensure PATH includes opencode
    if ! command -v opencode >/dev/null 2>&1; then
        export PATH="$HOME/.opencode/bin:$PATH"
        if command -v opencode >/dev/null 2>&1; then
            success "OpenCode found at ~/.opencode/bin/opencode"
        else
            warn "OpenCode not on PATH. Add to your shell config:"
            info "  export PATH=\$HOME/.opencode/bin:\$PATH"
        fi
    fi
}

# ── Configure OpenCode with Eburon Model ──
configure_opencode_eburon() {
    echo ""
    echo -e "${CYAN}${BOLD}  ─── Configuring OpenCode + Eburon Model ─────────${NC}"

    local model="$EBURON_MODEL"
    local config_file="$OPENCODE_CONFIG_DIR/opencode.json"

    step "Setting $model as default model via Ollama"

    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would configure: provider=ollama, model=$model"
        return
    fi

    if ! command -v opencode >/dev/null 2>&1; then
        warn "OpenCode CLI not found — skipping config"
        return
    fi

    # Ensure config directory exists
    mkdir -p "$OPENCODE_CONFIG_DIR"

    # Create or update config
    if [ -f "$config_file" ]; then
        # Config exists — use jq if available, otherwise python, otherwise warn
        if command -v jq >/dev/null 2>&1; then
            local tmp=$(mktemp)
            jq --arg m "$model" '.provider = "ollama" | .model = $m' "$config_file" > "$tmp" && mv "$tmp" "$config_file"
            success "Updated existing config to use: $model"
        elif command -v python3 >/dev/null 2>&1; then
            python3 -c "
import json, sys
with open('$config_file') as f:
    cfg = json.load(f)
cfg['provider'] = 'ollama'
cfg['model'] = '$model'
with open('$config_file', 'w') as f:
    json.dump(cfg, f, indent=2)
print('done')
" 2>/dev/null && success "Updated existing config to use: $model" || warn "Could not update config"
        else
            warn "Install jq for better config management. Config at: $config_file"
        fi
    else
        # Create fresh config
        if command -v python3 >/dev/null 2>&1; then
            python3 -c "
import json
cfg = {
    'provider': 'ollama',
    'model': '$model',
    'ollama': {
        'url': 'http://localhost:11434'
    }
}
with open('$config_file', 'w') as f:
    json.dump(cfg, f, indent=2)
" 2>/dev/null && success "Created config: provider=ollama, model=$model" || {
            cat > "$config_file" <<EOF
{
  "provider": "ollama",
  "model": "$model",
  "ollama": {
    "url": "http://localhost:11434"
  }
}
EOF
            success "Created config: provider=ollama, model=$model"
        }
        else
            cat > "$config_file" <<EOF
{
  "provider": "ollama",
  "model": "$model",
  "ollama": {
    "url": "http://localhost:11434"
  }
}
EOF
            success "Created config: provider=ollama, model=$model"
        fi
    fi

    echo ""
    echo -e "  ${CYAN}OpenCode is now configured to use:${NC}"
    echo -e "    ${BOLD}Provider:${NC} ollama (local)"
    echo -e "    ${BOLD}Model:${NC}    $model"
    echo -e "    ${BOLD}API:${NC}      http://localhost:11434"
    echo ""
    echo -e "  ${CYAN}Start coding:${NC}"
    echo "    cd <your-project>"
    echo "    opencode"
}

# ── Install eburoncode Command ──
install_eburoncode() {
    echo ""
    echo -e "${CYAN}${BOLD}  ─── Installing eburoncode Command ───────────────${NC}"

    local dest="$HOME/.opencode/bin/eburoncode"

    step "Installing eburoncode wrapper..."

    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would install eburoncode to: $dest"
        return
    fi

    mkdir -p "$(dirname "$dest")"

    # Write the eburoncode script from the repo copy or embed inline
    if [ -f "$TEMP_DIR/bin/eburoncode" ]; then
        cp "$TEMP_DIR/bin/eburoncode" "$dest"
    else
        # Inline fallback — minimal version
        cat > "$dest" << 'EBURONCODE_EOF'
#!/usr/bin/env bash
set -euo pipefail
EBURON_MODEL="${EBURON_MODEL:-media-pipe/eburon-sandbox-worker}"
echo -e "\033[0;36m\033[1m  ╔═══════════════════════════════════════════╗"
echo "  ║     🤖 eburoncode — Eburon AI + OpenCode ║"
echo -e "  ╚═══════════════════════════════════════════╝\033[0m"
# Ensure Ollama
curl -s --max-time 2 http://localhost:11434/api/tags >/dev/null 2>&1 || {
    ollama serve >/dev/null 2>&1 & sleep 2
}
# Ensure model
ollama list 2>/dev/null | grep -q "$EBURON_MODEL" || {
    echo "Pulling $EBURON_MODEL (1GB)..."
    ollama pull "$EBURON_MODEL"
}
# Ensure config
mkdir -p ~/.config/opencode
[ -f ~/.config/opencode/opencode.json ] || cat > ~/.config/opencode/opencode.json <<CFG
{
  "provider": "ollama",
  "model": "$EBURON_MODEL",
  "ollama": { "url": "http://localhost:11434" }
}
CFG
echo "Provider: ollama"
echo "Model:    $EBURON_MODEL"
echo ""
exec opencode "$@"
EBURONCODE_EOF
    fi

    chmod 755 "$dest"
    success "eburoncode installed to: $dest"

    # Add to PATH hint if not already
    echo ""
    echo -e "  ${CYAN}Launch Eburon-powered OpenCode TUI:${NC}"
    echo "    eburoncode"
    echo ""
    echo -e "  ${CYAN}Or with a project:${NC}"
    echo "    eburoncode /path/to/project"
    echo ""
    echo -e "  ${YELLOW}If 'eburoncode' not found, add to PATH:${NC}"
    echo "    export PATH=\$HOME/.opencode/bin:\$PATH"
}

# ── Print Step ──
step()       { echo -e "${BLUE}→${NC} $1"; }
success()    { echo -e "${GREEN}  ✓${NC} $1"; }
warn()       { echo -e "${YELLOW}  ⚠${NC} $1"; }
fail()       { echo -e "${RED}  ✗${NC} $1"; exit 1; }
info()       { [ "$VERBOSE" = true ] && echo -e "    $1" || true; }

# ── Count Skills ──
count_skills() {
    local dir="$1"
    if [ -d "$dir" ]; then
        ls -d "$dir"/*/ 2>/dev/null | wc -l | tr -d ' '
    else
        echo "0"
    fi
}

# ── Backup Existing Skills ──
backup_existing() {
    local backup_needed=false
    [ -d "$AGENTS_DIR" ] && [ "$(count_skills "$AGENTS_DIR")" -gt 0 ] && backup_needed=true
    [ -d "$OPENCODE_DIR" ] && [ "$(count_skills "$OPENCODE_DIR")" -gt 0 ] && backup_needed=true

    if [ "$backup_needed" = false ]; then
        info "No existing skills to backup"
        return
    fi

    step "Backing up existing skills to $BACKUP_DIR"
    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would backup to: $BACKUP_DIR"
        return
    fi

    mkdir -p "$BACKUP_DIR"
    [ -d "$AGENTS_DIR" ] && cp -r "$AGENTS_DIR" "$BACKUP_DIR/agents" 2>/dev/null || true
    [ -d "$OPENCODE_DIR" ] && cp -r "$OPENCODE_DIR" "$BACKUP_DIR/opencode" 2>/dev/null || true
    success "Backed up to $BACKUP_DIR"
}

# ── Clean Existing Skills ──
clean_existing() {
    if [ -d "$AGENTS_DIR" ]; then
        step "Removing existing agent skills..."
        if [ "$DRY_RUN" = true ]; then
            info "[DRY RUN] Would remove: $AGENTS_DIR"
        else
            rm -rf "$AGENTS_DIR"
            success "Cleaned $AGENTS_DIR"
        fi
    fi

    if [ -d "$OPENCODE_DIR" ]; then
        step "Removing existing opencode skills..."
        if [ "$DRY_RUN" = true ]; then
            info "[DRY RUN] Would remove: $OPENCODE_DIR"
        else
            rm -rf "$OPENCODE_DIR"
            success "Cleaned $OPENCODE_DIR"
        fi
    fi
}

# ── Clone Repository ──
clone_repo() {
    step "Cloning $REPO_URL ..."
    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would clone to: $TEMP_DIR"
        return
    fi

    rm -rf "$TEMP_DIR"
    git clone --depth 1 --quiet "$REPO_URL" "$TEMP_DIR" 2>&1 || {
        fail "Failed to clone repository. Check your internet connection."
    }
    success "Cloned repository"
}

# ── Install Skills ──
install_skills() {
    local src="$1"
    local dest="$2"
    local label="$3"

    step "Installing $label skills..."

    if [ ! -d "$src" ]; then
        warn "Source directory not found: $src — skipping"
        return
    fi

    local count_in=$(count_skills "$src")
    info "Found $count_in skills in source"

    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would copy $count_in skills to: $dest"
        return
    fi

    mkdir -p "$dest"

    local installed=0
    local skipped=0
    local failed=0

    for skill_dir in "$src"/*/; do
        [ -d "$skill_dir" ] || continue
        local skill_name=$(basename "$skill_dir")

        if [ -f "$skill_dir/SKILL.md" ]; then
            if [ -d "$dest/$skill_name" ]; then
                rm -rf "$dest/$skill_name"
            fi
            cp -r "$skill_dir" "$dest/$skill_name" && {
                installed=$((installed + 1))
                info "  Installed: $skill_name"
            } || {
                failed=$((failed + 1))
                warn "  Failed: $skill_name"
            }
        else
            skipped=$((skipped + 1))
            info "  Skipped (no SKILL.md): $skill_name"
        fi
    done

    echo -e "${GREEN}  ✓ $label: $installed installed${NC}$([ "$skipped" -gt 0 ] && echo -e "${YELLOW}, $skipped skipped${NC}")$([ "$failed" -gt 0 ] && echo -e "${RED}, $failed failed${NC}")"
}

# ── Verify Installation ──
verify_install() {
    step "Verifying installation..."
    
    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would verify installation"
        return
    fi

    local total=0
    local agent_count=$(count_skills "$AGENTS_DIR")
    local opencode_count=$(count_skills "$OPENCODE_DIR")
    total=$((agent_count + opencode_count))

    echo ""
    echo -e "  ${CYAN}~/.agents/skills/${NC}   → ${BOLD}$agent_count${NC} skills"
    echo -e "  ${CYAN}~/.opencode/skills/${NC} → ${BOLD}$opencode_count${NC} skills"
    echo -e "  ${CYAN}Total${NC}             → ${BOLD}$total${NC} skills"
    echo ""
}

# ── Show Next Steps ──
show_next_steps() {
    echo -e "${BOLD}${GREEN}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${GREEN}║   ✓ Installation Complete!               ║${NC}"
    echo -e "${BOLD}${GREEN}╚═══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BOLD}Next Steps:${NC}"
    echo "  • Skills are now available in your AI agents"
    echo "  • List all skills:  ls ~/.agents/skills/"
    echo "  • Use the orchestrator: invoke 'skill-orchestrator' in any agent"
    echo "  • Update skills:    re-run this installer"
    echo ""
    [ "$BACKUP" = true ] && echo -e "  ${YELLOW}Backup saved at: $BACKUP_DIR${NC}"
}

# ── Cleanup ──
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
        info "Cleaned up temp directory"
    fi
}
trap cleanup EXIT

# ─── Main ──────────────────────────────────────────────────────────────
main() {
    banner

    check_deps

    # Show existing counts
    local before_agents=$(count_skills "$AGENTS_DIR")
    local before_opencode=$(count_skills "$OPENCODE_DIR")
    local before_total=$((before_agents + before_opencode))

    if [ "$before_total" -gt 0 ] && [ "$SKIP_SKILLS" != true ]; then
        echo -e "${YELLOW}Existing skills found: $before_agents agent + $before_opencode opencode = $before_total total${NC}"
        echo ""
    fi

    # ── Skills Installation ──
    if [ "$SKIP_SKILLS" != true ]; then
        if [ "$FRESH" = true ]; then
            step "Fresh install mode — removing existing skills"
            $BACKUP && backup_existing
            clean_existing
        elif [ "$BACKUP" = true ]; then
            backup_existing
        fi

        clone_repo
        install_skills "$TEMP_DIR/.agents/skills" "$AGENTS_DIR" "Agent"
        install_skills "$TEMP_DIR/.opencode/skills" "$OPENCODE_DIR" "OpenCode"
        verify_install
    fi

    # ── Ollama + Eburon Model + OpenCode CLI ──
    if [ "$WITH_OLLAMA" = true ] || [ "$OLLAMA_ONLY" = true ]; then
        install_ollama
        pull_eburon_model
        install_opencode
        configure_opencode_eburon
        install_eburoncode
    fi

    if [ "$SKIP_SKILLS" != true ]; then
        show_next_steps
    else
        echo ""
        echo -e "${BOLD}${GREEN}╔═══════════════════════════════════════════╗${NC}"
        echo -e "${BOLD}${GREEN}║   ✓ Ollama + Eburon Model Ready!         ║${NC}"
        echo -e "${BOLD}${GREEN}╚═══════════════════════════════════════════╝${NC}"
    fi
}

main
