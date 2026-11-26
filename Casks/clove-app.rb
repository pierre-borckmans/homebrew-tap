# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove-app.rb.in there, not this file.
cask "clove-app" do
  version "0.1.20"
  sha256 "34b0da7c1da1f6dfa3011cdf5e8f042e6ad19acbfa39f450ded781c2fa48ee24"

  url "https://github.com/pierre-borckmans/clove/releases/download/v#{version}/clove-app-v#{version}-universal.dmg"
  name "clove"
  desc "Menu-bar app for clove, copy-on-write git worktrees"
  homepage "https://github.com/pierre-borckmans/clove"

  depends_on macos: ">= :ventura"
  # The background service and agent hooks run the CLI.
  depends_on formula: "pierre-borckmans/tap/clove"

  app "clove.app"

  # Clones and golden images live in ~/.clove and the repos' clone folders;
  # removing the app never touches them.
  zap trash: [
    "~/Library/Application Support/dev.clove.desktop",
    "~/Library/Caches/dev.clove.desktop",
    "~/Library/Preferences/dev.clove.desktop.plist",
    "~/Library/WebKit/dev.clove.desktop",
  ]
end
