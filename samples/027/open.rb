require 'open-uri'

response = open('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=ebola&retmode=json')
# response.class #=> StringIO
# response.read.class #=> String

puts response.read
#=> {
#       "header": {
#           "type": "esearch",
#           "version": "0.3"
#       },
#       "esearchresult": {
#           "count": "2819",
#           "retmax": "20",
#           "retstart": "0",
#           "idlist": [
#               "25587816",
