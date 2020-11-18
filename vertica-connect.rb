# frozen_string_literal: true
require 'vertica'
#require 'docker'
require_relative 'timer'
require_relative 'Constants/constants'
require 'method_decorators'
require 'active_record'
# Rest client to access Vertica DB
class VerticaClient
  # Creates the connection to Vertica DB
  # @return [Vertica::Connection] the connection
  extend Timer
  def initialize(username)
    @connection = Vertica.connect(
            host: VerticaConstants::VERTICA_HOSTNAME,
            port: VerticaConstants::VERTICA_PORT,
            username: username, #VerticaConstants::VERTICA_USERNAME,
            password: VerticaConstants::VERTICA_PASSWORD,
            database: VerticaConstants::VERTICA_DATABASE
    )
    @start_execution = Time.new
    @rows_in_database = Array.new
  end
  # Check Vertica DB is available for query
  #
  # @return [Boolean] true if ready, else - false
  def ready_for_query
    @connection.ready_for_query?
  end

  def self.read_file(file)
    query = []
    file = File.new(file, 'r')
    p file.path
    file.each do |line|
      query.append(line.tr("\n\t", ""))
    end
    query.join(" ")
  end

  def data_in_database
    #Return two-dimensional massive of values of each row
    query = sql_query('sql/show_table.sql')
    query.to_a.each { |row| @rows_in_database.append(row.to_a) }
    @rows_in_database
  end

  def sql_query(file)
    #VerticaClient.read_file(file)
    @result = @connection.query(VerticaClient.read_file(file))
  end

  def values_of_row
    @result.to_a.collect {|row| row.to_a}
  end

  def value_of_field(number_of_row, column_name)
    @result.fetch(number_of_row, column_name)
  end
=begin
  def timer
    @stop_execution = Time.new
    time = @stop_execution - @start_execution
    puts "Excution time is #{time} seconds."
  end
=end
  def close_connection
    @connection.close

  end
end

=begin
class Timer < MethodDecorators::Decorator
  def call(func, *args, &blk)
    ActiveRecord::Base.transaction do
      @start_execution = Time.new
      func.call(*args,&blk)
      @stop_execution = Time.new
      puts "Excution time is #{time} seconds."
    end
  end
end
=end



