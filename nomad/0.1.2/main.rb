class Nomad012 < FPM::Cookery::Recipe
  name        'nomad'
  version     '0.1.2'
  revision    0
  description 'A Distributed, Highly Available, Datacenter-Aware Scheduler'
  homepage    'http://nomadproject.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/nomad/nomad_#{version}_linux_amd64.zip"
  sha256      "3335f7acb0d5eacaaa19aea37d128418ace18e6ef03d38de0c2c52ce831d7934"

  build_depends 'zip'

  def build
  end

  def install
    install_etc

    install_var_lib

    install_systemd_files

    install_bin
  end

  private

  def install_etc
    etc('nomad.d/server').mkdir
    etc('nomad.d/server').install workdir('files/etc/nomad.d/server/nomad.json')

    etc('nomad.d/client').mkdir
    etc('nomad.d/client').install workdir('files/etc/nomad.d/client/nomad.json')
  end

  def install_var_lib
    var('lib/nomad').mkdir
  end

  def install_systemd_files
    lib('systemd/system').install workdir('files/usr/lib/systemd/system/nomad-server.service')
    lib('systemd/system').install workdir('files/usr/lib/systemd/system/nomad-client.service')
  end

  def install_bin
    glob = File.join(builddir, File.basename(self.source, ".zip"), '*')

    Dir[glob].each do |file|
      bin.install(file)
    end
  end

end
