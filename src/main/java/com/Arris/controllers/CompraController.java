package com.Arris.controllers;

import com.Arris.models.*;
import com.Arris.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class CompraController {

    @Autowired
    CompraService compraService;

    @Autowired
    DetalleCompraService detalleCompraService;

    @Autowired
    ProductoService productoService;

    @Autowired
    DetallePedidoService detallePedidoService;

    @Autowired
    ProveedorService proveedorService;

    @GetMapping("/allzz")
    public ArrayList<Compra> getAllCompras(){
        return compraService.getAll();
    }

    @GetMapping("/administrador_compras_admin")
    public String listarCompras(Model model){
        List<DetalleCompra> detalleCompras = detalleCompraService.getAll();
        List<Producto> productos = productoService.getAll();
        List<DetallePedido> detallePedidos = detallePedidoService.getAll();
        List<Proveedor> proveedores = proveedorService.getAll();
        List<Compra> compras = compraService.getAll();
        model.addAttribute("compras", compras);
        model.addAttribute("proveedores",proveedores);
        model.addAttribute("detallePedidos",detallePedidos);
        model.addAttribute("productos", productos);
        model.addAttribute("detalleCompras",detalleCompras);
        return "interfaz_administrador/templates/administrador_compras";
    }

    @GetMapping("/inventario_compras_empleado")
    public String listarComprasEmpleado(Model model){
        List<DetalleCompra> detalleCompras = detalleCompraService.getAll();
        List<Producto> productos = productoService.getAll();
        List<DetallePedido> detallePedidos = detallePedidoService.getAll();
        List<Proveedor> proveedores = proveedorService.getAll();
        List<Compra> compras = compraService.getAll();
        model.addAttribute("compras", compras);
        model.addAttribute("proveedores",proveedores);
        model.addAttribute("detallePedidos",detallePedidos);
        model.addAttribute("productos", productos);
        model.addAttribute("detalleCompras",detalleCompras);
        return "interfaz_empleado/templates/compras";
    }

    @GetMapping("/findzz/{idCompra}")
    public Optional<Compra> getCompraById(@PathVariable("idCompra") long idCompra){
        return compraService.getById(idCompra);
    }

    @PostMapping("/savezz")
    public Compra saveCompra(@RequestBody Compra c){
        return compraService.save(c);
    }

    @PostMapping("/crear_compra_admin")
    public String crearCompra(Compra compra, RedirectAttributes redirectAttrs){
        compraService.save(compra);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se a creado una nueva compra satisfactoriamente, Numero De La Compra: #" + compra.getIdCompra() +", Descripción: " + compra.getDescripcion() + ", Nombre Del Proveedor: #" + compra.getProveedor().getNombreProveedor() + " ✔")
                .addFlashAttribute("clase", "success");
        return "redirect:/administrador_compras_admin";
    }

    @DeleteMapping("/deletezz/{idCompra}")
    public String deleteCompraById(@PathVariable("idCompra") long idCompra){
        if (compraService.deleteById(idCompra))
            return "Se ha eliminado";
        else
            return "No se ha eliminado";
    }


}
