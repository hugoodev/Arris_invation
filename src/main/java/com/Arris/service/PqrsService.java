package com.Arris.service;


import com.Arris.models.Pqrs;

import java.util.ArrayList;
import java.util.Optional;

public interface PqrsService {
    ArrayList<Pqrs> getAll();
    Optional<Pqrs> getById(long idPqrs);
    Pqrs save(Pqrs p);
    boolean deleteById(long idPqrs);
}
