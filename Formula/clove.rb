# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.29/clove-v0.1.29-aarch64-apple-darwin.tar.gz"
      sha256 "fda47113e1000042a15a54900fb72d82058835658600d31974541b484ac6f26c"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.29/clove-v0.1.29-x86_64-apple-darwin.tar.gz"
      sha256 "3c763e811df164158abc55311a9402b809cab9449ca59d5db43a7663a3609dd9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.29/clove-v0.1.29-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b87ddd633ae4c71670175facf5ab1120fc886eec92cc0c1e9918bdcb797440d0"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.29/clove-v0.1.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6486aec328567c679b547097c62da36f029b403da3361b5ffd91a230af66c261"
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
