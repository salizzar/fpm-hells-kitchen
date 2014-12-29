class Ruby220 < FPM::Cookery::Recipe
  description 'The Ruby virtual machine'
  name        'ruby'
  version     '1:2.2.0'
  revision    0
  homepage    'http://www.ruby-lang.org/'
  source      'http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.bz2'
  sha256      '1c031137999f832f86be366a71155113675b72420830ce432b777a0ff4942955'
  section     'interpreters'

  build_depends 'autoconf', 'readline-devel', 'bison', 'zlib-devel', 'openssl-devel', 'libyaml-devel', 'libffi-devel'

  def build
    configure :prefix => prefix, 'disable-install-doc' => true
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end

