class Gloperate < Formula
  desc "C++ library for defining and controlling modern GPU rendering/processing operations"
  homepage "https://github.com/cginternals/gloperate"
  url "https://github.com/cginternals/gloperate/archive/v0.5.0.tar.gz"
  sha256 "ec7495b2fd73f7ff3077dc4bb5c007ff51edc07d3d3372546721deeda87f650b"
  head "https://github.com/cginternals/gloperate.git"

  depends_on "cmake" => :build
  depends_on "cpplocate" => :required
  depends_on "libzeug" => :required
  depends_on "cginternals/cginternals/glbinding" => :required
  depends_on "globjects" => :required
  depends_on "qt5" => :recommended
  depends_on "glfw3" => :optional
  needs :cxx11

  def install
    args = []

    args << "-Dcpplocate_DIR=" + Formula["cpplocate"].prefix
    args << "-Dlibzeug_DIR=" + Formula["libzeug"].prefix
    args << "-Dglbinding_DIR=" + Formula["glbinding"].prefix
    args << "-Dglobjects_DIR=" + Formula["globjects"].prefix

    if build.with? "qt5"
      args << "-DOPTION_BUILD_TOOLS=ON"
    end

    ENV.cxx11
    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
