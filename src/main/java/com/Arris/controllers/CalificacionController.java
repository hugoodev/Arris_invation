package com.Arris.controllers;

import com.Arris.models.Calificacion;
import com.Arris.service.CalificacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Optional;

@RestController
@RequestMapping("calificacion")
public class CalificacionController {

    @Autowired
    CalificacionService calificacionService;

    @GetMapping("/all")
    public ArrayList<Calificacion> getAllCalificaciones(){
        return calificacionService.getAllCalificaciones();
    }

    @GetMapping("/find/{idCalificacion}")
    public Optional<Calificacion> getCalificacionById(@PathVariable("idCalificacion") long idCalificacion){
        return calificacionService.getCalificacionById(idCalificacion);
    }

    @PostMapping("/save")
    public Calificacion saveCalificacion(@RequestBody Calificacion c){
        return calificacionService.saveCalificacion(c);
    }

    @DeleteMapping("/delete/{idCalificacion}")
    public String deleteCalificacionById(@PathVariable("idCalificacion") long idCalififcacion){
        if (calificacionService.deleteCalificacionById(idCalififcacion))
            return "se ha eliminado la calificacion";
        else
            return "No se ha eliminado la calificaion";
    }

}
