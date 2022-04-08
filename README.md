# Esolang categories intersector

This repo is hosting code of a scheduled task that scrapes the Esolang Wiki on a daily basis.  
It makes possible to find languages assigned to several categories at the same time, Esolang Wiki does not currently provide a way to do this.
![image](https://user-images.githubusercontent.com/2870363/162365163-edaa815f-b7c5-4796-a700-fa4a1248f242.png)

Source of the [webpage](http://www.nakilon.pro.website.yandexcloud.net/esolang.htm) is located in [another repo](https://github.com/Nakilon/www-nakilon-pro/blob/master/www.nakilon.pro/esolang.htm).  

~~It is running on Github Action...~~ (Github disabled the schedule if there are no commits)  
~~It is running on Google Cloud...~~ (xenophobic Google applied sanctions against me for being Russian)  
It is running on Yandex Cloud, utilizing Serverless Containers, "timer" Trigger and Object Storage.

## Development notes

```bash
$ docker build --build-arg AWS_ACCESS_KEY_ID=... --build-arg AWS_SECRET_ACCESS_KEY=... --progress plain -t temp . < Dockerfile
$ docker run -e PORT=8000 -p 8000:8000 --rm -ti temp
$ curl localhost:8000
```
```bash
$ yc serverless container revision deploy --container-name esolang --image cr.yandex/.../esolang --service-account-id ... --execution-timeout 60s
```
