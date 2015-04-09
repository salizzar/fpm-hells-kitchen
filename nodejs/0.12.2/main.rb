class Nodejs0122 < FPM::Cookery::Recipe
  name        'nodejs'
  version     '0.12.2'
  revision    0
  description 'Node.js is a platform built on Chrome\'s JavaScript runtime for easily building fast, scalable network applications.'
  homepage    'http://nodejs.org'
  section     'interpreters'

  source      "http://nodejs.org/dist/v#{version}/node-v#{version}-linux-x64.tar.gz"
  sha256      "4e1578efc2a2cc67651413a05ccc4c5d43f6b4329c599901c556f24d93cd0508"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.tar.gz'))
    glob = File.join(builddir(folder), 'bin', '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

