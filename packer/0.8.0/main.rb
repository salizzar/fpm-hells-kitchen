class Packer_0_8_0 < FPM::Cookery::Recipe
  name        'packer'
  version     '0.8.0'
  revision    0
  description 'A tool to create identical machine images for multiple platforms from a single source configuration.'
  homepage    'http://packer.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/packer/packer_#{version}_linux_amd64.zip"
  sha256      "74b21580a7734fd6a025cfbba5ec60b85a61cd7c99ffe87904c4c013c801e6d2"

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each do |file|
      # treatment for centos because symlink /usr/sbin/packer conflicts on PATH
      file_name = File.basename(file)
      bin_prefix = self.class.platform == :centos && file_name == 'packer' ? 'packer.io' : file_name
      file_path = File.join(File.dirname(file), bin_prefix)

      bin.install(file, bin_prefix)
    end
  end
end

