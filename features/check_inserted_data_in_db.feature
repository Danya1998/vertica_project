Feature: Check that right data inserted in database
  Scenario: Check if user successfully connected to database
    Given database Vertica
    Then connect to database and verify if ready db to query

  Scenario:Check that right data inserted in database
    Given database Vertica
    Then connect to database and verify if ready db to query
    When execute some sql script 'sql/insert.sql'
    Then verify that all data inserted successfully