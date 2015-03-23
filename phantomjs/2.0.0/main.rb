class PhantomJS200 < FPM::Cookery::Recipe
  description 'PhantomJS is a headless WebKit scriptable with a JavaScript API'
  name        'phantomjs'
  version     '2.0.0'
  revision    0
  homepage    'http://phantomjs.org'
  source      'https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.0.0-source.zip'
  sha256      'cc81249eaa059cc138414390cade9cb6509b9d6fa0df16f4f43de70b174b3bfe'
  section     'tools'

  build_depends %w(gcc gcc-c++ make flex bison gperf ruby openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel libpng-devel libjpeg-turbo-devel)
  depends       %w(libicu fontconfig libjpeg-turbo libpng)

  def build
    bash_path = get_workdir

    safesystem("cd #{bash_path} && bash build.sh --jobs 4 --confirm")
  end

  def install
    bin_path = File.join(get_workdir, 'bin', '*')

    Dir[bin_path].each { |file| bin.install(file) }
  end

  private

  def get_workdir
    File.join(builddir, 'phantomjs-2.0.0-source', 'phantomjs-2.0.0')
  end
end

