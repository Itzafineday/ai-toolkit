# AI workshop setup for Windows.
# Run it from PowerShell with:
#   irm https://raw.githubusercontent.com/Itzafineday/ai-toolkit/main/setup/install.ps1 | iex
#
# What it does, in order (safe to run again; it skips anything already done):
#   1. Installs Git, GitHub CLI, the Claude app, Claude Code and gitleaks (via winget).
#   2. Signs you in to GitHub (opens your browser).
#   3. Sets your commits to use GitHub's private email address.
#   4. Copies the hub template into a new PRIVATE repo on your account, in ~\Projects\my-hub.
#   5. Adds the ai-toolkit plugins to Claude Code.
# It never asks for or stores a password.

# 'Continue', not 'Stop': in Windows PowerShell 5.1, 'Stop' turns any native
# command's stderr output into a fatal error. Each step checks $LASTEXITCODE.
$ErrorActionPreference = 'Continue'
function Step($text) { Write-Host "`n== $text" -ForegroundColor Cyan }
function Ok($text)   { Write-Host "   OK: $text" -ForegroundColor Green }
function Stop-Setup($text) { Write-Host "`n   STOPPED: $text" -ForegroundColor Yellow; throw $text }
function Refresh-Path {
  $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' +
              [Environment]::GetEnvironmentVariable('Path', 'User') + ';' +
              "$env:USERPROFILE\.local\bin"
}
function Have($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }

Write-Host "AI workshop setup. This takes about 10 minutes. Keep this window open." -ForegroundColor White

# 1. Apps
Step "1 of 5: Installing apps"
if (-not (Have 'winget')) {
  Stop-Setup "Windows can't find 'winget' (App Installer). Install 'App Installer' from the Microsoft Store, then run this again."
}
$apps = @(
  @{ Id = 'Git.Git';              Name = 'Git';         Cmd = 'git' },
  @{ Id = 'GitHub.cli';           Name = 'GitHub CLI';  Cmd = 'gh' },
  @{ Id = 'Anthropic.Claude';     Name = 'Claude app';  Cmd = $null },
  @{ Id = 'Anthropic.ClaudeCode'; Name = 'Claude Code'; Cmd = 'claude' },
  @{ Id = 'Gitleaks.Gitleaks';    Name = 'gitleaks';    Cmd = 'gitleaks' }
)
foreach ($app in $apps) {
  winget list --id $app.Id -e --accept-source-agreements *> $null
  if ($LASTEXITCODE -eq 0) { Ok "$($app.Name) is already installed"; continue }
  Write-Host "   Installing $($app.Name)..."
  winget install --id $app.Id -e --silent --accept-source-agreements --accept-package-agreements
  if ($LASTEXITCODE -ne 0) { Stop-Setup "$($app.Name) didn't install. Restart the computer and run this again." }
  Ok "$($app.Name) installed"
}
Refresh-Path
foreach ($app in $apps | Where-Object { $_.Cmd }) {
  if (-not (Have $app.Cmd)) { Stop-Setup "$($app.Name) is installed but Windows can't find it yet. Close this window, open a new PowerShell window and run the command again." }
}

# 2. GitHub sign-in
Step "2 of 5: Signing in to GitHub"
gh auth status *> $null
if ($LASTEXITCODE -eq 0) {
  Ok "already signed in"
} else {
  Write-Host "   Your browser will open. Copy the one-time code shown here, paste it there, then approve."
  gh auth login --hostname github.com --git-protocol https --web
  if ($LASTEXITCODE -ne 0) { Stop-Setup "GitHub sign-in didn't finish. Run this again to retry." }
  Ok "signed in"
}
gh auth setup-git *> $null
$login = gh api user --jq .login
$id    = gh api user --jq .id

# 3. Private commit email
Step "3 of 5: Using your private GitHub email for commits"
$noreply = "$id+$login@users.noreply.github.com"
git config --global user.email $noreply
if (-not (git config --global user.name)) { git config --global user.name $login }
Ok "commits will show $login, not your real email"

# 4. Your private hub
Step "4 of 5: Creating your private hub"
$projects = Join-Path $env:USERPROFILE 'Projects'
$hub = Join-Path $projects 'my-hub'
New-Item -ItemType Directory -Force $projects | Out-Null
if (Test-Path (Join-Path $hub '.git')) {
  Ok "hub already exists at ~\Projects\my-hub"
} else {
  Push-Location $projects
  gh repo view "$login/my-hub" *> $null
  if ($LASTEXITCODE -eq 0) {
    gh repo clone "$login/my-hub"
  } else {
    gh repo create my-hub --private --template Itzafineday/hub-template --clone
  }
  Pop-Location
  if (-not (Test-Path (Join-Path $hub '.git'))) { Stop-Setup "The hub wasn't created. Run this again; if it fails twice, send a screenshot to whoever set you up." }
  Ok "private hub created at ~\Projects\my-hub (github.com/$login/my-hub)"
}
git -C $hub config core.hooksPath .githooks
foreach ($label in 'bug', 'feature', 'idea') { gh label create $label --repo "$login/my-hub" --force *> $null }

# 5. Toolkit plugins
Step "5 of 5: Adding the toolkit to Claude Code"
claude plugin marketplace add Itzafineday/ai-toolkit *> $null
claude plugin marketplace update ai-toolkit *> $null
claude plugin install workshop@ai-toolkit
if ($LASTEXITCODE -ne 0) { Stop-Setup "The toolkit didn't install. Run this again." }
Ok "workshop plugin installed"

Write-Host "`nAll done. Go back to the setup guide for the next step." -ForegroundColor Green
