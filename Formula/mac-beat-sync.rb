class MacBeatSync < Formula
  include Language::Python::Virtualenv

  desc "Real-time audio-reactive keyboard brightness controller for macOS"
  homepage "https://github.com/1rsh/mac-beat-sync"
  url "https://github.com/1rsh/mac-beat-sync/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "42b357dac9311e23bc5570ca8165095284467d76078fa47d57cbf7a4a345d220"
  license "MIT"
  head "https://github.com/1rsh/mac-beat-sync.git", branch: "main"

  depends_on "python@3.11"
  depends_on "rakalex/mac-brightnessctl"

  def install
    venv = virtualenv_create(libexec, Formula["python@3.11"].opt_bin/"python3")

    reqs = buildpath/"requirements.txt"
    if reqs.exist?
      system venv.instance_variable_get(:@venv_root)/"bin/pip", "install", "--upgrade", "pip", "setuptools", "wheel"
      system venv.instance_variable_get(:@venv_root)/"bin/pip", "install", "-r", reqs
    else
      opoo "⚠️ requirements.txt not found in source — skipping pip dependency install."
    end

    venv.pip_install_and_link buildpath
  end

  def caveats
    <<~EOS
      🎧 mac-beat-sync has been installed!

      To start the controller:
        mac-beat-sync

      Note: `mac-brightnessctl` is required and comes from the external tap:
        brew tap rakalex/mac-brightnessctl
        brew install mac-brightnessctl
    EOS
  end

  test do
    system "#{bin}/mac-beat-sync", "--help"
  end
end
