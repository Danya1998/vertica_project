require 'time'

module Timer
  def sql_query(file)
    @start_execution = Time.new
    super
    @stop_execution = Time.new
    time = @stop_execution - @start_execution
    puts "Excution time is #{time} seconds."
  end
end
