module Settings
    
    require 'facter'
    require 'inifile'
    
    @@home_path = Facter['HOME'].value.tr('\\', '/')
    app_conf = Facter['CONF'].value
    @@arguments_array = Facter['ARGUMENTS'].value.downcase.split(' ')
    @@app_ini = IniFile.load(@@home_path + app_conf)
    
    def self.dry_run
        true if @@arguments_array.include? '--dry-run'
    end

    def self.cleanup
        true if @@arguments_array.include? '--cleanup'
    end

    def self.version
        @@app_ini['general']['version']
    end

end