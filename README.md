Para iniciar el proyecto:

Seguir los siguientes pasos para instalar RVM:
http://rvm.beginrescueend.com/packages/openssl/

Jquery para rails 3 (jquery-ujs):
	git submodule init
	git submodule update

Crear y poblar BBDD:
	rake db:migrate
	rake db:seed


#### Version 1.1

Se incorporan las siguientes correcciones:

* Se corrige el ordenamiento por columnas en el listado de requerimientos (N°, fecha, solicitante, empresa, sector y rubro)
* Se agrega el orden por "Estado" en la lista de requerimientos.
* Se agrega el filtro de razón social del proveedor en la pantalla de requerimientos.  Se filtrarán solo los requerimientos que ya hayan sido aprobados por compras (o sea, que poseen un presupuesto asignado).
* Se agrega el campo "Consumo" en los requerimientos.  El consumo puede ser una opción dentro de "semanal, quincenal, bimestral, trimestral, semestral y anual"

....

Fugue icons from http://p.yusukekamiyamane.com/

Fugue Icons

Copyright (C) 2010 Yusuke Kamiyamane. All rights reserved.
The icons are licensed under a Creative Commons Attribution
3.0 license. <http://creativecommons.org/licenses/by/3.0/>

