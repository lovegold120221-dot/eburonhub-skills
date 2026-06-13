# SKILL-CODE.md — EburonHub Skills Manifest

> **Repository:** [github.com/lovegold120221-dot/eburonhub-skills](https://github.com/lovegold120221-dot/eburonhub-skills)
> **Total Skills:** 139 (121 agent skills + 18 opencode skills)
> **Last Updated:** 2026-06-13
> **Maintained by:** Eburon AI

---

## Installation

### 🚀 One-Line Installer (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/lovegold120221-dot/eburonhub-skills/main/install.sh | bash
```

Options:
```bash
curl -fsSL .../install.sh | bash -s -- --fresh     # Clean install
curl -fsSL .../install.sh | bash -s -- --backup    # Backup existing first
curl -fsSL .../install.sh | bash -s -- --dry-run   # Preview only
curl -fsSL .../install.sh | bash -s -- --verbose   # Detailed output
```

### Manual Clone & Install

```bash
git clone https://github.com/lovegold120221-dot/eburonhub-skills.git /tmp/eburonhub-skills
cp -r /tmp/eburonhub-skills/.agents/skills/* ~/.agents/skills/
cp -r /tmp/eburonhub-skills/.opencode/skills/* ~/.opencode/skills/
echo "Agent skills: $(ls -d ~/.agents/skills/*/ | wc -l)"
echo "OpenCode skills: $(ls -d ~/.opencode/skills/*/ | wc -l)"
```

### Install Specific Skill

```bash
# Example: install only the edge-ollama skill
cp -r /tmp/eburonhub-skills/.agents/skills/edge-ollama ~/.agents/skills/
```

---

## Complete Skill Inventory

### 🎯 Meta & Orchestration

| # | Skill | Path | Version | Description |
|---|-------|------|---------|-------------|
| 1 | `skill-orchestrator` | `.agents/skills/` | v1.0.0 | Bootstrap meta-skill. Always starts with last30days, then routes to correct downstream skills |
| 2 | `find-skills` | `.agents/skills/` | — | Discover and install agent skills |
| 3 | `using-superpowers` | `.agents/skills/` | — | How to find and use skills in any conversation |

### 🏗️ Agent Workflow & Management

| # | Skill | Path | Stars | License | Author | Description |
|---|-------|------|-------|---------|--------|-------------|
| 4 | `gstack-suite` | `.agents/skills/` | ⭐110k | MIT | Garry Tan (YC) | 23-specialist AI engineering team: CEO, Designer, Eng Manager, QA, Security, Release. Think→Plan→Build→Review→Test→Ship→Reflect |
| 5 | `superpowers` | `.agents/skills/` | ⭐226k | MIT | Jesse Vincent | Agentic skills framework: brainstorming→writing-plans→subagent-driven-dev→TDD→code-review→finishing |
| 6 | `hermes-agent` | `.agents/skills/` | ⭐192k | MIT | Nous Research | Self-improving personal AI agent. Learning loop, cross-session memory, multi-platform (Telegram/Discord/Slack/WhatsApp/Signal/CLI) |
| 7 | `paperclip` | `.agents/skills/` | ⭐70.2k | MIT | Paperclip Labs | Multi-agent company orchestration: org charts, budgets, governance, heartbeats, ticketing |
| 8 | `autonomous-app-generator` | `.agents/skills/` | — | — | — | Conceive, build, deploy complete applications automatically |

### 🧠 Planning & Design

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 9 | `brainstorming` | `.agents/skills/` | Socratic design refinement before writing any code |
| 10 | `writing-plans` | `.agents/skills/` | Break specs into bite-sized implementation tasks |
| 11 | `office-hours` | `.agents/skills/` | YC-style brainstorming — 6 forcing questions |
| 12 | `plan-ceo-review` | `.agents/skills/` | CEO/founder-mode plan review — 4 scope modes |
| 13 | `plan-eng-review` | `.agents/skills/` | Engineering architecture review |
| 14 | `plan-design-review` | `.agents/skills/` | Designer's eye plan audit |
| 15 | `plan-devex-review` | `.agents/skills/` | Developer Experience plan review |
| 16 | `design-consultation` | `.agents/skills/` | Build complete design system from scratch |
| 17 | `design-shotgun` | `.agents/skills/` | Generate 4-6 AI design variants, compare, iterate |
| 18 | `design-html` | `.agents/skills/` | Production HTML/CSS from approved mockups |
| 19 | `design-review` | `.agents/skills/` | Visual QA with atomic fixes |
| 20 | `devex-review` | `.agents/skills/` | Live DX audit — test onboarding, time TTHW |
| 21 | `autoplan` | `.agents/skills/` | Auto-review pipeline: CEO→design→eng→DX in one pass |

### 🖥️ Edge & Offline LLM (13 Skills)

| # | Skill | Stars | License | Description |
|---|-------|-------|---------|-------------|
| 22 | `edge-llama-cpp` | ⭐116k | MIT | CPU-first LLM inference in C/C++. Metal, CUDA, Vulkan, WebGPU, mobile |
| 23 | `edge-ollama` | ⭐174k | MIT | Easiest local LLM runner. One command to run any model |
| 24 | `edge-vllm` | ⭐82.7k | Apache-2.0 | Production LLM serving. PagedAttention. 200+ models |
| 25 | `edge-gpt4all` | ⭐75k | MIT | CPU-only laptop AI with curated model library |
| 26 | `edge-exo` | ⭐45.3k | Apache-2.0 | Distributed AI cluster. RDMA over Thunderbolt 5 |
| 27 | `edge-jan` | ⭐43k | Apache-2.0 | ChatGPT alternative desktop app, 100% offline |
| 28 | `edge-open-webui` | ⭐139k | MIT | Self-hosted web UI with RAG, web search, voice, MCP |
| 29 | `edge-llamafile` | ⭐24.9k | Apache-2.0 | Single-file LLM executable. Zero install. 6 OSes |
| 30 | `edge-mlc-llm` | ⭐22.8k | Apache-2.0 | ML compilation for iOS/Android/WebGPU deployment |
| 31 | `edge-langchain` | ⭐105k | MIT | LLM app framework: agents, RAG, chains |
| 32 | `edge-candle` | ⭐17k | MIT/Apache-2.0 | Rust ML framework, WASM-compatible |
| 33 | `edge-transformers-js` | ⭐14k | Apache-2.0 | HuggingFace models in the browser (WebGPU) |
| 34 | `edge-tensorrt-llm` | ⭐11k | Apache-2.0 | NVIDIA-optimized inference. Up to 8x speedup |

### 🤖 AI/ML Models & APIs

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 35 | `open-search-code-lm` | `.opencode/skills/` | Find open-source LLMs, TTS, STT, image/video gen on GitHub |
| 36 | `gemini-api-dev` | `.agents/skills/` | Build with Gemini models (multimodal, function calling, structured output) |
| 37 | `gemini-api` | `.agents/skills/` | Gemini API on Agent Platform with Vertex AI |
| 38 | `gemini-interactions-api` | `.agents/skills/` | Gemini Interactions API for text, chat, image, streaming |
| 39 | `gemini-live-api-dev` | `.agents/skills/` | Real-time bidirectional streaming with Gemini Live API |
| 40 | `gemini` | `.agents/skills/` | Gemini CLI for code review, plan review, big context |
| 41 | `finetuning` | `.agents/skills/` | Fine-tune models on Azure AI Foundry (SFT/DPO/RFT) |
| 42 | `image-gen-gemini` | `.agents/skills/` | Generate images via Gemini CLI |

### 🎬 AI Video & Media

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 43 | `ai-video-generation` | `.opencode/skills/` | 100+ t2v/i2v/lipsync models via Muapi API |
| 44 | `ai-video-cinema` | `.opencode/skills/` | Cinematic AI video with Veo 3.1, FFmpeg, Vertex AI |
| 45 | `ai-video-production` | `.opencode/skills/` | Full video pipeline: TTS, music, Remotion, cloud GPU |
| 46 | `tiktok-contents` | `.opencode/skills/` | TikTok ads/content with Symphony Studio, Seedance 2.0 |

### 📹 YouTube & Media Extraction

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 47 | `youtube-transcribe` | `.agents/skills/` | Download YouTube video and transcribe with Whisper |
| 48 | `youtube-transcript` | `.opencode/skills/` | Extract full YouTube transcripts with/without timestamps |
| 49 | `youtube-subtitle-downloader` | `.agents/skills/` | Download subtitles from YouTube via downsub.com |
| 50 | `youtube-search` | `.opencode/skills/` | Structured YouTube search data extraction |

### 🌐 Web & Browser Automation

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 51 | `browser-act` | `.opencode/skills/` | Browser automation CLI: navigation, interaction, extraction |
| 52 | `browser-act-skill-forge` | `.opencode/skills/` | Forge reusable skills from website exploration |
| 53 | `browser-use` | `.opencode/skills/` | Headless browser for testing, scraping, screenshots |
| 54 | `machine-access` | `.opencode/skills/` | Full machine control: browser + desktop GUI + AppleScript |
| 55 | `web-page-marker` | `.opencode/skills/` | Extract readable Markdown from any URL |
| 56 | `google-search-serp` | `.opencode/skills/` | Google SERP data: organic, ads, AI Overview, People Also Ask |
| 57 | `last30days` | `.agents/skills/` | Research any topic across Reddit, X, YouTube, TikTok, HN, GitHub |

### 📊 Quality & Review (gstack suite)

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 58 | `review` | `.agents/skills/` | Pre-landing PR review: SQL safety, LLM trust boundaries |
| 59 | `codex` | `.agents/skills/` | Codex CLI wrapper: review/challenge/consult modes |
| 60 | `qa` | `.agents/skills/` | Systematic QA testing + fix + verify for web apps |
| 61 | `qa-only` | `.agents/skills/` | Report-only QA: test but don't fix |
| 62 | `benchmark` | `.agents/skills/` | Performance regression detection |
| 63 | `canary` | `.agents/skills/` | Post-deploy monitoring |
| 64 | `health` | `.agents/skills/` | Code quality dashboard (0-10 score) |
| 65 | `cso` | `.agents/skills/` | Chief Security Officer: OWASP Top 10 + STRIDE |
| 66 | `retro` | `.agents/skills/` | Weekly engineering retrospective |
| 67 | `learn` | `.agents/skills/` | Manage project learnings across sessions |

### 🚀 Deploy, Ship & Release

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 68 | `ship` | `.agents/skills/` | Release workflow: tests, review, bump version, PR |
| 69 | `land-and-deploy` | `.agents/skills/` | Merge PR, wait for CI/deploy, verify production |
| 70 | `setup-deploy` | `.agents/skills/` | One-time deploy configuration for land-and-deploy |
| 71 | `document-release` | `.agents/skills/` | Auto-update all project docs after shipping |
| 72 | `full-app-development` | `.agents/skills/` | End-to-end app to Vercel + GitHub |

### 🛡️ Safety & Security

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 73 | `careful` | `.agents/skills/` | Warn before destructive commands |
| 74 | `freeze` | `.agents/skills/` | Restrict edits to specific directory |
| 75 | `guard` | `.agents/skills/` | Full safety: careful + freeze |
| 76 | `unfreeze` | `.agents/skills/` | Remove freeze boundary |
| 77 | `yolo` | `.agents/skills/` | Full send, no confirmation |
| 78 | `checkpoint` | `.agents/skills/` | Save/resume working state |

### 🐛 Debugging & Testing

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 79 | `investigate` | `.agents/skills/` | Systematic root-cause debugging |
| 80 | `systematic-debugging` | `.agents/skills/` | 4-phase debug process |
| 81 | `test-driven-development` | `.agents/skills/` | RED-GREEN-REFACTOR cycle |
| 82 | `requesting-code-review` | `.agents/skills/` | Pre-review checklist before merging |
| 83 | `mobile-app-debugging` | `.agents/skills/` | iOS/Android crash and perf debugging |
| 84 | `mobile-app-testing` | `.agents/skills/` | iOS/Android testing: unit, UI, integration, Detox, Appium |
| 85 | `mock-data-cleanup` | `.agents/skills/` | Detect and remove mock data |

### 🌐 Web & Mobile App Dev

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 86 | `mobile-pwa-design` | `.opencode/skills/` | PWA & mobile-first HTML/CSS/JS design |
| 87 | `flutter-dev` | `.opencode/skills/` | Full-stack Flutter: architecture, UI, state, routing, testing |
| 88 | `sleek-design-mobile-apps` | `.agents/skills/` | Design mobile apps in Sleek |

### ☁️ Azure Cloud (28 Skills)

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 89 | `azure-prepare` | `.agents/skills/` | Prepare apps for Azure: Bicep/Terraform, azure.yaml, Dockerfiles |
| 90 | `azure-deploy` | `.agents/skills/` | Execute prepared Azure deployments |
| 91 | `azure-validate` | `.agents/skills/` | Pre-deployment validation |
| 92 | `azure-kubernetes` | `.agents/skills/` | AKS cluster planning, creation, configuration |
| 93 | `azure-kubernetes-automatic-readiness` | `.agents/skills/` | AKS Automatic compatibility assessment |
| 94 | `azure-enterprise-infra-planner` | `.agents/skills/` | Landing zones, hub-spoke, WAF-aligned infra |
| 95 | `azure-cloud-migrate` | `.agents/skills/` | Cross-cloud migration (Lambda→Functions, K8s→ACA) |
| 96 | `azure-compute` | `.agents/skills/` | VM/VMSS provisioning, sizing, troubleshooting |
| 97 | `azure-storage` | `.agents/skills/` | Blob, Files, Queue, Table, Data Lake |
| 98 | `azure-ai` | `.agents/skills/` | Search, Speech, OpenAI, Document Intelligence |
| 99 | `azure-aigateway` | `.agents/skills/` | API Management as AI Gateway |
| 100 | `azure-messaging` | `.agents/skills/` | Event Hubs/Service Bus SDK troubleshooting |
| 101 | `azure-diagnostics` | `.agents/skills/` | Production debugging: AppLens, Monitor, KQL |
| 102 | `azure-cost` | `.agents/skills/` | Cost query, forecast, optimization |
| 103 | `azure-quotas` | `.agents/skills/` | Quota checks, capacity validation |
| 104 | `azure-rbac` | `.agents/skills/` | Least-privilege role assignments |
| 105 | `azure-compliance` | `.agents/skills/` | Compliance scans, Key Vault expiration checks |
| 106 | `azure-reliability` | `.agents/skills/` | Zone redundancy, multi-region failover |
| 107 | `azure-resource-lookup` | `.agents/skills/` | Resource inventory via Resource Graph |
| 108 | `azure-resource-visualizer` | `.agents/skills/` | Mermaid architecture diagrams |
| 109 | `azure-upgrade` | `.agents/skills/` | Plan/SKU upgrades, SDK modernization |
| 110 | `azure-kusto` | `.agents/skills/` | KQL queries for ADX/log analytics |
| 111 | `azure-hosted-copilot-sdk` | `.agents/skills/` | GitHub Copilot SDK apps on Azure |
| 112 | `entra-agent-id` | `.agents/skills/` | Microsoft Entra Agent Identity Blueprints |
| 113 | `entra-app-registration` | `.agents/skills/` | Entra ID app registration, MSAL |
| 114 | `appinsights-instrumentation` | `.agents/skills/` | Azure Application Insights telemetry |
| 115 | `microsoft-foundry` | `.agents/skills/` | Deploy/eval/fine-tune/manage Foundry agents |
| 116 | `airunway-aks-setup` | `.agents/skills/` | AI Runway on AKS setup |

### 🛠️ Google ADK Agents

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 117 | `google-agents-cli-workflow` | `.agents/skills/` | Full ADK agent development lifecycle |
| 118 | `google-agents-cli-scaffold` | `.agents/skills/` | Create/scaffold new ADK agent projects |
| 119 | `google-agents-cli-adk-code` | `.agents/skills/` | ADK Python API: agents, tools, callbacks, state |
| 120 | `google-agents-cli-deploy` | `.agents/skills/` | Deploy ADK agents to Agent Runtime/Cloud Run/GKE |
| 121 | `google-agents-cli-eval` | `.agents/skills/` | Evaluate ADK agents: metrics, evalsets, LLM-as-judge |
| 122 | `google-agents-cli-observability` | `.agents/skills/` | Tracing, logging, monitoring for ADK agents |
| 123 | `google-agents-cli-publish` | `.agents/skills/` | Publish agents to Gemini Enterprise |

### 🎨 Media & Design Tools

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 124 | `cloudinary-docs` | `.agents/skills/` | Cloudinary API docs for image/video upload & optimization |
| 125 | `cloudinary-react` | `.agents/skills/` | Cloudinary React SDK patterns |
| 126 | `cloudinary-transformations` | `.agents/skills/` | Cloudinary transformation URL generation |
| 127 | `image-gen-gemini` | `.agents/skills/` | Image generation via Gemini CLI |

### 🖥️ Desktop & System

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 128 | `macbook` | `.opencode/skills/` | macOS automation: AppleScript, system info, Finder, Dock |
| 129 | `machine-access` | `.opencode/skills/` | Full machine control: GUI, browser, AppleScript |
| 130 | `screenshot` | `.agents/skills/` | Take screenshots of apps, websites, desktop |
| 131 | `voicebox` | `.agents/skills/` | Local Voicebox REST API for TTS/STT |

### 📧 Communication

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 132 | `himalaya` | `.opencode/skills/` | CLI email client: IMAP/SMTP, read/send/manage |
| 133 | `gmail-accounts` | `.opencode/skills/` | Gmail credential management for social account creation |

### 🔌 IDE Integrations

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 134 | `cursor` | `.agents/skills/` | Cursor AI code editor integration |
| 135 | `vscode` | `.agents/skills/` | Visual Studio Code IDE integration |
| 136 | `windsurf` | `.agents/skills/` | Windsurf AI IDE by Codeium |
| 137 | `antigravity` | `.agents/skills/` | Google Antigravity IDE integration |

### 🔧 Utility

| # | Skill | Path | Description |
|---|-------|------|-------------|
| 138 | `connect-chrome` | `.agents/skills/` | Real Chrome with Side Panel extension |
| 139 | `setup-browser-cookies` | `.agents/skills/` | Import real Chrome cookies for authenticated QA |

---

## Skill Directory Structure

```
eburonhub-skills/
├── SKILL-CODE.md              ← This file
├── README.md
├── .agents/
│   └── skills/
│       ├── skill-orchestrator/SKILL.md
│       ├── edge-ollama/SKILL.md
│       ├── edge-llama-cpp/SKILL.md
│       ├── ... (121 skills total)
│       └── yolo/SKILL.md
├── .opencode/
│   └── skills/
│       ├── ai-video-cinema/SKILL.md
│       ├── browser-act/SKILL.md
│       ├── ... (18 skills total)
│       └── youtube-transcript/SKILL.md
```

---

## Skill Metadata Format

Each `SKILL.md` follows this frontmatter format:

```yaml
---
name: skill-name
version: "1.0.0"
description: "What this skill does and when to use it"
argument-hint: 'how to invoke this skill'
allowed-tools: Bash, Read, Write, WebFetch
user-invocable: true
metadata:
  openclaw:
    emoji: "🎯"
    tags: [tag1, tag2, tag3]
    repo: https://github.com/owner/repo
    stars: 100000
    license: MIT
---
```

---

## Update Process

```bash
# Pull latest skills
cd ~/eburonhub-skills
git pull

# Reinstall
cp -r .agents/skills/* ~/.agents/skills/
cp -r .opencode/skills/* ~/.opencode/skills/

# Verify
ls -d ~/.agents/skills/*/ | wc -l
```

---

**Generated by Eburon AI — 2026-06-13**
