# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.5/clove-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "3a444cf2e68870e622b47fd3fc6905f7f642d0fea8a24032db61138634d4c9ab"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.5/clove-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "0ccceb5a16c39334c862fac8705b619b498ff2346b01f45242bccb410931c33b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.5/clove-v0.1.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2cd26166bfb682843e83023bcd1ea3df064a2b8a4638b7f7a904b90151a057a8"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.5/clove-v0.1.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "96064b66b31f11de9aa2a31cce31d07fdded502e677c5bfb41ba03449c18eec0"
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
