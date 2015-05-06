class GoogleAuthenticator_1_0_0 < FPM::Cookery::Recipe
  name        'google-authenticator'
  version     '1.0.0'
  revision    0
  description 'Google Two-Factor Authentication tool'
  homepage    'https://github.com/shaunduncan/packer-provisioner-host-command'
  section     'admin'

  source      "https://github.com/google/google-authenticator/archive/master.zip"
  sha256      "3e89aaf0f2ef698a4ca99d8de9ce30a9b5088c75b083a65e49ac5724b5a7b67d"

  build_depends 'gcc', 'pam-devel', 'autoconf', 'automake', 'libtool'

  def build
    Dir.chdir(get_path) do
      safesystem("./bootstrap.sh")
      safesystem("./configure")
      safesystem("make")
    end
  end

  def install
    path = get_path

    root('lib64/security').install(File.join(path, '.libs', 'pam_google_authenticator.so'))
    bin.install(File.join(path, 'google-authenticator'))
  end

  private

  def get_path
    File.join(builddir.to_s, 'master', 'google-authenticator-master', 'libpam')
  end
end

