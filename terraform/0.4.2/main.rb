class Terraform_0_4_2 < FPM::Cookery::Recipe
  name        'terraform'
  version     '0.4.2'
  revision    0
  description 'A tool for building, changing, and versioning infrastructure safely and efficiently.'
  homepage    'http://terraform.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/terraform/terraform_#{version}_linux_amd64.zip"
  sha256      "9fc236f86bc6fb002e6058e805ba49c78437cf0c688d26ecfbb21113c9613ec7"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

