# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.24/clove-v0.1.24-aarch64-apple-darwin.tar.gz"
      sha256 "375d47ef27c6833c474127aa52bfc4b9ea28f0ebb85ad7ef6932bea86b28b70e"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.24/clove-v0.1.24-x86_64-apple-darwin.tar.gz"
      sha256 "33859d57752d4b54822ff3432a0bfb597c5b2834ebe520d3fd440d15235d7153"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.24/clove-v0.1.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb9a4c633efc4d678068c633d06a0847b871b6368419b2cc72550182ac6ea4f0"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.24/clove-v0.1.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6743892d8d266c7e7ce8ec6bf973f1280182b835aa3021f6eed75e7436ab062a"
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
