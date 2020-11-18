require 'cucumber'
require_relative '../../vertica-connect'

Given 'database Vertica' do
  @client = VerticaClient.new
end

Then 'connect to database and verify if ready db to query' do
  result = @client.ready_for_query
  assert_equal(true, result)
end

When(/^execute some sql script '([^"]*)'$/) do |script|
  @client.sql_query(script)
end

Then(/^verify that all data inserted successfully$/) do
  assert_equal(@client.data_in_database, @client.values_of_row)
end
