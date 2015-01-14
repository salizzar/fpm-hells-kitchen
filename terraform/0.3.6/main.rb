class Terraform036 < FPM::Cookery::Recipe
  name        'terraform'
  arch        'x86_64'
  version     '0.3.6'
  revision    0
  description 'A tool for building, changing, and versioning infrastructure safely and efficiently.'
  homepage    'http://terraform.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/terraform/terraform_#{version}_linux_amd64.zip"
  sha256      "4c5890b098d07e4902e76331b576762632d6443e50030acb818b9a3d642a91c5"

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

