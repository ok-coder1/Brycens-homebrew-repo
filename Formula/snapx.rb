class Snapx < Formula
  desc "Screenshot tool that handles images, text, and video (fork of ShareX)"
  homepage "https://github.com/BrycensRanch/SnapX"
  url "https://github.com/BrycensRanch/SnapX/archive/8bfb7ca.tar.gz"
  version "0.2.1"
  sha256 "5687b73dc4cf6db6abdf401a49405197abce9ede4c4ca590b375c015d833286c"
  license "GPL-3.0-or-later"
  head "https://github.com/BrycensRanch/SnapX.git", branch: "develop"
  # Uncomment to bump the package when still using the same SnapX version. Acts like the release field in snapx.spec
  # revision 1

  depends_on "dotnet" => :build
  depends_on "git" => :build
  depends_on "llvm" => :build
  depends_on "ffmpeg@7"
  # NativeAOT support
  depends_on macos: :monterey

  on_macos do
    # Screenshotting on macOS is done via a Rust compat layer. We must compile it.
    depends_on "rust" => :build
  end
  on_linux do
    depends_on "dbus"
    depends_on "libsm"
    depends_on "libx11"
    depends_on "libxcb"
    depends_on "libxrandr"
    depends_on "openssl@3"
  end

  def install
    ENV["SKIP_MACOS_VERSION_CHECK"] = "1"
    ENV["ELEVATION_NOT_NEEDED"] = "1"
    system "./build.sh", "install", "--prefix", "/", "--dest-dir", "#{prefix}"
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

  test do
    system bin/"snapx", "--version"
  end
end
