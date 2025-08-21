#!/bin/bash

# Claude Code Agents Installation Script
# This script installs all agents from wshobson/agents repository to ClaudeCode

AGENTS_DIR="$HOME/AppData/Roaming/ClaudeCode/agents"
SOURCE_DIR="E:/data/claudecode/test4/temp_agents_repo"
LOG_FILE="E:/data/claudecode/test4/clagen/installation.log"

echo "===== Claude Code Agents Installation =====" | tee "$LOG_FILE"
echo "Date: $(date)" | tee -a "$LOG_FILE"
echo "Source: https://github.com/wshobson/agents" | tee -a "$LOG_FILE"
echo "Target: $AGENTS_DIR" | tee -a "$LOG_FILE"
echo "=========================================" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Create agents directory if it doesn't exist
mkdir -p "$AGENTS_DIR"

# Counter for statistics
installed=0
skipped=0
failed=0

# Process each agent file
for agent_file in "$SOURCE_DIR"/*.md; do
    if [[ "$agent_file" == *"README.md" ]] || [[ "$agent_file" == *"LICENSE"* ]]; then
        continue
    fi
    
    basename=$(basename "$agent_file")
    agent_name="${basename%.md}"
    
    # Check if agent already exists
    if [ -f "$AGENTS_DIR/$basename" ]; then
        echo "[-] Skipping $agent_name (already exists)" | tee -a "$LOG_FILE"
        ((skipped++))
    else
        # Copy the agent file
        if cp "$agent_file" "$AGENTS_DIR/$basename"; then
            echo "[+] Installed $agent_name" | tee -a "$LOG_FILE"
            ((installed++))
        else
            echo "[!] Failed to install $agent_name" | tee -a "$LOG_FILE"
            ((failed++))
        fi
    fi
done

echo "" | tee -a "$LOG_FILE"
echo "===== Installation Summary =====" | tee -a "$LOG_FILE"
echo "Installed: $installed agents" | tee -a "$LOG_FILE"
echo "Skipped: $skipped agents (already existed)" | tee -a "$LOG_FILE"
echo "Failed: $failed agents" | tee -a "$LOG_FILE"
echo "================================" | tee -a "$LOG_FILE"