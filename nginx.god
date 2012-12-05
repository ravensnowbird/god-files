God.watch do |w|
  w.name = "nginx"
  w.interval = 30.seconds # default

  w.start = "/etc/init.d/nginx start"

  w.stop = "/etc/init.d/nginx stop"

  w.restart = "/etc/init.d/nginx restart"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/run/nginx.pid"

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 50.megabytes
      c.times = 5
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 30.percent
      c.times = 5
    end

    #restart.condition(:http_response_code) do |c|
    #  c.host = 'localhost'
    #  c.port = 80
    #  c.path = 'check.txt'
    #  c.code_is_not = 200
    #  c.timeout = 10.seconds
    #  c.times = 1
    #end
  end

end
