class Globjects < Formula
  desc "C++ library strictly wrapping OpenGL objects"
  homepage "https://github.com/cginternals/globjects"
  url "https://github.com/cginternals/globjects/archive/master.tar.gz"
  sha256 "1730449be436ccd55080c7427f1ee82dd4adb4e333d8d43a0851bf88e74ba99d"
  head "https://github.com/cginternals/globjects.git"

  depends_on "cmake" => :build
  depends_on "glm"
  depends_on "cginternals/cginternals/glbinding"
  depends_on "cginternals/cginternals/cpplocate" => :optional
  depends_on "glfw3" => :optional
  depends_on "qt5" => :optional
  depends_on "doxygen" => :optional

  needs :cxx11

  def install
    args = []

    args << "-Dglbinding_DIR=" + Formula["cginternals/cginternals/glbinding"].installed_prefix

    if build.with? "glfw3" and build.with? "cpplocate"
      args << "-DOPTION_BUILD_EXAMPLES=ON"
    end

    if build.with? "cpplocate"
      args << "-Dcpplocate_DIR=" + Formula["cginternals/cginternals/cpplocate"].installed_prefix
    end

    if build.with? "doxygen"
      args << "-DOPTION_BUILD_DOCS=ON"
    end

    ENV.cxx11
    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
