class EnvConsul050 < FPM::Cookery::Recipe
  name        'envconsul'
  version     '0.5.0'
  revision    0
  description 'Read and set environmental variables for processes from Consul.'
  homepage    'https://github.com/hashicorp/envconsul'
  section     'admin'

  source      "https://github.com/hashicorp/envconsul/releases/download/v#{version}/envconsul_#{version}_linux_amd64.tar.gz"
  sha256      "f7e602e6c1e2a69c238e0d61449543cec161f9bdd16e70a3941aa1916a729dff"

  build_depends 'tar', 'gzip'

  fpm_attributes["#{FPM::Cookery::Facts.target}_user".to_sym]   = 'consul'
  fpm_attributes["#{FPM::Cookery::Facts.target}_group".to_sym]  = 'consul'

  def build
  end

  def install
    glob = File.join(builddir, File.basename(self.source, ".tar.gz"), '*')

    Dir[glob].each do |file|
      bin.install(file)
    end
  end
end

