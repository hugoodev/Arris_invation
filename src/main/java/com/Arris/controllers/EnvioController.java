package com.Arris.controllers;

import com.Arris.models.Envio;
import com.Arris.models.MailRequest;
import com.Arris.service.EnvioService;
import com.Arris.service.MailServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class EnvioController {

    @Autowired
    EnvioService envioService;

    @Autowired
    private MailServiceImp emailPort;

    @GetMapping("/allqq")
    public ArrayList<Envio> getAllEnvios(){
        return envioService.getAll();
    }

    @GetMapping("/verificacion_envios_admin")
    public String listarEnvio(Model model){
        List<Envio> envio = envioService.getAll();
        model.addAttribute("envio", envio);
        return "interfaz_administrador/templates/verificacion_envios";
    }

    @GetMapping("/verificacion_envios_empleado")
    public String listarEnvioEmpleado(Model model){
        List<Envio> envio = envioService.getAll();
        model.addAttribute("envio", envio);
        return "interfaz_empleado/templates/envios";
    }

    @GetMapping("/envios_cliente")
    public String listarEnviosCliente(Model model){
        List<Envio> envio = envioService.getAll();
        model.addAttribute("envio", envio);
        return "interfaz_cliente/templates/envios";
    }

    @GetMapping("/findqq/{id}")
    public Optional<Envio> getEnvioById(@PathVariable("id") long idEnvio){
        return envioService.getById(idEnvio);
    }

    @PostMapping("/saveqq")
    public Envio saveEnvio(@RequestBody Envio e){
        return envioService.save(e);
    }

    @PostMapping("/editar_envio_admin")
        public String editarEnvio(Envio envio, RedirectAttributes redirectAttrs, MailRequest emailBody, Authentication auth){
        String fechaIngresada = null;
        List<Envio> envios = envioService.getAll();
        for (Envio en : envios) {
            if (en.getIdEnvio() == envio.getIdEnvio()) {
                fechaIngresada = en.getFechaIngresada();

            }
        }
        LocalDateTime datetime = LocalDateTime.now();
        redirectAttrs
                .addFlashAttribute("mensaje", "Se a editado satisfactoriamente el envio, Numero De Envio: #" + envio.getIdEnvio() +", Estado: " + envio.getEstado() + ", Empresa Envio: " + envio.getEmpresa() + " ✔")
                .addFlashAttribute("clase", "success");
        emailBody.setEmail("mrloquendojodido@gmail.com");
        emailBody.setSubject("has entregado el pedido!! #"+ envio.getIdEnvio());
        emailBody.setContent(
                "<h1>Hola Admin <strong>" + auth.getName() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                        "<h1>Cliente: <strong>" + envio.getVenta().getPedido().getCliente().getNombre() + "</strong></h1><br/>" +
                        "<h1>El pedido que termino su proceso de envio, tiene los siguientes productos: </h1><strong><h2>" + envio.getVenta().getProducto() + "</strong></h2><br/>"+
                        "<h1>Fecha de ingreso: </h1><strong><h2>" + fechaIngresada +"</strong></h2>"+
                        "<h1>Fecha de entrega:</h1> <strong><h2>" + datetime + "</h2></strong>"
        );
        emailPort.sendEmail(emailBody);

        emailBody.setEmail("hugo.garcia29@misena.edu.co");
        emailBody.setSubject("Tu producto se entrego correctamente!! #"+envio.getIdEnvio());
        emailBody.setContent(
                "<h1>Hola <strong>" + envio.getVenta().getPedido().getCliente().getNombre() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                        "<h1>Productos entregados: </h1><strong><h2>" + envio.getVenta().getProducto() + "</strong></h2><br/>"+
                        "<h1>Fecha de ingreso: </h1><strong><h2>" + fechaIngresada +"</strong></h2>"+
                        "<h1>Fecha de entrega:</h1> <strong><h2>" + datetime + "</h2></strong>"
        );
        envioService.save(envio);


        emailPort.sendEmail(emailBody);
        return "redirect:/verificacion_envios_admin";
    }

    @DeleteMapping("/deleteqq/{id}")
    public String deleteEnvioById(@PathVariable("id") long idEnvio){
        if (envioService.deleteById(idEnvio))
            return "se ha eliminado";
        else
            return "no se elimino";
    }


}
