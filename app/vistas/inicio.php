<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio Psicólogo</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/inicio.css">
</head>

<body>
    <!-- Navegación -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="Inicio.php"><span>Inicio</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#quienessomos"><span>Quienes Somos</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#services"><span>Servicios</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#tipos-consulta"><span>Consultas y Precios</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#acercademi"><span>Acerca de mi</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#contact"><span>Contacto</span></a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Encabezado -->
    <header class="py-5 text-white">
        <div class="container">
            <div class="row align-items-center">
                <!-- Columna izquierda: Logo y botones -->
                <div class="col-md-6 d-flex flex-column justify-content-center text-center text-md-left">
                    <img src="files/logo.png" alt="Bienvenido" class="img-fluid rounded shadow mx-auto d-block" style="max-width: 400px; height: auto;">
                    <br>
                    <h1 class="display-6">Bienvenido a Emoción Vital</h1>
                    <p class="lead mx-auto d-block">¡Estamos aquí para acompañarte en tu camino!</p>
                    <div class="d-flex justify-content-start mx-auto d-block">
                        <a href="login_paciente.php" class="btn btn-lg mt-3 mr-2 btn-custom">Ingresa</a>
                        <a href="registro_paciente.php" class="btn btn-lg mt-3 btn-custom">Registrate</a>

                    </div>
                </div>

                <!-- Columna derecha: Imagen con servicios -->
                <!-- Servicios -->
                <div class="col-md-6">
                    <section id="services">
                        <div class="image-collage">
                            <!-- Título dentro del collage -->
                            <h2 class="collage-title">Servicios</h2>
                            <!-- Imagen 1 -->
                            <div class="image-item image-item-1">
                                <a href="#" onclick="openPopup('Psicoterapia Individual', 'collapseIndividual')">
                                    <img src="files/individual.png" alt="Psicoterapia Individual">
                                </a>
                            </div>
                            <!-- Imagen 2 -->
                            <div class="image-item image-item-2">
                                <a href="#" onclick="openPopup('Psicoterapia para Niños', 'collapseNinos')">
                                    <img src="files/niños.png" alt="Psicoterapia para Niños">
                                </a>
                            </div>
                            <!-- Imagen 3 -->
                            <div class="image-item image-item-3">
                                <a href="#" onclick="openPopup('Psicoterapia de Parejas', 'collapseParejas')">
                                    <img src="files/parejas.png" alt="Psicoterapia de Parejas">
                                </a>
                            </div>
                            <!-- Imagen 4 -->
                            <div class="image-item image-item-4">
                                <a href="#" onclick="openPopup('Psicoterapia para Adolescentes', 'collapseAdolescentes')">
                                    <img src="files/adolescentes.png" alt="Psicoterapia para Adolescentes">
                                </a>
                            </div>
                            <!-- Texto dentro del collage -->
                            <p class="collage-text">Click en la imagen para ver los servicios</p>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </header>

    <!-- Modal de servicio -->
    <div class="modal fade" id="serviceModal" tabindex="-1" aria-labelledby="serviceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Título del Servicio</h5>
                    <!-- Botón de cierre -->
                    <button type="button" class="btn-close" aria-label="Close" onclick="closeModal()"></button>
                </div>
                <div class="modal-body">
                    <div class="collapse" id="collapseIndividual">
                        <p>En ocasiones, nos encontramos abrumados, tristes, desesperanzados, estresados o afligidos, lo cual es parte de la experiencia humana. Sin embargo, cuando estos sentimientos se prolongan y afectan diferentes áreas de nuestra vida (social, personal, afectiva, laboral y familiar), la terapia psicológica individual puede ser una alternativa eficaz para abordar estas problemáticas.
                            <br><br>La terapia individual ofrece una reducción efectiva de problemáticas psicológicas como la depresión y la ansiedad, así como de los síntomas asociados, como el dolor, el cansancio y los problemas de sueño, entre otros. Además, la psicoterapia tiene un impacto positivo en la salud emocional y física, lo que conlleva una mejora general en el estado de salud de las personas.
                        </p>
                    </div>
                    <div class="collapse" id="collapseNinos">
                        <p>La niñez es una etapa crucial para el desarrollo, donde es fundamental que los niños y niñas reciban un apoyo que les permita adquirir habilidades y estrategias para enfrentar las situaciones que surgirán a lo largo de sus vidas.</p>
                        <p class="mt-3">Este apoyo es fundamental para detectar cualquier problema emocional, conductual, cognitivo u otros que puedan surgir. Por esta razón, es importante buscar ayuda o apoyo psicológico si usted está preocupado por el comportamiento de su hijo o hija. A través de un tratamiento adecuado, el psicólogo infantil puede ayudar tanto a los padres como a los niños a superar estas dificultades. El trabajo conjunto les permitirá aprender a relacionarse con los demás ya desarrollar habilidades y hábitos que les ayudarán a tener éxito en la escuela, en sus interacciones sociales y en la vida en general.</p>
                        <p>Algunas de las problemáticas más comunes en la niñez son:</p>
                        <ul style="text-align: left;">
                            <li>Miedos (oscuridad, dormir solos, etc.)</li>
                            <li>Ansiedad</li>
                            <li>Tristeza y desesperanza</li>
                            <li>Desobediencia</li>
                            <li>Bajo rendimiento académico</li>
                            <li>Divorcio de padres</li>
                            <li>Hiperactividad y falta de atención</li>
                        </ul>
                        </p>
                    </div>
                    <div class="collapse" id="collapseParejas">
                        <p>La terapia de pareja puede ser beneficiosa en varias situaciones, ya que ofrece la oportunidad de abordar de manera conjunta las dificultades emocionales y relacionales que puedan estar afectando la relación. Algunas de las razones comunes por las que las parejas buscan terapia incluyen la falta de confianza, problemas de comunicación, diferencias en la convivencia, discusiones recurrentes, crisis en la relación, problemas sexuales, celos, desconfianza, y la llegada de los hijos. La terapia de pareja proporciona un espacio para trabajar en la resolución de conflictos, mejorar la comunicación, reconstruir la conexión emocional y fortalecer la relación.
                            Además, puede ayudar a reducir el impacto negativo del estrés y la ansiedad, promoviendo un mayor entendimiento mutuo y bienestar emocional en la relación.</p>
                    </div>
                    <div class="collapse" id="collapseAdolescentes">
                        <p>En la adolescencia, es común enfrentarse a una variedad de desafíos psicológicos, conductuales, emocionales y cognitivos, ya que esta etapa es fundamental para la transición y la formación de la identidad.</p>
                        Es importante reconocer que estas luchas son parte natural del proceso de crecimiento. Sin embargo, si como padre o madre se encuentra preocupado por el comportamiento de su hijo o hija, considere conversar con un psicólogo especializado en adolescentes puede ser de gran ayuda. Un psicólogo puede proporcionar orientación para comprender si los cambios en el comportamiento son normales o si el adolescente se beneficiaría de la ayuda de un experto. Este enfoque puede brindar tranquilidad a los padres y fomentar un mejor entendimiento de los desafíos que enfrenta su hijo o hija durante esta etapa crucial de desarrollo.</p>
                        <p>Algunas de las problemáticas más comunes en la adolescencia son:</p>
                        <ul style="text-align: left;">
                            <li>Acoso escolar</li>
                            <li>Muerte y suicidio</li>
                            <li>Divorcio de padres</li>
                            <li>Problemas con la imagen corporal</li>
                            <li>Miedo, preocupación y angustia</li>
                            <li>Cambios de humor</li>
                            <li>Comer más o menos</li>
                            <li>Exceso de peso</li>
                            <li>Rebeldía</li>
                            <li>Timidez</li>
                            <li>Tristeza, desesperanza y daño propio</li>
                            <li>Deficiencias sociales</li>
                        </ul>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-custom" onclick="closeModal()">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Quienes somos -->
    <section id="quienessomos" class="py-5">
        <div class="container text-center">
            <!-- Título principal -->
            <h2 class="mb-4">Quiénes Somos</h2>
            <h3 class="mb-6">¿Qué es? </h3>
            <p>
                La emoción vital es la capacidad de experimentar y expresar emociones de una manera auténtica y profunda, que refleja la vitalidad y energía de una persona. Implica estar conectado con las propias emociones, ser capaz de reconocerlas, procesarlas y expresarlas de manera saludable. La emoción vital también implica estar en sintonía con uno mismo, con los demás y con el entorno, lo que contribuye a una sensación de plenitud y bienestar emocional.
            </p>
            <br>
            <h3 class="mb-6">Porque elegir Emoción Vital</h3>
            <p>
                Como especialista en psicología, mi enfoque terapéutico se centra en proporcionar un espacio seguro y confidencial donde pueda comprender y abordar sus desafíos emocionales. Con una amplia experiencia en el campo de la psicología clínica, ofrece un enfoque personalizado que se adapta a las necesidades individuales de cada cliente. Al elegirme como su terapeuta, se beneficiará de un enfoque compasivo y basado en la evidencia, diseñado para promover el crecimiento personal y el bienestar emocional. Mi objetivo es trabajar en colaboración con usted para fomentar el autoconocimiento, la resiliencia emocional y el desarrollo de estrategias efectivas para afrontar los desafíos de la vida. Le invitamos a considerar iniciar este viaje hacia el bienestar emocional y el crecimiento personal, y espero poder acompañarle en este proceso de cambio y transformación.
            </p>
            <br>
            <h3 class="mb-6">Objetivo principal de Emoción Vital</h3>
            <p>
                El objetivo principal siempre será el poder coadyuvar a las personas a mejorar su bienestar emocional y mental, brindando terapias, asesoramiento y herramientas para gestionar sus emociones de manera saludable. Además, se busca promover la salud mental y el autoconocimiento en la sociedad, fomentando un enfoque positivo hacia la vida y el desarrollo personal en base a un foque terapéutico.
            </p>
        </div>
    </section>

    <!-- Tipos de Consultas -->
    <section id="tipos-consulta" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4">Consultas y Precios</h2>
            <!-- Botón para mostrar las opciones -->
            <button id="verButton" class="btn btn-lg mt-3 mr-2">Ver</button>

            <!-- Contenedor de las pestañas, inicialmente oculto -->
            <div class="tab-content-container" style="display:none;" id="consultaTabs">
                <!-- Pestañas -->
                <ul class="nav nav-tabs mb-4" id="consultaTabsList" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="presencial-tab" data-bs-toggle="tab" data-bs-target="#presencial" type="button" role="tab" aria-controls="presencial" aria-selected="true">
                            Cita Presencial
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="online-tab" data-bs-toggle="tab" data-bs-target="#online" type="button" role="tab" aria-controls="online" aria-selected="false">
                            Cita Online
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="precios-tab" data-bs-toggle="tab" data-bs-target="#precios" type="button" role="tab" aria-controls="precios" aria-selected="false">
                            Precios
                        </button>
                    </li>
                </ul>

                <!-- Contenido de las pestañas -->
                <div class="tab-content" id="consultaTabsContent">
                    <div class="tab-pane fade show active" id="presencial" role="tabpanel" aria-labelledby="presencial-tab">
                        <h4 class="subrayado">Modalidad de Cita Presencial</h4>
                        <br>
                        <p>La consulta presencial es una necesidad fundamental para brindar apoyo a las personas que han iniciado un proceso terapéutico y que desean continuar con el tratamiento clínico de manera directa.
                            Se ofrece la opción de atención en persona para aquellas personas que prefieren la interacción cara a cara y consideran que este formato les proporciona un mayor beneficio en su proceso de sanación. <br>
                            La consulta presencial permite a los terapeutas ofrecer un acompañamiento más cercano y personalizado, facilitando un ambiente propicio para la apertura y el diálogo sobre los temas que cada persona desea abordar.
                        </p>
                        <h5 class="subrayado">Pasos para Solicitar una Consulta Presencial</h5>
                        <p>Pedir una cita presencial en la página web de Emoción Vital es un proceso sencillo. Aquí te dejo un paso a paso para que puedas hacerlo sin problemas:</p>
                        <ol>
                            <li>Accede a la página web: Abre tu navegador y escribe la dirección de la página de Emoción Vital. Asegúrate de que estás en el sitio correcto.</li>
                            <li>Busca la sección de citas: Una vez en la página principal, busca un enlace o botón que diga "Pedir cita Presencial". Esto suele estar en el menú principal o en la parte superior de la página.</li>
                            <li>Selecciona el tipo de consulta: En la sección de citas, es posible que te pidan seleccionar el tipo de consulta que deseas (por ejemplo, terapia individual, de pareja, etc.). Elige la opción que mejor se adapte a tus necesidades.</li>
                            <li>Completa el formulario: Rellena el formulario con tus datos personales. Esto generalmente incluye tu nombre, correo electrónico, número de teléfono y cualquier otra información relevante que se requiera.</li>
                            <li>Elige la fecha y hora: Después de completar tus datos, selecciona la fecha y hora que prefieras para tu cita. Asegúrate de que la disponibilidad se ajuste a tu agenda.</li>
                            <li>Confirma tu cita: Revisa toda la información que has ingresado y asegúrate de que sea correcta. Luego, busca un botón que diga "Confirmar cita" o "Enviar". Haz clic en él para finalizar el proceso.</li>
                            <li>Recibe la confirmación: Después de enviar tu solicitud, deberías recibir un correo electrónico de confirmación con los detalles de tu cita. Si no lo recibes, revisa tu carpeta de spam o contacta a Emoción Vital para asegurarte de que tu cita ha sido agendada.</li>
                            <li>Prepárate para tu cita: Antes de la cita, es útil que pienses en los temas que deseas tratar y prepares cualquier pregunta que tengas.</li>
                        </ol>
                        <p>Siguiendo estos pasos, podrás solicitar tu cita de manera efectiva y comenzar tu camino hacia el bienestar emocional. ¡Buena suerte!</p>
                    </div>

                    <div class="tab-pane fade" id="online" role="tabpanel" aria-labelledby="online-tab">
                        <h4 class="subrayado">Modalidad de Cita Online</h4>
                        <br>
                        <p>La consulta es una necesidad fundamental para brindar apoyo a las personas que han iniciado un proceso terapéutico previo y que, a pesar de la distancia, desean continuar con el tratamiento clínico.
                            Se ofrece la opción de atención remota para aquellas personas que encuentren dificultades para desplazarse, tengan horarios ajustados o enfrenten circunstancias familiares que les impidan acudir en persona. <br>
                            Consulta por vídeo llamada a personas que solicitan una orientación puntual sobre un tema en particular.
                        </p>
                        <h5 class="subrayado">Debes tener en cuenta al momento de Solicitar la Consulta Online:</h5>
                        <ul>
                            <li>El apoyo por vídeo llamada se realiza por medio de Google Met.</li>
                            <li>Asegúrate de tener cámara web, micrófono y audífonos.</li>
                            <li>Realiza una prueba de funcionamiento previamente.</li>
                            <li>Escoge un lugar tranquilo y cómodo para ti, en donde no tengas interrupciones.</li>
                            <li>Es muy importante la puntualidad.</li>
                        </ul>
                        <h5 class="subrayado">Pasos para Solicitar una Consulta Online</h5>
                        <p>Pedir una cita online en la página web de Emoción Vital es un proceso sencillo. Aquí te dejo un paso a paso para que puedas hacerlo sin problemas:</p>
                        <ol>
                            <li>Accede a la página web: Abre tu navegador y escribe la dirección de la página de Emoción Vital. Asegúrate de que estás en el sitio correcto.</li>
                            <li>Busca la sección de citas: Una vez en la página principal, busca un enlace o botón que diga "Pedir cita Online". Esto suele estar en el menú principal o en la parte superior de la página.</li>
                            <li>Selecciona el tipo de consulta: En la sección de citas, es posible que te pidan seleccionar el tipo de consulta que deseas (por ejemplo, terapia individual, de pareja, etc.). Elige la opción que mejor se adapte a tus necesidades.</li>
                            <li>Completa el formulario: Rellena el formulario con tus datos personales. Esto generalmente incluye tu nombre, correo electrónico, número de teléfono y cualquier otra información relevante que se requiera.</li>
                            <li>Elige la fecha y hora: Después de completar tus datos, selecciona la fecha y hora que prefieras para tu cita. Asegúrate de que la disponibilidad se ajuste a tu agenda.</li>
                            <li>Confirma tu cita: Revisa toda la información que has ingresado y asegúrate de que sea correcta. Luego, busca un botón que diga "Confirmar cita" o "Enviar". Haz clic en él para finalizar el proceso.</li>
                            <li>Recibe la confirmación: Después de enviar tu solicitud, deberías recibir un correo electrónico de confirmación con los detalles de tu cita. Si no lo recibes, revisa tu carpeta de spam o contacta a Emoción Vital para asegurarte de que tu cita ha sido agendada.</li>
                            <li>Prepárate para tu cita: Antes de la cita, es útil que pienses en los temas que deseas tratar y prepares cualquier pregunta que tengas.</li>
                        </ol>
                        <p>Siguiendo estos pasos, podrás solicitar tu cita de manera efectiva y comenzar tu camino hacia el bienestar emocional. ¡Buena suerte!</p>
                    </div>

                    <div class="tab-pane fade" id="precios" role="tabpanel" aria-labelledby="precios-tab">
                        <h4 class="subrayado">Precios</h4>
                        <div class="modalidades">
                            <div class="modalidad-left">
                                <br>
                                <h5 class="subrayado">Modalidad Presencial</h5>
                                <ul>
                                    <li><strong>Individual:</strong> 30$</li>
                                    <li><strong>Parejas:</strong> 35$</li>
                                    <li><strong>Niños y Adolescentes:</strong> 30$</li>
                                    <li><strong>Estudiantes:</strong> 15$</li>
                                </ul>
                            </div>
                            <div class="modalidad-right">
                                <br>
                                <h5 class="subrayado">Modalidad Online</h5>
                                <ul>
                                    <li><strong>Individual:</strong> 20$</li>
                                    <li><strong>Parejas:</strong> 25$</li>
                                    <li><strong>Niños y Adolescentes:</strong> 20$</li>
                                    <li><strong>Estudiantes:</strong> 10$</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Acerca de mi (psicologa) -->
    <section id="acercademi" class="py-5">
        <div class="container text-center">
            <div class="perfil-cuadro">
                <h2 class="mb-4">Acerca de mí</h2>
                <img src="files/Marce.png" alt="Foto de la psicóloga">
                <p>
                    En Emoción Vital, creemos que la conexión entre el terapeuta y el paciente es fundamental para un proceso terapéutico efectivo. Te presentamos a nuestra psicóloga, la licenciada María Daniela Mogollón quien se dedica al acompañamiento terapéutico y la evaluación de la conducta, enfocándose en el tratamiento de la salud mental y emocional.
                    Con una sólida formación académica, nuestra psicóloga es licenciada en Psicología por la Universidad Yacambú y cuenta con especializaciones en atención y evaluación psicológica. Su experiencia laboral incluye más de cuatro años como docente universitario en la Universidad Nacional Experimental Politécnica de la Fuerza Armada (UNEFA), donde impartió materias relacionadas con la psicología y el desarrollo social.
                    Además, ha trabajado en el departamento de Bienestar Estudiantil, brindando atención y evaluación psicológica a estudiantes, así como en el ámbito organizacional, donde se encargó de la selección y capacitación de personal en Transbarca.
                    Nuestra psicóloga también ha complementado su formación con diversos cursos, incluyendo liderazgo en Yoga de la Risa y talleres sobre conductas en niños y adolescentes, lo que le permite abordar una amplia gama de problemáticas desde diferentes perspectivas.
                    Si buscas un espacio seguro y profesional para tu bienestar emocional, no dudes en conocer más a tu psicólogo y dar el primer paso hacia tu salud mental.
                    ¡Estamos aquí para acompañarte en tu camino!
                </p>
            </div>
        </div>
    </section>

    <!-- Contacto -->
    <section id="contact" class="py-3 text-white">
        <div class="container text-center">
            <h2 class="mb-4">Contactos</h2>
            <div class="row">
                <!-- Horarios -->
                <div class="col-md-3">
                    <h5><strong>Horarios</strong></h5>
                    <p><strong>Consulta Presencial</strong></p>
                    <p class="small">Lunes a viernes: 9:00am a 12:00m <br> 1:00pm a 4:00pm<br>
                        Sábado: 9:00am a 1:00pm
                    </p>
                    <br>
                    <p><strong>Consulta Virtual</strong></p>
                    <p class="small">Lunes a viernes: 9:00am a 12:00m <br> 1:00pm a 4:00pm<br>
                        Sábado: 9:00am a 1:00pm</p>
                    <p class="small">Domingo: No hay consultas</p>
                </div>
                <!-- Teléfonos y correo -->
                <div class="col-md-3">
                    <h5><strong>Teléfonos</strong></h5>
                    <p class="small"><i class="bi bi-whatsapp" style="font-size: 1rem; color: #FFFFFF;"></i> 0418-001-00-11 <br>
                        <i class="bi bi-telephone" style="color: #FFFFFF;"></i> 0251-7178172
                    </p>
                    <h5><strong>Correo Electrónico</strong></h5>
                    <p class="small"><a href="mailto:contacto@psicologo.com" class="text-white">contacto@psicologo.com</a></p>
                </div>
                <!-- Ver mapa -->
                <div class="col-md-3">
                    <h5><strong>Visítanos</strong></h5>
                    <a href="https://www.google.com/maps?q=40.730610,-73.997318" target="_blank" rel="noopener noreferrer">
                        <i class="bi bi-geo-alt" style="font-size: 2rem; color: #007bff;"></i>
                    </a>
                    <p class="mt-2 small">Ver mapa</p>
                    <p class="mt-2 small">Carrera 90 entre Calles 80 y 77 Edificio Flores, Piso 8 Consultorio 8-2</p>
                </div>
                <!-- Redes sociales -->
                <div class="col-md-3">
                    <h5><strong>Síguenos</strong></h5>
                    <div class="d-flex justify-content-center mt-3">
                        <a href="https://www.facebook.com/psicologo" class="mx-2" target="_blank" aria-label="Facebook">
                            <i class="bi bi-facebook" style="font-size: 2rem; color: #3b5998;"></i>
                        </a>
                        <a href="https://www.instagram.com/psicologo" class="mx-2" target="_blank" aria-label="Instagram">
                            <i class="bi bi-instagram" style="font-size: 2rem; color: #E1306C;"></i>
                        </a>
                        <a href="https://www.x.com/psicologo" class="mx-2" target="_blank" aria-label="X">
                            <i class="bi bi-twitter" style="font-size: 2rem; color: #1DA1F2;"></i>
                        </a>
                    </div>
                    <br>
                    <h5><strong>Nuestras redes sociales</strong></h5>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer de página -->
    <footer class="footer">
        <p><strong>© 2024 Emoción Vital. Todos los derechos reservados.</strong></p>
    </footer>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script src="script/Textservicio.js"></script>
    <script src="script/botonver.js"></script>
    <script src="script/inicio-collageImagen.js "></script>
    <script src="script/imagenpopups.js "></script>
</body>

</html>