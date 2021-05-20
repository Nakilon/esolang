# Esolang categories scraper

This repo is hosting code of a scheduled task that updates the [esolangcategories.json](http://storage.googleapis.com/esolang.www.nakilon.pro/esolangcategories.json) on a daily basis. Source of the [webpage](http://www.nakilon.pro/esolang.htm) is located in [another repo](https://github.com/Nakilon/www-nakilon-pro/blob/master/www.nakilon.pro/esolang.htm).

Previously it was done with Github Actions cron but since they disable the workflow automatically if there are no recent commits I've switched it now to Google Cloud. Note: current GCP implementation is not ideal -- I pass GCS secret as an arbitrary Secret instead of using the Cloud Run Service Accounts integration properly because who knows how to test it. Also note that if you have enabled the Cloud Scheduler prior to March 19, 2019 you'd have to do [some magic](https://medium.com/@azarudeena/cloud-scheduler-default-service-account-needs-have-the-roles-cloudscheduler-serviceagent-dc8bb4720e54) to stop seeing 403 error in the Scheduler logs when it tries to trigger the Cloud Run.

Any accepted change to master branch will take effect on the next day. The whole task run currently takes less than a minute.

## GCS bucket integration notes

* create a GCS bucket to give a Service Account the [Object Admin](https://stackoverflow.com/a/61359836/322020) Role in it  
* paste the `$ base64 < service-account-key.json | pbcopy` as a `SECRET` as a repo's [Github Action var](https://github.com/Nakilon/esolang/settings/secrets/actions)  
* `gsutil cors set cors.json gs://esolang.www.nakilon.pro`

## testing notes

```bash
docker build --progress plain . -t temp
# temporary create SECRET file to emulate some way of it being passed in the current continuous delivery
docker run --rm -ti -p 8080:8080 -e SECRET=$(cat SECRET) temp
curl localhost:8080
gcloud builds submit --tag gcr.io/nakilonpro/esolang
```
