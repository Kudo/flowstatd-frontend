require 'flowd_client'

client = FlowdClient.new('140.123.20.7', '9993')
client.get_top(5)
