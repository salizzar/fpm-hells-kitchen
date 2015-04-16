class SensuCommunityPlugins_0_17_2 < FPM::Cookery::Recipe
  description 'Sensu Community Plugins'
  name        'sensu-community-plugins'
  version     '0.17.2'
  revision    0
  homepage    "https://github.com/sensu/sensu-community-plugins"
  source      "https://github.com/sensu/sensu-community-plugins/archive/master.zip"
  sha256      "06c694b4dd74cf96e3b53b4c877bb216b4a88fb4592bd17e083734a26b236488"
  section     "operations"

  build_depends 'mariadb-devel', 'libxml2-devel', 'libxslt-devel'

  depends       'sensu'

  REQUIRED_GEMS = %w(mysql mysql2 inifile)

  def build
    repo = %{
[sensu]
name=sensu
baseurl=http://repos.sensuapp.org/yum/el/$basearch/
gpgcheck=0
enabled=1
}

    safesystem("/usr/bin/echo '#{repo}' > /etc/yum.repos.d/sensu.repo")

    safesystem("/usr/bin/yum install -y sensu")

    safesystem("/usr/bin/echo 'EMBEDDED_RUBY=true' > /etc/default/sensu")

    safesystem("/opt/sensu/embedded/bin/ruby -S gem install --no-document --verbose #{REQUIRED_GEMS.join ' '}")
  end

  def install
    install_files
    install_injected_gems
  end

  private

  def install_files
    glob = File.join(builddir, File.basename(self.source, '.zip'), '*/', '{extensions,handlers,mutators,plugins}')

    Dir[glob].each { |file| etc('sensu').install(file) }
  end

  def install_injected_gems
    path = "/opt/sensu/embedded/lib/ruby/gems/2.0.0/"
    folders = %w(cache gems specifications).map { |folder| File.join(path, folder) }

    folders.each do |folder|
      REQUIRED_GEMS.each do |gem|
        glob = File.join(folder, "#{gem}-*")

        Dir[glob].each { |file| root(File.dirname(file)).install(file) }
      end
    end
  end
end

