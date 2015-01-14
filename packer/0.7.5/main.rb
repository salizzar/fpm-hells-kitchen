class Packer075 < FPM::Cookery::Recipe
  name        'packer'
  arch        'x86_64'
  version     '0.7.5'
  revision    0
  description 'A tool to create identical machine images for multiple platforms fro a single source configuration.'
  homepage    'http://packer.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/packer/packer_#{version}_linux_amd64.zip"
  sha256      "8fab291c8cc988bd0004195677924ab6846aee5800b6c8696d71d33456701ef6"

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

