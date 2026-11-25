# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.1/clove-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "0f1aafb46787fddb04f815a95e226ff6717503e9d5d8b8fbd195688d08d68339"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.1/clove-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "2233e919dd12cfb1fd66c25fd014f3c453e4ce5c4a4819124346ce9d3ece12ea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.1/clove-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f71daa6516a0d99967e725c7b5a8380a38c06baf835f3c9fc549336eff883353"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.1/clove-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c3fb87396060eacac4f5a3cd66d3bc25a4585306e1c0ffd7aff18724333e5c8"
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
