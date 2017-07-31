# vagrant-ES5
A Vagrantfile used to spin up a test ES5 instance.

This README is almost entirely just steps pulled from the ElasticSearch website (including the sample data) and placed here in a succinct way.

## Pre-requisites

Virtualbox (I'm using 5.0.40 on Ubuntu 16.04).

Vagrant (I'm using version 1.8.1)

Installing Vagrant and VirtualBox (Ubuntu):

        sudo apt install vagrant virtualbox

## Build the box

To create the box, you only need to run the following command.

        vagrant up

To check that it build correctly and the port forwarding is working, open a browser and navigate to `localhost:9200`.  You should see output like this:

        {
            "name" : "zeqIbIN",
            "cluster_name" : "elasticsearch",
            "cluster_uuid" : "BGocLbe1QdqhOh-8-HBNog",
            "version" : {
                "number" : "5.5.1",
                "build_hash" : "19c13d0",
                "build_date" : "2017-07-18T20:44:24.823Z",
                "build_snapshot" : false,
                "lucene_version" : "6.6.0"
            },
            "tagline" : "You Know, for Search"
        }

## Add some test data (optional)

You can use the file `accounts.json` in this repo.  The data originally came from [here][1]

        curl -H "Content-Type: application/json" -XPOST 'localhost:9200/bank/account/_bulk?pretty&refresh' --data-binary "@accounts.json"

And verify the data is there:

        curl 'localhost:9200/_cat/indices?v'

You should see data like this:

        health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
        yellow open   bank  srKuc8KWQ5-LfaEbOtLCng   5   1       1000            0    640.4kb        640.4kb

## Troubleshooting

You can use `vagrant ssh` to log into the box and look for errors in `/var/log/elasticsearch/elasticsearch.log`.  If there are no files in this directory check `/var/log/syslog` for errors.  You can also use the command `netstat -nlp` to see if ElasticSearch is running on port `9200`.

## References
[1]: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/_exploring_your_data.html "ES5 - Exploring your data"

