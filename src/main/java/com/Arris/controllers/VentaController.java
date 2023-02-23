package com.Arris.controllers;

import com.Arris.models.Usuario;
import com.Arris.models.Venta;
import com.Arris.service.UsuarioService;
import com.Arris.service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping
public class VentaController {

    @Autowired
    VentaService ventaService;

    @Autowired
    UsuarioService usuarioService;
    @GetMapping("/all")
    public ArrayList<Venta> getAllVentas(){
        return ventaService.getAll();
    }



    @GetMapping("/find/{id}")
    public Optional<Venta> getVentaById(@PathVariable("id") long idVenta){
        return ventaService.getById(idVenta);
    }

    @PostMapping("/save")
    public Venta saveVenta(@RequestBody Venta v){
        return ventaService.save(v);
    }

    @DeleteMapping("/delete/{id}")
    public String deleteVentaById(@PathVariable("id") long idVenta){
        if (ventaService.deleteById(idVenta))
            return "se ha eliminado";
        else
            return "no se elimino";
    }

}
