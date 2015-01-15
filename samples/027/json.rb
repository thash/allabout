require 'open-uri'
require 'json'

response = open('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=ebola&retmode=json')
data = response.read
json = JSON.parse(data)

puts json.class # => Hash
puts json.keys  # => header esearchresult
puts json['esearchresult']['count']  # => 2819
puts json['esearchresult']['idlist'] # => 25587816 25585832 25585771 ...
