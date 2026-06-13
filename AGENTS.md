# AGENTS.md — EburonCode Skill Routing Rules

## Skill Activation System

You have access to 139+ skills in `~/.agents/skills/` and `~/.opencode/skills/`.  
Skills are **lazy-loaded playbooks** — you read only the name + description upfront, then load the full SKILL.md only when a skill matches the task.

### Progressive Disclosure Rule

1. **Before any task**, scan `~/.agents/skills/*/SKILL.md` and `~/.opencode/skills/*/SKILL.md` for name + description only (first 5 lines of each).
2. **Match task intent** against skill descriptions. Trigger words in descriptions are your routing keys.
3. **Load only matched skills** — never load all skills into context at once.
4. **Follow the skill's workflow** after loading — skills are engineering playbooks, not suggestions.

### How to Match Skills

**Explicit invocation** — user says `$skill-name` or `use skill-name`:
→ Load that skill's full SKILL.md immediately.

**Implicit invocation** — task matches a skill's description:
→ Load the skill if the description's trigger words match the task domain.

### Reading Skill Descriptions (Context-Efficient)

When scanning skills before a task, use this bash command to read only name + description:

```bash
for f in ~/.agents/skills/*/SKILL.md ~/.opencode/skills/*/SKILL.md; do
  [ -f "$f" ] && head -8 "$f" | grep -E "^(name:|description:)" | paste - -
done
```

### Skill Loading Contract

When a skill is loaded (explicit or implicit):
1. **Read the full `SKILL.md`** — it contains the workflow steps.
2. **Inspect the repo state** before editing (as the skill instructs).
3. **Run verification** after changes (tests, typecheck, lint, build).
4. **Summarize** — files changed, verification results, risks.

### Skill Hierarchy

```
AGENTS.md (this file)     = Global agent rules + skill routing
~/.config/opencode/developer.md = Core coding discipline rules  
Skills/*.md               = Task-specific engineering playbooks
Scripts/                  = Deterministic helpers (run, don't guess)
```

### Never Do This

- ❌ Load all skills into context at once (context pollution)
- ❌ Ignore skill descriptions and improvise (defeats the system)
- ❌ Skip skill verification steps (defeats consistency)
- ❌ Use mock data when a skill says "real data only"
- ❌ Change CSS/UI/functions unless the skill or user explicitly says to

### Always Do This

- ✅ Scan skill name + description before every task
- ✅ Match task intent → skill description → load SKILL.md
- ✅ Follow the skill workflow top to bottom
- ✅ Report what skill(s) were used and why
- ✅ Use `skill-orchestrator` when unsure which skill to use
