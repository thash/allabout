require 'open-uri'
require 'json'
require 'hashie'

response = open('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=ebola&retmode=json')
data = response.read
json = JSON.parse(data)

mash = Hashie::Mash.new(json)
mash.esearchresult.idlist # => => ["25587816", "25585832", "25585771", ...
