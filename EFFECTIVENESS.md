# How Effective Are These Mitigations?

Honest assessment — these mitigations are not all equally strong.

## Structurally reliable (will fire if the skill is followed at all)

**Hallucination prevention** is the hardest gate in the skill. It's a binary check — the author verifies each citation exists — not a judgment call the AI can get wrong. The residual risk is author fatigue on lower-tier references, which the skill addresses with explicit triage tiers (verify foundational refs carefully, spot-check supporting refs, skim contextual refs).

**Context/continuity loss prevention** is infrastructure, not behavior. Persistent state files, session start/end protocols, and transcript archival work because they're built into the workflow structure. If you follow the skill at all, this fires.

## Strong process, dependent on author engagement

**Confirmation bias mitigation** is well-positioned (before drafting, not after) and mandatory. But its effectiveness depends on whether the author genuinely engages with the counterarguments or treats the step as a checkbox. This is the best structural mitigation possible — you can't do better without a separate human adversarial reviewer — but it's fundamentally a prompt to think, not a gate that blocks.

**Literature bias mitigation** has real teeth. In strict mode, you can't proceed to drafting without diverse sources — that's a genuine gate. In standard mode (the default), gaps are flagged but overridable with logged reasoning. The honest limit: the AI's ability to suggest underrepresented sources is constrained by the same training data that creates the bias. The skill can flag *absences*, but it can't populate them with scholarship the AI doesn't know about. The genai-disclosure template acknowledges this structural limit rather than pretending the guardrail eliminates it.

## Useful checks, dependent on AI judgment quality

**Theme downweighting detection** asks the right question at the right time (post-draft: "are the sharp edges still sharp?"). But detecting whether an argument got flattened requires the AI to understand the *intended* sharpness — a subtle judgment call. The author is the real backstop; the skill's role is to remind them to look.

**Language homogenization prevention** improves over time as the style guide accumulates specific preferences, but early in a project, the AI is pattern-matching against vague descriptions. The iterative drafting protocol (one passage at a time, author reacts, iterate) is actually the stronger defense — homogenization gets caught in the revision loop even if the voice check misses it.

**Temporal gap detection** catches obvious staleness in foundational references but is limited by the AI's own knowledge cutoff. A paper retracted after the AI's training date won't be flagged.

**Citation bias mitigation** uses the same mechanism as literature bias (the representation lens during triage). Same strengths, same structural limits around training data.

## The irreducible gap

Nothing in this skill can fully compensate for biases in the AI's training data. The representation audit can flag *absences* in your reference list, but it can't suggest sources the AI doesn't know about. Counter-searches help, but the AI searches with the same biased training data. The skill's honest response to this is transparency: the genai-disclosure template puts the limitation on the record, the process journal documents where the AI's suggestions were and weren't sufficient, and the decision log captures where the author overrode the AI's framing.

## Why the decision log matters

The decision log is arguably the most important artifact the skill produces. Every editorial choice — framing decisions, reference inclusion/exclusion, argument structure, guardrail overrides — gets recorded with what was decided, what alternatives were considered, who drove the decision (author or AI), and why. This serves multiple purposes: it prevents relitigating settled decisions when context windows reset between sessions, it provides raw material for the genai-disclosure statement, and it creates an auditable record that editorial judgment remained with the author throughout. Combined with session history tracking in each section's state file (which logs what happened in every work session, phase by phase), the decision log means no part of the writing process is a black box. If a reviewer asks "how did you arrive at this framing?" or "why did you exclude that perspective?", the answer is in the log — not reconstructed after the fact.

This is by design. A tool that claimed to eliminate AI bias in academic writing would be dishonest. A tool that makes AI bias visible, creates checkpoints for human judgment, and maintains a transparent record of the collaboration — that's a credible contribution.
