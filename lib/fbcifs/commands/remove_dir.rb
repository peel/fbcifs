require_relative 'commands'
class RemoveDir < Command
  attr_reader :dir_name
  def initialize(env_config,dir_name)
    super(env_config,"Delete directory: #{dir_name}")
    @dir_name = dir_name
    @env_config = env_config
  end
  def action
    "rmdir \\\"#{dir_name}\\\"\n"
  end
end