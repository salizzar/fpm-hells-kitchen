class Ruby215 < FPM::Cookery::Recipe
  description 'The Ruby virtual machine'
  name        'ruby'
  version     '2.1.5'
  revision    0
  homepage    'http://www.ruby-lang.org/'
  source      'http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.bz2'
  sha256      '0241b40f1c731cb177994a50b854fb7f18d4ad04dcefc18acc60af73046fb0a9'
  section     'interpreters'

  build_depends 'autoconf', 'readline-devel', 'bison', 'zlib-devel', 'openssl-devel', 'libyaml-devel'

  def build
    configure :prefix => prefix, 'disable-install-doc' => true, 'enable-shared' => true
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end

