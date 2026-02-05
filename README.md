# CRUD_Biblioteca

## Descripción del Proyecto
Este proyecto es una aplicación de escritorio desarrollada en Delphi para la gestión de una biblioteca. Permite realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre libros, usuarios y préstamos. El sistema está diseñado para facilitar la administración básica de una biblioteca.

## Reglas de negoccio
- **Tipos de usuario** Existen dos tipos de usuario
    - **Regular** Puede pedir un maximo de 5 libros por un maximo de 5 dias.
    - **Estudiante** Puede pedir un maximo de 10 libros por un maximo de 10 dias.
- **Prestamos** 
    - **Cantidad prestamos** Cada usuario puede tener un prestamo activo a la vez.
    - **Cantidad libros** Por cada prestamo solo se puede pedir una copia de cada libro.
    - **Fechas** El inicio del prestamo se genere en la fecha del sistema.
    - **Devolucion** Se calcula en base al tipo de usuario.


## Funcionalidades
El sistema `CRUD_Biblioteca` ofrece las siguientes funcionalidades principales:

### Gestión de Libros
-   **Alta de Libros**: Permite añadir nuevos libros al inventario de la biblioteca (`UAltaLibro.pas`).
-   **Consulta de Libros**: Visualización y búsqueda de libros existentes (`ULibros.pas`).
-   **Modificación de Libros**: Edición de la información de libros previamente registrados (`UModificarLibros.pas`).

### Gestión de Usuarios
-   **Alta de Usuarios**: Permite registrar nuevos usuarios de la biblioteca (`UAltaUsuario.pas`).
-   **Consulta de Usuarios**: Visualización y búsqueda de usuarios existentes (`UUsuarios.pas`).
-   **Modificación de Usuarios**: Edición de la información de usuarios registrados (`UModificarUsuario.pas`).

### Gestión de Préstamos
-   **Alta de Préstamos**: Registro de nuevos préstamos de libros a usuarios (`UAltaPrestamo.pas`).
-   **Consulta de Préstamos**: Visualización de los préstamos activos y su estado (`UPrestamos.pas`).


### Tecnologías Utilizadas
-   **Delphi**: Lenguaje de programación y entorno de desarrollo.
-   **Archivos DFM**: Archivos de definición de formularios visuales para la interfaz de usuario.
-   **Módulos de Datos**: Gestión de la conexión y acceso a la base de datos (`dmData.pas`).
