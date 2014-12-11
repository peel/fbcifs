require_relative 'commands'
class GetFile < Command
  attr_reader :filename
  def initialize(env, filename)
    super(env,"Downloads file by filename: #{filename}")
    @filename=filename
    @env_config = env_config
  end
  def action
    "get \\\"#{filename}\\\"\n"
  end
end