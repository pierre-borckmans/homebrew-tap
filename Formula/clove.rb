# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.10/clove-v0.1.10-aarch64-apple-darwin.tar.gz"
      sha256 "0788e30329ddf93dfcd9bd6c54d25805c1e60288318efbab92143827ecc0b521"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.10/clove-v0.1.10-x86_64-apple-darwin.tar.gz"
      sha256 "a48928edeab91539be0512cccdf2b65d7b2c26d9e44565b9d3cd5154db3fd458"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.10/clove-v0.1.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "403d920757202c328daead3819d8b4e69133371269dd14b6dcf8824f17071849"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.10/clove-v0.1.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ce88427a8651dc115616d69f65933762d9e3c509135a1ebf64baf32b49f7c1d8"
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
