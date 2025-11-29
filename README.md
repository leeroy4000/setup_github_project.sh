
```markdown
# setup_github_project.sh

A bootstrap script for creating or setting up individual GitHub projects.  
This script handles both **new projects** (initializing a repo locally and creating it
on GitHub) and **existing projects** (cloning and installing dependencies).  
New projects are created as **private by default** for security.

---

## 🚀 What the Script Does

- Ensures the GitHub CLI (`gh`) is installed. If not, it installs it automatically.
- Prompts whether this is a **new project** or an **existing project**.
- **New project path**:
  - Asks for GitHub username, repo name, and description.
  - Creates a local project directory.
  - Initializes Git, adds a README and `.gitignore`.
  - Commits the initial files and sets branch to `main`.
  - Uses the GitHub CLI (`gh`) to create a **private repo** on GitHub, link it,
    and push the initial commit.
- **Existing project path**:
  - Asks for GitHub username and repo name.
  - Clones the repo (or pulls updates if already cloned).
  - Installs dependencies from `requirements.txt` system‑wide using
    `pip --break-system-packages`.
  - Prints a hint to open the project in VS Code.

---

## 🛠️ Requirements

- GitHub CLI (`gh`) is required, but the script will install it automatically if
  missing.
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

- **New project (yes)** → Creates a private repo on GitHub and pushes the initial commit.  
- **Existing project (no)** → Clones or updates the repo and installs dependencies.

---

## 📂 Workflow

- Use this script **per project** to bootstrap or set up repos.  
- Combine with `setup_github_environment.sh` (machine‑wide setup) for a complete
  reproducible workflow.  
- New projects default to **private**. You can change visibility later with:
  ```bash
  gh repo edit --visibility public
  ```

---

## ✅ Notes

- Each machine should already have an SSH key added to GitHub (see environment script).  
- Dependencies are installed system‑wide with `pip --break-system-packages`.  
- Developer tools (`black`, `flake8`, etc.) are installed globally via `pipx`
  in the environment script.  
- Designed for Debian/Ubuntu/Mint systems. Adjust package manager commands if using another
  distro.
```
