package com.Arris.service;


import com.Arris.models.Envio;

import java.util.ArrayList;
import java.util.Optional;

public interface EnvioService {
    ArrayList<Envio> getAll();
    Optional<Envio> getById(long idEnvio);
    Envio save(Envio e);
    boolean deleteById(long idEnvio);

}
