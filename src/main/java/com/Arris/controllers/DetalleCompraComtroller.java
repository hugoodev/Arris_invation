package com.Arris.controllers;

import com.Arris.models.DetalleCompra;
import com.Arris.service.DetalleCompraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Optional;

@Controller
public class DetalleCompraComtroller {

    @Autowired
    DetalleCompraService compraService;


    @GetMapping("/allwa")
    public ArrayList<DetalleCompra> getAllDetalleCompras(){
        return compraService.getAll();
    }

    @GetMapping("/findwa/{id}")
    public Optional<DetalleCompra> getDetalleCompraById(@PathVariable("id") long idDetalleCompra){
        return compraService.getById(idDetalleCompra);
    }

    @PostMapping("/savewa")
    public DetalleCompra saveDetalleCompra(@RequestBody DetalleCompra d){
        return compraService.saveDetalleCompra(d);
    }

    @PostMapping("/crear_detalle_compra")
    public String crearDetalleCompra(DetalleCompra detalleCompra, RedirectAttributes redirectAttrs){
        compraService.saveDetalleCompra(detalleCompra);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se a ingresado una nueva compra de productos satisfactoriamente, Numero De Detalle De La Compra #" + detalleCompra.getIdDetalleCompra() +", Nombre Del Producto: " + detalleCompra.getProducto().getNombre() + ", Cantidad: " + detalleCompra.getCantidad() +  "Numero De Compra: " + detalleCompra.getCompra().getIdCompra() +" ✔")
                .addFlashAttribute("clase", "success");
        return "redirect:/administrador_compras_admin";

    }

    @DeleteMapping("/deletewa/{id}")
    public String deleteDetalleCompraById(@PathVariable("id") long idDetalleCompra){
        if (compraService.deleteById(idDetalleCompra))
            return "se ha eliminado";
        else
            return "no se elimino";
    }


}
