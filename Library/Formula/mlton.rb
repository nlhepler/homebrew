require 'formula'

# Installs the binary build of MLton.
# Since MLton is written in ML, building from source
# would require an existing ML compiler/interpreter for bootstrapping.

class Mlton < Formula
  homepage 'http://mlton.org'
  url 'http://downloads.sourceforge.net/project/mlton/mlton/20100608/mlton-20100608-1.amd64-darwin.gmp-static.tgz'
  md5 'd32430f2b66f05ac0ef6ff087ea109ca'

  # We download and install the version of MLton which is statically linked to libgmp, but all
  # generated executables will require gmp anyway, hence the dependency
  depends_on 'gmp'

  skip_clean :all

  def install
    unless HOMEBREW_PREFIX.to_s == "/usr/local"
      opoo "mlton won't work outside of /usr/local."
      puts "Because this uses pre-compiled binaries, it will not work if"
      puts "Homebrew is installed somewhere other than /usr/local; mlton"
      puts "will be unable to find GMP."
    end

    cd "local" do
      # Remove OS X droppings
      rm Dir["man/man1/._*"]
      mv "man", "share"
      prefix.install Dir['*']
    end
  end
end
