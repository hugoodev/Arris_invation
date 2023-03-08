package com.Arris.service;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Producto;
import com.Arris.models.Usuario;
import com.Arris.repository.ItemsCarritoRepository;
import com.Arris.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
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

    public double updateCantidad(long productoId,Integer cantidad, Usuario usuario) {
        itemsCarritoRepository.updateCantidad(cantidad, productoId, usuario.getIdUsuario());
        System.out.println("llego aca al updateCantidad - " + productoId +" - "+cantidad);
        Producto producto = productoRepository.findById(productoId).get();
        System.out.println("%%%% " + producto);
        double total = producto.getPrecio() * cantidad;
        double iva = total * 0.19;
        double subtotal = total + iva;
        return subtotal;

    }

    public void removeProducto(long productoId, Usuario usuario) {
        itemsCarritoRepository.deleteByUsuarioYProducto(usuario.getIdUsuario(), productoId);
    }
}
