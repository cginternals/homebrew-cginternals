class Cppexpose < Formula
  desc "C++ library for type introspection, reflection, and scripting interface"
  homepage "https://github.com/cginternals/cppexpose"
  sha256 ""

  head "https://github.com/cginternals/cppexpose.git"

  depends_on "cmake" => :build
  depends_on "cginternals/cginternals/cpplocate" => :required
  depends_on "cginternals/cginternals/cppassist" => :required

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
