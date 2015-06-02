class Terraform_0_5_3 < FPM::Cookery::Recipe
  name        'terraform'
  version     '0.5.3'
  revision    0
  description 'A tool for building, changing, and versioning infrastructure safely and efficiently.'
  homepage    'http://terraform.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/terraform/terraform_#{version}_linux_amd64.zip"
  sha256      "c5c36be4e2cd2168142dd2b2950231d4b68ab0c14880aec1bbae1ed04cf2a16b"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

