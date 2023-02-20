package com.Arris.service;


import com.Arris.models.RespuestaPqrs;

import java.util.ArrayList;
import java.util.Optional;

public interface RespuestaPqrsService {
    ArrayList<RespuestaPqrs> getAll();
    Optional<RespuestaPqrs> getById(long idRespuesta);
    RespuestaPqrs save(RespuestaPqrs r);
    boolean deleteById(long idRespuesta);

}
