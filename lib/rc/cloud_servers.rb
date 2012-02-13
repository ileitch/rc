require 'cloudservers'

module Rc
  class CloudServers
    class << self
      attr_accessor :connection
    end

    def self.execute(command, args)
      new(args).send(command)
    end

    def initialize(args)
      @args = args
    end

    def list
      connection.servers.each { |server| puts "#{server[:name]} (#{server[:id]})" }
    end

    def status
      puts server.status
    end

    def delete
      server.delete
    end

    def reboot
      server.reboot
    end

    def size
      flavor = server.flavor
      puts "Disk: #{flavor.disk}GB"
      puts "RAM: #{flavor.ram}GB"
    end

    def ip
      puts "Public: #{server.addresses[:public].join(', ')}"
      puts "Private: #{server.addresses[:private].join(', ')}"
    end

    def info
      puts "#{server.name} (#{server.id})\nStatus: #{server.status}\nImage: #{server.image.name}\nFlavor: #{server.flavor.name}"
    end

    protected

    def connection
      return self.class.connection if self.class.connection
      STDOUT.write('Username: ')
      username = gets
      STDOUT.write('API key: ')
      api_key = gets
      begin
        self.class.connection ||= ::CloudServers::Connection.new(:username => username, :api_key => api_key)
      rescue ::CloudServers::Exception::Authentication => e
        STDERR.puts(e.message)
        exit 1
      end
    end

    def server
      name_or_id = @args.shift
      id = name_or_id != /^\d+$/ ? id_for_server_named(name_or_id) : name_or_id
      @server ||= connection.server(id)
    end

    def id_for_server_named(name)
      server = connection.servers.find { |server| server[:name] == name }
      server[:id] if server
    end
  end
end