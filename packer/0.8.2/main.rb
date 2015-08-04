class Packer_0_8_2 < FPM::Cookery::Recipe
  name        'packer'
  version     '0.8.2'
  revision    0
  description 'A tool to create identical machine images for multiple platforms from a single source configuration.'
  homepage    'http://packer.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/packer/packer_#{version}_linux_amd64.zip"
  sha256      "a80ed2594ad0f57452730c07d631059dfd85c85f25b4fe8ff226dece26921243"

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

