require_relative 'commands'
class MakeDir < Command
  attr_reader :dir_name
  def initialize(env_config,dir_name)
    super(env_config,"Make directory: #{dir_name}")
    @dir_name=dir_name
  end
  def action
    "md \\\"#{dir_name}\\\"\n"
  end
end