class Tomcat7054 < FPM::Cookery::Recipe
  name        'tomcat'
  version     '7.0.54'
  arch        :noarch
  revision    0
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

    %w(catalina.sh startup.sh shutdown.sh).each do |sh|
      daemon_path = File.join(builddir(path), 'bin', sh)
      File.chmod(0755, daemon_path)
    end

    glob = File.join(builddir(path), '*')
    Dir[glob].each { |file| opt('tomcat').install(file) }

    etc('sysconfig').install workdir('files/etc/sysconfig/tomcat')
    lib('systemd/system').install workdir('files/usr/lib/systemd/system/tomcat.service')
  end

  private

  def get_tomcat_build_path
    zip_folder = File.basename(source, '.zip')

    path = File.join(zip_folder, zip_folder)
  end
end

