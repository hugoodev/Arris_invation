package com.Arris.rest;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Producto;
import com.Arris.models.Usuario;
import com.Arris.repository.ProductoRepository;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.CarritoDeComprasService;
import com.Arris.service.ProductoService;
import com.Arris.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CarritoDeComprasRestController {

    @Autowired
    private CarritoDeComprasService carritoDeComprasService;

    @Autowired
    private UsuarioRepository usuarioRepository;
    @Autowired
    private UsuarioService usuarioService;
    @Autowired
    private ProductoRepository productoRepository;


    @PostMapping("/carrito/agregar/{pid}/{ctl}")
    public String addProductosCarrito(@PathVariable("pid") Integer productoId, @PathVariable("ctl") Integer cantidad, Authentication auth) {
        System.out.println("addproductcarrito" + productoId + "-" + cantidad);
        if (auth == null || auth instanceof AnonymousAuthenticationToken) {
            return "Necesitas registrarte o iniciar sesión para poder agregar productos al carrito. <br> <a href='/registro'><button type='button' class='btn btn-success border border-warning'>Registrarse</button></a> o <a href='/login'><button type='button' class='btn btn-success border border-warning'>Iniciar Sesión</button></a>";
        }
        String email = auth.getName();
        long id = 0;
        List<Usuario> usuarios = usuarioService.listarUsuarios();
        for (Usuario user : usuarios){
            if(user.getEmail().equals(email)){
                id = user.getIdUsuario();
                System.out.println("######" + user.getNombre() + user.getIdUsuario());
            }
        }
        Usuario usuario = usuarioRepository.findById(id);

        if (usuario == null) {
            return "Necesitas registrarte o iniciar sesión para poder agregar productos al carrito. <br> <a href='/registro'><button type='button' class='btn btn-success border border-warning'>Registrarse</button></a> o <a href='/login'><button type='button' class='btn btn-success border border-warning'>Iniciar Sesión</button></a>";
        }
        Long idproducto = Long.valueOf(productoId);

        Producto producto = productoRepository.findById(idproducto).get();
        List<ItemsCarrito> itemsCarrito = carritoDeComprasService.listCartItems(usuario);

        if (producto.getDisponibles() < cantidad) {
            return "El producto es mayor del stock";
        }
        for (ItemsCarrito it : itemsCarrito) {
            if (it.getProducto().getIdProducto() == productoId) {
                if ( it.getCantidad() >= it.getProducto().getDisponibles()) {
                    return "El producto es mayor del stock, revisa tu carrito de compras y verifica si ya tienes agregada esta cantidad o si vas a agregar mas de la que hay en stock";
                }
                long totalCant = it.getCantidad() + cantidad;
                if (totalCant > it.getProducto().getDisponibles()) {
                    return "El producto es mayor del stock, revisa tu carrito de compras y verifica si ya tienes agregada esta cantidad o si vas a agregar mas de la que hay en stock";
                }
            }
        }

        Integer addCantidad = carritoDeComprasService.addProduct(productoId,cantidad,usuario);

        return addCantidad + " Producto(s) agregado(s) en el carrito de compras satisfactoriamente";

    }

    @PostMapping("/carrito/actualizar/{pid}/{ctl}")
    public String updateCantidad(@PathVariable("pid") Integer productoId, @PathVariable("ctl") Integer cantidad, Authentication auth) {
        System.out.println("addproductcarrito" + productoId + "-" + cantidad);
        if (auth == null || auth instanceof AnonymousAuthenticationToken) {
            return "Necesitas registrarte o iniciar sesión para poder actualizar el producto al carrito";
        }
        String email = auth.getName();
        long id = 0;
        List<Usuario> usuarios = usuarioService.listarUsuarios();
        for (Usuario user : usuarios){
            if(user.getEmail().equals(email)){
                id = user.getIdUsuario();
                System.out.println("######" + user.getNombre() + user.getIdUsuario());
            }
        }
        Usuario usuario = usuarioRepository.findById(id);

        if (usuario == null) {
            return "Necesitas registrarte o iniciar sesión para poder actualizar productos al carrito";
        }

        double subtotal = carritoDeComprasService.updateCantidad(productoId,cantidad,usuario);

        return String.valueOf(subtotal);

    }

    @PostMapping("/carrito/eliminar/{pid}")
    public String removeProductoCarrito(@PathVariable("pid") Integer productoId, Authentication auth) {
        System.out.println("addproductcarrito" + productoId);
        if (auth == null || auth instanceof AnonymousAuthenticationToken) {
            return "Necesitas registrarte o logearte para poder eliminar productos del carrito";
        }
        String email = auth.getName();
        long id = 0;
        List<Usuario> usuarios = usuarioService.listarUsuarios();
        for (Usuario user : usuarios){
            if(user.getEmail().equals(email)){
                id = user.getIdUsuario();
                System.out.println("######" + user.getNombre() + user.getIdUsuario());
            }
        }
        Usuario usuario = usuarioRepository.findById(id);

        if (usuario == null) {
            return "Necesitas registrarte o logearte para poder eliminar productos del carrito";
        }

        carritoDeComprasService.removeProducto(productoId,usuario);

        return "Se elimino el producto del carrito satisfactoriamente. (removed)";

    }

}
