#! /bin/bash

# install openjdk-8
sudo apt-get purge openjdk*
sudo apt-get -y install openjdk-8-jdk

sudo apt-get install apt-transport-https

echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list

sudo apt-get update && sudo apt-get install -y --allow-unauthenticated elasticsearch

# Set to run at boot.
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service

# either of the next two lines is needed to be able to access "localhost:9200" from the host os
sudo echo "network.bind_host: 0" >> /etc/elasticsearch/elasticsearch.yml
#sudo echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml

# enable dynamic scripting
#sudo echo "script.inline: on" >> /etc/elasticsearch/elasticsearch.yml
#sudo echo "script.indexed: on" >> /etc/elasticsearch/elasticsearch.yml

# Enable CORS
sudo echo "http.cors.enabled: true" >> /etc/elasticsearch/elasticsearch.yml

sudo echo "http.cors.allow-origin: /https?:\/\/.*/" >> /etc/elasticsearch/elasticsearch.yml
# You can lock to localhost with the following line instead.
#http.cors.allow-origin: /https?:\/\/localhost(:[0-9]+)?/

# Settings to make ES5 work on low memory.
sudo echo "MAX_LOCKED_MEMORY=1g" >> /etc/default/elasticsearch

sudo sysctl vm.max_map_count=262144

sudo echo "-Xms1g" >> /etc/elasticsearch/jvm.options
sudo echo "-Xmx1g" >> /etc/elasticsearch/jvm.options

sudo /etc/init.d/elasticsearch restart

