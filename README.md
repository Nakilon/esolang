**Temporary down/unsupported**

# Esolang categories scraper

This repo is hosting code of a scheduled task that updates the [esolangcategories.json](https://storage.yandexcloud.net/unversioned.www.nakilon.pro/esolangcategories.json) on a daily basis. Source of the [webpage](http://www.nakilon.pro/esolang.htm) is located in [another repo](https://github.com/Nakilon/www-nakilon-pro/blob/master/www.nakilon.pro/esolang.htm).

~~It is running on Github Action...~~ (Github disable the schedule if there are no commits)  
~~It is running on Google Cloud...~~ (xenophobic Google apply sanctions against me for being Russian)  
Is it running on Yandex Cloud, utilizing Serverless Containers, "timer" Trigger and Object Storage.

## Development notes

```bash
$ docker build --build-arg AWS_ACCESS_KEY_ID=... --build-arg AWS_SECRET_ACCESS_KEY=... --progress plain -t temp . < Dockerfile
$ docker run -e PORT=8000 -p 8000:8000 --rm -ti temp
$ curl localhost:8000
```
```bash
$ yc serverless container revision deploy --container-name esolang --image cr.yandex/.../esolang --service-account-id ... --execution-timeout 60s
```
