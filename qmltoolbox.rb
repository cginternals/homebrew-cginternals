class Qmltoolbox < Formula
  desc "QML item library for cross-platform graphics applications"
  homepage "https://github.com/cginternals/qmltoolbox"
  sha256 ""

  head "https://github.com/cginternals/qmltoolbox.git"

  depends_on "cmake" => :build
  depends_on "cginternals/cginternals/cpplocate"
  depends_on "qt5"

  needs :cxx11

  def install
    args = []
    args << "-Dcpplocate_DIR=" + Formula["cginternals/cginternals/cpplocate"].installed_prefix

    ENV.cxx11
    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
