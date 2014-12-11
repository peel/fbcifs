require_relative 'commands'
class PutFile < Command
  attr_reader :filename
  def initialize(env, filename)
    super(env,"Upload file by filename: #{filename}")
    @filename=filename
    @env_config = env_config
  end
  def action
    "put \\\"#{filename}\\\"\n"
  end
end
