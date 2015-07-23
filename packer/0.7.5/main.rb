class Packer075 < FPM::Cookery::Recipe
  name        'packer'
  version     '0.7.5'
  revision    0
  description 'A tool to create identical machine images for multiple platforms from a single source configuration.'
  homepage    'http://packer.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/packer/packer_#{version}_linux_amd64.zip"
  sha256      "8fab291c8cc988bd0004195677924ab6846aee5800b6c8696d71d33456701ef6"

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

