class Glkernel < Formula
  desc "C++ library for pre-computing noise, and random sample-kernels"
  homepage "https://github.com/cginternals/glkernel"
  sha256 ""

  head "https://github.com/cginternals/glkernel.git"

  depends_on "cmake" => :build
  depends_on "glm"
  depends_on "qt5" => :optional
  depends_on "cginternals/cginternals/cppassist" => :recommended
  depends_on "cginternals/cginternals/cppexpose" => :recommended

  needs :cxx11

  def install
    args = []

    if build.with? "qt5"
      args << "-DOPTION_BUILD_EXAMPLES=ON"
    end

    if build.with?("cppassist") && build.with?("cppexpose")
      args << "-Dcppassist_DIR=" + Formula["cginternals/cginternals/cppassist"].installed_prefix
      args << "-Dcppexpose_DIR=" + Formula["cginternals/cginternals/cppexpose"].installed_prefix

      args << "-DOPTION_BUILD_TOOLS=ON"
    else
      args << "-DOPTION_BUILD_TOOLS=OFF"
    end

    ENV.cxx11
    system "cmake", ".", *args, *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end
end
