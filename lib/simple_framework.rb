require 'lib/action'

module SimpleFramework
  def self.app
    @app ||= begin
      App.new(Rack::Builder.new) do
        map "/" do
          run ->(env) {[404, {'Content-Type' => 'text/plain'}, ['Page Not Found!']] }
        end
      end
    end
  end

  class App < SimpleDelegator
  end
end

def route(pattern, &block)
  SimpleFramework.app.map(pattern) do
    run Action.new(&block)
  end
end
