# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.4/clove-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "7e0b8a7a0633e629ffb07d341a90f1d8925d62fa4eccbe891fe1ad3bf273ea5e"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.4/clove-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "1c1dec84425b061249fd182bb682fa57baf505e7d68f21e68f7d5bb30e964341"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.4/clove-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cf888aca63d90065fc3187259328d07ee6e37db2f825176281a886db1c7886ff"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.4/clove-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c6bfd714d23629bf56cff0f5d6a4148242c349934ce2965a33bb784b9e47ee37"
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
