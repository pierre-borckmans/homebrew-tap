# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.8/clove-v0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "0d2783d0d3c31ec4851ddc21795e79ac42b2f3943305e84c801ac284a2a7dd7c"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.8/clove-v0.1.8-x86_64-apple-darwin.tar.gz"
      sha256 "64baa5bb81a94047bc142f0b1311f81c0d3124a6e9401ffa3be0706dcfd78547"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.8/clove-v0.1.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d5a8aa633e1b99497ccb9a6a29f7c26b7e35149e7d927225d9bc203075a4c045"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.8/clove-v0.1.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "db7ee85203918b62f119c62f41967c2ac2016d2f0f4cf3b6ffb66e2e57c2f40e"
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
