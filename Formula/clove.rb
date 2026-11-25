# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.11/clove-v0.1.11-aarch64-apple-darwin.tar.gz"
      sha256 "cb7996c1f1c61d982e3402815b2224e7adbef6a7999aad875f8fd735ace0ce3b"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.11/clove-v0.1.11-x86_64-apple-darwin.tar.gz"
      sha256 "2345a800deb222ed7c14df9d71b5cd2c35f5f61d80ce4648d91cf7c71c55c553"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.11/clove-v0.1.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5b1325bed3c203adcb4a31d95baf2d29ca112486d5de38f17085e253e557fe98"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.11/clove-v0.1.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c41c88ee9559db68bc1d2103ac9e70e0ab4c67a822f9db19701c1a2b440016cb"
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
