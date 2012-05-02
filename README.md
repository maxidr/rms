Para iniciar el proyecto:

Seguir los siguientes pasos para instalar RVM:
http://rvm.beginrescueend.com/packages/openssl/

Jquery para rails 3 (jquery-ujs):
	git submodule init
	git submodule update

Crear y poblar BBDD:
	rake db:migrate
	rake db:seed

----------------------------------------------------------------------

*[Changelog](https://github.com/maxidr/rms/blob/master/CHANGELOG.md)*

-----------------------------------------------------------------------

## Metodología de despliegue

Los depliegues se realizan en dos ambientes: staging y production.  Se require desplegar primero en staging y luego en production.  Al desplegar en staging automáticamente se incrementa la versión del proyecto.  Para desplegar en production se requiere tener una version ya generada (realizada por el despliegue en staging).

### Despliegue a staging
    
    rake deploy:staging

Esto genera una nueva versión y crea un tag (en git) para contenerlo.  Cuando se utiliza este comando, automáticamente incrementa el número de versión (la sección de revisión, ver [semantic versioning](http://semver.org/)).  Luego de ello, la tarea, despliega el proyecto en heroku usando la rama.

### Desplegar al ambiente de producción

    rake deploy:production

Esta tarea despliega la aplicación a la instancia de producción a heroku (remoto production) usando la último tag versionado.  Si necesita desplegar una versión que no es la última tageada puede utilizar el parámetro *tag* con el número de versión (ej.: rake deploy:production tag=0.1.2).


### Listado de ambientes

Para listar la información de los ambientes que maneja la tarea rake puede ejecutar:

    rake deploy:show_environments



-------------------------------------------------------------------------------------------------------

Fugue icons from http://p.yusukekamiyamane.com/

Fugue Icons

Copyright (C) 2010 Yusuke Kamiyamane. All rights reserved.
The icons are licensed under a Creative Commons Attribution
3.0 license. <http://creativecommons.org/licenses/by/3.0/>

