class Gloperate < Formula
  desc "C++ library for defining and controlling modern GPU rendering/processing operations"
  homepage "https://github.com/cginternals/gloperate"
  sha256 ""

  head "https://github.com/cginternals/gloperate.git"

  depends_on "cmake" => :build
  depends_on "glm"
  depends_on "cginternals/cginternals/cpplocate"
  depends_on "cginternals/cginternals/cppassist"
  depends_on "cginternals/cginternals/cppexpose"
  depends_on "cginternals/cginternals/glbinding"
  depends_on "cginternals/cginternals/globjects"
  depends_on "qt5" => :recommended
  depends_on "glfw3" => :optional
  depends_on "doxygen" => :optional

  needs :cxx11

  def install
    args = []

    args << "-Dcpplocate_DIR=" + Formula["cpplocate"].installed_prefix
    args << "-Dcppassist_DIR=" + Formula["cppassist"].installed_prefix
    args << "-Dcppexpose_DIR=" + Formula["cppexpose"].installed_prefix
    args << "-Dglbinding_DIR=" + Formula["glbinding"].installed_prefix
    args << "-Dglobjects_DIR=" + Formula["globjects"].installed_prefix

    if build.with? "qt5"
      args << "-DOPTION_BUILD_TOOLS=ON"
    end

    ENV.cxx11
    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
