# Car Maintenance - Aplicación Web

## Introducción
Esta es una aplicación web desarrollada con Ruby on Rails que te permite gestionar los servicios de mantenimiento de automóviles. Puedes ver, agregar, actualizar y eliminar registros de automóviles, así como hacer seguimiento a los servicios de mantenimiento de cada uno.

## Tecnologías Utilizadas
- **Ruby 3.2.3**
- **Rails 7.1.3**
- **Postgresql**
- **RSpec**

## Requisitos Previos
Antes de comenzar, asegúrate de tener instalados los siguientes componentes en tu sistema:
- Ruby 3.2.3
- Rails 7.1.3
- PostgreSQL

## Configuración del Proyecto
1. Clona este repositorio en tu máquina local usando el siguiente comando:
     ```
     https://github.com/Alonso2105/car_maintenance.git
     ```

2. Accede al directorio del proyecto:
     ```
     cd car_maintenance
     ```

3. Instala las gemas necesarias usando Bundler:
     ```
     bundle install
     ```

4. Crea la base de datos y ejecuta las migraciones:
     ```
     rails db:create
     rails db:migrate
     ```

## Ejecución de pruebas del Proyecto
para ejecutar las pruebas de Rspec ejecuta el siguiente comando
```
bundle exec rspec 
```

## Ejecución del Proyecto
Una vez que hayas configurado correctamente el proyecto, puedes iniciar el servidor Rails con el siguiente comando:

```
rails server
```
Esto iniciará el servidor en tu máquina local y podrás acceder a la aplicación desde tu navegador web visitando la dirección `http://localhost:3000`.

## Uso de la Aplicación
1. **Lista de Autos**: En la página principal de la aplicación, verás una lista de todos los autos en la base de datos. Puedes ver los detalles de cada auto y navegar a través de la lista usando paginación.
   
2. **Agregar un Nuevo Auto**: Para agregar un nuevo auto, haz clic en el botón "Nuevo Auto". Completa el formulario con los detalles del auto, incluyendo el número de placa, modelo y año. Una vez enviado el formulario, el nuevo auto se agregará a la lista.

3. **Editar un Auto**: Para actualizar un auto existente, haz clic en el botón "Editar" junto al auto que deseas modificar. Realiza los cambios necesarios en el formulario y envíalo para actualizar los detalles del auto.

4. **Eliminar un Auto**: Para eliminar un auto de la lista, haz clic en el botón "Eliminar" y el auto será removido de la base de datos.

5. **Ver Detalles del Auto**: Haz clic en el botón "Ver" junto a un auto para ver información detallada, incluyendo el número de placa, modelo, año y los servicios de mantenimiento asociados.

6. **Gestionar Servicios de Mantenimiento**: Para cada auto, puedes hacer seguimiento a los servicios de mantenimiento que ha recibido mediante estados( pending, in_progress y completed ). Puedes agregar nuevos servicios, editar los existentes o eliminar los servicios que ya no sean relevantes.

¡Y eso es todo! Ahora estás listo para comenzar a usar la aplicación de Car Maintenance.