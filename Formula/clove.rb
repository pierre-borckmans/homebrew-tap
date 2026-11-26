# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.20/clove-v0.1.20-aarch64-apple-darwin.tar.gz"
      sha256 "d5bd306978060adba734d76edde1a9935e6b8274b65eac8079efa40b7ba363f6"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.20/clove-v0.1.20-x86_64-apple-darwin.tar.gz"
      sha256 "92ae530a82d2a16f5528a9f5eddccc5060f555f24e05fc7553a6487b6ec791ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.20/clove-v0.1.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ae09a4617719415af6274f575cff8e94bad4f874c9cffa6bd3d3d12261f4b921"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.20/clove-v0.1.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "912dbd891b9423ed68076350ff80c07a770d58c9b3959afde19fde6c050f4ca3"
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
