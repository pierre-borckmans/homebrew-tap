# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove-app.rb.in there, not this file.
cask "clove-app" do
  version "0.1.28"
  sha256 "0ca7aa09e34030c3363c993492111d450573a50e3f8c77045ace65b9184c33fd"

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
