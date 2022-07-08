class Errors < StandardError
  def initialize(msg="Something wrong is going on")
    super
  end
end
