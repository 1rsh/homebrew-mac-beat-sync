class MacBeatSync < Formula
  include Language::Python::Virtualenv

  desc "Real-time audio-reactive keyboard brightness controller for macOS"
  homepage "https://github.com/1rsh/mac-beat-sync"
  url "https://github.com/1rsh/mac-beat-sync/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b57fc2570447b622e7d2ea5f47b10e3018d348a788265342563cdd8e74dc3fa9"
  license "MIT"
  head "https://github.com/1rsh/mac-beat-sync.git", branch: "main"

  depends_on "python@3.11"
  depends_on "mac-brightnessctl"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      🎧 mac-beat-sync has been installed!

      Run:
        mac-beat-sync

      Make sure `mac-brightnessctl` is installed and accessible in your PATH.
      You can install it via Homebrew:
        brew install mac-brightnessctl
    EOS
  end

  test do
    system "#{bin}/mac-beat-sync", "--help"
  end
end
