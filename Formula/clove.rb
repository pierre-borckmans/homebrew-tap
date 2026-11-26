# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.21/clove-v0.1.21-aarch64-apple-darwin.tar.gz"
      sha256 "084d15bb0891c80c909bc2eefb050cb6394546827a4e8321b105f9084ff09bad"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.21/clove-v0.1.21-x86_64-apple-darwin.tar.gz"
      sha256 "5205100bbef5625113e721298dfd7301d8f33800d67d2c781af16351d4cc6920"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.21/clove-v0.1.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2c9a4794483d53d8c47a4237c132e5333cbf0ce58857418fb96e5d160aec851"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.21/clove-v0.1.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5bdf292fb68493b75ac78942f29ed770ad1149e848d21463fc87adc649184484"
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
