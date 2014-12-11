require_relative 'commands/commands'

module Fbcifs
  class Operator
    attr_reader :handler,:uri_parser,:credentials
    def initialize(credentials,uri_parser=Fbcifs::UriParser.new,handler=Fbcifs::MessageHandler.new)
      @handler=handler
      @uri_parser=uri_parser
      @credentials=credentials
    end
    def goto(uri)
      directories = uri_parser.directories(uri)
      directories.map{|dir| GoToDir.new(credentials,dir)}
    end
    def remove(file)
      filename = uri_parser.file(file)
      cmd = goto(file)
      cmd << DeleteFile.new(credentials,filename)
    end
    def execute(cmd)
      credentials.make_credentials_file
      cmd.execute.each{|out|
        handler=handler(credentials)
        handler.handle_message(out)
      }
      credentials.drop_credentials_file
    end
  end
  class FileOperationException < Exception; end
end
