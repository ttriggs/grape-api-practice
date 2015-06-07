[![Build Status](https://travis-ci.org/ttriggs/grape-api-practice.svg?branch=master)](https://travis-ci.org/ttriggs/grape-api-practice) [![Coverage Status](https://coveralls.io/repos/ttriggs/grape-api-practice/badge.svg)](https://coveralls.io/r/ttriggs/grape-api-practice)

##About
Simple record storing and retrieval app with a command line utility (cli.rb) and [Grape](https://github.com/intridea/grape) API to interface with the redis database.

##CLI (made with the [gli](https://github.com/davetron5000/gli) gem):
Note: Be sure to have ```redis-server``` running when using the CLI

Run ```./cli.rb help``` to see accepted commands:
```
NAME
    cli.rb -
      Store and retrieve sorted records from a redis database.
      Imported text files should have five fields per record:
      LastName | FirstName | Gender | FavoriteColor | DOB(YYYYMMDD)
      delimited by pipes, commas, or white spaces.


SYNOPSIS
    cli.rb [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help - Show this message

COMMANDS
    help              - Shows a list of commands or help for one command
    import            - Import records from text file(s) (arguments). Accepts comma, pipe, or space
                        delimited text files.
    sort_by_dob       - Sort records by date of birth.
    sort_by_gender    - Sort records by gender, then by last name.
    sort_by_last_name - Sort records by last name.
```

Example importable text file:
```
Albert, Steve, male, red, 19830319
Stevens, Steve, male, red, 19830310
Lee, Julia, female, blue, 19840619
Apple, Julia, female, blue, 19840610
```

##[Grape](https://github.com/intridea/grape) API:
The Grape API can be also be used to either return sorted records (GET endpoints) or to import a new record (POST /records)

To run the grape API, run ```rackup``` (and have redis-server running)
default url is http://localhost:9292

Run ```rake routes``` to view API endpoints:
```
  method: GET   path: /records/gender
  method: GET   path: /records/birthdate
  method: GET   path: /records/name
  method: POST  path: /records
```

To Post a new record using curl:
```
curl --data "{\"record\":\"Jones|Adam|male|red|19650115\"}" http://localhost:9292/records/ --header "Content-Type:application/json"
```
response:
```
[{"last_name":"Jones","first_name":"Adam","gender":"male","favorite_color":"red","dob":"1/15/1965"}]%
```

##Goals:
###Step 1 - Build a system to parse and sort a set of records

Create a command line app that takes as input a file with a set of records in one of three formats described below, and outputs (to the screen) the set of records sorted in one of three ways.

Input

A record consists of the following 5 fields: last name, first name, gender, date of birth and favorite color. The input is 3 files, each containing records stored in a different format.

The pipe-delimited file lists each record as follows:
LastName | FirstName | Gender | FavoriteColor | DateOfBirth

The comma-delimited file looks like this:
LastName, FirstName, Gender, FavoriteColor, DateOfBirth

The space-delimited file looks like this:
LastName FirstName Gender FavoriteColor DateOfBirth

Assume that the delimiters (commas, pipes and spaces) do not appear anywhere in the data values themselves. Write a Ruby program to read in records from these files and combine them into a single set of records.

Output

Create and display 3 different views of the data you read in:

Output 1 – sorted by gender (females before males) then by last name ascending.
Output 2 – sorted by birth date, ascending.
Output 3 – sorted by last name, descending.
Display dates in the format M/D/YYYY.

###Step 2 - Build a Grape API

Build a standalone Grape API with the following endpoints:

POST /records - Post a single data line in any of the 3 formats supported by your existing code
GET /records/gender - returns records sorted by gender
GET /records/birthdate - returns records sorted by birthdate
GET /records/name - returns records sorted by name
It's your choice how you render the output from these endpoints as long as it well structured data. These endpoints should return JSON.

