require 'cloudservers'

module Rc
  class CloudServers
    def self.execute(command, args)
      new(args).send(command)
    end

    def initialize(*args)
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

    protected

    def connection
      return @connection if @connection
      STDOUT.write('Username: ')
      username = gets
      STDOUT.write('API key: ')
      api_key = gets
      begin
        @connection ||= ::CloudServers::Connection.new(:username => username, :api_key => api_key)
      rescue ::CloudServers::Exception::Authentication => e
        STDERR.puts(e.message)
        exit 1
      end
    end

    def server
      name_or_id = @args.shift
      id = name_or_id != /^\d+$/ ? id_for_server_named(name_or_id) : name_or_id
      connection.server(id)
    end

    def id_for_server_named(name)
      server = connection.servers.find { |server| server[:name] == name }
      server[:id]
    end
  end
end