package com.Arris.controllers;

import com.Arris.models.Proveedor;
import com.Arris.service.ProveedorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Optional;

@Controller
@RequestMapping("proveedor")
public class ProveedorController {

    @Autowired
    ProveedorService proveedorService;

    @GetMapping("/all")
    public ArrayList<Proveedor> getAllProveedores(){
        return proveedorService.getAll();
    }

    @GetMapping("/find/{id}")
    public Optional<Proveedor> getProveedorById(@PathVariable("id") long idProveedor){
        return proveedorService.getById(idProveedor);
    }

    @PostMapping("/save")
    public Proveedor saveProveedor(@RequestBody Proveedor p){
        return proveedorService.save(p);
    }

    @PostMapping("/ingresar_nuevo_proveedor_admin")
    public String ingresarProveedorAdmin(Proveedor proveedor, RedirectAttributes redirectAttrs){
        proveedorService.save(proveedor);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se a agragado un nuevo proveedor, ID#" + proveedor.getIdProveedor() +", Nombre proveedor: " + proveedor.getNombreProveedor() + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("estado actualizado con exito");
        return "redirect:/administrador_compras_admin";
    }

    @DeleteMapping("/delete/{id}")
    public String deleteProveedor(@PathVariable("id") long idProveedor){
        if (proveedorService.deleteById(idProveedor))
            return "se ha eliminado";
        else
            return "no se elimino";
    }

}
