# Esolang categories scraper

This repo is hosting code of a scheduled task that updates the [esolangcategories.json](http://storage.googleapis.com/esolang.www.nakilon.pro/esolangcategories.json) on a daily basis. Source of the webpage is located in [another repo](https://github.com/Nakilon/www-nakilon-pro/blob/master/www.nakilon.pro/esolang.htm).

Previously it was done with Github Actions cron but since they disable the workflow automatically if there are no recent commits I'm switching it now to Google Cloud and so the `.github/workflows/main.yaml` was transformed to `main.sh`. Minor note: current GCP implementation is not ideal -- I pass GCS secret as an arbitrary secret via Secrets service instead of using the Cloud Run Service Accounts integration because who knows how to test it.

WARNING: any accepted change to master branch will take effect in the next run (at 00:00)

## GCS bucket integration notes

* create a GCS bucket to give a Service Account the [Object Admin](https://stackoverflow.com/a/61359836/322020) Role in it  
* paste the `$ base64 < service-account-key.json | pbcopy` as a `SECRET` as a repo's [Github Action var](https://github.com/Nakilon/esolang/settings/secrets/actions)  
* `gsutil cors set cors.json gs://esolang.www.nakilon.pro`
