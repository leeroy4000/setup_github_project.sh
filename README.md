
```markdown
# setup_github_project.sh

A bootstrap script for creating or setting up individual GitHub projects.  
This script handles both **new projects** (initializing a repo locally and creating it on GitHub) and **existing projects** (cloning and installing dependencies).  
New projects are created as **private by default** for security.  
At the end of setup, the script automatically generates a VS Code workspace file, recommends useful extensions, verifies SSH connectivity, and launches VS Code directly into the workspace.

---

## 🚀 What the Script Does

- Ensures the GitHub CLI (`gh`) is installed. If not, installs it automatically.
- Prompts whether this is a **new project** or an **existing project**.
- **New project path**:
  - Asks for GitHub username, repo name, and description.
  - Creates a local project directory.
  - Initializes Git, adds a README and `.gitignore`.
  - Commits the initial files and sets branch to `main`.
  - Uses the GitHub CLI (`gh`) to create a **private repo** on GitHub, link it, and push the initial commit.
  - Generates a `.code-workspace` file with sensible defaults and recommended extensions:
    - `ms-python.python`
    - `ms-python.vscode-pylance`
    - `ms-toolsai.jupyter`
  - Launches VS Code into the new workspace.
  - Prints the repo’s GitHub URL and runs an SSH check (`ssh -T git@github.com`) for confirmation.
- **Existing project path**:
  - Asks for GitHub username and repo name.
  - Clones the repo (or pulls updates if already cloned).
  - Installs dependencies from `requirements.txt` system‑wide using `pip --break-system-packages`.
  - Generates a `.code-workspace` file if missing (with the same defaults and extension recommendations).
  - Launches VS Code into the workspace.
  - Prints the repo’s GitHub URL and runs an SSH check for confirmation.

---

## 🛠️ Requirements

- The script will install GitHub CLI (`gh`) automatically if missing.
- You must authenticate once with GitHub CLI:
  ```bash
  gh auth login
  ```
  - Choose GitHub.com
  - Authenticate with SSH
  - Store credentials

---

## ▶️ Installation

To make the script available system‑wide:

1. Clone or download this repository.
2. Make the script executable:
   ```bash
   chmod +x setup_github_project.sh
   ```
3. Move it into `/usr/local/bin`:
   ```bash
   sudo mv setup_github_project.sh /usr/local/bin/setup_github_project.sh
   ```

Now you can run the script from anywhere with:
```bash
setup_github_project.sh
```

---

## 📂 Usage

Run the script:

```bash
setup_github_project.sh
```

You’ll be prompted:

- **New project (yes)** → Creates a private repo on GitHub, pushes the initial commit, generates a workspace, recommends extensions, verifies SSH, and launches VS Code.  
- **Existing project (no)** → Clones or updates the repo, installs dependencies, generates a workspace if missing, recommends extensions, verifies SSH, and launches VS Code.

---

## 📂 Workflow

- Use this script **per project** to bootstrap or set up repos.  
- Combine with `setup_github_environment.sh` (machine‑wide setup) for a complete reproducible workflow.  
- New projects default to **private**. You can change visibility later with:
  ```bash
  gh repo edit --visibility public
  ```

---

## ✅ Notes

- Each machine should already have an SSH key added to GitHub (see environment script).  
- Dependencies are installed system‑wide with `pip --break-system-packages`.  
- Developer tools (`black`, `flake8`, etc.) are installed globally via `pipx` in the environment script.  
- Designed for Debian/Ubuntu/Mint systems. Adjust package manager commands if using another distro.
```
