package com.Arris.controllers;


import com.Arris.models.Inventario;
import com.Arris.service.InventarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Optional;

@RestController
@RequestMapping("inventario")
public class InventarioController {

    @Autowired
    InventarioService inventarioService;

    @GetMapping("/all")
    public ArrayList<Inventario> getAllInventario(){
        return inventarioService.getAll();
    }

    @GetMapping("/find/{id}")
    public Optional<Inventario> getInventarioById(@PathVariable("id") long idInventario){
        return inventarioService.getById(idInventario);
    }

    @PostMapping("/save")
    public Inventario saveInventario(@RequestBody Inventario i){
        return inventarioService.save(i);
    }

    @DeleteMapping("/delete/{id}")
    public String deleteInventarioById(@PathVariable("id") long idInventario){
        if (inventarioService.deleteById(idInventario))
            return "se ha eliminado";
        else
            return "no se ha eliminado";
    }


}
