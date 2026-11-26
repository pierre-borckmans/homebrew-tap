# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.19/clove-v0.1.19-aarch64-apple-darwin.tar.gz"
      sha256 "173f0d54e80e9c4384a1b8e191721879ad3bea1a1baf4f817d29da7a9ce4b397"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.19/clove-v0.1.19-x86_64-apple-darwin.tar.gz"
      sha256 "34baec6803fbe7d2dca01a90c46de9735ed68efa69fdf910f6ef0ccd3f0d0386"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.19/clove-v0.1.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cd7d95c81e1d928cb294d557ec75f19eac801c504e312ac4ebf129c368ad6d93"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.19/clove-v0.1.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c84db5946f4a5b2275e64aae8a98049ffb8b35690fc1e3882aed02fe6b3c665"
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
