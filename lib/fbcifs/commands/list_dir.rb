require_relative 'command'

class ListDir < Command
  def initialize(env_config)
    super(env_config,"List current directory")
  end
  def action
    "ls \\n"
  end
end