class Terraform_0_6_1 < FPM::Cookery::Recipe
  name        'terraform'
  version     '0.6.1'
  revision    0
  description 'A tool for building, changing, and versioning infrastructure safely and efficiently.'
  homepage    'http://terraform.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/terraform/terraform_#{version}_linux_amd64.zip"
  sha256      "3f7e135cb106c331f71667e188b602623d98fa37b10eb93c5330c4a63ebee244"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

