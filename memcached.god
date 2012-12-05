God.watch do |w|
  w.name = "memcached"
  w.interval = 30.seconds # default

  w.start = "/etc/init.d/memcached start"

  w.stop = "/etc/init.d/memcached stop"

  w.restart = "/etc/init.d/memcached restart"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/run/memcached.pid"

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:cpu_usage) do |c|
      c.above = 98.percent
      c.times = 5
    end
  end
end
