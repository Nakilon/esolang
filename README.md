![.github/workflows/main.yaml](https://github.com/Nakilon/esolang/workflows/.github/workflows/main.yaml/badge.svg)

This repo is hosting a scheduled Github Action that updates the http://storage.googleapis.com/esolang.www.nakilon.pro/esolangcategories.json (not http://esolang.www.nakilon.pro/ because I didn't add the DNS record) on a daily basis.
Source of the webpage is in another repo: https://github.com/Nakilon/www-nakilon-pro/blob/master/www.nakilon.pro/esolang.htm

How it's done:

* create a GCS bucket to give it the Service Account [Object Admin](https://stackoverflow.com/a/61359836/322020) Role permission  
* paste the `$ base64 < service-account-key.json | pbcopy` as a `SECRET` as a repo's [Github Action var](https://github.com/Nakilon/esolang/settings/secrets/actions)  
* `gsutil cors set cors.json gs://esolang.www.nakilon.pro`
