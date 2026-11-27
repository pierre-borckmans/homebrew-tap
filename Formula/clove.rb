# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.25/clove-v0.1.25-aarch64-apple-darwin.tar.gz"
      sha256 "5d6f2911da4f01a78f3232c92020edca1d724c7929df9689602702524a05b804"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.25/clove-v0.1.25-x86_64-apple-darwin.tar.gz"
      sha256 "4739837e460407ad7868665aa80e8ea0cf01b30a41586d63616dffc11ae9f53a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.25/clove-v0.1.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "38a1f927251cddd292e41476985a78d8512a969ec6ff84898273fb7f7e85925c"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.25/clove-v0.1.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bfe37293890b52f35e50d7f15370a77c566b5c7f497ac6e8e09012dd85bbb434"
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
