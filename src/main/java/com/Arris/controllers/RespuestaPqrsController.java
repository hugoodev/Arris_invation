package com.Arris.controllers;

import com.Arris.models.RespuestaPqrs;
import com.Arris.service.RespuestaPqrsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Optional;

@RestController
@RequestMapping("respuesta")
public class RespuestaPqrsController {

    @Autowired
    RespuestaPqrsService pqrsService;

    @GetMapping("/all")
    public ArrayList<RespuestaPqrs> getAllRespuestas(){
        return pqrsService.getAll();
    }

    @GetMapping("/find/{id}")
    public Optional<RespuestaPqrs> getRespuestaById(@PathVariable("id") long idRespuesta){
        return pqrsService.getById(idRespuesta);
    }

    @PostMapping("/save")
    public RespuestaPqrs saveRespuesta(@RequestBody RespuestaPqrs r){
        return pqrsService.save(r);
    }

    @DeleteMapping("delete/{id}")
    public String deleteRespuestaById(@PathVariable("id") long idRespuesta){
        if (pqrsService.deleteById(idRespuesta))
            return "se ha eliminado";
        else
            return "no se elimino";
    }

}
