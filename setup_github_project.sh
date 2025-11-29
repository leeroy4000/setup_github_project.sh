#!/usr/bin/env bash
set -e  # exit on error

echo "🚀 GitHub Project Setup"

read -p "Is this a new project (yes/no)? " NEW_PROJECT

if [[ "$NEW_PROJECT" == "yes" ]]; then
  # --- New project setup ---
  read -p "Enter your GitHub username: " GITHUB_USER
  read -p "Enter the new repository name: " REPO_NAME
  read -p "Enter a short project description: " DESCRIPTION

  WORK_DIR="$HOME/${REPO_NAME}"

  echo "📂 Creating new project directory..."
  mkdir -p "$WORK_DIR"
  cd "$WORK_DIR"

  echo "📂 Initializing Git repo..."
  git init
  echo "# ${REPO_NAME}" > README.md
  echo "${DESCRIPTION}" >> README.md
  touch .gitignore
  echo "venv/" >> .gitignore
  echo "__pycache__/" >> .gitignore

  git add .
  git commit -m "Initial commit"
  git branch -M main

  echo "🔗 Creating PRIVATE repo on GitHub via gh..."
  gh repo create "${GITHUB_USER}/${REPO_NAME}" --private --source=. --remote=origin --push

  echo "✅ New private project created and pushed to GitHub!"

else
  # --- Existing project setup ---
  read -p "Enter your GitHub username: " GITHUB_USER
  read -p "Enter the repository name: " REPO_NAME

  REPO_URL="git@github.com:${GITHUB_USER}/${REPO_NAME}.git"
  WORK_DIR="$HOME/${REPO_NAME}"

  echo "🚀 Setting up existing project $REPO_NAME..."

  if [ -d "$WORK_DIR/.git" ]; then
    echo "📂 Repo already exists, pulling latest..."
    cd "$WORK_DIR"
    git pull
  else
    echo "📂 Cloning repo..."
    git clone "$REPO_URL" "$WORK_DIR"
    cd "$WORK_DIR"
  fi

  # --- Install Python dependencies (system-wide) ---
  if [ -f "requirements.txt" ]; then
    echo "🐍 Installing Python dependencies system-wide..."
    python3 -m pip install -r requirements.txt --break-system-packages
  else
    echo "⚠️ No requirements.txt found, skipping."
  fi

  echo "💡 Open VS Code with:"
  echo "   code $WORK_DIR"

  echo "✅ Existing project setup complete!"
fi
