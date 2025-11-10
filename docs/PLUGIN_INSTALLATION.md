# Plugin Installation Guide

Install the Flutter Expert Agent as a Claude Code plugin for easy access across all your projects.

## Quick Install (2 Commands)

```bash
# Step 1: Add the marketplace
/plugin marketplace add sheiquezakir/Flutter-Agent

# Step 2: Install the plugin
/plugin install flutter-agent
```

**Done!** The Flutter Expert and Flutter Security Auditor skills are now available.

## What Gets Installed

When you install the plugin, you get:

- **flutter-expert** skill - Main development expert agent
- **flutter-security-auditor** skill - Security scanning and OWASP compliance
- **Templates** - Clean Architecture, security implementations, CI/CD configs
- **Documentation** - Best practices, guidelines, and examples

## Installation Methods

### Method 1: From GitHub Repository (Recommended)

```bash
/plugin marketplace add sheiquezakir/Flutter-Agent
/plugin install flutter-agent@sheiquezakir/Flutter-Agent
```

### Method 2: Using Relative Path (Local Testing)

For testing during development:

```bash
/plugin marketplace add ./Flutter-Agent
/plugin install flutter-agent
```

### Method 3: Using Full GitHub URL

```bash
/plugin marketplace add https://github.com/sheiquezakir/Flutter-Agent
/plugin install flutter-agent
```

## Verifying Installation

After installation, test that the skills are working:

```
Ask Claude: "I need to build a Flutter app with authentication and offline support"

You should see: Flutter Expert skill automatically activates
```

For security:

```
Ask Claude: "Can you audit my Flutter app for OWASP vulnerabilities?"

You should see: Flutter Security Auditor skill automatically activates
```

## Using the Plugin

Once installed, the Flutter Expert Agent activates automatically when you ask about Flutter topics.

### Example Scenarios

**Building a new app:**
```
I need to create a Flutter app for iOS and Android with:
- User authentication
- Real-time database
- Offline support
- Material Design 3

What's the best architecture?
```

**Code review:**
```
Can you review my Flutter code for security issues?

[Share your code]
```

**Specific features:**
```
How do I implement secure storage for API tokens?
```

**Security audit:**
```
Audit my Flutter app for OWASP Mobile Top 10 compliance.

[Describe your app or share code]
```

## Managing the Plugin

### List Installed Plugins

```bash
/plugin
```

Shows all installed plugins and their status.

### Check Installed Version

```bash
/plugin marketplace list
```

Displays marketplace information including plugin versions.

### Update Plugin

```bash
/plugin marketplace update sheiquezakir/Flutter-Agent
/plugin install flutter-agent --force
```

### Disable Plugin

```bash
/plugin disable flutter-agent
```

Skills won't activate, but plugin remains installed.

### Enable Plugin

```bash
/plugin enable flutter-agent
```

Reactivates the plugin.

### Uninstall Plugin

```bash
/plugin uninstall flutter-agent
```

Completely removes the plugin.

## Accessing Templates and Files

After installation, templates are available in Claude Code. You can:

1. **Ask Claude to use them:**
   ```
   Use the clean architecture template to scaffold my app
   ```

2. **Reference them directly:**
   - Architecture: `skill:flutter-expert:templates/clean_architecture`
   - Security: `skill:flutter-expert:templates/security`
   - CI/CD: `skill:flutter-expert:templates/cicd`

3. **Copy to your project:**
   Claude can copy template files to your project when you ask.

## Troubleshooting

### Plugin Not Found

**Problem:** `/plugin install flutter-agent` says plugin not found

**Solution:**
1. Verify marketplace is added:
   ```bash
   /plugin marketplace list
   ```
   Should show `flutter-agent-marketplace`

2. Re-add marketplace:
   ```bash
   /plugin marketplace add sheiquezakir/Flutter-Agent
   ```

3. Try again:
   ```bash
   /plugin install flutter-agent
   ```

### Skills Not Activating

**Problem:** You ask about Flutter but the skill doesn't activate

**Solutions:**
1. Verify plugin is installed:
   ```bash
   /plugin
   ```
   Look for `flutter-agent` in the list

2. Verify plugin is enabled:
   ```bash
   /plugin enable flutter-agent
   ```

3. Reload Claude Code (sometimes helps):
   - Close and reopen Claude Code
   - Ask your Flutter question again

4. Check plugin status:
   ```bash
   /plugin marketplace update sheiquezakir/Flutter-Agent
   ```

### Skill Activation Too Slow

**Problem:** Skills take a long time to activate

**Solution:** This is normal for first use. Claude needs to:
1. Load the skill metadata
2. Understand when to activate
3. Load relevant templates

Subsequent uses are faster.

### Templates Not Accessible

**Problem:** Can't access templates from the skill

**Solution:**
1. Verify installation:
   ```bash
   /plugin
   ```

2. Ask Claude directly:
   ```
   Show me the clean architecture template from flutter-agent
   ```

3. If still not working, reinstall:
   ```bash
   /plugin uninstall flutter-agent
   /plugin install flutter-agent
   ```

## For Teams

### Installing Across Team

1. **Admin sets up marketplace:**
   ```bash
   /plugin marketplace add sheiquezakir/Flutter-Agent
   ```

2. **Team members install:**
   ```bash
   /plugin install flutter-agent
   ```

3. **Share setup script:**
   Create a `setup-flutter-agent.sh`:
   ```bash
   #!/bin/bash
   /plugin marketplace add sheiquezakir/Flutter-Agent
   /plugin install flutter-agent
   ```

### Private Marketplace (Enterprise)

For organizations wanting to use their own marketplace:

1. **Fork the repository:**
   ```bash
   git clone https://github.com/sheiquezakir/Flutter-Agent.git
   git remote set-url origin https://github.com/YOUR-ORG/flutter-agent
   git push
   ```

2. **Configure team plugin settings:**
   ```bash
   /plugin marketplace add YOUR-ORG/flutter-agent
   /plugin install flutter-agent
   ```

## Advanced Configuration

### Custom Marketplace

Create your own marketplace with this plugin:

1. Create `.claude-plugin/marketplace.json`:
   ```json
   {
     "name": "company-flutter-plugins",
     "owner": {"name": "Company"},
     "plugins": [
       {
         "name": "flutter-agent",
         "source": {"source": "github", "repo": "company/flutter-agent"}
       }
     ]
   }
   ```

2. Add to Claude Code:
   ```bash
   /plugin marketplace add company/flutter-plugins
   ```

### Plugin Restrictions

Some organizations may want restricted versions. Contact the maintainers about:
- Read-only audit plugins
- Limited template access
- Compliance-specific variants

## Next Steps

After installing:

1. **Try the quick start:**
   ```
   I'm new to Flutter. How do I get started?
   ```

2. **Build your first feature:**
   ```
   Help me build a todo app with offline support
   ```

3. **Learn best practices:**
   ```
   What are the best practices for Flutter state management?
   ```

4. **Set up security:**
   ```
   Show me how to implement secure storage
   ```

## Support

- **Issues:** Report problems at https://github.com/sheiquezakir/Flutter-Agent/issues
- **Discussions:** Ask questions at https://github.com/sheiquezakir/Flutter-Agent/discussions
- **Security:** Report vulnerabilities at security@compatio.ai

## Plugin Info

- **Plugin:** flutter-agent
- **Maintainer:** sheiquezakir
- **Repository:** https://github.com/sheiquezakir/Flutter-Agent
- **License:** MIT
- **Latest Version:** 1.2.0

---

**Installed successfully?** Ask Claude to "help me build a Flutter app!" 🎉
