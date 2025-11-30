#!/usr/bin/env bash
set -e  # exit on error

echo "🚀 GitHub Project Setup"

# --- Ensure GitHub CLI is installed ---
if ! command -v gh &> /dev/null; then
  echo "📦 Installing GitHub CLI (gh)..."
  sudo apt update
  sudo apt install -y gh
  echo "✅ GitHub CLI installed."
else
  echo "✅ GitHub CLI already installed."
fi

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

  # --- Create VS Code workspace file ---
  cat > "${WORK_DIR}/${REPO_NAME}.code-workspace" <<EOF
{
  "folders": [
    {
      "path": "."
    }
  ],
  "settings": {
    "python.defaultInterpreterPath": "python3",
    "editor.formatOnSave": true,
    "files.exclude": {
      "**/__pycache__": true,
      "**/*.pyc": true
    }
  },
  "extensions": {
    "recommendations": [
      "ms-python.python",
      "ms-python.vscode-pylance",
      "ms-toolsai.jupyter"
    ]
  }
}
EOF

  echo "💻 Launching VS Code..."
  code "${WORK_DIR}/${REPO_NAME}.code-workspace"

  echo "🔗 Repo linked to GitHub at git@github.com:${GITHUB_USER}/${REPO_NAME}.git"
  ssh -T git@github.com || true
  echo "✅ New private project created, pushed, and opened in VS Code!"

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
    git clone "$REPO_URL" "$WORK
