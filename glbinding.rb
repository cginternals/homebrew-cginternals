class Glbinding < Formula
  desc "C++ binding for the OpenGL API"
  homepage "https://github.com/cginternals/glbinding"
  url "https://github.com/cginternals/glbinding/archive/v2.0.1.tar.gz"
  sha256 "6712d91c5f8de81089549e499d8d63554f20abcd250cbfbfae34065760ddf6cb"
  head "https://github.com/cginternals/glbinding.git"

  depends_on "cmake" => :build
  depends_on "glfw3" => :optional
  depends_on "cpplocate" => :optional
  needs :cxx11

  def install
    args = []

    if build.with? "glfw3"
      args << "-DOPTION_BUILD_TOOLS=ON"
    else
      args << "-DOPTION_BUILD_TOOLS=OFF"
    end

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

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <glbinding/gl/gl.h>
      #include <glbinding/Binding.h>
      int main(void)
      {
        glbinding::Binding::initialize();
      }
      EOS
    system ENV.cxx, "-o", "test", "test.cpp", "-std=c++11", "-stdlib=libc++",
                    "-I#{include}/glbinding", "-I#{lib}/glbinding",
                    "-lglbinding", *ENV.cflags.to_s.split
    system "./test"
  end
end
