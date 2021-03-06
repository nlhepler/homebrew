require 'formula'

class Urweb < Formula
  homepage 'http://impredicative.com/ur/'
  url 'http://www.impredicative.com/ur/urweb-20120329.tgz'
  md5 '3ba9b96aff2d39fc6dfc153c8be7ac7f'
  head 'http://hg.impredicative.com/urweb', :using => :hg

  depends_on 'mlton'
  depends_on "automake" if MacOS.xcode_version >= "4.3"

  if MacOS.xcode_version >= "4.3"
    # remove the autoreconf if possible, no comment provided about why it is there
    # so we have no basis to make a decision at this point.
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "aclocal && autoreconf -i --force"
    system "./configure --prefix=#{prefix}"
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    Programs generated by the Ur/Web compiler can use SQLite,
    PostgreSQL, or MySQL for the data store. You probably want to
    install either PostgreSQL or MySQL if you're going to deploy
    real apps or test them heavily.
    EOS
  end
end
