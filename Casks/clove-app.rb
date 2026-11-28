# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove-app.rb.in there, not this file.
cask "clove-app" do
  version "0.1.29"
  sha256 "5457142e23681e1603e4eaae951f55990773e7bb5a3f3f3c3e6e550f260cd0f1"

  url "https://github.com/pierre-borckmans/clove/releases/download/v#{version}/clove-app-v#{version}-universal.dmg"
  name "clove"
  desc "Menu-bar app for clove, copy-on-write git worktrees"
  homepage "https://github.com/pierre-borckmans/clove"

  depends_on macos: :ventura
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
