# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.18/clove-v0.1.18-aarch64-apple-darwin.tar.gz"
      sha256 "ce46b8afdbb458ff9a1f1001b40cd321c74f85c3620bead9ef226d6bd41e1c2b"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.18/clove-v0.1.18-x86_64-apple-darwin.tar.gz"
      sha256 "6eee327e0d844320583105c1231472a4ce2dd8a62b8fadff07ee9ef0681dbe35"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.18/clove-v0.1.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5eb05a2ff49de2e861d364fcd667dba440cc2ab9f2d7e54fc8644cb8fa411270"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.18/clove-v0.1.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "83fe528d663c70236efda4d023e3c785a53bb954f3a9d71549ebe1fff5afe9a6"
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
