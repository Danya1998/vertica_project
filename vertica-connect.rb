# frozen_string_literal: true
require 'vertica'
#require 'docker'
require_relative 'Constants/constants'

# Rest client to access Vertica DB
class VerticaClient
  # Creates the connection to Vertica DB
  # @return [Vertica::Connection] the connection
  def initialize
    @connection = Vertica.connect(
            host: VerticaConstants::VERTICA_HOSTNAME,
            port: VerticaConstants::VERTICA_PORT,
            username: VerticaConstants::VERTICA_USERNAME,
            password: VerticaConstants::VERTICA_PASSWORD,
            database: VerticaConstants::VERTICA_DATABASE
    )
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

  def sql_query(file)
    #VerticaClient.read_file(file)
    @result = @connection.query(VerticaClient.read_file(file))
  end

  def values_of_column(column_name)
    @result.to_a.collect {|row| row[column_name]}
  end

  def value_of_field(number_of_row, column_name)
    @result.fetch(number_of_row, column_name)
  end
end


=begin
if __FILE__ == $0
  client = VerticaClient.new
  p client.ready_for_query
  #client.sql_query('create_table.sql')
  client.sql_query('sql/insert.sql')
  client.sql_query('sql/show_table.sql')
  p client.values_of_column('name')
end
=end






