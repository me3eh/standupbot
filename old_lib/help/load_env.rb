class LoadENV
  def initialize
    # Dotenv.load
    # @envs = {}
    # try do
    #   File.open('.env').read.split("\n").map { |u| @envs[u.split('=')[0]] = u.split('=')[1] }
    # catch Exception
  end

  def get(symbol)
    @envs[symbol.to_s]
  end
end
