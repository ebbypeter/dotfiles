# Dotfiles Config backup for Windows

## Git Configurations

```powershell
# Create a Symbolic Link to the Git Configurations Folder
New-Item -Path ~/Git -ItemType SymbolicLink -Target [dotfiles-Repo-Directory]\appConfigs\git\

# Copy the main .gitconfig file to the User's Home Directory
cp [dotfiles-Repo-Directory]\appConfigs\git\.gitconfig ~\.gitconfig
```

## AI Configurations

### Copilot Configurations

```powershell
# Create a Symbolic Link to the Skills Folder
New-Item -Path ~\.copilot\skills -ItemType SymbolicLink -Target [dotfiles-Repo-Directory]\ai-assets\skills\
```
