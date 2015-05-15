class SensuCommunityPlugins_0_17_2 < FPM::Cookery::Recipe
  description 'Sensu Community Plugins'
  name        'sensu-community-plugins'
  version     '0.17.2'
  revision    1
  homepage    "https://github.com/sensu/sensu-community-plugins"
  source      "https://github.com/sensu/sensu-community-plugins/archive/master.zip"
  sha256      "b96ffd1cc295c69be728f43c55aa4ec575e6aec82bc00336e10f54acc4f8373b"
  section     "operations"

  build_depends 'mariadb-devel', 'libxml2-devel', 'libxslt-devel'

  depends       'nmap'

  REQUIRED_GEMS = %w(mysql mysql2 inifile docker-api excon redis rest_client carrot-top raindrops netrc)

  def build
    repo = %{
[sensu]
name=sensu
baseurl=http://repos.sensuapp.org/yum/el/$basearch/
gpgcheck=0
enabled=1
}

    safesystem("/usr/bin/echo '#{repo}' > /etc/yum.repos.d/sensu.repo")

    safesystem("/usr/bin/yum clean all")
    safesystem("/usr/bin/yum install -y sensu")

    self.depends << 'sensu'

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

