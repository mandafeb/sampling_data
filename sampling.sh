#!/usr/bin/bash

# download requirements
pip install csvkit
python3 -m pip install sample-stream

# download data
wget https://github.com/labusiam/dataset/raw/main/weather_data.xlsx

# cek folder data
if [ ! -d data ]; then
        mkdir data
        mv weather_data.xlsx data
else
        mv weather_data.xlsx data
fi

# move to dir data
cd data

# convert xlsx ke csv, per kolom
in2csv weather_data.xlsx --sheet "weather_2014" > weather_2014.csv

in2csv weather_data.xlsx --sheet "weather_2015" > weather_2015.csv

# join csv files
csvstack weather_2014.csv weather_2015.csv > weather.csv

# create sample data
cat weather.csv | sample -r 0.3 > sample_weather.csv
