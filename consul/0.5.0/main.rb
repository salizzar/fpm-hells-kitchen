class Consul050 < FPM::Cookery::Recipe
  name        'consul'
  version     '0.5.0'
  revision    0
  description 'A service discovery and configuration made easy.'
  homepage    'http://consul.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/consul/#{version}_linux_amd64.zip"
  sha256      "161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

