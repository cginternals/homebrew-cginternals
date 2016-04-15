class Globjects < Formula
  desc "C++ library strictly wrapping OpenGL objects"
  homepage "https://github.com/cginternals/globjects"
  url "https://github.com/cginternals/globjects/archive/v0.5.0.tar.gz"
  sha256 "172936e813609896573ba6e94ea4754555de14103a3aa416e36b839dd338cad6"
  head "https://github.com/cginternals/globjects.git"

  depends_on "cmake" => :build
  depends_on "cginternals/cginternals/glbinding" => :required
  depends_on "glfw3" => :optional
  depends_on "cpplocate" => :optional
  needs :cxx11

  def install
    args = []

    args << "-Dglbinding_DIR=" + Formula["glbinding"].prefix

    if build.with? "glfw3" and build.with? "cpplocate"
      args << "-DOPTION_BUILD_EXAMPLES=ON"
    else
      args << "-DOPTION_BUILD_EXAMPLES=OFF"
    end

    if build.with? "cpplocate"
      args << "-Dcpplocate_DIR=" + Formula["cpplocate"].prefix
    end

    ENV.cxx11
    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
