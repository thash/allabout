$ curl -s "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=ebola&retmode=json" | head -n 20
{
    "header": {
        "type": "esearch",
        "version": "0.3"
    },
    "esearchresult": {
        "count": "2819",
        "retmax": "20",
        "retstart": "0",
        "idlist": [
            "25587816",
            "25585832",
            "25585771",
            "25585757",
            "25585723",
            "25585496",
            "25585384",
            "25584879",
            "25584356",
            "25584153",
