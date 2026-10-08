#!/bin/bash

PROJECT_DIR="/home/user/projects/employeeservice"
BACKUP_SCRIPT="$PROJECT_DIR/scripts/github-backup.sh"
LOG_DIR="/home/user/.logs"
LOG_FILE="$LOG_DIR/backup-scheduler.log"
PID_FILE="$LOG_DIR/backup-scheduler.pid"

INTERVAL=1800   # 30 minutes

mkdir -p "$LOG_DIR"

# Prevent multiple scheduler instances
if [ -f "$PID_FILE" ]; then
    OLD_PID=$(cat "$PID_FILE")

    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Scheduler already running with PID $OLD_PID"
        exit 0
    fi
fi

echo $$ > "$PID_FILE"

cleanup() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Scheduler stopped" >> "$LOG_FILE"
    rm -f "$PID_FILE"
    exit 0
}

trap cleanup SIGTERM SIGINT EXIT

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Scheduler started with PID $$" >> "$LOG_FILE"

while true; do

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running GitHub backup..." >> "$LOG_FILE"

    cd "$PROJECT_DIR" || {
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Cannot access project directory" >> "$LOG_FILE"
        sleep "$INTERVAL"
        continue
    }

    "$BACKUP_SCRIPT" >> "$LOG_FILE" 2>&1

    EXIT_CODE=$?

    if [ "$EXIT_CODE" -eq 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup completed successfully." >> "$LOG_FILE"
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Backup failed with exit code $EXIT_CODE" >> "$LOG_FILE"
    fi

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Next backup in 30 minutes." >> "$LOG_FILE"

    sleep "$INTERVAL"

done
