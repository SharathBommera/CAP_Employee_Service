#!/usr/bin/env bash

set -u

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$PROJECT_DIR" || exit 1

BRANCH="$(git branch --show-current)"

echo "=========================================="
echo "Employee Service - Automatic Git Backup"
echo "Started: $(date)"
echo "Branch : $BRANCH"
echo "=========================================="

if [ -z "$BRANCH" ]; then
    echo "ERROR: No branch is currently checked out."
    exit 1
fi

# Stage all changes
git add -A

# Check whether there is anything to commit
if git diff --cached --quiet; then
    echo "No changes detected. Nothing to push."
    exit 0
fi

COMMIT_MESSAGE="chore: automatic BAS backup $(date '+%Y-%m-%d %H:%M:%S')"

echo "Changes detected."
echo "Creating commit..."

git commit -m "$COMMIT_MESSAGE"

if [ $? -ne 0 ]; then
    echo "ERROR: Commit failed."
    exit 1
fi

echo "Pushing to GitHub..."

git push origin "$BRANCH"

if [ $? -ne 0 ]; then
    echo "ERROR: Push failed."
    exit 1
fi

echo "SUCCESS: Changes pushed to GitHub."
