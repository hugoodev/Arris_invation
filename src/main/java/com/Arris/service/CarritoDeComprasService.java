package com.Arris.service;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Producto;
import com.Arris.models.Usuario;
import com.Arris.repository.ItemsCarritoRepository;
import com.Arris.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CarritoDeComprasService {
    @Autowired
    ItemsCarritoRepository itemsCarritoRepository;
    @Autowired
    ProductoRepository productoRepository;

    public List<ItemsCarrito> listCartItems(Usuario usuario) {
        return itemsCarritoRepository.findByUsuario(usuario);
    }

    public Integer addProduct(long productoId, Integer cantidad, Usuario usuario) {
        Integer addedCantidad = cantidad;

        Producto producto = productoRepository.findById(productoId).get();

        ItemsCarrito itemsCarrito = itemsCarritoRepository.findByUsuarioAndProducto(usuario, producto);

        if (itemsCarrito != null) {
            addedCantidad = itemsCarrito.getCantidad() + cantidad;
            itemsCarrito.setCantidad(addedCantidad);
        } else {
            itemsCarrito = new ItemsCarrito();
            itemsCarrito.setCantidad(cantidad);
            itemsCarrito.setUsuario(usuario);
            itemsCarrito.setProducto(producto);
        }
        itemsCarritoRepository.save(itemsCarrito);

        return addedCantidad;
    }
}
