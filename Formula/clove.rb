# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.2/clove-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "e8907255cd23a4ca727eb382f4276bf533262991b35cd4d1a0afc033096c84f7"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.2/clove-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "c995c2385d7330f6e05488b57dff39ed12edb80b3918ae72f4473684b6233eb0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.2/clove-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9487e7199cdbcf97be65f2b65d83766eb6dd7db27b90fe065be00986deb28f80"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.2/clove-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a2bf3496924b73f75909215f4a4ce67d88e47405397ab368bafad23727529a3b"
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
