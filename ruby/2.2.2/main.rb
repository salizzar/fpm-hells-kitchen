class Ruby_2_2_2 < FPM::Cookery::Recipe
  description 'The Ruby virtual machine'
  name        'ruby'
  version     '2.2.2'
  revision    0
  homepage    'http://www.ruby-lang.org/'
  source      'http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.bz2'
  sha256      'f3b8ffa6089820ee5bdc289567d365e5748d4170e8aa246d2ea6576f24796535'
  section     'interpreters'

  build_depends 'autoconf', 'readline-devel', 'bison', 'zlib-devel', 'openssl-devel', 'libyaml-devel', 'libffi-devel'

  def build
    configure :prefix => prefix, 'disable-install-doc' => true, 'enable-shared' => true
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end

