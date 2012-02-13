module Rc
  class Runner
    def self.execute(*args)
      new(*args).execute
    end

    def initialize(*args)
      @args = args.clone
      ARGV.clear
    end

    def execute
      group = parse_group
      group.execute(@args.shift, @args)
    end

    protected

    def parse_group
      case @args.shift
      when /servers|s/
        Rc::CloudServers
      end
    end
  end
end