class Terraform_0_5_0 < FPM::Cookery::Recipe
  name        'terraform'
  version     '0.5.0'
  revision    0
  description 'A tool for building, changing, and versioning infrastructure safely and efficiently.'
  homepage    'http://terraform.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/terraform/terraform_#{version}_linux_amd64.zip"
  sha256      "f643a0113c6c0c3f0825a693fe116369cfbe44a9c6432b2923b8f4b1cbf1cee8"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

