class Cppassist < Formula
  desc "C++ sanctuary for small but powerful and frequently required, stand alone features."
  homepage "https://github.com/cginternals/cppassist"
  sha256 ""

  head "https://github.com/cginternals/cppassist.git"

  depends_on "cmake" => :build
  depends_on "boost" => :optional

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
