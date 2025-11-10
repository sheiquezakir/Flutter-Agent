# Installation Guide - Flutter Expert Agent Skills

Complete guide to install and use the Flutter Expert Agent skills in Claude Code.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Install (Choose One)](#quick-install-choose-one)
3. [Verification](#verification)
4. [Usage](#usage)
5. [Troubleshooting](#troubleshooting)
6. [Advanced Configuration](#advanced-configuration)
7. [Uninstallation](#uninstallation)

## Prerequisites

### Required

- **Claude Code** - Latest version
  - Download: https://claude.com/claude-code
  - Or use Claude AI with built-in code interface

- **Git** - For cloning repository
  ```bash
  git --version  # Verify installation
  ```

- **Flutter & Dart** - For using the skills
  ```bash
  flutter --version  # Should be 3.32+
  dart --version     # Should be 3.8+
  ```

### Optional

- **GitHub Account** - For cloning via HTTPS/SSH
- **Text Editor** - For customizing skills
- **Terminal/Command Prompt** - For installation commands

## Quick Install (Choose One)

### Option 1: Clone Full Repository (Recommended for Most Users)

**Best for:** New projects, learning, starting from scratch

```bash
# Clone the repository
git clone https://github.com/sheiquezakir/Flutter-Agent.git
cd Flutter-Agent

# Skills are now available!
# The .claude folder contains all skills
ls .claude/skills/
```

**What you get:**
- ✅ Flutter Expert skill
- ✅ Flutter Security Auditor skill
- ✅ All templates
- ✅ Complete documentation
- ✅ Example projects

**Using the skills:**
```
/use flutter-expert

I want to create a Flutter app...
```

---

### Option 2: Copy to Existing Project (Recommended for Existing Projects)

**Best for:** Adding to an existing Flutter project

```bash
# Download Flutter Agent (if you haven't already)
git clone https://github.com/sheiquezakir/Flutter-Agent.git

# Go to your existing project
cd your-existing-flutter-project

# Copy the .claude folder
cp -r ../Flutter-Agent/.claude .

# Verify
ls .claude/skills/
```

**Verify in Claude Code:**
```
/use flutter-expert

Now the skill is available in YOUR project!
```

**File structure after copy:**
```
your-project/
├── lib/
├── test/
├── .claude/              ← Skills added here
│   ├── skills/
│   │   ├── flutter-expert.md
│   │   └── flutter-security-auditor.md
│   ├── templates/
│   └── docs/
├── pubspec.yaml
└── ...
```

---

### Option 3: Global Installation (Advanced - All Projects)

**Best for:** Power users, multiple projects, system-wide access

#### macOS & Linux

```bash
# Create Claude config directory if it doesn't exist
mkdir -p ~/.config/claude

# Option A: Copy skills only
mkdir -p ~/.config/claude/skills
cp Flutter-Agent/.claude/skills/* ~/.config/claude/skills/

# Option B: Copy entire .claude folder
cp -r Flutter-Agent/.claude ~/.config/claude/

# Verify
ls ~/.config/claude/skills/
```

#### Windows (PowerShell)

```powershell
# Create Claude config directory
$claudePath = "$env:APPDATA\Claude"
New-Item -ItemType Directory -Path $claudePath -Force

# Copy skills
Copy-Item "Flutter-Agent\.claude\skills\*" "$claudePath\skills" -Recurse -Force

# Verify
Get-ChildItem "$claudePath\skills"
```

#### Windows (Command Prompt)

```cmd
# Create Claude config directory
mkdir %APPDATA%\Claude\skills

# Copy skills
xcopy "Flutter-Agent\.claude\skills\*" "%APPDATA%\Claude\skills\" /E /I /Y

# Verify
dir %APPDATA%\Claude\skills
```

**Using globally installed skills:**
```
# Skills are now available in ALL projects
/use flutter-expert

Works in any project!
```

---

### Option 4: Docker Installation (For Containerized Environments)

**Best for:** CI/CD pipelines, isolated environments

```dockerfile
FROM ubuntu:latest

# Install Flutter
RUN curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/linux/flutter_linux_3.32.0-stable.tar.xz | tar xJ -C /opt

# Install Flutter Agent
RUN git clone https://github.com/sheiquezakir/Flutter-Agent.git /opt/flutter-agent

# Setup skills
RUN mkdir -p ~/.config/claude/skills && \
    cp -r /opt/flutter-agent/.claude/skills/* ~/.config/claude/skills/

# Skills ready in container
```

---

## Verification

### Step 1: Verify Claude Code Recognizes Skills

In Claude Code, try:

```
/use flutter-expert
```

**Expected output:**
```
Flutter Expert skill is loading...
```

If you see an error, proceed to [Troubleshooting](#troubleshooting).

### Step 2: Test the Skill

Ask the skill a simple question:

```
/use flutter-expert

What are the key principles of Clean Architecture?
```

**Expected output:**
- Agent responds with architecture explanation
- Shows understanding of Flutter development
- References the skill documentation

### Step 3: Verify Security Auditor

```
/use flutter-security-auditor

What is OWASP Mobile Top 10?
```

### Quick Verification Script

Create a test file `test_skills.sh`:

```bash
#!/bin/bash

echo "🔍 Flutter Expert Agent - Installation Verification"
echo "================================================"

# Check if .claude directory exists
if [ -d ".claude" ]; then
    echo "✅ .claude directory found"
else
    echo "❌ .claude directory NOT found"
    exit 1
fi

# Check if skills directory exists
if [ -d ".claude/skills" ]; then
    echo "✅ .claude/skills directory found"
else
    echo "❌ .claude/skills directory NOT found"
    exit 1
fi

# Check for flutter-expert skill
if [ -f ".claude/skills/flutter-expert.md" ]; then
    echo "✅ flutter-expert.md skill found"
else
    echo "❌ flutter-expert.md skill NOT found"
    exit 1
fi

# Check for security auditor skill
if [ -f ".claude/skills/flutter-security-auditor.md" ]; then
    echo "✅ flutter-security-auditor.md skill found"
else
    echo "❌ flutter-security-auditor.md skill NOT found"
    exit 1
fi

# Count total skills
skill_count=$(ls .claude/skills/*.md 2>/dev/null | wc -l)
echo "✅ Total skills installed: $skill_count"

# Check templates
if [ -d ".claude/templates" ]; then
    template_count=$(find .claude/templates -type d | wc -l)
    echo "✅ Templates available: $((template_count - 1))"
else
    echo "⚠️  Templates directory not found"
fi

echo ""
echo "🎉 Installation verified successfully!"
echo "Run: /use flutter-expert to get started"
```

Run it:

```bash
chmod +x test_skills.sh
./test_skills.sh
```

## Usage

### Basic Usage

After installation, in Claude Code:

```
/use flutter-expert

I want to create a Flutter app with:
- User authentication
- Real-time messaging
- Offline support

Platforms: iOS, Android
Design: Material Design 3
```

### Security Auditing

```
/use flutter-security-auditor

Audit my Flutter app's lib/ folder for:
- OWASP Mobile vulnerabilities
- Hardcoded credentials
- Insecure storage
- Certificate pinning
```

### Accessing Templates

```bash
# Copy a template to your project
cp -r .claude/templates/flutter/clean_architecture ./my-app
cd my-app

# Get dependencies
flutter pub get

# Run
flutter run
```

## Troubleshooting

### Issue: "Skill not found" error

**Solution 1: Verify file location**

```bash
# Check if skills exist
ls -la .claude/skills/flutter-expert.md

# Should output: file exists if present
```

**Solution 2: Reload Claude Code**

```
1. Close Claude Code
2. Wait 5 seconds
3. Reopen Claude Code
4. Try again
```

**Solution 3: Check file permissions**

```bash
# Make sure files are readable
chmod 644 .claude/skills/flutter-expert.md
chmod 644 .claude/skills/flutter-security-auditor.md
```

---

### Issue: "Command not recognized: /use"

**Possible causes:**
- Claude Code not installed
- Using wrong interface (not Claude Code)
- Syntax error in command

**Solution:**
```
1. Verify you're using Claude Code (not regular Claude)
2. Use correct syntax: /use flutter-expert
3. Ensure there's a space after /use
```

---

### Issue: Skills appear but don't work correctly

**Solution 1: Clear cache**

```bash
# Remove Claude cache
rm -rf ~/.cache/claude  # macOS/Linux
rmdir %TEMP%\claude /s  # Windows
```

**Solution 2: Reinstall skills**

```bash
# Option A: Copy fresh from repository
git clone https://github.com/sheiquezakir/Flutter-Agent.git
cp -r Flutter-Agent/.claude .

# Option B: For global installation
cp -r Flutter-Agent/.claude/skills ~/.config/claude/skills
```

---

### Issue: Can't clone repository

**Solution 1: Use HTTPS instead of SSH**

```bash
# Instead of:
git clone git@github.com:sheiquezakir/Flutter-Agent.git

# Use:
git clone https://github.com/sheiquezakir/Flutter-Agent.git
```

**Solution 2: Check internet connection**

```bash
ping github.com
```

**Solution 3: Use GitHub Desktop**

- Download: https://desktop.github.com
- Use GUI to clone the repository

---

### Issue: "Permission denied" errors

**On macOS/Linux:**

```bash
# Make skills readable
chmod -R 755 .claude/

# Make scripts executable if needed
chmod +x test_skills.sh
```

**On Windows (PowerShell - as Administrator):**

```powershell
# Check current permissions
Get-Acl ".claude"

# If needed, run PowerShell as Administrator
```

---

### Issue: macOS - "Cannot open files" error

```bash
# Verify file is not quarantined
xattr -d com.apple.quarantine .claude/skills/*

# If permission issues persist
sudo chown -R $USER .claude/
```

---

## Advanced Configuration

### Custom Skill Configuration

Create `.claude/settings.local.json`:

```json
{
  "skills": {
    "flutter-expert": {
      "enabled": true,
      "priority": 1,
      "tags": ["flutter", "dart", "architecture"]
    },
    "flutter-security-auditor": {
      "enabled": true,
      "priority": 2,
      "tags": ["flutter", "security", "owasp"]
    }
  },
  "templates": {
    "path": ".claude/templates",
    "autoDiscover": true
  }
}
```

### Disable Specific Skills

If you want to use only one skill:

```json
{
  "skills": {
    "flutter-expert": {
      "enabled": true
    },
    "flutter-security-auditor": {
      "enabled": false
    }
  }
}
```

### Custom Skill Paths

Point to custom locations:

```json
{
  "skillPaths": [
    ".claude/skills",
    "~/my-custom-skills",
    "/shared/team-skills"
  ]
}
```

### Environment Variables

Set globally:

```bash
# macOS/Linux
export CLAUDE_SKILLS_PATH=~/.config/claude/skills
export CLAUDE_CONFIG=~/.config/claude/config.json

# Windows (PowerShell)
$env:CLAUDE_SKILLS_PATH = "$env:APPDATA\Claude\skills"
$env:CLAUDE_CONFIG = "$env:APPDATA\Claude\config.json"
```

## Uninstallation

### Remove from Single Project

```bash
# Delete the .claude folder
rm -rf .claude/

# Or on Windows
rmdir .claude /s /q
```

### Remove Global Installation

**macOS/Linux:**

```bash
# Remove from global config
rm -rf ~/.config/claude/skills/flutter-expert.md
rm -rf ~/.config/claude/skills/flutter-security-auditor.md

# Or remove entire skills directory
rm -rf ~/.config/claude/skills
```

**Windows:**

```cmd
# Delete from AppData
del %APPDATA%\Claude\skills\flutter-expert.md
del %APPDATA%\Claude\skills\flutter-security-auditor.md
```

### Keep Templates, Remove Skills Only

```bash
# Remove just the skills, keep templates
rm .claude/skills/flutter-expert.md
rm .claude/skills/flutter-security-auditor.md

# Templates remain for reference
ls .claude/templates/
```

## Getting Help

### Installation Issues

1. **Check [Troubleshooting](#troubleshooting)** - Most common issues covered
2. **GitHub Issues** - Report bugs: https://github.com/sheiquezakir/Flutter-Agent/issues
3. **GitHub Discussions** - Ask questions: https://github.com/sheiquezakir/Flutter-Agent/discussions

### Need Help With Skills?

- **Agent Usage Guide**: See [`docs/AGENT_USAGE.md`](docs/AGENT_USAGE.md)
- **Quick Start**: See [`docs/QUICK_START.md`](docs/QUICK_START.md)
- **Best Practices**: See [`.claude/docs/flutter-guidelines.md`](.claude/docs/flutter-guidelines.md)

## Next Steps After Installation

1. ✅ Verify installation (see [Verification](#verification))
2. 📖 Read [QUICK_START.md](docs/QUICK_START.md)
3. 🎯 Try the [Example Project](examples/todo_app/)
4. 📚 Review [flutter-guidelines.md](.claude/docs/flutter-guidelines.md)
5. 🚀 Start building your Flutter app!

---

**Installation successful! Ready to build amazing Flutter apps with the expert agent! 🎉**

For detailed usage, see [AGENT_USAGE.md](docs/AGENT_USAGE.md) and [QUICK_START.md](docs/QUICK_START.md).

