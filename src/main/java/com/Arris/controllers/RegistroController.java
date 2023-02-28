package com.Arris.controllers;

import com.Arris.models.Envio;
import com.Arris.models.Rol;
import com.Arris.models.Usuario;
import com.Arris.service.EnvioService;
import com.Arris.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;

@Controller
public class RegistroController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private EnvioService envioService;


    @GetMapping("/login")
    public String iniciarSesion(){
        return "login";
    }

    @GetMapping("/sesion")
    public String sesionRoles() {
        return "sesion";
    }


    @GetMapping("/admin")
    public String interfazAdmin(){
        return "interfaz_administrador/interfaz_administrador";
    }

    @GetMapping("/empleado")
    public String interfazEmpleado(){
        return "interfaz_empleado/interfaz_empleado";
    }

    @GetMapping("/cliente")
    public String interfazCliente(Model model){

        return "interfaz_cliente/interfaz_cliente";
    }
}
