class Glkernel < Formula
  desc "C++ library for pre-computing noise, and random sample-kernels"
  homepage "https://github.com/cginternals/glkernel"
  sha256 ""

  head "https://github.com/cginternals/glkernel.git"

  depends_on "cmake" => :build
  depends_on "glm" => :required
  depends_on "qt5" => :optional
  depends_on "cginternals/cginternals/cppassist" => :optional
  depends_on "cginternals/cginternals/cppexpose" => :optional

  needs :cxx11

  def install
    ENV.cxx11

    args = []

    if build.with? "qt5"
      args << "-DOPTION_BUILD_EXAMPLES=ON"
    end

    if build.with? "cginternals/cginternals/cppassist" && build.with? "cginternals/cginternals/cppexpose"
      args << "-DOPTION_BUILD_TOOLS=ON"
    end

    system "cmake", ".", *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
