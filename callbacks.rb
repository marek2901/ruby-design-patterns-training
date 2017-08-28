class XdResult
  attr_reader :message

  def self.success(message = '')
    new(:success, message)
  end

  def self.error(message = '')
    new(:error, message)
  end

  def self.timed_out(message = '')
    new(:timed_out, message)
  end

  def self.progress_update(message = '')
    new(:progress_update, message)
  end

  def initialize(status, message = '')
    @status = status
    @message = message
  end

  def on_success
    yield if @status == :success
  end

  def on_error
    yield if @status == :error
  end

  def on_timed_out
    yield if @status == :timed_out
  end

  def on_progress_update
    yield if @status == :progress_update
  end
end

def xd
  sleep(0.5)
  yield XdResult.progress_update('first')
  sleep(0.5)
  yield XdResult.progress_update('second')
  sleep(0.5)
  yield XdResult.progress_update('third')
  sleep(0.5)
  yield XdResult.progress_update('fourth')
  sleep(0.5)
  yield XdResult.progress_update('fiveththt')
  sleep(0.5)
  yield XdResult.progress_update('sixfdsf')
  sample = [1, 2, 3].sample
  if sample == 1
    yield XdResult.success
  elsif sample == 2
    yield XdResult.timed_out
  else
    yield XdResult.error('something went wrong :D :D :D xD')
  end
end

xd do |result|
  result.on_progress_update do
    puts result.message
  end
  result.on_success do
    puts 'xDD'
  end

  result.on_timed_out do
    puts 'timed'
  end

  result.on_error do
    puts "Error : #{result.message}"
  end
end
