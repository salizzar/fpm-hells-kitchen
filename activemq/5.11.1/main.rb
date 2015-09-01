class ActiveMQ_5_11_1 < FPM::Cookery::Recipe
  name          'activemq'
  version       '5.11.1'
  revision      0
  description   'Apache ActiveMQ is the most popular and powerful open source messaging and Integration Patterns server.'
  homepage      'http://activemq.apache.org'
  section       'admin'

  source        "http://ftp.unicamp.br/pub/apache/activemq/#{version}/apache-activemq-#{version}-bin.tar.gz"
  sha256        "5ae90f4ea6caa3af7d9f79d1cc55b575dd44170b1451f096494e1a356828d35f"

  pre_install   'files/preinstall'
  post_install  'files/postinstall'

  def build
  end

  def install
    path = get_activemq_path

    install_etc(path)
    install_share(path)
    install_bin(path)
    install_usr_lib(path)
    install_var_lib(path)
    install_var_lib_webapps(path)
    install_var_log(path)
    install_var_cache(path)
    install_var_run(path)
    install_doc(path)
    install_init(path)
  end

  private

  def get_activemq_path
    path = File.join(File.basename(source, '-bin.tar.gz'))

    builddir(path)
  end

  def install_init(path)
    etc('rc.d/init.d').mkdir

    init_path = File.join(path, 'bin', 'linux-x86-64', 'activemq')
    etc('rc.d/init.d').install(init_path)

    hack_activemq_initd
  end

  def hack_activemq_initd
    old_initd = File.read(etc('rc.d/init.d/activemq').to_s)

    new_initd = old_initd
                  .gsub(/^ACTIVEMQ_HOME=(.*)$/, 'ACTIVEMQ_HOME="/usr/share/activemq"')
                  .gsub(/^WRAPPER_CMD=(.*)$/,   'WRAPPER_CMD="/usr/lib/activemq/linux/wrapper"')
                  .gsub(/^WRAPPER_CONF=(.*)$/,  'WRAPPER_CONF="/etc/activemq/wrapper.conf"')
                  .gsub(/^PID_DIR=(.*)$/,       'PID_DIR="/var/run/activemq"')
                  .gsub(/^PIDDIR=(.*)$/,        'PIDDIR="/var/run/activemq"')

    initd = File.open(etc('rc.d/init.d/activemq').to_s, "w")
    initd.write(new_initd)
    initd.close
  end

  def install_etc(path)
    etc('activemq').mkdir
    share('activemq').mkdir

    Dir[File.join(path, 'conf', '*')].each do |file|
      etc('activemq').install(file)
    end

    wrapper_path = File.join(path, 'bin', 'linux-x86-64', 'wrapper.conf')
    etc('activemq').install(wrapper_path)

    with_trueprefix { ln_s(etc('activemq'), destdir(share('activemq/conf').to_s)) }

    hack_activemq_wrapper_conf
  end

  def hack_activemq_wrapper_conf
    old_conf = File.read(etc('activemq/wrapper.conf'))

    new_conf = old_conf
                  .gsub(/^set.default.ACTIVEMQ_HOME=(.*)$/,   'set.default.ACTIVEMQ_HOME=/usr/share/activemq')
                  .gsub(/^set.default.ACTIVEMQ_BASE=(.*)$/,   'set.default.ACTIVEMQ_BASE=/usr/share/activemq')
                  .gsub(/^wrapper.java.classpath.1=(.*)$/,    'wrapper.java.classpath.1=%ACTIVEMQ_HOME%/bin/wrapper.jar')
                  .gsub(/^wrapper.java.classpath.2=(.*)$/,    'wrapper.java.classpath.2=%ACTIVEMQ_HOME%/bin/activemq.jar')
                  .gsub(/^wrapper.java.library.path.1=(.*)$/, 'wrapper.java.library.path.1=/usr/lib/activemq/linux/')
                  .gsub(/^wrapper.working.dir=(.*)$/,         'wrapper.working.dir=/var/log/activemq')

    wrapper_conf = File.open(etc('activemq/wrapper.conf'), 'w')
    wrapper_conf.write(new_conf)
    wrapper_conf.close
  end

  def install_share(path)
    share('activemq').mkdir
    share('activemq/bin').mkdir

    bin_path = File.join(path, 'bin')
    share('activemq/bin').install(File.join(bin_path, 'activemq'))
    share('activemq/bin').install(File.join(bin_path, 'activemq-admin'))
    share('activemq/bin').install(File.join(bin_path, 'activemq.jar'))
    share('activemq/bin').install(File.join(bin_path, 'diag'))
    share('activemq/bin').install(File.join(bin_path, 'env'))
    share('activemq/bin').install(File.join(bin_path, 'wrapper.jar'))
  end

  def install_bin(path)
    bin.mkdir

    with_trueprefix { ln_s(destdir(share('activemq/bin/activemq').to_s), destdir(bin('activemq').to_s)) }
    with_trueprefix { ln_s(destdir(share('activemq/bin/activemq-admin').to_s), destdir(bin('activemq-admin').to_s)) }
  end

  def install_usr_lib(path)
    lib('activemq/linux').mkdir

    lib_path = File.join(path, 'bin', 'linux-x86-64')
    lib('activemq/linux').install(File.join(lib_path, 'libwrapper.so'))
    lib('activemq/linux').install(File.join(lib_path, 'wrapper'))
  end

  def install_var_lib(path)
    var('lib/activemq').mkdir
    var('lib/activemq/lib').mkdir

    lib_path = File.join(path, 'lib', '*')

    Dir[lib_path].each { |file| var('lib/activemq/lib').install(file) }

    with_trueprefix { ln_s(var('lib/activemq/lib'), destdir(share('activemq/lib').to_s)) }
  end

  def install_var_lib_webapps(path)
    var('lib/activemq/webapps').mkdir
    webapps_path = File.join(path, 'webapps', '*')

    Dir[webapps_path].each { |file| var('lib/activemq/webapps').install(file) }

    with_trueprefix { ln_s(var('lib/activemq/webapps'), destdir(share('activemq/webapps').to_s)) }
  end

  def install_var_log(path)
    var('log/activemq').mkdir

    with_trueprefix { ln_s(var('log/activemq'), destdir(share('activemq/log').to_s)) }
  end

  def install_var_cache(path)
    var('cache/activemq').mkdir
    var('cache/activemq/data').mkdir

    with_trueprefix { ln_s(var('cache/activemq/data'), destdir(share('activemq/data').to_s)) }
  end

  def install_var_run(path)
    var('run/activemq').mkdir
  end

  def install_doc(path)
    doc_path = "doc/#{name}-#{version}"
    share(doc_path).mkdir

    %w(README.txt LICENSE NOTICE docs).each do |file|
      share(doc_path).install(File.join(path, file))
    end
  end
end

