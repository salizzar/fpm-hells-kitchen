class Consul052 < FPM::Cookery::Recipe
  name        'consul'
  version     '0.5.2'
  revision    0
  description 'A service discovery and configuration made easy.'
  homepage    'http://consul.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/consul/#{version}_linux_amd64.zip"
  sha256      "171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445"

  build_depends 'zip', 'curl'

  pre_install   'files/preinstall'

  fpm_attributes["#{FPM::Cookery::Facts.target}_user".to_sym]   = 'consul'
  fpm_attributes["#{FPM::Cookery::Facts.target}_group".to_sym]  = 'consul'

  def build
    zip_file = get_ui_zip_name
    zip_path = File.join(builddir, zip_file)

    safesystem("curl -L -o #{zip_path} https://dl.bintray.com/mitchellh/consul/#{zip_file} ")
    safesystem("unzip #{zip_path}")
  end

  def install
    install_etc

    install_var_lib

    install_ui_files

    install_systemd_files

    install_bin
  end

  private

  def install_etc
    etc('consul.d/bootstrap').mkdir
    etc('consul.d/bootstrap').install workdir('files/etc/consul.d/bootstrap/consul.json')

    etc('consul.d/server').mkdir
    etc('consul.d/server').install workdir('files/etc/consul.d/server/consul.json')

    etc('consul.d/agent').mkdir
    etc('consul.d/agent').install workdir('files/etc/consul.d/agent/consul.json')
  end

  def install_var_lib
    var('lib/consul').mkdir
  end

  def install_ui_files
    share('consul').mkdir

    zip_path = File.join(builddir, '*', 'dist')

    Dir[zip_path].each do |file|
      share('consul').install file
    end
  end

  def install_systemd_files
    lib('systemd/system').install workdir('files/usr/lib/systemd/system/consul-bootstrap.service')
    lib('systemd/system').install workdir('files/usr/lib/systemd/system/consul-server.service')
    lib('systemd/system').install workdir('files/usr/lib/systemd/system/consul-agent.service')
  end

  def install_bin
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), 'consul')

    Dir[glob].each do |file|
      bin.install(file)
    end
  end

  def get_ui_zip_name
    "#{version}_web_ui.zip"
  end
end

