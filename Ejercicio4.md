# Ejercicio 4: Kubernetes

El objetivo es extender la pipeline actual para desplegar la aplicación **votingapp** y ejecutar sus test de integración tests en `kubernetes`.

A parte del script de la pipeline, la solución debe contener los siguientes recursos de la **API** de `kubernetes` en formato `yaml`:

* `Deployment` para la aplicación votingapp con 2 réplicas.
* `Service` de tipo `clusterIP` para la aplicación votingapp.
* `Deployment` para la base de datos redis con 1 réplica.
* `Service` de tipo `clusterIP` para la base de datos redis.
* `ConfigMap` usando la configuración proporcionada en `./nginx/nginx.conf`.
* `Deployment` para **nginx** montando un volumen que lea del `configMap` creado en el punto anterior.
* `Service` de tipo `NodePort` para acceder al **nginx** desde el exterior.

La entrega se realiza en el repo privado de github de cada estudiante.
