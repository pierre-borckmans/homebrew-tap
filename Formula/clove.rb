# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.22/clove-v0.1.22-aarch64-apple-darwin.tar.gz"
      sha256 "3edc4d37a9286c650bece4e7b8a68c25515b5031444cfa5753c0d0df046550d8"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.22/clove-v0.1.22-x86_64-apple-darwin.tar.gz"
      sha256 "18d8ab3ee55f6f9bc5d0acef6c7750e9715fc51518762219e3aff38c1c0993c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.22/clove-v0.1.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a9139355c7502a475bfd3aedbc928872b3a838e28d4035f1f8180be62bbf0f4d"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.22/clove-v0.1.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "366c8888c8effbc2f1911139110b1f4033256827780343ad454a67773e2cd518"
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
