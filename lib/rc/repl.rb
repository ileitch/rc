module Rc
  class Repl
    def self.start
      Signal.trap('INT') do
        puts
        exit 0
      end

      loop do
        STDOUT.write('> ')
        STDOUT.flush
        args = gets
        if args
          break if args =~ /^exit|quit$/
          Rc::Runner.execute(*args.split(' '))
        else
          puts
          break
        end
      end
    end
  end
end