class FindBugs301 < FPM::Cookery::Recipe
  name          'findbugs'
  version       '3.0.1'
  revision      0
  description   'A tool to detect bugs in Java code'
  homepage      'http://findbugs.sourceforge.net'
  section       'development'
  arch          'noarch'

  source        'http://ufpr.dl.sourceforge.net/project/findbugs/findbugs/3.0.1/findbugs-3.0.1-rc2.zip'
  md5           'fc5965835bcacd106b2078dc06842913'

  build_depends 'zip'

  def build
  end

  def install
    opt('findbugs/bin/').mkdir

    folder = File.basename(source, '.zip')
    glob = File.join(builddir(folder), folder, '*')

    Dir[glob].each { |file| opt('findbugs').install(file) }

    bin.mkdir
    symlink = bin('findbugs')
    with_trueprefix { ln_s opt('findbugs/bin/findbugs'), symlink }
  end
end

