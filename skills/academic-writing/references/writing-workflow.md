# Writing Workflow — Detailed Phase Instructions

This document provides detailed guidance for each phase of the section-by-section writing process. The SKILL.md gives the summary; this is the full playbook.

---

## Foundational Principle: Iterative, Not Generative

The AI does not produce full drafts independently. The process is always:

1. AI drafts a passage (paragraph or sub-section)
2. Author reacts — approves, redirects, challenges, refines
3. Together, iterate until the author is satisfied
4. Author gives final approval before moving on

This applies to every piece of prose, not just the first draft. If the AI rewrites a paragraph based on feedback, that rewrite goes back to the author for review. No silent changes.

---

## Phase 1: Orientation

**Goal:** Establish shared understanding of what this section needs to accomplish.

### Steps

1. **Pull up the outline.** Show the author the relevant section from the approved outline. This is the structural contract — drafting should follow it unless the author explicitly decides to deviate.

2. **Discuss the argument.** What is this section's core claim? What's the emphasis? How does it connect to the sections before and after it? The author should articulate this, not the AI. The AI's job is to confirm understanding and flag potential issues.

3. **Confirmation bias check.** This is a required step, not optional. Before any drafting begins, explicitly explore:
   - What would someone who disagrees with this section say?
   - What perspectives or evidence might challenge the framing?
   - Are there alternative interpretations we're not considering?

   The reason this matters: AI assistants are structurally inclined to reinforce the author's direction. This step creates a deliberate moment to push against that tendency. The author doesn't have to change anything — but they should hear the counterarguments before committing to a direction.

4. **Gap analysis #1.** Identify:
   - Claims in the outline that need evidence
   - Arguments that need sharpening or more specificity
   - Connections to other sections that need to be set up
   - Missing perspectives or angles

Document gaps in the section's state file.

---

## Phase 2: Reference Work

**Goal:** Build an evidence base that is verified, representative, and sufficient.

### Reference Triage

Categorize each reference for this section into three tiers:

- **Foundational** — Must read. The section's argument depends on understanding these sources deeply. Without them, the claims don't hold up.
- **Supporting** — Should read. These confirm specific claims exist in the literature. You need to verify they say what the outline implies they say.
- **Contextual** — Skim or cite. Relevant and real, but the section doesn't depend on a deep reading. Provides breadth and situates the work.

**Fourth lens — Representation:** Apply across all tiers. A source that brings a perspective from an affected community or underrepresented scholarship may be elevated specifically because its absence would be a gap, even if it's less cited than alternatives.

### Temporal Verification

For each foundational reference:
- Is this the most current version of this argument?
- Has it been superseded, retracted, or substantially critiqued?
- For fast-moving fields (AI/ML, policy), flag anything older than 3-5 years and actively search for more recent work

### Hallucination Gate

Every citation the AI suggests or references must be independently verifiable by the author:
- AI provides: title, author(s), year, journal/venue, and a brief note on what it contributes
- AI flags confidence level: "I'm confident this exists" vs. "I believe this exists but you should verify"
- Author verifies before the citation enters the draft
- No citation enters the final draft unverified. Period.

### Reference Review Process

When the author reads and extracts key points from references:
1. Do this in a focused sub-session — load the reference (or author's notes on it)
2. Author shares extractions, AI confirms alignment with section argument and flags anything missed
3. Write a structured summary to a per-reference notes file or the section state file
4. The drafting session loads the summary, not the full discussion

This compresses reference material intentionally and transparently rather than letting the context window do it silently.

### Literature Bias Guardrails

See `bias-guardrails.md` for the full protocol. Key points:
- Representation audit happens at triage time, not after
- Deliberate counter-searches for dissenting/alternative perspectives
- Source diversity is an explicit triage criterion
- Acknowledge structural limits of AI training data honestly

### Guardrail Overrides

If the author chooses to proceed past any guardrail flag (representation gaps, unverified citation, skipped counter-search), log the override:
1. Name which guardrail was triggered
2. Record the author's reasoning
3. Append to the decision log tagged `[guardrail-override]`

The author's judgment is final, but overrides are always on the record. This applies to all phases, not just reference work.

---

## Phase 3: Drafting

**Goal:** Produce prose that is grounded in evidence, faithful to the argument, and sounds like the author.

### Drafting Protocol

1. **Draft from the outline, not from scratch.** The approved outline is the structural contract. The AI should follow it unless the author explicitly decides to deviate. If the AI thinks the outline needs adjustment based on what emerged during reference work, flag it — don't silently restructure.

2. **One passage at a time.** Draft a paragraph or logical sub-section. Show it to the author. Get reaction. Iterate. Then move to the next passage. Do not draft an entire section and present it as a fait accompli.

3. **Show full text after every edit.** After any change, show the author the complete updated passage so they can review in context. Don't summarize what changed — show the actual words.

### Theme Downweighting Check

After drafting the section (or after a significant revision pass):
- Re-read the section's outline entry
- Compare the draft against it: did any arguments get flattened or diluted?
- AI-assisted drafting tends to smooth out contested or nuanced claims, moving toward consensus language. Actively check for this.
- Ask the author: "Are the sharp edges still sharp, or did anything get softened?"

### Voice Calibration

- Check the draft against the project's style guide
- Flag passages that sound like generic academic writing rather than the author's voice
- Common issues: passive voice creep, hedging language proliferation, loss of directness, buzzword insertion
- If the project doesn't have a style guide yet, this is a good time to start one — note the author's preferences as they emerge during revision

### Gap Analysis #2

After drafting, before declaring the section done:
- Are there claims without sufficient evidence?
- Are there logical gaps in the argument?
- Does anything need a reference that doesn't have one?
- Are there transitions that paper over genuine tensions?

Document remaining gaps in the section state file.

---

## Phase 4: Integration

**Goal:** Lock in the completed section and document the process.

### Steps

1. **Update the compiled draft.** Add the approved prose to the project's compiled draft file, in the correct position.

2. **Log editorial decisions.** Review the session(s) spent on this section and log key decisions in the decision log:
   - What alternatives were considered and why one was chosen
   - Where the author overrode the AI's suggestions (and why)
   - Where the argument was deliberately narrowed or expanded
   - Any unresolved tensions that were intentionally left in

3. **Update section status.** Mark the section as complete (or revision-needed) in `section-status.md`.

4. **Post-section debrief.** This is a candid assessment, not a victory lap:
   - What worked well in the collaboration?
   - Where was the collaboration genuinely interactive vs. performative?
   - Did the AI push back usefully at any point, or just agree?
   - Were there moments where the process broke down?
   - Anything that should change for the next section?

   Save to the process journal. These debriefs are primary source material for documenting the AI-assisted writing process.

---

## Cross-Section Flow Review

After all sections are drafted, do a whole-paper flow review as a **separate session**:

- Load only: compiled draft, style guide, outline (for structural reference)
- No section-level drafting context, no reference review notes
- Read the paper as a whole — check for:
  - Argument coherence across sections
  - Repetition or contradiction
  - Tone consistency
  - Whether the introduction's promises are kept by the conclusion
  - Transitions between sections

This needs clean context. Don't try to do it at the end of a long drafting session.
