require 'cucumber'
require_relative '../../vertica-connect'

Given "database Vertica" do
  @client = VerticaClient.new
end

Then "connect to database and verify if ready db to query" do
  result = @client.ready_for_query
  assert_equal(true, result)
end

When /^execute some sql script '([^"]*)'$/ do |script|
  @client.sql_query('sql/insert.sql')
  @client.sql_query(script)
end

Then /^verify that user "([^"]*)" successfully added$/ do |name|
  assert name == @client.value_of_field(0,"name")
end