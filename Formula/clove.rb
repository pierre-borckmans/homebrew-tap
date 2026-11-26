# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.16/clove-v0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "132c4c0eca277e2f942a33c66e5fbe6112a36efff26ba2acbf34c0f162c127d7"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.16/clove-v0.1.16-x86_64-apple-darwin.tar.gz"
      sha256 "4da3e4c1193a5146490a2f3d59f32c34040674e5e5f1c92972473f5562aa62fa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.16/clove-v0.1.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ab8834ebb7b93a0ef166e90347adbdb9fd509e04e8ba50f33ea07de989035c7"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.16/clove-v0.1.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5723d02904d0dca494fcbab5f2fccf361adbddb3189bf1ba230f3c6ee21962c9"
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
