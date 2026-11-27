# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.26/clove-v0.1.26-aarch64-apple-darwin.tar.gz"
      sha256 "98c96f7e1012ec95c9fda0aa1df3d1800583cb1975f2c045901d8d6ed34ef158"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.26/clove-v0.1.26-x86_64-apple-darwin.tar.gz"
      sha256 "d26c5bc10ea4547eb88a39bbaf7cfaf4d028a8499420bd997a2bc11808459721"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.26/clove-v0.1.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dbe63670ab83979c8c7549a2cf64d7ed2b5010c1b5669f81e6f88c79097a6a98"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.26/clove-v0.1.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a091b8d4430f8fdd65778d7f46d22c891aaac3f40330cb16b178bebbc80f893"
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
