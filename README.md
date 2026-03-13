# Academic Writing Process Skill

A process enforcement skill for responsible AI-assisted academic writing. Designed for use with [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and [Cowork](https://claude.ai).

## What It Does

This skill enforces a structured, transparent process when writing academic papers with AI assistance. It addresses eight documented risks of AI-assisted academic writing:

| Risk | What happens | How the skill helps |
|------|-------------|-------------------|
| **Literature bias** | AI training data overrepresents Western, English-language, highly-cited work | Representation audits, deliberate counter-searches, source diversity as triage criterion |
| **Confirmation bias** | AI reinforces the author's framing rather than challenging it | Required "challenge the framing" step before any drafting begins |
| **Theme downweighting** | AI-assisted drafting flattens nuanced or contested arguments | Post-draft check against outline for diluted arguments |
| **Language homogenization** | AI defaults to dominant language patterns, erasing distinctive voice | Voice calibration against project style guide |
| **Temporal gaps** | AI training has a cutoff; recent work may be missing | Recency verification for foundational references |
| **Citation bias** | AI surfaces well-cited sources, reinforcing existing hierarchies | Representation lens elevates underrepresented but relevant sources |
| **Hallucination** | AI can generate plausible but fabricated citations | Independent verification gate — no unverified citations enter drafts |
| **Context loss** | Context window compression silently degrades editorial agreements | Section isolation, persistent state files, explicit compression boundaries |

The human author directs. The AI assists. All editorial decisions belong to the author. This skill makes sure that principle holds throughout the process, not just at the start.

## Installation

### Claude Code / Cowork

Copy or clone this repository into your skills directory:

```bash
# Clone to your skills folder
git clone https://github.com/jayweiler/academic-writing-skill.git \
  ~/.claude/skills/academic-writing

# Or for a specific project
git clone https://github.com/jayweiler/academic-writing-skill.git \
  /path/to/your/project/.skills/academic-writing
```

### Initialize a New Paper Project

```bash
# Run the init script to scaffold a project
./scripts/init-project.sh /path/to/your/paper "My Paper Title"
```

This creates the directory structure, copies templates, and generates a `project-config.yaml` you can edit.

## How It Works

### Four-Phase Writing Workflow

Each section of your paper follows four phases:

1. **Orientation** — Review the outline, discuss the argument, run the confirmation bias check, identify gaps
2. **Reference Work** — Triage references (Foundational / Supporting / Contextual), apply bias guardrails, verify citations, extract key points
3. **Drafting** — Write iteratively (AI drafts a passage, author reacts, refine together, author approves), check for theme downweighting and voice drift
4. **Integration** — Add approved prose to compiled draft, log decisions, debrief on the collaboration

The skill detects which phase you're in based on project state and loads only the relevant guidance — keeping the context window lean.

### Session Protocol

Every session starts with orientation (where did we leave off, what's next) and ends with state persistence (save transcript, log decisions, update section status). This ensures continuity across sessions even when the context window resets.

### Literature Bias Guardrails

Applied during reference triage, not as an afterthought:

- **Representation audit** — Check for Global South researchers, non-English-origin work, scholars from discussed communities, emerging voices
- **Deliberate counter-searches** — For each core claim, actively search for dissenting perspectives and underrepresented scholarship
- **Source diversity as criterion** — When two sources make similar points, prefer the one that adds demographic or geographic diversity
- **Structural limits acknowledged** — Be honest about gaps in AI training data rather than pretending the reference list is representative
- **Human judgment primary** — The guardrails create moments for the author's judgment, not substitutes for it

### Context Engineering

Strategies for managing the context window intentionally:

- **Section isolation** — Load only what's needed for the current section
- **Per-section state files** — Persistent memory that survives context resets
- **Reference review as isolated passes** — Compress reference material intentionally, not silently
- **Explicit compression boundaries** — Save state before heavy context operations
- **Cross-section flow as separate phase** — Clean context for whole-paper review

## Project Structure

```
academic-writing/
  SKILL.md                          # Main skill file (process engine)
  references/
    writing-workflow.md             # Detailed phase-by-phase instructions
    bias-guardrails.md              # Literature bias guardrails + reference triage
    context-engineering.md          # Context window management strategies
  templates/
    project-config.yaml             # Project configuration schema
    section-state.md                # Per-section state file template
    decision-log.md                 # Editorial decision logging template
    process-journal.md              # Process documentation template
    section-status.md               # Project-wide section tracking
  scripts/
    init-project.sh                 # Project scaffolding script
```

## Background

This skill was developed as part of a paper on bias in AI safety measures for the San Francisco State University Ethical AI Certificate program. The paper itself was written collaboratively with AI, and the process of writing it revealed the need for systematic guardrails against the risks listed above.

The skill is both a tool used during the paper's development and a contribution of the paper — a concrete, reusable artifact that other researchers can adopt when doing AI-assisted academic writing.

For the full analysis of these risks and their mitigations, see the paper (citation forthcoming).

## License

MIT. See [LICENSE](LICENSE).

## Contributing

Issues and pull requests welcome. This is a process tool, so the most valuable contributions are:

- Reports of risks or failure modes not currently addressed
- Improvements to the bias guardrails based on lived experience
- Adaptations for different academic disciplines or writing workflows
- Translations or adaptations for non-English academic contexts
