
class Timer < Hokusai::Block
  style <<~EOF
  [style]
  stopwatch {
    size: 30.0;
    color: rgb(22,22,22);
  }
  control {
    height: 100.0;
  }
  EOF
  
  template <<~EOF
  [template]
    hblock
      text { ...stopwatch :content="current_time" }
    hblock { ...control }
      circle {
        :color="color"
        :radius="30.0"
        @click="pause_timer"
        cursor="pointer"
      }
  EOF

  uses(
    text: Hokusai::Blocks::Text,
    hblock: Hokusai::Blocks::Hblock,
    circle: Hokusai::Blocks::Circle
  )

  attr_reader :time, :paused

  def initialize(**args)
    @time = nil
    @paused = true
    @now = 0

    super
  end

  def color
    @paused ? [67, 72, 191] : [222, 32, 83]
  end

  def current_time
    return @now.to_s if @paused
    return 0.to_s if time.nil?
    
    (Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond) - time + @now).to_s
  end

  def pause_timer(event)
    @paused = !@paused

    if @paused
      @now += Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond) - time
      @time = nil
    else
      @time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond) 
    end
  end
end
