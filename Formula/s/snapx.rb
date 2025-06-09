class SnapX < Formula
  desc "SnapX is a free, open-source, cross-platform tool that lets you capture or record any area of your screen and instantly share it with a single keypress. Upload images, videos, text, and more to multiple supported destinations — all with ease."
  homepage "https://github.com/BrycensRanch/SnapX"
  version "0.2.0"
  url "https://github.com/BrycensRanch/SnapX/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "7a163aee1b39a39dd9149a823364fcdf988e6750b0aeb450f8aa15ef4e656d1c"
  license "GPL-3.0"

  depends_on macos: ">= :monterey"

  def detect_distro
    on_linux do
      os_release = if File.exist?("/etc/os-release")
                    File.read("/etc/os-release")
                  else
                    Utils.safe_popen_read("lsb_release", "-si").strip
                  end
    
      if os_release.include?("UBUNTU") || os_release.include?("ubuntu") || os_release.include?("Ubuntu")
        :ubuntu
      elsif os_release.include?("FEDORA") || os_release.include?("fedora") || os_release.include?("Fedora")
        :fedora
      else
        :unknown
      end
    end
  end

  def install
    if OS.mac?
      ohai "OS: macOS"
      depends_on "ffmpeg@7"
      depends_on "rust"
    end
    if OS.linux?
      case detect_distro
      when :ubuntu
        ohai "OS: Ubuntu"
        depends_on "dotnet-sdk"
        depends_on "ffmpeg@7"
        depends_on "llvm"
        depends_on "zlib"
        depends_on "libsm"
      when :fedora
        ohai "OS: Fedora"
        depends_on "git"
        depends_on "dotnet-sdk"
        depends_on "ffmpeg@7"
      else
        opoo "Unsupported linux distribution (if using Arch Linux please use AUR package). Continuing..."
    end
    ENV["SKIP_MACOS_VERSION_CHECK"] = 1
    system "./build.sh"
  end
end

def caveats
  <<~EOS
    On Ubuntu, you need to run
      sudo apt install -y libvlc-dev zlib1g-dev
    On Fedora, you need to run
    sudo dnf in -y vlc-devel

    Additionally, it seems SnapX hasn't been able to create the configuration file(s) it expects.
    You should place it in the configuration directory that it expects.
    On Linux, it's
      ~/.config/SnapX
    On macOS, it's
      ~/Library/Application Support/SnapX
  EOS
end
