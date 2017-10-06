$:.unshift File.dirname(__FILE__)

require 'lib/simple_framework'

route("/delete") do
  'Deleted'
end

run SimpleFramework.app
