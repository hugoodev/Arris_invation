package com.Arris.controllers;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Usuario;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.CarritoDeComprasService;
import com.Arris.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CarritoDeComprasController {
    @Autowired
    private CarritoDeComprasService carritoDeComprasService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @GetMapping("/carrito")
    public String mostrarCarritoCompras(Model model, Authentication auth) {
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
        List<ItemsCarrito> itemsCarrito = carritoDeComprasService.listCartItems(usuario);

        model.addAttribute("itemsCarrito", itemsCarrito);


        return "redirect:/home";
    }
}
