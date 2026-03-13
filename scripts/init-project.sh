#!/usr/bin/env bash
#
# init-project.sh — Scaffold a new academic writing project
#
# Usage:
#   ./init-project.sh /path/to/project-directory "Project Name"
#
# Creates the directory structure and copies templates for a new
# academic writing project managed by the academic-writing skill.

set -euo pipefail

# --- Argument parsing ---

if [ $# -lt 1 ]; then
    echo "Usage: $0 <project-directory> [project-name]"
    echo ""
    echo "  project-directory  Path where the project will be created"
    echo "  project-name       Human-readable name (optional, defaults to directory name)"
    exit 1
fi

PROJECT_DIR="$1"
PROJECT_NAME="${2:-$(basename "$PROJECT_DIR")}"

# --- Locate skill root (where templates live) ---

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATES_DIR="$SKILL_ROOT/templates"

if [ ! -d "$TEMPLATES_DIR" ]; then
    echo "Error: Templates directory not found at $TEMPLATES_DIR"
    echo "Make sure this script is in the skill's scripts/ directory."
    exit 1
fi

# --- Check if directory already exists ---

if [ -d "$PROJECT_DIR" ] && [ "$(ls -A "$PROJECT_DIR" 2>/dev/null)" ]; then
    echo "Warning: $PROJECT_DIR already exists and is not empty."
    read -p "Continue anyway? Files won't be overwritten. [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# --- Create directory structure ---

echo "Creating project: $PROJECT_NAME"
echo "Location: $PROJECT_DIR"
echo ""

mkdir -p "$PROJECT_DIR"/{drafts,state,references,process,session_transcripts,context}

echo "  Created directories:"
echo "    drafts/              — Section drafts and compiled draft"
echo "    state/               — Per-section state files"
echo "    references/          — Reference notes and extractions"
echo "    process/             — Decision log and process journal"
echo "    session_transcripts/ — Archived session logs"
echo "    context/             — Project-specific context files"
echo ""

# --- Copy templates (don't overwrite existing files) ---

copy_if_missing() {
    local src="$1"
    local dest="$2"
    if [ -f "$dest" ]; then
        echo "  Skipped (exists): $(basename "$dest")"
    else
        cp "$src" "$dest"
        echo "  Created: $(basename "$dest")"
    fi
}

echo "Copying templates:"
copy_if_missing "$TEMPLATES_DIR/project-config.yaml" "$PROJECT_DIR/project-config.yaml"
copy_if_missing "$TEMPLATES_DIR/section-status.md" "$PROJECT_DIR/section-status.md"
copy_if_missing "$TEMPLATES_DIR/decision-log.md" "$PROJECT_DIR/process/decision-log.md"
copy_if_missing "$TEMPLATES_DIR/process-journal.md" "$PROJECT_DIR/process/process-journal.md"
echo ""

# --- Inject project name into config ---

if [ -f "$PROJECT_DIR/project-config.yaml" ]; then
    sed -i "s/^project_name: \"\"/project_name: \"$PROJECT_NAME\"/" "$PROJECT_DIR/project-config.yaml"
    sed -i "s|^working_directory: \"\"|working_directory: \"$PROJECT_DIR\"|" "$PROJECT_DIR/project-config.yaml"
fi

# --- Create placeholder files ---

if [ ! -f "$PROJECT_DIR/outline.md" ]; then
    cat > "$PROJECT_DIR/outline.md" << 'OUTLINE'
# Paper Outline

## Introduction

[Your introduction outline here]

## Section 1: [Title]

[Section outline]

## Section 2: [Title]

[Section outline]

## Conclusion

[Conclusion outline]
OUTLINE
    echo "Created: outline.md (placeholder — replace with your outline)"
fi

if [ ! -f "$PROJECT_DIR/style-guide.md" ]; then
    cat > "$PROJECT_DIR/style-guide.md" << 'STYLE'
# Style Guide

This file captures your writing voice and preferences. It starts empty and grows as preferences emerge during the drafting process.

## Voice and Tone

[Will be filled in as drafting reveals your preferences]

## Formatting Conventions

[Citation style, heading conventions, etc.]

## Things to Avoid

[Patterns you've flagged during revision — passive voice, hedging, buzzwords, etc.]
STYLE
    echo "Created: style-guide.md (placeholder — builds during drafting)"
fi

echo ""
echo "--- Project scaffolded successfully ---"
echo ""
echo "Next steps:"
echo "  1. Edit project-config.yaml with your project details"
echo "  2. Replace outline.md with your actual paper outline"
echo "  3. Start a session and tell your AI assistant:"
echo "     'Let's work on my paper — the project config is at $PROJECT_DIR/project-config.yaml'"
echo ""
