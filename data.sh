echo 'Fetching data from Our World in Data . . . '
source='https://covid.ourworldindata.org/data/owid-covid-data.csv'
raw_dir='./data/raw/'
dest_path=${raw_dir}owid-covid-data.csv
mkdir -p $raw_dir
wget --no-clobber $source -O $dest_path
echo -e 'Done.\n'

echo -n 'Extracting data for South Africa . . . '
processed_dir='./data/processed/'
tmp_filename=${processed_dir}owid-rsa_all.csv
mkdir -p $processed_dir
head -1 $dest_path > $tmp_filename
awk -F, '$1=="ZAF" { print $0 }' $dest_path >> $tmp_filename
echo -e 'Done.\n'

echo -n 'Extracting date, case, and death data . . . '
rsa_filename=${processed_dir}owid-rsa.csv
cut -d',' -f4,12,13,15,16 $tmp_filename > $rsa_filename # grab columns with date, smoothed cases per million, smoothed deaths per million
echo -e 'Done.\n'
