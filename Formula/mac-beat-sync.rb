class MacBeatSync < Formula
  include Language::Python::Virtualenv

  desc "Real-time audio-reactive keyboard brightness controller for macOS"
  homepage "https://github.com/1rsh/mac-beat-sync"
  url "https://github.com/1rsh/mac-beat-sync/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "1fe4b8ffaf178197ea5e0b9f75d3f9e33daa414c1102d3fd8a39704dfdee3aa2"
  license "MIT"
  head "https://github.com/1rsh/mac-beat-sync.git", branch: "main"

  depends_on "python@3.11"

  def install
    # Create isolated Python environment
    venv = virtualenv_create(libexec, Formula["python@3.11"].opt_bin/"python3")

    # Install dependencies if requirements.txt exists
    reqs = buildpath/"requirements.txt"
    if reqs.exist?
      venv.pip_install ["--upgrade", "pip", "setuptools", "wheel"]
      venv.pip_install reqs
    end

    # Install mac-beat-sync package and symlink its CLI
    venv.pip_install_and_link buildpath
  end

  def caveats
    <<~EOS
      🎧 mac-beat-sync has been installed successfully!

      ▶ To start the controller:
         mac-beat-sync

      ⚙️  Dependency note:
         This tool relies on `mac-brightnessctl` for brightness control.
         If not already installed, run:
           brew tap rakalex/mac-brightnessctl
           brew install mac-brightnessctl

      🧩 Python virtual environment:
         mac-beat-sync runs in an isolated Python 3.11 virtualenv managed by Homebrew.
    EOS
  end

  test do
    system "#{bin}/mac-beat-sync", "--help"
  end
end
