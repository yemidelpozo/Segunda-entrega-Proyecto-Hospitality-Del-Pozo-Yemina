## CREACION DE UNA APP DE RESERVAS PARA EL ÁREA DE HOSPITALITY DE UNA PRESTIGIOSA BODEGA

### Problema:
El equipo de Hospitality de una reconocida bodega de Mendoza necesita un sistema que le permita gestionar las reservas de todas las actividades que ofrecen como experiencia al cliente. Por ello, nuestro equipo tiene el desafío de diseñar una base de datos eficiente que pueda manejar todas las operaciones relacionadas con las reservas de manera óptima.

Descripción del problema:
1.	Gestión de Clientes y Empleados : Necesitamos una base de datos que nos permita registrar la información de los clientes que realizan reservas, así como de los empleados involucrados en cada reserva, como sommeliers, encargados de atención al cliente y, en algunos casos, hasta los enólogos o embajadores de marca.
2.	Gestión de Tipos de Reserva : Es importante poder clasificar las reservas según su tipo, ya sea estándar, reservas de grupos grandes, reservas para atenciones especiales, como recepción de críticos o proveedores o clientes VIP, reservas para empleados de la bodega, etc. 
3.	Gestión de Disponibilidad : La base de datos debe permitirnos registrar la disponibilidad de lugares para visitas guiadas y degustaciones; así como gestionar su capacidad y estado (ocupado o disponible). Esto es fundamental para asegurar una correcta atención y evitar conflictos de reservas.
4.	Registro de Reservas : Necesitamos un sistema que pueda registrar de manera detallada cada reserva realizada, incluyendo la fecha y hora de la reserva, el cliente que la realizó, la actividad reservada, el empleado que atendió la reserva y el tipo de reserva.

### Objetivo:
Diseñar e implementar una base de datos relacional que satisfaga todas las necesidades de gestión de reservas de las actividades de Hospitality. Esta base de datos deberá ser eficiente, escalable y fácil de mantener, permitiendo una gestión ágil y precisa de todas las operaciones relacionadas con las reservas.

### Descripción de la Base de Datos - Gestión de Reservas de actividades de Hospitality

A continuación, se detallan los elementos principales de la base de datos:

#### Tablas:
1.	CLIENTE:
- Almacena información sobre los clientes que realizan reservas.
- Atributos: Id_cliente, Nombre, Telefono, Email, Fecha_alta
  
2.	EMPLEADO:
- Contiene información sobre los empleados involucrados en el proceso de reservas.
- Atributos: Id_empleado, Nombre, Telefono, Email, Id_actividad.
  
3.	TIPO_RESERVA:
- Define diferentes tipos de reserva para clasificarlas según su propósito o requisitos específicos.
- Atributos: Id_tiporeserva, Tipo.
   
4.	ACTIVIDAD:
- Almacena información sobre las actividades disponibles.
- Atributos: Id_actividad, Nombre, Idioma, Capacidad, Disponible
  
5.	RESERVA:
- Registra las reservas realizadas por los clientes.
- Atributos: Id_reserva, Id_cliente, Id_actividad, Id_empleado, Id_tiporeserva, Fecha, Cancelacion, Horario_reserva

### Resultado problemático:
Esta base de datos permite gestionar eficientemente el proceso de reserva de las actividades, desde la información de los clientes y empleados hasta el registro de reservas. 

Algunos de los aspectos que aborda incluyen:

•	Registro de clientes y empleados involucrados en el proceso de reserva.

•	Clasificación de las reservas según su tipo.

•	Gestión de la disponibilidad de plazas para actividades.

•	Registro detallado de las reservas realizadas, incluyendo la fecha, cliente, empleado y tipo de reserva.

En resumen, esta base de datos proporciona una estructura para organizar y gestionar eficientemente las operaciones de reserva de actividades, lo que contribuye a mejorar el servicio ofrecido a los clientes y optimizar sus actividades.

## MODELO DE RESERVAS 

<img width="473" alt="image" src="https://github.com/user-attachments/assets/d74a7115-513d-4512-b035-545835723d6c">

## Documentación de Vistas

### Vista: ReservasPorFecha
Descripción: Esta vista muestra la cantidad de reservas realizadas en diferentes fechas, como el número total de reservas por día.

Columnas: 
- Fecha:
- Fecha de la reserva (formato AAAA-MM-DD)
- TotalReservas: Número total de reservas realizadas en la fecha indicada

Ejemplo de consulta:

<img width="559" alt="image" src="https://github.com/user-attachments/assets/99d28e96-6ddf-4cbc-a400-6490addf1750">

### Vista: ReservasPorActividad
Descripción: Esta vista muestra la cantidad de reservas realizadas para cada actividad, así como la capacidad total de la misma.

Columnas:

- Id_actividad: Identificador de la actividad
- Capacidad: Número de personas que pueden realizar la actividad
- TotalReservas: Número total de reservas realizadas para la actividad

Ejemplo de consulta:

<img width="566" alt="image" src="https://github.com/user-attachments/assets/a24bc0c8-3220-4e99-9bd9-dee895bed155">


### Vista: CancelacionesPorTipoReserva
Descripción: Esta vista muestra la cantidad de cancelaciones para cada tipo de reserva.
Columnas:
- Tipo: Tipo de reserva (ej. "Estandar", "Recepción de críticos", etc.)
- TotalCancelaciones: Número total de cancelaciones para el tipo de reserva

<img width="564" alt="image" src="https://github.com/user-attachments/assets/1fd06f2a-9f61-435f-84d6-c833031c017a">

## Documentación de Funciones

### Función: contar_reservas_cliente
Descripción: Esta función cuenta la cantidad de reservas realizadas por un cliente en un intervalo de tiempo.
Parámetros:
- cliente_id: Identificador único del cliente
- fecha_inicio: Fecha de inicio del intervalo (formato YYYY-MM-DD)
- fecha_fin: Fecha de fin del intervalo (formato YYYY-MM-DD)
Retorno:
- Número total de reservas realizadas por el cliente en el intervalo de tiempo especificado

Ejemplo de uso:

<img width="558" alt="image" src="https://github.com/user-attachments/assets/31880408-1a6d-49eb-a763-c9a03e317461">

Nota: La función no toma en cuenta las cancelaciones de reservas.

### Función: reservas_por_empleado
Descripción: Esta función cuenta la cantidad de reservas en las que está involucrado un empleado, dentro de un período de tiempo
Parámetros:
- empleado_id: Identificador del empleado
- fecha_inicio: Fecha de inicio del intervalo (formato YYYY-MM-DD)
- fecha_fin: Fecha de fin del intervalo (formato YYYY-MM-DD)
Retorno:
- Reservas asociadas al empleado en el período de tiempo especificado

Ejemplo de uso:

<img width="563" alt="image" src="https://github.com/user-attachments/assets/17c64f83-2c8e-496b-bc9d-b865a20da9fb">

Nota: La función no toma en cuenta las cancelaciones de reservas.

### Función: actividad_cancelada
Descripción: Esta función verifica si una actividad está cancelada para una reserva.

Parámetros:
- actividad_id: Identificador único de la actividad
Retorno:
- TRUE si la actividad está cancelada para alguna reserva, FALSE en caso contrario

Ejemplo de uso:

<img width="542" alt="image" src="https://github.com/user-attachments/assets/fe942861-2873-480a-85d6-ae88bac49798">

Nota: La función solo verifica si la actividad está cancelada para alguna reserva. No indica si está disponible para una nueva reserva en este momento.

## Documentación de Triggers
### Trigger:after_insert_trigger
Descripción: Este trigger registra la inserción de un nuevo cliente en la tabla LOG_CAMBIOS.
Detalles:
- Tabla afectada: CLIENTE
- Acción: INSERT
- Información registrada: Fecha, ID del cliente, Usuario

Ejemplo:

Se inserta un nuevo cliente. El trigger registra la acción en la tabla LOG_CAMBIOS con los detalles correspondientes.

### Trigger:after_update_cancelacion_trigger
Descripción: Este trigger registra la cancelación de una reserva en la tabla LOG_CAMBIOS.
Detalles:
- Tabla afectada: RESERVA
- Acción: CANCELACION
- Información registrada: Fecha, ID del cliente (si se conoce), Usuario

Ejemplo:

Se actualiza una reserva para indicar su cancelación. Si la cancelación no estaba presente antes, el trigger registra la acción en la tabla LOG_CAMBIOS.

### Trigger:before_insert_cliente_trigger
Descripción: Este trigger verifica si el correo electrónico de un nuevo cliente ya está en uso.
Detalles:
- Tabla afectada: CLIENTE
- Acción: INSERT
- Validación: Correo electrónico único

Ejemplo:

Si se intenta insertar un nuevo cliente con un correo electrónico ya registrado, el trigger genera un error y la inserción no se realiza.

### Trigger:before_insert_reserva_trigger
Descripción: Este trigger verifica si un cliente ya tiene una reserva en la misma hora y mesa.
Detalles:
- Tabla afectada: RESERVA
- Acción: INSERT
- Validación: No se permiten reservas duplicadas en la misma hora y actividad para un mismo cliente.

Ejemplo:

Si se intenta reservar una actividad para un cliente que ya tiene una reserva en la misma hora y actividad, el trigger genera un error y la reserva no se realiza.

## Documentación de Procedimientos 
### Procedimiento: actualizar_reserva_cancelada_por_email
Descripción: Este procedimiento actualiza una reserva cancelada para un cliente a partir de su correo electrónico.

Parámetros:
- p_email: Correo electrónico del cliente

Retorno: Mensaje de éxito o error

Ejemplo de uso:
CALL actualizar_reserva_cancelada_por_email('ejemplo@correo.com');

### Procedimiento: actualizar_tipo_reserva_por_email
Descripción: Este procedimiento actualiza el tipo de reserva de la última reserva realizada por un cliente a partir de su correo electrónico.

Parámetros:
- p_email: Correo electrónico del cliente
- p_nuevo_tipo: Nuevo tipo de reserva

Retorno: Mensaje de éxito o error

Ejemplo de uso:
CALL actualizar_tipo_reserva_por_email('ejemplo@correo.com', 'Clientes VIP');

### Procedimiento: crear_empleado
Descripción: Este procedimiento crea un nuevo empleado en la base de datos.

Parámetros:
- p_nombre: Nombre del empleado
- p_telefono: Teléfono del empleado
- p_correo: Correo electrónico del empleado
- p_id_actividad: Identificador de la actividad que puede desempeñar el empleado

Retorno: Mensaje de éxito o error

Ejemplo de uso:
CALL crear_empleado('Emiliano Martinez', '343456789', 'emiliano.martinez@ejemplo.com', 1);
