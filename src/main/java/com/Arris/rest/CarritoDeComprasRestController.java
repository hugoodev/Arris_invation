package com.Arris.rest;

import com.Arris.models.Usuario;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.CarritoDeComprasService;
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


    @PostMapping("/carrito/agregar/{pid}/{ctl}")
    public String addProductosCarrito(@PathVariable("pid") Integer productoId, @PathVariable("ctl") Integer cantidad, Authentication auth) {
        System.out.println("addproductcarrito" + productoId + "-" + cantidad);
        if (auth == null || auth instanceof AnonymousAuthenticationToken) {
            return "Necesitas registrarte o logearte para poder agregar productos al carrito";
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
            return "Necesitas registrarte o logearte para poder agregar productos al carrito";
        }

        Integer addCantidad = carritoDeComprasService.addProduct(productoId,cantidad,usuario);

        return addCantidad + " Producto(s) agregado(s) en el carrito de compras satisfactoriamente";

    }

}
