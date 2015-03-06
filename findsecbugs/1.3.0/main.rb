class FindSecBugs130 < FPM::Cookery::Recipe
  name          'findbugs-findsecbugs-plugin'
  version       '1.3.0'
  revision      0
  description   'Find Security Bugs plugin for findbugs'
  homepage      'http://findbugs.sourceforge.net'
  section       'development'
  arch          'noarch'

  source        'https://repo1.maven.org/maven2/com/h3xstream/findsecbugs/findsecbugs-plugin/1.3.0/findsecbugs-plugin-1.3.0.jar'
  md5           '842db3ae425a4c40a963e0d8acf3c758'

  depends       'findbugs'

  def build
  end

  def install
    path = File.join(builddir, '*/*.jar')

    Dir[path].each { |jar| opt('findbugs/plugin').install jar }
  end
end

