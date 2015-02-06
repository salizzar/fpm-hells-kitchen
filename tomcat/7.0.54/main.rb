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

  def build
  end

  def install
    zip_folder = File.basename(source, '.zip')

    path = File.join(zip_folder, zip_folder)
    glob = File.join(builddir(path), '*')

    Dir[glob].each { |file| opt('tomcat').install(file) }

    etc('sysconfig').install workdir('common/etc/sysconfig/tomcat')
  end
end

