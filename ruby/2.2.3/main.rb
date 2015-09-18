class Ruby_2_2_3 < FPM::Cookery::Recipe
  description 'The Ruby virtual machine'
  name        'ruby'
  version     '2.2.3'
  revision    0
  homepage    'http://www.ruby-lang.org/'
  source      'http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.bz2'
  sha256      'c745cb98b29127d7f19f1bf9e0a63c384736f4d303b83c4f4bda3c2ee3c5e41f'
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


