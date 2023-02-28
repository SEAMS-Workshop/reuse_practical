wget 'https://covid.ourworldindata.org/data/owid-covid-data.csv'
head -1 owid-covid-data.csv > owid-rsa.csv
#awk '$1=="ZAF" { print $0 }' owid-covid-data.csv >> owid-rsa.csv 
#less owid-rsa.csv 
#awk '$1=="ZAF" { print $0 }' owid-covid-data.csv | less
#cut -f1 owid-covid-data.csv | uniq
#cut -f1, -d',' owid-covid-data.csv | uniq
#cut -f1 -d',' owid-covid-data.csv | uniq
#cut -f1 -d',' owid-covid-data.csv | sort | uniq
#awk -F, '$1=="ZAF" { print $0 }' owid-covid-data.csv | less
awk -F, '$1=="ZAF" { print $0 }' owid-covid-data.csv >> owid-rsa.csv 
