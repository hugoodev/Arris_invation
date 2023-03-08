package com.Arris.service;

import com.Arris.models.DetalleTransaccion;
import com.Arris.repository.DetalleTransaccionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DetalleTransaccionServiceImp implements DetalleTransaccionService{
    @Autowired
    DetalleTransaccionRepository detalleTransaccionRepository;

    @Override
    public DetalleTransaccion save(DetalleTransaccion detalleTransaccion) {
        return detalleTransaccionRepository.save(detalleTransaccion);
    }
}
