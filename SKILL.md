---
name: academic-writing
description: "AI-assisted academic writing process enforcer. Use this skill whenever the user wants to work on an academic paper, thesis, dissertation, or research document collaboratively with AI. Enforces phase-gated workflows, literature bias guardrails, citation verification, session transcript archival, and editorial decision logging. Triggers on: 'work on my paper', 'let's write', 'next section', 'paper session', 'resume writing', academic writing tasks, or any reference to a configured academic writing project. Also use when the user wants to set up a new academic writing project with process guardrails."
---

# Academic Writing Process

A process enforcement skill for responsible AI-assisted academic writing. Ensures transparent, auditable collaboration between a human author and an AI assistant.

## What This Skill Does

This skill enforces a structured, transparent process for writing academic papers with AI assistance. It:

- Phase-gates the writing workflow so sections are developed methodically, not generated wholesale
- Enforces literature bias guardrails to counteract AI training data skews
- Manages context engineering to prevent silent degradation of editorial agreements
- Archives session transcripts and logs decisions for full process transparency
- Detects which phase of work you're in and loads relevant guidance

The human author directs. The AI assists. All editorial decisions belong to the author. This skill makes sure that principle holds throughout the process, not just at the start.

---

## Session Start Protocol

Every session begins here. No exceptions.

### Step 1: Load Project Config

Read the project's `project-config.yaml` file. If the user hasn't specified which project, check for a config file in the current working directory or ask.

If no project exists yet, ask: "Want to set up a new academic writing project?" and run the init script (see `scripts/init-project.sh`).

### Step 2: Read Project State

Load the project's `section-status.md` to determine:
- Which sections exist and their current status
- What was worked on last
- What's next in the outline

### Step 3: Orient the Session

Tell the author:
1. Where we left off (last section worked on, its status)
2. What the natural next step is
3. Any open items from last session (check the decision log for unresolved questions)

Then ask: "Does this match where you want to pick up, or do you want to work on something else?"

Do NOT proceed until the author confirms direction.

### Step 4: Load Phase-Specific Context

Based on what we're doing, load only what's needed:

**If starting a new section:** Load that section's outline, the style guide, and any existing section state file.

**If continuing a section:** Load the section state file (which has reference notes, draft status, open gaps, decisions made).

**If doing reference work:** Load the reference triage framework from `references/bias-guardrails.md` and the section's reference list.

**If doing a full-paper flow review:** Load compiled draft + style guide + outline only. No section-level context.

Keep the context window lean. Read `references/context-engineering.md` for the full strategy.

---

## The Writing Workflow

Each section follows four phases. Read `references/writing-workflow.md` for detailed instructions on each phase. Summary:

### Phase 1: Orientation
- Review the section's outline
- Discuss the argument and emphasis
- **Confirmation bias check:** Before drafting, explicitly ask: "What would someone who disagrees with this section's argument say? What are we not seeing?" This is not optional. AI assistants tend to reinforce the author's framing rather than challenge it.
- Gap analysis: what needs evidence, what's missing, what needs sharpening

### Phase 2: Reference Work
- Triage references into Foundational / Supporting / Contextual tiers
- Apply literature bias guardrails (see `references/bias-guardrails.md`)
- **Temporal verification:** For each foundational reference, check: is this the most current version of this argument? Has it been superseded, retracted, or substantially updated? Flag references older than 5 years on fast-moving topics.
- **Hallucination gate:** Every citation the AI suggests must be independently verified by the author before inclusion. No exceptions. The AI should provide enough detail (title, authors, year, journal) for the author to verify, and should flag when it is uncertain about a citation's accuracy.
- Author reads and extracts key points; AI confirms alignment with argument

### Phase 3: Drafting
- Draft from outline structure and reference points — iterative, not generative
- AI drafts → author reacts → refine together → author approves
- **Theme downweighting check:** After drafting, re-read the section's outline and ask: "Did any arguments get flattened or diluted in the draft? Are the sharp edges still sharp?" AI-assisted drafting tends to smooth out contested or nuanced claims. Actively check for this.
- **Voice calibration:** Check draft against the project's style guide. Flag passages that sound like generic academic writing rather than the author's voice.
- Gap analysis: remaining holes, weak claims, missing evidence

### Phase 4: Integration
- Update the compiled draft with approved prose
- Log editorial decisions in the decision log
- Update section status
- **Post-section debrief:** What worked, what didn't, where the collaboration was genuinely interactive vs. performative. Save to process journal. These are primary source material for documenting the AI-assisted process.

---

## Session End Protocol

Before closing any session where writing work was done:

### 1. Save Session Transcript

If `auto_archive_transcript` is enabled in the project config:

Check the `platform` field to determine where session logs live:
- `cowork`: Copy from the Cowork session log path
- `claude-code`: Copy from the Claude Code transcript path
- `manual`: Remind the author to save the transcript themselves

Archive to the project's `transcripts_path` with filename `YYYY-MM-DD-session.jsonl`. Multiple sessions per day get `-2`, `-3` suffixes.

If the session gets compacted mid-conversation, save immediately with `-precompact` suffix.

### 2. Extract and Log Decisions

If `decision_extraction` is `auto` or `prompted`:

**Prompted mode:** Ask the author: "What editorial decisions did we make this session? I'll log them." Append responses to the decision log with date and section reference.

**Auto mode:** Scan the session for decision points — moments where the author chose between alternatives, approved or rejected a draft direction, or set editorial policy. Present the extracted decisions to the author for confirmation before logging. Never log unconfirmed decisions.

**Manual mode:** Remind the author to update the decision log.

### 3. Update Section State

Write/update the current section's state file with:
- References reviewed and key extractions
- Current draft status
- Open gaps and unresolved questions
- Decisions made this session

### 4. Update Process Journal

Append a brief entry to the process journal: what was worked on, how the collaboration went, any process refinements, anything notable for documenting the AI-assisted writing process.

### 5. Update Section Status

Mark the section's current phase in `section-status.md`.

---

## Platform Configuration and Permissions

When the skill first loads for a project, check the `platform` and `session_log_access` config fields:

```yaml
platform: cowork          # cowork | claude-code | manual
session_log_access:
  enabled: true
  path_pattern: ""        # auto-detected from platform, or user-specified
  permissions: prompt     # prompt | granted | denied
```

- If `permissions: prompt`, ask the user on first session: "This skill can automatically archive session transcripts for process documentation. This requires read access to [path]. Grant access?" Respect the answer and update the config.
- If `permissions: granted`, proceed with auto-archival.
- If `permissions: denied`, fall back to manual reminders.
- If `platform: manual`, skip log access entirely and remind the author to save transcripts.

The skill should never access session logs without the user's explicit knowledge and consent.

---

## Risk Mitigation Summary

This skill addresses eight documented risks of AI-assisted academic writing:

| Risk | Mitigation | Phase |
|---|---|---|
| Literature bias | Representation audits, deliberate counter-searches, source diversity as triage criterion | Phase 2 |
| Confirmation bias | Explicit "challenge the framing" step before drafting | Phase 1 |
| Theme downweighting | Post-draft check against outline for flattened arguments | Phase 3 |
| Language homogenization | Voice calibration against project style guide | Phase 3 |
| Temporal gaps | Recency verification for foundational references | Phase 2 |
| Citation bias | Representation audit elevates underrepresented but relevant sources | Phase 2 |
| Hallucination | Independent verification gate — no unverified citations | Phase 2 |
| Context/continuity loss | Context engineering strategy, section isolation, persistent state files | All |

For detailed instructions on each mitigation, see `references/bias-guardrails.md` and `references/context-engineering.md`.

---

## Reference Files

Load these as needed — do NOT load all at once:

- `references/writing-workflow.md` — Detailed phase-by-phase instructions
- `references/bias-guardrails.md` — Literature bias guardrails, reference triage framework, representation audit protocol
- `references/context-engineering.md` — Context window management, section isolation, compression boundaries, state file protocol

## Templates

- `templates/project-config.yaml` — Schema for new projects (used by init script)
- `templates/section-state.md` — Per-section state file template
- `templates/decision-log.md` — Editorial decision logging template
- `templates/process-journal.md` — Process documentation template
- `templates/section-status.md` — Project-wide section tracking
