require 'yaml'

module Serialize
    def self.to_yaml(obj)
        Dir.mkdir "saves" unless Dir.exist? "saves"
        f = File.new "saves/#{Time.now.strftime("%H%M%S%L")}.yaml", "w"
        f << YAML.dump(obj)
        f.close
    end

    def self.from_yaml(string)
        data = YAML.load string
        return data
    end
end