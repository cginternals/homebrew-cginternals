class Libzeug < Formula
  desc "C++ sanctuary for small but powerful and frequently required, stand alone features"
  homepage "https://github.com/cginternals/libzeug"
  url "https://github.com/cginternals/libzeug/archive/v0.6.0.tar.gz"
  sha256 "af3ca78cf01423dfbba80405ea48f81b7b28c7b79be8dc44b7d6f432d837bc3e"

  needs :cxx11

  def install
    args = []

    ENV.cxx11
    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end