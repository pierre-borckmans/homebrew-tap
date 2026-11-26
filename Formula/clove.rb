# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.14/clove-v0.1.14-aarch64-apple-darwin.tar.gz"
      sha256 "cbe21a95198524fc182f7748d5000589d6877100a74dd97eec755990e9966001"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.14/clove-v0.1.14-x86_64-apple-darwin.tar.gz"
      sha256 "de6c377eed68917b20ea6fb6a35bac29d5c53de1e8c1e6e4ee3cc316518946ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.14/clove-v0.1.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6d7e97724ed688a8f653225943bb92ff48f380dd45f43f72b33355a9b61f6505"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.14/clove-v0.1.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "107466c2f02769122aa80fd5be9fd3780473ac1905f68c27c0a1af27548ead17"
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
