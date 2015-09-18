class Ruby_2_1_7 < FPM::Cookery::Recipe
  description 'The Ruby virtual machine'
  name        'ruby'
  version     '2.1.7'
  revision    0
  homepage    'http://www.ruby-lang.org/'
  source      'http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.7.tar.bz2'
  sha256      'b02c1a5ecd718e3f6b316384d4ed6572f862a46063f5ae23d0340b0a245859b6'
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


