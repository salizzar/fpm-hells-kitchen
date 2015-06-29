class Tomcat7054 < FPM::Cookery::Recipe
  name        'tomcat'
  version     '7.0.54'
  arch        :noarch
  revision    ENV['TOMCAT_REVISION'] || 0
  description 'Apache Servlet/JSP Engine'
  homepage    'http://tomcat.apache.org/'
  section     'tools'

  source      'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.54/bin/apache-tomcat-7.0.54.zip'
  md5         '6b5a52ad653979b7e2e276351051b7b1'

  build_depends 'zip'

  pre_install   'files/preinstall'
  post_install  'files/postinstall'

  def build
  end

  def install
    path = get_tomcat_build_path

    install_thirdparty(path)

    install_bin(path)
    install_conf(path)
    install_lib(path)
    install_run(path)
    install_logs(path)
    install_temp(path)
    install_webapps(path)
    install_work(path)
  end

  private

  def get_tomcat_build_path
    zip_folder = File.basename(source, '.zip')

    path = File.join(zip_folder, zip_folder)
  end

  def install_thirdparty(path)
    # env vars
    etc('sysconfig').install workdir('files/etc/sysconfig/tomcat')

    # systemd service file
    lib('systemd/system').install workdir('files/usr/lib/systemd/system/tomcat.service')
  end

  def install_bin(path)
    %w(catalina.sh startup.sh shutdown.sh).each do |sh|
      daemon_path = File.join(builddir(path), 'bin', sh)
      File.chmod(0755, daemon_path)
    end

    bin_glob = File.join(builddir(path), 'bin/*')

    Dir[bin_glob].each do |file|
      share('tomcat/bin').install(file) unless file.end_with?('.bat')
    end
  end

  def install_conf(path)
    conf_glob = File.join(builddir(path), 'conf', '*')
    Dir[conf_glob].each { |file| etc('tomcat').install file }

    with_trueprefix { ln_s etc('tomcat'), destdir(share('tomcat/conf').to_s) }
  end

  def install_lib(path)
    lib_glob = File.join(builddir(path), 'lib', '*')
    Dir[lib_glob].each { |file| share('java/tomcat').install file }

    with_trueprefix { ln_s share('java/tomcat'), destdir(share('tomcat/lib').to_s) }
  end

  def install_run(path)
    var('run/tomcat').mkdir
  end

  def install_logs(path)
    var('log/tomcat').mkdir

    with_trueprefix { ln_s var('log/tomcat'), destdir(share('tomcat/logs').to_s) }
  end

  def install_temp(path)
    var('cache/tomcat/temp').mkdir

    with_trueprefix { ln_s var('cache/tomcat/temp'), destdir(share('tomcat/temp').to_s) }
  end

  def install_webapps(path)
    webapps_glob = File.join(builddir(path), 'webapps', '*')

    Dir[webapps_glob].each do |file|
      var('lib/tomcat/webapps').install(file) if (file =~ /\/webapps\/(docs|examples|host-manager)/i).nil?
    end

    with_trueprefix { ln_s var('lib/tomcat/webapps'), destdir(share('tomcat/webapps').to_s) }
  end

  def install_work(path)
    var('cache/tomcat/work').mkdir

    with_trueprefix { ln_s var('cache/tomcat/work'), destdir(share('tomcat/work').to_s) }
  end
end

