module Observabl
  def initialize
    @observers = []
  end

  def add_observer(&block)
    @observers << block
  end

  def notify
    @observers.each do |obs|
      obs.call
    end
  end
end

class User
  include Observabl

  def initialize
    super
    add_observer do
      puts "Hello World" 
    end
  end
end

user = User.new

user.notify
