class Consul041 < FPM::Cookery::Recipe
  name        'consul'
  version     '0.4.1'
  revision    0
  description 'A service discovery and configuration made easy.'
  homepage    'http://consul.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/consul/#{version}_linux_amd64.zip"
  sha256      "2cf6e59edf348c3094c721eb77436e8c789afa2c35e6e3123a804edfeb1744ac"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

