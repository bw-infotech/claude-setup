#!/bin/bash
set -e

# Determine base projects directory based on OS
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
  BASE_DIR="C:/srv/projects"
else
  BASE_DIR="/srv/projects"
fi

# Ask for project name
read -p "Enter project name: " PROJECT_NAME

if [[ -z "$PROJECT_NAME" ]]; then
  echo "Error: Project name cannot be empty."
  exit 1
fi

PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"

# Create project directory
if [ -d "$PROJECT_DIR" ]; then
  echo "Project directory already exists: $PROJECT_DIR"
else
  mkdir -p "$PROJECT_DIR"
  echo "Created project directory: $PROJECT_DIR"
fi

# Initialize git repo if not already one
if [ ! -d "$PROJECT_DIR/.git" ]; then
  git init "$PROJECT_DIR"
  echo "Initialized git repository in $PROJECT_DIR"
fi

# Run all other .sh scripts in this directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for script in "$SCRIPT_DIR"/*.sh; do
  # Skip this install script itself
  [ "$(basename "$script")" = "install.sh" ] && continue

  echo ""
  echo "Running $(basename "$script")..."
  bash "$script" "$PROJECT_DIR"
done

echo ""
echo "Setup complete for $PROJECT_DIR"
