# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.6/clove-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "7be7c775cb2fd5ba2b67572d491c0740a51f0a7c4cb2ca7e6a71abbf3934adb0"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.6/clove-v0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "61a5a4b84f537cc2ea5430d4c37520c3371d53ba2c5e35e3b3d5485992621159"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.6/clove-v0.1.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35d57140bf3f04346756d7ad8747622fb2337d46f0d4324743e2ebfbba6c00cd"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.6/clove-v0.1.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "056b352e15d888805c47c9a683aef6d036c7b47a80effa1230388c5401762d05"
    end
  end

  def install
    bin.install "clove"
    # clove completes dynamically (clap's COMPLETE=<shell>).
    generate_completions_from_executable(bin/"clove", shell_parameter_format: :clap)
  end

  def caveats
    s = <<~EOS
      Let clove cd into new clones (adds one line to your shell rc):
        clove shell-init --install

      Then, in a git repository:
        clove init
        clove new <branch>
    EOS
    if OS.linux?
      s += <<~EOS

        On Linux, clove keeps each repo's clones in a btrfs image. Install
        btrfs-progs from your distribution (e.g. `sudo apt install btrfs-progs`).
      EOS
    end
    s
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clove --version")
    assert_match "init", shell_output("#{bin}/clove --help")
  end
end
