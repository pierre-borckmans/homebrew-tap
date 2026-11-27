# Rendered by .github/workflows/release.yml in pierre-borckmans/clove.
# Edit packaging/homebrew/clove.rb.in there, not this file.
class Clove < Formula
  desc "Copy-on-write git worktrees with dependencies already installed"
  homepage "https://github.com/pierre-borckmans/clove"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.23/clove-v0.1.23-aarch64-apple-darwin.tar.gz"
      sha256 "91e7f8a568718a95e28219b8c9f47ad9c9da70c9c0fc029b32f63d5da79d2a16"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.23/clove-v0.1.23-x86_64-apple-darwin.tar.gz"
      sha256 "48e873351d9b02d32843c1713a461f630525e284d56d7b94932442369ae429e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.23/clove-v0.1.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a8e91586ee16e2eeb8a59c993918489c046cbfd26705bcf02cbe613f97d2fe8"
    end
    on_intel do
      url "https://github.com/pierre-borckmans/clove/releases/download/v0.1.23/clove-v0.1.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "edc76747712dee0c6eda697a41a3d692c69f10520852689303ab3668e28acb44"
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
