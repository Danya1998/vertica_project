require_relative 'vertica-connect'
require_relative 'timer'
if __FILE__ == $0
  client = VerticaClient.new
  p client.ready_for_query
  # client.sql_query('create_table.sql')
  client.sql_query('sql/insert.sql')
  client.extend(Timer)
  # client.sql_query('sql/show_table.sql')
  client.data_in_database
  p client.values_of_row
  client.close_connection
end
