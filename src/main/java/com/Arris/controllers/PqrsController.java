package com.Arris.controllers;

import com.Arris.models.*;
import com.Arris.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class PqrsController {

    @Autowired
    PqrsService pqrsService;

    @Autowired
    DetallePedidoService detallePedidoService;

    @Autowired
    VentaService ventaService;

    @Autowired
    private EnvioService envioService;

    @Autowired
    CalificacionService calificacionService;

    @GetMapping("/allx")
    public ArrayList<Pqrs> getAllPqrs(){
        return pqrsService.getAll();
    }

    @GetMapping("/solicitudes_pqrs_admin")
    public String listarPQRS(Model model){
        List<Pqrs> pqrs =pqrsService.getAll();
        model.addAttribute("listarPqrs",pqrs);
        return "interfaz_administrador/templates/solicitudes_pqrs";
    }

    @GetMapping("/solicitudes_pqrs_empleado")
    public String listarPQRSEmpleado(Model model){
        List<Pqrs> pqrs =pqrsService.getAll();
        model.addAttribute("listarPqrs",pqrs);
        return "interfaz_empleado/templates/pqrs";
    }

    @GetMapping("/solicitudes_pqrs_cliente")
    public String listarPQRSCliente(Model model){
        List<DetallePedido> detallePedido = detallePedidoService.getAll();
        List<Pqrs> pqrs =pqrsService.getAll();
        List<Envio> envio = envioService.getAll();
        List<Calificacion> calificacion = calificacionService.getAllCalificaciones();
        model.addAttribute("envio",envio);
        model.addAttribute("pedido", detallePedido);
        model.addAttribute("listarPqrs",pqrs);
        model.addAttribute("calificacion", calificacion);
        return "interfaz_cliente/templates/pqrs";
    }

    @GetMapping("/findx/{id}")
    public Optional<Pqrs> getPqrsById(@PathVariable("id") long idPqrs){
        return pqrsService.getById(idPqrs);
    }

    @PostMapping("/responder_mensaje_admin")
    public String responderMensaje(Pqrs pqrs, RedirectAttributes redirectAttrs, Authentication auth){
        pqrs.setEncargadoRes(auth.getName());
        pqrsService.save(pqrs);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se respondio el mensaje de la PQRS #" + pqrs.getIdPqrs() + ", del cliente: " + pqrs.getVenta().getPedido().getCliente().getNombre() +" A Sido Satisfactoriamente Respondida " + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("estado actualizado con exito");
        return "redirect:/solicitudes_pqrs_admin";
    }

    @PostMapping("/responder_mensaje_empleado")
    public String responderMensajeEmpleado(Pqrs pqrs, RedirectAttributes redirectAttrs, Authentication auth){
        pqrs.setEncargadoRes(auth.getName());
        pqrsService.save(pqrs);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se respondio el mensaje de la PQRS #" + pqrs.getIdPqrs() + ", del cliente: " + pqrs.getVenta().getPedido().getCliente().getNombre() +" A Sido Satisfactoriamente Respondida " + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("estado actualizado con exito");
        return "redirect:/solicitudes_pqrs_empleado";
    }

    @PostMapping("/ingresar_nuevo_pqrs_cliente")
    public String ingresarPQRSCliente(Pqrs pqrs, RedirectAttributes redirectAttrs){
        pqrsService.save(pqrs);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se a ingresado un nuevo PQRS #" + pqrs.getIdPqrs() + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("ingresado nuevo pqrs con exito");
        return "redirect:/solicitudes_pqrs_cliente";
    }

    @PostMapping("/calificar_pqrs_cliente")
    public String calificarPqrsCliente(Pqrs pqrs, RedirectAttributes redirectAttrs){
        pqrsService.save(pqrs);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se a calificado la PQRS #" + pqrs.getIdPqrs() + " ✔ <br> ¡Gracias por calificar! <br> tu opinión es muy importante para nosotros")
                .addFlashAttribute("clase", "success");
        return "redirect:/solicitudes_pqrs_cliente";
    }

    @PostMapping("/savex")
    public Pqrs savePqrs(@RequestBody Pqrs p){
        return pqrsService.save(p);
    }

    @DeleteMapping("/deletex/{id}")
    public String deletePqrsById(@PathVariable("id") long idPqrs){
        if (pqrsService.deleteById(idPqrs))
            return "se ha eliminado";
        else
            return "no se elimino";
    }

}
