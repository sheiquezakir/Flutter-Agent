# Migration Guide - v1.0.0 → v1.1.0

Official Claude Skills Format Update

## What Changed?

The Flutter Expert Agent has been updated to use the official Claude Skills format. This is a **breaking change** that affects how skills are stored and discovered.

### Summary of Changes

| Aspect | Before (v1.0.0) | After (v1.1.0) |
|--------|-----------------|-----------------|
| **Skill Location** | `.claude/skills/flutter-expert.md` | `.claude/skills/flutter-expert/SKILL.md` |
| **Structure** | Single `.md` file | Folder with SKILL.md + README.md |
| **Invocation** | Manual `/use flutter-expert` | Automatic based on context |
| **Discovery** | Manual file search | Automatic folder scanning |
| **Format** | Markdown instructions | Official Claude Skills format |

## Why the Change?

✅ **Official Compatibility** - Uses Claude's official skills format
✅ **Automatic Activation** - Skills activate without manual invocation
✅ **Better Organization** - Folder-based structure for scalability
✅ **Improved Documentation** - Each skill has dedicated README
✅ **Future-Proof** - Ready for Claude Skills API and marketplace

## Migration Steps

### Step 1: Back Up Your Current Installation

```bash
# Save your current installation
cp -r Flutter-Agent Flutter-Agent.backup
```

### Step 2: Delete Old Skill Files

```bash
# Remove old single-file format
rm .claude/skills/flutter-expert.md
rm .claude/skills/flutter-security-auditor.md

# Verify new structure exists
ls -la .claude/skills/
# Should show: flutter-expert/ and flutter-security-auditor/
```

### Step 3: Update Your Projects

**If you copied `.claude` to your project:**

```bash
# Remove old .claude folder
rm -rf .claude

# Copy new format from updated Flutter-Agent
cp -r Flutter-Agent/.claude .
```

**If you're using global installation:**

```bash
# Update global skills
cp -r Flutter-Agent/.claude/skills/* ~/.config/claude/skills/

# On Windows (PowerShell):
Copy-Item "Flutter-Agent\.claude\skills\*" "$env:APPDATA\Claude\skills" -Recurse -Force
```

### Step 4: Test Skills Work

Instead of:
```
/use flutter-expert

How do I build an app?
```

Now just ask naturally:
```
How do I build a Flutter app with Clean Architecture?

[Claude automatically activates the skill]
```

### Step 5: Update Your Workflow

**Old workflow:**
```
1. /use flutter-expert
2. Ask question
3. Skill provides answer
```

**New workflow:**
```
1. Ask Flutter question naturally
2. Claude automatically activates skill
3. Skill provides answer
```

## Backward Compatibility

⚠️ **Important**: v1.0.0 and v1.1.0 are NOT compatible.

If you try to use old `/use` commands:
```
❌ /use flutter-expert
Error: Skill not found

✅ Just ask about Flutter:
"I need to build a Flutter app..."
[Skill activates automatically]
```

## Common Questions

### Q: Do I need to update?

**A:** Not immediately. v1.0.0 still works locally. But v1.1.0 is recommended because:
- Works with official Claude Skills format
- Better automatic activation
- Future compatibility with Skills API

### Q: What if I want to stay on v1.0.0?

**A:** You can keep using your old installation. But:
- No more updates to v1.0.0
- Manual `/use` invocation required
- Won't work with future Claude Skills features

### Q: Will my projects break?

**A:** Only if you update the `.claude` folder. Keep a backup to be safe.

### Q: Can I have both v1.0.0 and v1.1.0?

**A:** Yes, in different projects or directories. But don't mix them.

### Q: How do I know which version I have?

Check your skills folder:

```bash
# v1.0.0: Single .md files
ls .claude/skills/*.md

# v1.1.0: Folder structure
ls -d .claude/skills/*/
```

## New Features in v1.1.0

✨ **Automatic Skill Activation**
- Skills activate based on context
- No manual `/use` commands needed
- See skill activation in chain of thought

✨ **Better Organization**
- Each skill has dedicated README
- Folder-based structure for templates
- Resources directory for each skill

✨ **Official Format**
- Aligns with Claude Skills specification
- Compatible with future Skills API
- Ready for Skills Marketplace

✨ **Improved Documentation**
- Clear activation patterns
- Coordination with other skills
- Better resource organization

## Troubleshooting

### Issue: Skills not activating

**Solution:**
1. Verify folder structure: `.claude/skills/flutter-expert/SKILL.md`
2. Reload Claude Code
3. Ask naturally about Flutter (no `/use` commands)
4. Check Claude recognizes skills in settings

### Issue: Getting errors about skill format

**Solution:**
- Ensure you're using the new v1.1.0 format
- Don't mix old `.md` files with new folders
- Delete `.claude/skills/*.md` files if they exist

### Issue: Old `/use flutter-expert` commands don't work

**Solution:**
- This is expected in v1.1.0
- Just ask about Flutter naturally
- Skills activate automatically

## Rollback to v1.0.0

If you need to go back:

```bash
# Restore from backup
rm -rf .claude
cp -r .claude.backup .claude

# Or re-clone v1.0.0 from git history
git checkout v1.0.0 -- .claude/
```

## Need Help?

- See [INSTALLATION.md](INSTALLATION.md) for current setup
- See [README.md](README.md) for overview
- Check [docs/SKILL_INSTALLATION.md](docs/SKILL_INSTALLATION.md) for technical details
- Ask in [GitHub Discussions](https://github.com/sheiquezakir/Flutter-Agent/discussions)

## Version Timeline

| Version | Released | Status | Format |
|---------|----------|--------|--------|
| v1.0.0  | 2025-01-10 | Legacy | Single .md files |
| v1.1.0  | 2025-01-10 | Current | Official folder format |
| v2.0.0  | TBD | Future | Skills API ready |

## File Changes Summary

**Deleted:**
- `.claude/skills/flutter-expert.md`
- `.claude/skills/flutter-security-auditor.md`

**Added:**
- `.claude/skills/flutter-expert/SKILL.md` (moved from .md)
- `.claude/skills/flutter-expert/README.md` (new)
- `.claude/skills/flutter-security-auditor/SKILL.md` (moved from .md)
- `.claude/skills/flutter-security-auditor/README.md` (new)

**Updated:**
- `README.md` - New format examples
- `INSTALLATION.md` - Updated setup instructions
- `docs/QUICK_START.md` - Automatic activation guide
- `CHANGELOG.md` - Version history

---

**Migration complete! Welcome to v1.1.0 🎉**

For questions, see [GitHub Discussions](https://github.com/sheiquezakir/Flutter-Agent/discussions) or [SECURITY.md](SECURITY.md).
