class Snapx < Formula
  desc "Screenshot tool that handles images, text, and video (fork of ShareX)"
  homepage "https://github.com/BrycensRanch/SnapX"
  version "0.2.1"
  url "https://github.com/BrycensRanch/SnapX/archive/9abede0.tar.gz"
  head "https://github.com/BrycensRanch/SnapX.git", branch: "develop"
  sha256 "087ab3d2cc1be14a3021b5aba9dd2dc365a75d6d32f85fc9211c2d4d0a8a8698"
  # Uncomment to bump the package when still using the same SnapX version. Acts like the release field in snapx.spec
  #revision 1
  license "GPL-3.0-or-later"

  depends_on macos: :monterey
  depends_on "git" => :build
  depends_on "ffmpeg@7"
  # NativeAOT support
  depends_on "llvm" => :build
  depends_on "dotnet" => :build

  on_macos do
    # Screenshotting on macOS is done via a Rust compat layer. We must compile it.
    depends_on "rust" => :build
  end
  on_linux do
    depends_on "libx11"
    depends_on "libsm"
    depends_on "libxrandr"
    depends_on "libxcb"
    depends_on "dbus"
    depends_on "openssl@3"
  end

  def install
    ENV["SKIP_MACOS_VERSION_CHECK"] = "1"
    ENV["ELEVATION_NOT_NEEDED"] = "1"
    system "./build.sh install --prefix / --dest-dir #{prefix}"
  end

  test do
    system bin/"snapx", "--version"
  end

  def caveats
    <<~EOS
    On Ubuntu, you need to run
      sudo apt install -y libvlc-dev xdg-utils
    On Fedora, you need to run
      sudo dnf in -y vlc-devel xdg-utils
    Additionally, SnapX hasn't been able to create the configuration file(s) it expects.
    You should place it in the configuration directory that it expects.
    On Linux, it's
      ~/.config/SnapX
    On macOS, it's
      ~/Library/Application Support/SnapX
    EOS
  end
end
