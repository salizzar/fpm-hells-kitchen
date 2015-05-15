class Terraform_0_5_1 < FPM::Cookery::Recipe
  name        'terraform'
  version     '0.5.1'
  revision    0
  description 'A tool for building, changing, and versioning infrastructure safely and efficiently.'
  homepage    'http://terraform.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/terraform/terraform_#{version}_linux_amd64.zip"
  sha256      "5f651ffd0f8d7386ed5d44d50ef0053ee974d1a73bb9becf7c99c886615a98f7"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

