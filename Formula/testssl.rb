class Testssl < Formula
  desc "Tool which checks for the support of TLS/SSL ciphers and flaws"
  homepage "https://testssl.sh/"
  url "https://github.com/drwetter/testssl.sh/archive/v3.0.8.tar.gz"
  sha256 "22c5dc6dfc7500db94b6f8a48775f72b5149d0a372b8552ed7666016ee79edf0"
  license "GPL-2.0-or-later"
  head "https://github.com/drwetter/testssl.sh.git", branch: "3.1dev"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "6f5a1162e55cf0b03f4261d2e653c01302ede13d56c413b4172774f2e0f2d7a0"
  end

  depends_on "openssl@1.1"

  on_linux do
    depends_on "bind" => :test # can also use `drill` or `ldns`
    depends_on "util-linux" # for `hexdump`
  end

  def install
    bin.install "testssl.sh"
    man1.install "doc/testssl.1"
    prefix.install "etc"
    env = {
      PATH:                "#{Formula["openssl@1.1"].opt_bin}:$PATH",
      TESTSSL_INSTALL_DIR: prefix,
    }
    bin.env_script_all_files(libexec/"bin", env)
  end

  test do
    system "#{bin}/testssl.sh", "--local", "--warnings", "off"
  end
end
