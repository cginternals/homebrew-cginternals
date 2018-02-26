class Cppexpose < Formula
  desc "C++ library for type introspection, reflection, and scripting interface"
  homepage "https://github.com/cginternals/cppexpose"
  sha256 ""

  head "https://github.com/cginternals/cppexpose.git"

  depends_on "cmake" => :build
  depends_on "cginternals/cginternals/cpplocate"
  depends_on "cginternals/cginternals/cppassist"

  needs :cxx11

  def install
    ENV.cxx11

    args = []
    args << "-Dcppassist_DIR=" + Formula["cginternals/cginternals/cppassist"].installed_prefix
    args << "-Dcpplocate_DIR=" + Formula["cginternals/cginternals/cpplocate"].installed_prefix

    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
