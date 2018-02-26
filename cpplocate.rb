class Cpplocate < Formula
  desc "C++ library that for applications to locate themselves, their data assets, as well as dependend modules."
  homepage "https://github.com/cginternals/cpplocate"
  sha256 ""

  head "https://github.com/cginternals/cpplocate.git"

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <cpplocate/cpplocate.h>
      int main(void)
      {
        const cpplocate::ModuleInfo moduleInfo = cpplocate::findModule("cpplocate");
      }
      EOS
    system ENV.cxx, "-o", "test", "test.cpp", "-std=c++11", "-stdlib=libc++",
                    "-I#{include}/cpplocate", "-I#{lib}/cpplocate",
                    "-lcpplocate", *ENV.cflags.to_s.split
    system "./test"
  end
end
