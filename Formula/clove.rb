# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.3/clove-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "6a896fffb4c4086608f85c24d2eeda37451cf985660820d834354e255808a167"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.3/clove-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "ebc1754e20252948cf2fbcc54925e822b9dcc3790c7b6da05cca13f98b036e16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.3/clove-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5a4d172f9b779516f1521f2935a4b64dcf3d928de189dd2d1375a0b0b88907c"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.3/clove-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9d627913be3ebd157f0e3b564aa954d760950ecf3d98db6ff098a4bd3b55a53f"
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
