package com.Arris.controllers;


import com.Arris.controllers.dto.UsuarioRegistroDTO;
import com.Arris.models.*;
import com.Arris.repository.EstadoUsuariosRepository;
import com.Arris.repository.RolRepository;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.EnvioService;
import com.Arris.service.EstadoUsuariosService;
import com.Arris.service.MailServiceImp;
import com.Arris.service.UsuarioService;
import net.bytebuddy.utility.RandomString;
import org.apache.commons.lang3.RandomStringUtils;
import org.hibernate.annotations.ManyToAny;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/registro")
public class UsuarioController {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    UsuarioService usuarioService;

    @Autowired
    UsuarioRepository usuarioRepository;

    @Autowired
    RolRepository rolRepository;

    @Autowired
    EnvioService envioService;

    @Autowired
    EstadoUsuariosService estadoUsuariosService;

    @Autowired
    private MailServiceImp emailPort;

    @ModelAttribute("usuario")
    public UsuarioRegistroDTO retornarNuevoUsuarioRegistroDTO() {
        return new UsuarioRegistroDTO();
    }



    @GetMapping
    public String mostrarFormularioDeRegistro() {
        return "registro";
    }

    @PostMapping
    public String registrarCuentaDeUsuario(@ModelAttribute("usuario") UsuarioRegistroDTO registroDTO) {
        usuarioService.guardarUsuario(registroDTO);
        return "redirect:/registro?exito";
    }

    // create generateSecurePassword() method that find the secure password and returns it to the main() method


    @PostMapping("/guardar_usuario_admin")
    public String registrarCuentaDeUsuarioadmin(UsuarioRegistroDTO registroDTO, Authentication auth, MailRequest emailBody, RedirectAttributes redirectAttrs) {
        String upperCaseLetters = RandomStringUtils.random(2, 65, 90, true, true);
        String lowerCaseLetters = RandomStringUtils.random(2, 97, 122, true, true);
        String numbers = RandomStringUtils.randomNumeric(2);
        String specialChar = RandomStringUtils.random(2, 33, 47, false, false);
        String totalChars = RandomStringUtils.randomAlphanumeric(2);
        String combinedChars = upperCaseLetters.concat(lowerCaseLetters)
                .concat(numbers)
                .concat(specialChar)
                .concat(totalChars);
        List<Character> pwdChars = combinedChars.chars()
                .mapToObj(c -> (char) c)
                .collect(Collectors.toList());
        Collections.shuffle(pwdChars);
        String password = pwdChars.stream()
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
        registroDTO.setPassword(password);
        usuarioService.guardarUsuario(registroDTO);
            emailBody.setEmail("mrloquendojodido@gmail.com");
            emailBody.setSubject("has registrado un nuevo usuario!!");
            emailBody.setContent(
                    "<h1>Hola Admin <strong>" + auth.getName() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                            "<h1>Cliente: <strong>" + registroDTO.getNombre() + "</strong></h1><br/>" +
                            "<h1>Email: <strong>" + registroDTO.getEmail() + "</strong></h1><br/>" +
                            "<h1>Se registro recientemente este usuario en el sistema, al correo del cliente deberia llegar la contraseña</h1>"
            );
            emailPort.sendEmail(emailBody);

            emailBody.setEmail("hugo.garcia29@misena.edu.co");
            emailBody.setSubject("Se registro tu usuario en lipem's.in!!");
            emailBody.setContent(
                    "<h1>Hola <strong>" + registroDTO.getNombre() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                            "<h1>Bienvenid@ a lipem's, se acaba de crear un usuario con este correo, para ingresar al sistema digita la siguiente contraseña</h1>"+
                            "<h1>Contraseña: </h1><strong><h2>" + password +"</strong></h2>"+
                            "<h1>Entra al siguiente link para iniciar sesión:</h1> <strong><h2><a href='http://localhost:8080/login'>http://localhost:8080/login</a></h2></strong>" +
                            "<h1>Recuerda que esta contraseña es personal, ningun colaborador o trabajador de nuestra empresa te pedira esta contraseña, tampoco la compartas con nadie externo</h1>"
            );
            emailPort.sendEmail(emailBody);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se Registro el Nuevo Usuario Satisfactoriamente, Nombre del Usuario: " + registroDTO.getNombre() +", Correo Electronico: " + registroDTO.getEmail() + ", Recuerda que se Envio un Mensaje a Este Correo con La Contraseña ✔")
                .addFlashAttribute("clase", "success");
        return "redirect:/gestion_ventas_admin";
    }
    @PostMapping("/guardar_nuevo_usuario_empleado")
    public String registrarCuentaDeUsuarioEmpleado(UsuarioRegistroDTO registroDTO, Authentication auth, MailRequest emailBody, RedirectAttributes redirectAttrs) {
        String upperCaseLetters = RandomStringUtils.random(2, 65, 90, true, true);
        String lowerCaseLetters = RandomStringUtils.random(2, 97, 122, true, true);
        String numbers = RandomStringUtils.randomNumeric(2);
        String specialChar = RandomStringUtils.random(2, 33, 47, false, false);
        String totalChars = RandomStringUtils.randomAlphanumeric(2);
        String combinedChars = upperCaseLetters.concat(lowerCaseLetters)
                .concat(numbers)
                .concat(specialChar)
                .concat(totalChars);
        List<Character> pwdChars = combinedChars.chars()
                .mapToObj(c -> (char) c)
                .collect(Collectors.toList());
        Collections.shuffle(pwdChars);
        String password = pwdChars.stream()
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
        registroDTO.setPassword(password);
        usuarioService.guardarUsuario(registroDTO);
        emailBody.setEmail("mrloquendojodido@gmail.com");
        emailBody.setSubject("Se ha registrado un nuevo usuario!!");
        emailBody.setContent(
                "<h1>Hola Admin <strong>" + auth.getName() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                        "<h1>Cliente: <strong>" + registroDTO.getNombre() + "</strong></h1><br/>" +
                        "<h1>Email: <strong>" + registroDTO.getEmail() + "</strong></h1><br/>" +
                        "<h1>Se registro recientemente este usuario en el sistema, al correo del cliente deberia llegar la contraseña</h1>"
        );
        emailPort.sendEmail(emailBody);

        emailBody.setEmail("hugo.garcia29@misena.edu.co");
        emailBody.setSubject("has registrado un nuevo usuario!!");
        emailBody.setContent(
                "<h1>Hola <strong>" + auth.getName() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                        "<h1>Cliente: <strong>" + registroDTO.getNombre() + "</strong></h1><br/>" +
                        "<h1>Email: <strong>" + registroDTO.getEmail() + "</strong></h1><br/>" +
                        "<h1>Se registro recientemente este usuario en el sistema, al correo del cliente deberia llegar la contraseña</h1>"
        );
        emailPort.sendEmail(emailBody);

        emailBody.setEmail("hugo.garcia29@misena.edu.co");
        emailBody.setSubject("Se registro tu usuario en lipem's.in!!");
        emailBody.setContent(
                "<h1>Hola <strong>" + registroDTO.getNombre() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                        "<h1>Bienvenid@ a lipem's, se acaba de crear un usuario con este correo, para ingresar al sistema digita la siguiente contraseña</h1>"+
                        "<h1>Contraseña: </h1><strong><h2>" + password +"</strong></h2>"+
                        "<h1>Entra al siguiente link para iniciar sesión:</h1> <strong><h2><a href='http://localhost:8080/login'>http://localhost:8080/login</a></h2></strong>" +
                        "<h1>Recuerda que esta contraseña es personal, ningun colaborador o trabajador de nuestra empresa te pedira esta contraseña, tampoco la compartas con nadie externo</h1>"
        );
        emailPort.sendEmail(emailBody);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se Registro el Nuevo Usuario Satisfactoriamente, Nombre del Usuario: " + registroDTO.getNombre() +", Correo Electronico: " + registroDTO.getEmail() + ", Recuerda que se Envio un Mensaje a Este Correo con La Contraseña ✔")
                .addFlashAttribute("clase", "success");
        return "redirect:/gestion_ventas_empleado";
    }

    @GetMapping("/actualizar-datos")
    public String editarDatosCliente(Model model){
        List<Usuario> usuario = usuarioService.listarUsuarios();
        List<Envio> envio = envioService.getAll();
        model.addAttribute("usuario",usuario);
        model.addAttribute("envio",envio);
        model.addAttribute("usuario",usuario);
        return "interfaz_cliente/templates/editar";
    }




    @PostMapping("/actualizado")
    public String editarDatosClienteEnv(@ModelAttribute("usuario") UsuarioRegistroDTO registroDTO, Model model, RedirectAttributes redirectAttrs, @RequestParam("file") MultipartFile imagen){

        Usuario usuario1 = usuarioRepository.findByEmail(registroDTO.getEmail());

        usuario1.setNombre(registroDTO.getNombre());
        usuario1.setTelefono(registroDTO.getTelefono());
        usuario1.setEmail(registroDTO.getEmail());
        usuario1.setDireccion(registroDTO.getDireccion());

        if (!imagen.isEmpty()) {
            //Path directorioImagenes = Paths.get("src//main//resources//static//img/productos");
            //String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();
            String rutaAbsoluta = "C://Producto//recursos";
            //String rutaAbsoluta = "//home//devh//Documentos//recursos//";

            try {
                byte[] bytesImg = imagen.getBytes();
                Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + imagen.getOriginalFilename());
                Files.write(rutaCompleta, bytesImg);
                usuario1.setImagen(imagen.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
            }

        } else {
            usuario1.setImagen(usuario1.getImagen());
        }

        usuarioRepository.save(usuario1);

        redirectAttrs
                .addFlashAttribute("mensaje", "Se A Guardado Satisfactioriamente Su Información" + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("Datos Actualizados");
        return "redirect:/registro/actualizar-datos";
    }

    @PostMapping("/cambiar-contraseña")
    public String cambiarPassword(@RequestParam("oldPassword") String oldPassword, @RequestParam("newPassword") String newPassword, RedirectAttributes redirectAttrs, Principal principal){

        System.out.println("OLD PASSWORD " + oldPassword);
        System.out.println("NEW PASSWORD " + newPassword);

        String email = principal.getName();
        Usuario uActual = this.usuarioRepository.findByEmail(email);
        System.out.println(uActual.getPassword());


        if (this.bCryptPasswordEncoder.matches(oldPassword, uActual.getPassword())) {

            uActual.setPassword(this.bCryptPasswordEncoder.encode(newPassword));
            this.usuarioRepository.save(uActual);

            redirectAttrs
                    .addFlashAttribute("mensaje", "Tu contraseña ha sido actualizada correctamente" + " ✔")
                    .addFlashAttribute("clase", "success");

        } else {

            redirectAttrs
                    .addFlashAttribute("mensaje", "Contraseña anterior incorrecta" + "❌")
                    .addFlashAttribute("clase", "danger");
        }

        return "redirect:/registro/actualizar-datos";
    }

    @GetMapping("/actualizar-datos-admin")
    public String editarDatosAdmin(Model model){
        List<Usuario> usuario = usuarioService.listarUsuarios();
        List<Envio> envio = envioService.getAll();
        model.addAttribute("envio",envio);
        model.addAttribute("usuario",usuario);
        return "interfaz_administrador/templates/editar";
    }


    @PostMapping("/actualizado-admin")
    public String editarDatosAdminEnv(@ModelAttribute("usuario") UsuarioRegistroDTO registroDTO, Model model, RedirectAttributes redirectAttrs, @RequestParam("file") MultipartFile imagen){

        Usuario usuario1 = usuarioRepository.findByEmail(registroDTO.getEmail());

        usuario1.setIdUsuario(registroDTO.getIdUsuario());
        usuario1.setNombre(registroDTO.getNombre());
        usuario1.setTelefono(registroDTO.getTelefono());
        usuario1.setEmail(registroDTO.getEmail());
        usuario1.setDireccion(registroDTO.getDireccion());

        if (!imagen.isEmpty()) {
            //Path directorioImagenes = Paths.get("src//main//resources//static//img/productos");
            //String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();
            String rutaAbsoluta = "C://Producto//recursos";
            //String rutaAbsoluta = "//home//devh//Documentos//recursos//";

            try {
                byte[] bytesImg = imagen.getBytes();
                Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + imagen.getOriginalFilename());
                Files.write(rutaCompleta, bytesImg);
                usuario1.setImagen(imagen.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
            }

        } else {
            usuario1.setImagen(usuario1.getImagen());
        }

        usuarioRepository.save(usuario1);

        redirectAttrs
                .addFlashAttribute("mensaje", "Se A Guardado Satisfactioriamente Su Información" + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("Datos Actualizados");
        return "redirect:/registro/actualizar-datos-admin";
    }

    @PostMapping("/cambiar-contraseña-admin")
    public String cambiarPasswordAdmin(@RequestParam("oldPassword") String oldPassword, @RequestParam("newPassword") String newPassword, RedirectAttributes redirectAttrs, Principal principal){

        System.out.println("OLD PASSWORD " + oldPassword);
        System.out.println("NEW PASSWORD " + newPassword);

        String email = principal.getName();
        Usuario uActual = this.usuarioRepository.findByEmail(email);
        System.out.println(uActual.getPassword());


        if (this.bCryptPasswordEncoder.matches(oldPassword, uActual.getPassword())) {

            uActual.setPassword(this.bCryptPasswordEncoder.encode(newPassword));
            this.usuarioRepository.save(uActual);

            redirectAttrs
                    .addFlashAttribute("mensaje", "Tu contraseña ha sido actualizada correctamente" + " ✔")
                    .addFlashAttribute("clase", "success");

        } else {

            redirectAttrs
                    .addFlashAttribute("mensaje", "Contraseña anterior incorrecta" + "❌")
                    .addFlashAttribute("clase", "danger");
        }

        return "redirect:/registro/actualizar-datos-admin";
    }

    @GetMapping("/actualizar-datos-empleado")
    public String editarDatosEmpleado(Model model){
        List<Usuario> usuario = usuarioService.listarUsuarios();
        List<Envio> envio = envioService.getAll();
        model.addAttribute("envio",envio);
        model.addAttribute("usuario",usuario);
        return "interfaz_empleado/templates/editar";
    }


    @PostMapping("/actualizado-empleado")
    public String editarDatosEmpleadoEnv(@ModelAttribute("usuario") UsuarioRegistroDTO registroDTO, Model model, RedirectAttributes redirectAttrs, @RequestParam("file") MultipartFile imagen){

        Usuario usuario1 = usuarioRepository.findByEmail(registroDTO.getEmail());

        usuario1.setNombre(registroDTO.getNombre());
        usuario1.setTelefono(registroDTO.getTelefono());
        usuario1.setEmail(registroDTO.getEmail());
        usuario1.setDireccion(registroDTO.getDireccion());

        if (!imagen.isEmpty()) {
            //Path directorioImagenes = Paths.get("src//main//resources//static//img/productos");
            //String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();
            String rutaAbsoluta = "C://Producto//recursos";
            //String rutaAbsoluta = "//home//devh//Documentos//recursos//";

            try {
                byte[] bytesImg = imagen.getBytes();
                Path rutaCompleta = Paths.get(rutaAbsoluta + "//" + imagen.getOriginalFilename());
                Files.write(rutaCompleta, bytesImg);
                usuario1.setImagen(imagen.getOriginalFilename());
            } catch (IOException e) {
                e.printStackTrace();
            }

        } else {
            usuario1.setImagen(usuario1.getImagen());
        }

        usuarioRepository.save(usuario1);

        redirectAttrs
                .addFlashAttribute("mensaje", "Se A Guardado Satisfactioriamente Su Información" + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("Datos Actualizados");
        return "redirect:/registro/actualizar-datos-empleado";
    }

    @PostMapping("/cambiar-contraseña-empleado")
    public String cambiarPasswordEmpleado(@RequestParam("oldPassword") String oldPassword, @RequestParam("newPassword") String newPassword, RedirectAttributes redirectAttrs, Principal principal){

        System.out.println("OLD PASSWORD " + oldPassword);
        System.out.println("NEW PASSWORD " + newPassword);

        String email = principal.getName();
        Usuario uActual = this.usuarioRepository.findByEmail(email);
        System.out.println(uActual.getPassword());


        if (this.bCryptPasswordEncoder.matches(oldPassword, uActual.getPassword())) {

            uActual.setPassword(this.bCryptPasswordEncoder.encode(newPassword));
            this.usuarioRepository.save(uActual);

            redirectAttrs
                    .addFlashAttribute("mensaje", "Tu contraseña ha sido actualizada correctamente" + " ✔")
                    .addFlashAttribute("clase", "success");

        } else {

            redirectAttrs
                    .addFlashAttribute("mensaje", "Contraseña anterior incorrecta" + "❌")
                    .addFlashAttribute("clase", "danger");
        }

        return "redirect:/registro/actualizar-datos-empleado";
    }


    @PostMapping("/editar_datos_cliente_dev")
    public ResponseEntity<String> actualizarDatos(@PathVariable long idUsuario,@PathVariable String nombre,@PathVariable Integer telefono,@PathVariable String email,@PathVariable String direccion,@PathVariable PasswordEncoder password) {
        return new ResponseEntity<String>(usuarioRepository.actualizarDatos(idUsuario, nombre, telefono, email, direccion,password)+" record(s) updated.", HttpStatus.OK);
    }


    @GetMapping("/editar_usuarios_admin")
    public String EditarUsuariosAdmin(Model model){
        List<Usuario> usuarios = usuarioService.listarUsuarios();
        List<Usuario> usuario = usuarioService.listarUsuarios();
        List<Usuario> roles = usuarioRepository.listarWithrol();
        List<Rol> allRoles = rolRepository.findAll();
        List<EstadoUsuarios> estadoUsuarios = estadoUsuariosService.getAll();
        model.addAttribute("usuario",usuarios);
        model.addAttribute("allRoles",allRoles);
        model.addAttribute("roles",roles);
        model.addAttribute("usuario",usuario);
        model.addAttribute("estadoUsuarios",estadoUsuarios);
        return "interfaz_administrador/templates/editar_usuarios";
    }

    @PostMapping("/edit")
    public String editUsuario(@RequestParam("idUsuario") Long idUsuario,UsuarioRegistroDTO registroDTO,@RequestParam("nombre") String nombre,@RequestParam("telefono") String telefono,@RequestParam("email") String email, @RequestParam("direccion") String direccion, @RequestParam("role") String rol, RedirectAttributes redirectAttrs){

        System.out.println("id" + idUsuario);

        Usuario u = usuarioRepository.findById(idUsuario).get();
        Rol rol1 = rolRepository.findByName(rol);
        u.setNombre(registroDTO.getNombre());
        u.setTelefono(registroDTO.getTelefono());
        u.setEmail(registroDTO.getEmail());
        u.setDireccion(registroDTO.getDireccion());
        u.setEstado(registroDTO.getEstado());
        System.out.println("$$$$$"+registroDTO.getEstado());
        redirectAttrs
                .addFlashAttribute("mensaje", "Se a actualizado los parametros del usuario " + u.getNombre() + " satisfactoriamente" + " ✔")
                .addFlashAttribute("clase", "success");

        usuarioService.actualizarUsuario(u,rol);


        return "redirect:/registro/editar_usuarios_admin";
    }





}
