class Action
  attr_reader :headers, :body, :request

  def initialize(&block)
    @block   = block
    @status  = 200
    @headers = { 'Content-Type'.freeze => 'text/html'.freeze }
    @body    = ''.freeze
  end

  def status(value = nil)
    value ? @status = value : @status
  end

  def params
    request.params
  end

  def call(env)
    @request = Rack::Request.new(env)
    result   = self.instance_eval(&@block)
    @body    = result if result.is_a?(String)

    [status, headers, [body]]
  end
end
