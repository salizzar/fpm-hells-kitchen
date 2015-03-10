class Terraform037 < FPM::Cookery::Recipe
  name        'terraform'
  version     '0.3.7'
  revision    0
  description 'A tool for building, changing, and versioning infrastructure safely and efficiently.'
  homepage    'http://terraform.io'
  section     'admin'

  source      "https://dl.bintray.com/mitchellh/terraform/terraform_#{version}_linux_amd64.zip"
  sha256      "b63b36d76d9ea31cb6971edf23899ceb7291800618177adf987b7660b486527b"

  build_depends 'zip'

  def build
  end

  def install
    folder = File.join(File.basename(source, '.zip'))
    glob = File.join(builddir(folder), '*')

    Dir[glob].each { |file| bin.install(file) }
  end
end

