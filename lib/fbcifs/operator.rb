require_relative 'commands/commands'

module Fbcifs
  class Operator
    attr_reader :handler,:uri_parser,:server_params
    def initialize(server_params,uri_parser=self.parser,handler=self.handler(server_params))
      @handler=handler
      @uri_parser=uri_parser
      @server_params=server_params
    end
    def goto(uri)
      directories = uri_parser.directories(uri)
      directories.map{|dir| GoToDir.new(server_params,dir)}
    end
    def remove(file)
      filename = uri_parser.file(file)
      cmd = goto(file)
      cmd << DeleteFile.new(server_params,filename)
    end
    def execute(cmd)
      cmd.execute.each{|out|
        handler=handler(server_params)
        handler.handle_message(out)
      }
    end
    def parser
      Fbcifs::UriParser.new
    end
    def handler(server_params)
      Fbcifs::MessageHandler.new(server_params.address)
    end
  end
end
