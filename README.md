# 🎯 EburonHub Skills

> **The complete AI agent skill collection — 139+ skills, one command.**

[![Skills](https://img.shields.io/badge/skills-139%2B-blue)](https://github.com/lovegold120221-dot/eburonhub-skills)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Ollama](https://img.shields.io/badge/ollama-ready-orange)](https://ollama.com)
[![OpenCode](https://img.shields.io/badge/opencode-ready-purple)](https://opencode.ai)

---

## 🚀 One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/lovegold120221-dot/eburonhub-skills/main/install.sh | bash -s -- --with-ollama
```

### What This Installs

| Component | Description |
|-----------|-------------|
| 📦 **85+ agent skills** | `~/.agents/skills/` — Azure, edge LLM, workflow, design, debugging, security |
| 📦 **18 OpenCode skills** | `~/.opencode/skills/` — video, browser, PWA, YouTube, scraping |
| 🦙 **Ollama** | Local LLM runner (auto-detects macOS/Linux/WSL) |
| 🤖 **Eburon Model** | `media-pipe/eburon-sandbox-worker` (1GB, vision + tools, 256K ctx) |
| 💻 **OpenCode CLI** | AI coding agent in your terminal |
| ⚡ **eburoncode** | One-word command to launch OpenCode with the Eburon model |

---

## ⚡ After Install — Just Type

```bash
eburoncode
```

Launches OpenCode TUI powered by the Eburon AI model. Auto-starts Ollama, pulls the model if needed, and configures everything. Works from any directory.

```bash
eburoncode /path/to/project       # Launch in specific project
eburoncode "build me a todo app"  # Launch with initial prompt
```

---

## 📦 Install Options

```bash
# Full install: skills + Ollama + Eburon model + OpenCode + eburoncode
curl -fsSL .../install.sh | bash -s -- --with-ollama

# Skills only (no Ollama/OpenCode)
curl -fsSL .../install.sh | bash

# Ollama + Model + OpenCode only (skip skills)
curl -fsSL .../install.sh | bash -s -- --ollama-only

# Clean install (removes existing skills first)
curl -fsSL .../install.sh | bash -s -- --fresh --with-ollama

# Preview without installing
curl -fsSL .../install.sh | bash -s -- --dry-run --with-ollama
```

---

## 🗂️ What's Inside

### 🎯 Meta & Orchestration
`skill-orchestrator` · `find-skills` · `using-superpowers`

### 🏗️ Agent Workflow (4 major frameworks)
| Skill | Stars | Author | Description |
|-------|-------|--------|-------------|
| `gstack-suite` | ⭐110k | Garry Tan (YC) | 23-specialist AI engineering team |
| `superpowers` | ⭐226k | Jesse Vincent | TDD-driven agent methodology |
| `hermes-agent` | ⭐192k | Nous Research | Self-improving personal AI agent |
| `paperclip` | ⭐70.2k | Paperclip Labs | Multi-agent company orchestration |

### 🖥️ Edge & Offline LLM (13 skills)
`edge-ollama` ⭐174k · `edge-llama-cpp` ⭐116k · `edge-vllm` ⭐82.7k · `edge-gpt4all` ⭐75k · `edge-open-webui` ⭐139k · `edge-exo` ⭐45.3k · `edge-jan` ⭐43k · `edge-llamafile` ⭐24.9k · `edge-mlc-llm` ⭐22.8k · `edge-langchain` ⭐105k · `edge-candle` ⭐17k · `edge-transformers-js` ⭐14k · `edge-tensorrt-llm` ⭐11k

### ☁️ Azure Cloud (28 skills)
`azure-prepare` · `azure-deploy` · `azure-validate` · `azure-kubernetes` · `azure-enterprise-infra-planner` · `azure-compute` · `azure-storage` · `azure-ai` · `azure-aigateway` · `azure-diagnostics` · `azure-cost` · `azure-quotas` · `azure-rbac` · `azure-compliance` · `azure-reliability` · `azure-resource-lookup` · `azure-resource-visualizer` · `azure-upgrade` · `azure-kusto` · `azure-cloud-migrate` · `azure-messaging` · `azure-hosted-copilot-sdk` · `entra-agent-id` · `entra-app-registration` · `appinsights-instrumentation` · `microsoft-foundry` · `airunway-aks-setup`

### 🧠 Planning & Design (13 skills)
`brainstorming` · `writing-plans` · `office-hours` · `plan-ceo-review` · `plan-eng-review` · `plan-design-review` · `plan-devex-review` · `design-consultation` · `design-shotgun` · `design-html` · `design-review` · `devex-review` · `autoplan`

### 📊 Quality & Security (10 skills)
`qa` · `qa-only` · `review` · `codex` · `cso` · `benchmark` · `canary` · `health` · `retro` · `learn`

### 🚀 Deploy & Ship (5 skills)
`ship` · `land-and-deploy` · `setup-deploy` · `document-release` · `full-app-development`

### 🛡️ Safety & Utilities (7 skills)
`careful` · `freeze` · `guard` · `unfreeze` · `yolo` · `checkpoint` · `mock-data-cleanup`

### 🐛 Debugging & Testing (7 skills)
`investigate` · `systematic-debugging` · `test-driven-development` · `requesting-code-review` · `mobile-app-debugging` · `mobile-app-testing` · `verification-before-completion`

### 🎬 AI Video & Media (4 skills)
`ai-video-generation` · `ai-video-cinema` · `ai-video-production` · `tiktok-contents`

### 📹 YouTube & Extraction (4 skills)
`youtube-transcribe` · `youtube-transcript` · `youtube-subtitle-downloader` · `youtube-search`

### 🌐 Web & Browser (7 skills)
`browser-act` · `browser-act-skill-forge` · `browser-use` · `machine-access` · `web-page-marker` · `google-search-serp` · `last30days`

### 🤖 AI/ML Models (6 skills)
`open-search-code-lm` · `gemini-api` · `gemini-api-dev` · `gemini-interactions-api` · `gemini-live-api-dev` · `finetuning`

### 🌍 Web & Mobile Dev (3 skills)
`mobile-pwa-design` · `flutter-dev` · `sleek-design-mobile-apps`

### 🛠️ Google ADK (7 skills)
`google-agents-cli-workflow` · `google-agents-cli-scaffold` · `google-agents-cli-adk-code` · `google-agents-cli-deploy` · `google-agents-cli-eval` · `google-agents-cli-observability` · `google-agents-cli-publish`

### 🎨 Media & Design (4 skills)
`cloudinary-docs` · `cloudinary-react` · `cloudinary-transformations` · `image-gen-gemini`

### 🖥️ Desktop & System (4 skills)
`macbook` · `machine-access` · `screenshot` · `voicebox`

### 📧 Communication (2 skills)
`himalaya` · `gmail-accounts`

### 🔌 IDE Integrations (4 skills)
`cursor` · `vscode` · `windsurf` · `antigravity`

---

## 📖 Full Manifest

See [SKILL-CODE.md](SKILL-CODE.md) for the complete skill inventory with versions, licenses, GitHub repos, and metadata for all 139 skills.

---

## 🔄 Updating

```bash
# Re-run the installer — it's idempotent (safe to run anytime)
curl -fsSL https://raw.githubusercontent.com/lovegold120221-dot/eburonhub-skills/main/install.sh | bash -s -- --with-ollama
```

---

## 📂 Repo Structure

```
eburonhub-skills/
├── README.md                  ← This file
├── SKILL-CODE.md              ← Full skill manifest
├── install.sh                 ← One-line installer
├── bin/
│   └── eburoncode             ← Launch OpenCode + Eburon model
├── .agents/
│   └── skills/                ← 85+ agent skills
│       ├── skill-orchestrator/
│       ├── edge-ollama/
│       ├── gstack-suite/
│       └── ...
└── .opencode/
    └── skills/                ← 18 OpenCode skills
        ├── ai-video-cinema/
        ├── browser-act/
        └── ...
```

---

## 🛠️ Manual Install

```bash
git clone https://github.com/lovegold120221-dot/eburonhub-skills.git /tmp/eburonhub-skills
cp -r /tmp/eburonhub-skills/.agents/skills/* ~/.agents/skills/
cp -r /tmp/eburonhub-skills/.opencode/skills/* ~/.opencode/skills/
cp /tmp/eburonhub-skills/bin/eburoncode ~/.opencode/bin/eburoncode
chmod 755 ~/.opencode/bin/eburoncode
```

---

**Built by Eburon AI** · [eburon.ai](https://eburon.ai) · MIT License
