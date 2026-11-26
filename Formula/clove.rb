# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.13/clove-v0.1.13-aarch64-apple-darwin.tar.gz"
      sha256 "cce415b7dde081a91998277b8483ceea933ea307168af0c32aacfbdf53f7d1d7"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.13/clove-v0.1.13-x86_64-apple-darwin.tar.gz"
      sha256 "b09e26adf02b96f4de99cb5a31405bbcffa3a85205cdb25d807957d80cabc4af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.13/clove-v0.1.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "497560c08f906e394d3f54e5a9035df8176ee37a85e31f8a4ed0dcd31cfa5c3b"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.13/clove-v0.1.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "159febfc31fe07b90321b1717563b166883fe310236d49175d1a14698837009e"
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
