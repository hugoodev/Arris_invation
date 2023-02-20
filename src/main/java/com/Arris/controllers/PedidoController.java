package com.Arris.controllers;

import com.Arris.models.DetallePedido;
import com.Arris.models.Pedido;
import com.Arris.models.Venta;
import com.Arris.service.PedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping
public class PedidoController {

    @Autowired
    PedidoService pedidoService;

    @GetMapping("/alls")
    public ArrayList<Pedido> getAllPedidos(){
        return pedidoService.getAll();
    }

    @GetMapping("/finds/{id}")
    public Optional<Pedido> getPedidoById(@PathVariable("id") long idPedido){
        return pedidoService.getById(idPedido);
    }

    @PostMapping("/saves")
    public Pedido savePedido(@RequestBody Pedido p){
        return pedidoService.save(p);
    }



    @PostMapping("/guardar_nuevo_pedido_existente")
    public String GuardarExistente(Pedido pedidos, RedirectAttributes redirectAttrs) {
        pedidoService.save(pedidos);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se A Creado Un Nuevo Pedido Existente, Numero De Pedido: #" + pedidos.getIdPedido() + ", Nombre Del Cliente: " + pedidos.getCliente().getNombre() + ", Nombre Del Vendedor: " + pedidos.getEmpleado().getNombre()  +  " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("pedido guardado con exito");
        return "redirect:/gestion_ventas_admin";
    }
    @PostMapping("/guardar_nuevo_pedido_existente_empleado")
    public String GuardarExistenteEmpleado(Pedido pedidos, RedirectAttributes redirectAttrs) {
        pedidoService.save(pedidos);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se A Creado Un Nuevo Pedido Existente, Numero De Pedido: #" + pedidos.getIdPedido() + ", Nombre Del Cliente: " + pedidos.getCliente().getNombre() + ", Nombre Del Vendedor: " + pedidos.getEmpleado().getNombre()  +  " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("pedido guardado con exito");
        return "redirect:/gestion_ventas_empleado";
    }

    @DeleteMapping("/deletes/{id}")
    public String deletePedidoById(@PathVariable("id") long idPedido){
        if (pedidoService.deleteById(idPedido))
            return "se ha eliminado";
        else
            return "no se elimino";
    }

}
