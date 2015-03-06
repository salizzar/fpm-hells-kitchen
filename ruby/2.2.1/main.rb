class Ruby221 < FPM::Cookery::Recipe
  description 'The Ruby virtual machine'
  name        'ruby'
  version     '2.2.1'
  revision    0
  homepage    'http://www.ruby-lang.org/'
  source      'http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.1.tar.bz2'
  sha256      '4e5676073246b7ade207be3e80a930567a88100513591a0f19fc38e247370065'
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


