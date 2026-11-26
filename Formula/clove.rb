# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.12/clove-v0.1.12-aarch64-apple-darwin.tar.gz"
      sha256 "ab3dc9ade70f2ac0efcdf04e63cbe792a103fbc1fe16a7ea81ea4e9939ea74d3"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.12/clove-v0.1.12-x86_64-apple-darwin.tar.gz"
      sha256 "6d94c3e1f6bddca7824f0660156c83c5026e8e575b9a16cc87e766616af4276b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.12/clove-v0.1.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a732bd19068b6423af668ea9f38f3dc91e87fddb49b2ed60bd12565b534a8b63"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.12/clove-v0.1.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "043ea96e258698244b97a78f5978b20dc56296293dd4fe9700a1037d9e462af8"
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
