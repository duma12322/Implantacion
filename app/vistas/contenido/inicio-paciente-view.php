<div class="wrapper">
        <form action="" method="POST" autocomplete="on">
            <h2>Login Paciente</h2>
            <div class="input-field">
                <input class="input" type="text" name="usuario" id="usuario" placeholder=" " pattern="[a-zA-Z0-9]{1,20}" maxlength="20" required>
                <label for="usuario">Usuario</label>
            </div>
            <div class="input-field">
                <input class="input" type="password" name="contraseña" id="contraseña" placeholder=" " pattern="[a-zA-Z0-9$@.-]{1,100}" maxlength="100" required>
                <label for="contraseña">Contraseña</label>
            </div>
            <input type="hidden" name="tipo" value="paciente">
            <div class="forget">
                <label for="remember">
                    <input type="checkbox" id="remember">
                    <p>Recuérdame</p>
                </label>
                <a href="#">¿Olvidaste tu contraseña?</a>
            </div>
            <button type="submit">Iniciar Sesión</button>
            <div class="register">
                <p>¿No tienes una cuenta? <a href="#">Regístrate</a></p>
            </div>
        </form>
    </div>

    <?php
        if(isset($_POST['usuario']) && isset($_POST['contraseña'])){
            $insLogin->iniciarSesionControlador();
        }
    ?>