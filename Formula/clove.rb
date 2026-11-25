# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.0/clove-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "be00b90727072e6c7fbb068963a7b3596a732b85c2f0fe6796291173c49b3922"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.0/clove-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "7c7cae5d7cc3779fd24302ad8d22b7e1bb61e8c3166c18f3e2d04f676aba3679"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.0/clove-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b4be36576f854c21461172d6fa200cfd4ba6e54a5eb4639f31a89f0089ad06fb"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.0/clove-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2973cd7307143097781ad854b5cd07fa926d5817b1792304a0d4c00fcb2b7431"
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
