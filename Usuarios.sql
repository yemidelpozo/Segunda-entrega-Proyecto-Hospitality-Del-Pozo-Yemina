use reservas_actividades_hospitality;

-- En esta ocasión se crean los usuarios de la base de datos --

-- Se crea el usuario "delyem" y se le otorgan todos los permisos --

CREATE USER 'delyem'@'%' IDENTIFIED BY '1234' ; 
GRANT ALL PRIVILEGES ON *.* TO 'delyem'@'%' WITH GRANT OPTION;

-- Se crea el usuario "alogla" y se le otorgan permisos para ver todas las tablas de la base de datos --

CREATE USER 'alogla'@'%' IDENTIFIED BY 'abcd' ; 
GRANT ALL PRIVILEGES ON reservas_actividades_hospitality.* TO 'alogla'@'%';

-- Se crea un usuario con permisos para visualizar la tabla reservas de la base de datos --

CREATE USER 'barels'@'%' IDENTIFIED BY 'wxyz' ;
GRANT SELECT ON reservas_actividades_hospitality.reservas TO  'barels'@'%';

-- Se crea usuario modelo para quienes necesitan consultar las vistas sobre reservas --

CREATE USER 'sanrom'@'%' IDENTIFIED BY 'romi' ;
GRANT SELECT ON reservas_actividades_hospitality.reservasporactividad TO 'sanrom'@'%';
GRANT SELECT ON reservas_actividades_hospitality.reservasporfecha TO 'sanrom'@'%';
GRANT SELECT ON reservas_actividades_hospitality.cancelacionesportiporeserva TO 'sanrom'@'%';
GRANT SELECT ON reservas_actividades_hospitality.cancelacionesporcliente TO 'sanrom'@'%';
GRANT SELECT ON reservas_actividades_hospitality.reservasporcliente TO 'sanrom'@'%';

-- Select para consultar los usuarios de la base de datos --
SELECT *
FROM mysql.user;


