God.watch do |w|
  w.name = "sphinxsearch"
  w.interval = 30.seconds # default

  w.start = "/etc/init.d/sphinxsearch start"

  w.stop = "/etc/init.d/sphinxsearch stop"

  w.restart = "/etc/init.d/sphinxsearch restart"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/run/sphinxsearch/searchd.pid"

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 300.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end
end
