# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.28/clove-v0.1.28-aarch64-apple-darwin.tar.gz"
      sha256 "81a2862b2bf82d699a903077c7d35060a3c41fec25c021fdb08b44d6382010d9"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.28/clove-v0.1.28-x86_64-apple-darwin.tar.gz"
      sha256 "e5388da079b8113a1b731157025b422e9be85b8fb8ccee7eea02eec3d6fb0163"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.28/clove-v0.1.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e7a599943a0189945746ace6c31b4c547e60b5b69f4ed08c28892028090ffbe"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.28/clove-v0.1.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b8142b31fe360f29e4721ae70dbd161780d4e497c762c252b35ca60b1c2c035"
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
