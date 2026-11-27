# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.27/clove-v0.1.27-aarch64-apple-darwin.tar.gz"
      sha256 "9d69c3fe7b0d591db78fe4c5c8b2db4a88328afb9d4d36129c4c4487fce51512"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.27/clove-v0.1.27-x86_64-apple-darwin.tar.gz"
      sha256 "c52442aa408fa75cb5bbdfa9d8a13e49c64a76b7440fe9777039ba3aead7000b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.27/clove-v0.1.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9cd559345459fd45b547d3c576de5f42a360636c5415e5ab442492385b9b6950"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.27/clove-v0.1.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ebdd1e5b4c3a6cf469f396405e5d513b69a40175e88a01849bbf4741b6d5562a"
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
