# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.30/clove-v0.1.30-aarch64-apple-darwin.tar.gz"
      sha256 "8ef285fcdcf56a99ef6d7afd7291d99efe90d852f6cba81e1b7d4aeb570fa2bd"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.30/clove-v0.1.30-x86_64-apple-darwin.tar.gz"
      sha256 "88e0022f769142d2001bf873cc3a0f0afb84bae71bd0b5298971f17fe6660b9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.30/clove-v0.1.30-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7b12a2367db1c0c2f35d1876db46b042ec1bc8228b3a0c2e69a7cc4009beebca"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.30/clove-v0.1.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "82d16962066486ac46f6f75b8e3d599f9f9602b532957bc394923e7ae9955b89"
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
