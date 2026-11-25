# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.7/clove-v0.1.7-aarch64-apple-darwin.tar.gz"
      sha256 "1c8d2b6fc10b6ebf3fec847b73c0f8bbe00305b7994ddeaf12e0d71bdfa0118b"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.7/clove-v0.1.7-x86_64-apple-darwin.tar.gz"
      sha256 "381ed8a8bdfd313afa1bb5c9fbd4c6ee47c3d93b8d2249eb2dd963a04ae3e412"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.7/clove-v0.1.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5898bc5a1a94fb099a4c9683ce46eacf4ed3ec20a9a888a3bcdd1997272ffc1f"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.7/clove-v0.1.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d563bcf7b8a652d8e62c50f3f7bcbea8bf5644ead911d287dae06698fed141b6"
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
