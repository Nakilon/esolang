require "webrick"
server = WEBrick::HTTPServer.new Port: ENV["PORT"]  # this env var is provided by YC
# there are two ways to ensure we call it only once per instance
server.mount_proc "/" do
  require "./main"   # 1
ensure
  server.shutdown  # 2, though this one isn't thread-safe
end
Thread.new{ server.start }.join
