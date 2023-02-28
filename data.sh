# download raw data
wget 'https://covid.ourworldindata.org/data/owid-covid-data.csv'

# create new file with the right header line
head -1 owid-covid-data.csv > owid-rsa.csv

# append South Africa data to the new file
awk -F, '$1=="ZAF" { print $0 }' owid-covid-data.csv >> owid-rsa.csv 
