![.github/workflows/main.yaml](https://github.com/Nakilon/esolang/workflows/.github/workflows/main.yaml/badge.svg)

# Esolang categories scraper

This repo is hosting a scheduled Github Action that updates the [esolangcategories.json](http://storage.googleapis.com/esolang.www.nakilon.pro/esolangcategories.json) on a daily basis.  
Source of the webpage is located in [another repo](https://github.com/Nakilon/www-nakilon-pro/blob/master/www.nakilon.pro/esolang.htm).

## How it works:

* Github Actions runs a Ruby script that scrapes the wiki API and stores it as a JSON file.  
* JSON file is then uploaded to a public GCS bucket.  
* Then the www.nakilon.pro/esolang.htm client-side JS fetches it.

## How it's made:

* create a GCS bucket to give a Service Account the [Object Admin](https://stackoverflow.com/a/61359836/322020) Role in it  
* paste the `$ base64 < service-account-key.json | pbcopy` as a `SECRET` as a repo's [Github Action var](https://github.com/Nakilon/esolang/settings/secrets/actions)  
* `gsutil cors set cors.json gs://esolang.www.nakilon.pro`
