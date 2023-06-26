class LoadENV
  def initialize
    @envs = {}
    File.open('.env').read.split("\n").map { |u| @envs[u.split('=')[0]] = u.split('=')[1] }
  end

  def get(symbol)
    @envs[symbol.to_s]
  end
end
