package com.Arris.controllers;


import com.Arris.controllers.dto.UsuarioRegistroDTO;
import com.Arris.models.Envio;
import com.Arris.models.Rol;
import com.Arris.models.Usuario;
import com.Arris.repository.RolRepository;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.EnvioService;
import com.Arris.service.UsuarioService;
import org.hibernate.annotations.ManyToAny;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.util.List;

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

    @PostMapping("/guardar_usuario_admin")
    public String registrarCuentaDeUsuarioadmin(UsuarioRegistroDTO registroDTO, RedirectAttributes redirectAttrs) {
        usuarioService.guardarUsuario(registroDTO);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se Registro el Nuevo Usuario Satisfactoriamente, Nombre del Usuario: " + registroDTO.getNombre() +", Correo Electronico: " + registroDTO.getEmail() + ", Recuerda que se Envio un Mensaje a Este Correo con La Contraseña ✔")
                .addFlashAttribute("clase", "success");
        return "redirect:/gestion_ventas_admin";
    }

    @GetMapping("/actualizar-datos")
    public String editarDatosCliente(Model model){
        List<Usuario> usuario = usuarioService.listarUsuarios();
        List<Envio> envio = envioService.getAll();
        model.addAttribute("envio",envio);
        model.addAttribute("usuario",usuario);
        return "interfaz_cliente/templates/editar";
    }




    @PostMapping("/actualizado")
    public String editarDatosClienteEnv(@ModelAttribute("usuario") UsuarioRegistroDTO registroDTO, Model model, RedirectAttributes redirectAttrs){

        Usuario usuario1 = usuarioRepository.findByEmail(registroDTO.getEmail());

        usuario1.setNombre(registroDTO.getNombre());
        usuario1.setTelefono(registroDTO.getTelefono());
        usuario1.setEmail(registroDTO.getEmail());
        usuario1.setDireccion(registroDTO.getDireccion());

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
    public String editarDatosAdminEnv(@ModelAttribute("usuario") UsuarioRegistroDTO registroDTO, Model model, RedirectAttributes redirectAttrs){

        Usuario usuario1 = usuarioRepository.findByEmail(registroDTO.getEmail());

        usuario1.setNombre(registroDTO.getNombre());
        usuario1.setTelefono(registroDTO.getTelefono());
        usuario1.setEmail(registroDTO.getEmail());
        usuario1.setDireccion(registroDTO.getDireccion());

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
    public String editarDatosEmpleadoEnv(@ModelAttribute("usuario") UsuarioRegistroDTO registroDTO, Model model, RedirectAttributes redirectAttrs){

        Usuario usuario1 = usuarioRepository.findByEmail(registroDTO.getEmail());

        usuario1.setNombre(registroDTO.getNombre());
        usuario1.setTelefono(registroDTO.getTelefono());
        usuario1.setEmail(registroDTO.getEmail());
        usuario1.setDireccion(registroDTO.getDireccion());

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
        List<Usuario> usuario = usuarioService.listarUsuarios();
        List<Usuario> roles = usuarioRepository.listarWithrol();
        List<Rol> allRoles = rolRepository.findAll();
        model.addAttribute("allRoles",allRoles);
        model.addAttribute("roles",roles);
        model.addAttribute("usuario",usuario);
        return "interfaz_administrador/templates/editar_usuarios";
    }

    @PostMapping("/edit")
    public String editUsuario(@RequestParam("idUsuario") Long idUsuario,UsuarioRegistroDTO registroDTO,@RequestParam("nombre") String nombre,@RequestParam("telefono") String telefono,@RequestParam("email") String email, @RequestParam("direccion") String direccion, @RequestParam("role") String rol){

        System.out.println("id" + idUsuario);

        Usuario u = usuarioRepository.findById(idUsuario).get();
        Rol rol1 = rolRepository.findByName(rol);
        u.setNombre(registroDTO.getNombre());
        u.setTelefono(registroDTO.getTelefono());
        u.setEmail(registroDTO.getEmail());
        u.setDireccion(registroDTO.getDireccion());


        usuarioService.actualizarUsuario(u,rol);


        return "redirect:/registro/editar_usuarios_admin";
    }





}
