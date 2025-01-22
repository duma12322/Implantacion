
        $(document).ready(function() {
            $('#id_paciente').on('change', function() {
                const idPaciente = $(this).val();

                if (idPaciente) {
                    // Solicitud AJAX
                    $.ajax({
                        url: 'get_paciente_info.php', // Ruta al archivo PHP
                        type: 'POST',
                        data: {
                            id_paciente: idPaciente
                        },
                        dataType: 'json',
                        success: function(response) {
                            if (response.success) {
                                // Actualizar los campos con los datos obtenidos
                                $('#relacion_tipo_doc').val(response.tipo_doc);
                                $('#relacion_numero_doc').val(response.num_doc);
                            } else {
                                alert(response.message);
                            }
                        },
                        error: function() {
                            alert('Error al obtener los datos del paciente.');
                        }
                    });
                } else {
                    // Limpiar los campos si no se selecciona un paciente
                    $('#relacion_tipo_doc').val('');
                    $('#relacion_numero_doc').val('');
                }
            });
        });
