
# Proyecto de Implantación

# Sistema Psicologico de consultas


## Integrantes

- [@Marcelis Dun](https://github.com/duma12322)
- [@Neylimar Pérez](https://github.com/Neylimar18)
- [@Michelle Camacaro](https://github.com/#)
- [@Wilfredo Salas](https://github.com/#)
- [@Oswaldo Anzola](https://github.com/rapanuti)

# Definición del Sistema
El sistema de gestión de consultas de Emoción Vital está diseñado para ofrecer un apoyo psicológico integral y accesible, adaptándose a las necesidades de cada persona. Este sistema permite a los usuarios gestionar sus citas, ya sea de manera presencial u online, brindando un espacio para su bienestar emocional y mental.

# ¿Como funciona?
1.	Página de Inicio:
•	El portal informativo incluye secciones como: ¿Quiénes somos?, Servicios que ofrecemos, Consultas y Precios, Acerca de mí y Contactos.

2.	Solicitar una Consulta:
•	Los usuarios deben ingresar al sistema haciendo clic en "Ingresar" y colocando su usuario y contraseña.
•	Si no están registrados, deben hacer clic en "Registrar" y llenar el formulario de registro de paciente con todos los campos requeridos.

3.	Gestión de Citas:
•	Una vez dentro del sistema, el paciente puede seleccionar entre:
	Psicoterapia individual
	Psicoterapia para parejas
	Psicoterapia para niños
	Psicoterapia para adolescentes
•	Las dos primeras opciones se pueden elegir en modalidades online o presencial, mientras que las consultas para menores de edad solo están disponibles en modalidad presencial.
•	El sistema enviará un correo electrónico al agendar la cita con los datos de esta y marcará el evento en Google Calendar.
•	En el apartado de "Consultar Citas," se mostrará un historial de citas agendadas y su estado (pendientes, confirmadas, completadas, canceladas o reprogramadas).

4.	Inicio de Sesión del Psicólogo y Administrador:
•	El psicólogo tiene un login aparte para mejorar la seguridad y eficiencia.
•	El inicio de sesión muestra un resumen de citas del mes, el módulo de agendar citas, y el apartado para consultar citas y marcar su estado.
•	También incluye el módulo de Pacientes, donde puede ver, modificar, eliminar o agregar datos de pacientes.
•	El módulo de reportes permite generar e imprimir reportes de citas.

5.	Rol de Administrador:
•	Creado para hacer escalable el sistema, permitiendo registrar y gestionar datos de nuevos psicólogos si ingresan más especialistas al consultorio.

# Paso a Paso de Instalación y Configuración

## 1. Descargar e Instalar XAMPP 3.3.0 con PHP 8.2.4

1. **Descargar XAMPP:**
   - Dirígete a la página oficial de XAMPP [aquí](https://www.apachefriends.org/es/download.html?form=MG0AV3).
   - Busca la versión que incluye PHP 8.2.4 (en el momento de la escritura, la versión 3.3.0 podría no estar disponible, pero asegúrate de elegir una que incluya PHP 8.2.4).
   - Descarga el instalador correspondiente para tu sistema operativo (Windows, Linux o macOS).

2. **Instalar XAMPP:**
   - Una vez descargado el archivo, ejecuta el instalador.
   - Durante la instalación, elige los componentes que deseas instalar (asegúrate de seleccionar "Apache" y "MySQL" como mínimo, y "PHP" debería estar seleccionado por defecto).
   - Selecciona el directorio de instalación (por ejemplo, `C:\xampp`).
   - Haz clic en "Next o Siguiente" y sigue las instrucciones para completar la instalación.

3. **Verificar la instalación:**
   - Una vez que XAMPP se haya instalado, abre el Panel de Control de XAMPP (se encuentra en el directorio donde instalaste XAMPP, como `C:\xampp\xampp-control.exe`, puede crear un acceso directo al escritorio para mayor facilidad).
   - Inicia Apache y MySQL desde el panel de control.
   - Abre tu navegador y escribe `http://localhost` o `http://localhost/phpmyadmin/` en la barra de direcciones. Deberías ver la página de inicio de XAMPP o la herramienta phpMyAdmin.

4. **Verificar la versión de PHP:**
   - Usa el comando `php -v` en la línea de comandos (cmd) para verificar que tienes PHP 8.2.4.

## 2. Instalar Git

1. **Descargar Git:**
   - Visita la página oficial de Git [aquí](https://git-scm.com/downloads) y descarga la versión más reciente de Git para tu sistema operativo.

2. **Instalar Git:**
   - Ejecuta el archivo descargado y sigue las instrucciones del instalador. Asegúrate de seleccionar las opciones adecuadas para integrar Git con la línea de comandos de Windows.

3. **Verificar la instalación de Git:**
   - Abre el símbolo del sistema (cmd) y ejecuta el siguiente comando:
     ```sh
     git --version
     ```
   - Deberías ver la versión de Git instalada en tu sistema.

## 3. Clonar un Repositorio de GitHub

1. **Obtener la URL del repositorio de GitHub:**
   - Dirígete al repositorio de GitHub que deseas clonar. Haz clic en el botón verde de "Code" y copia la URL del repositorio, que se verá algo así:
     ```plaintext
     https://github.com/usuario/repositorio.git
     ```
     [Link de este repositorio](https://github.com/duma12322/Implantacion)

2. **Clonar el repositorio:**
   - Abre el símbolo del sistema (cmd) o terminal y navega al directorio `htdocs` de XAMPP:
     ```sh
     cd C:\xampp\htdocs
     ```
   - O también puedes navegar al directorio donde está ubicado XAMPP, luego ingresa a la carpeta `htdocs`. Así se verá el directorio:
     ```plaintext
     C:\xampp\htdocs
     ```
   - Una vez seleccionada la mejor opción para estar en la carpeta `htdocs`, clona el repositorio con el siguiente comando:
     ```sh
     git clone https://github.com/usuario/repositorio.git
     ```

3. **Acceder al directorio del repositorio:**
   - Una vez que se haya clonado el repositorio, navega desde el terminal dentro de la carpeta creada:
     ```sh
     cd mi_repositorio
     ```
     ```sh
     cd Implantacion
     ```
   - O ingresa a la carpeta `htdocs` para verificar el repositorio.
