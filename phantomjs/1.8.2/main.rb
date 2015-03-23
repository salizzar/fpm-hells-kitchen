class PhantomJS182 < FPM::Cookery::Recipe
  description 'PhantomJS is a headless WebKit scriptable with a JavaScript API'
  name        'phantomjs'
  version     '1.8.2'
  revision    0
  homepage    'http://phantomjs.org'
  source      'https://phantomjs.googlecode.com/files/phantomjs-1.8.2-source.zip'
  sha1        '3e64b1b0030ad2dfb550466839f0f91fc3cdd668'
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
    File.join(builddir, 'phantomjs-1.8.2-source', 'phantomjs-1.8.2')
  end
end

