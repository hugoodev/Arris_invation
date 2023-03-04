package com.Arris.controllers;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Producto;
import com.Arris.models.Usuario;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.CarritoDeComprasService;
import com.Arris.service.ProductoService;
import com.Arris.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    ProductoService productoService;
    @Autowired
    private CarritoDeComprasService carritoDeComprasService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private UsuarioRepository usuarioRepository;


    @GetMapping("/home")
    public String Home(Model model, Authentication auth) {
        try {
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
            return "web/index";

        } catch (Exception e){
            return "web/index";
        }
    }
    @GetMapping("/nosotros")
    public String nosotros() {
        return "web/templates/nosotros";
    }
    @GetMapping("/productos/hombre")
    public String productosHombre(Model model) {
        List <Producto> productos = productoService.getAll();
        model.addAttribute("productos", productos);
        return "web/templates/hombre";
    }
    @GetMapping("/productos/mujer")
    public String productosMujer(Model model) {
        List <Producto> productos = productoService.getAll();
        model.addAttribute("productos", productos);
        return "web/templates/mujer";
    }
    @GetMapping("/productos/nino")
    public String productosNino(Model model) {
        List <Producto> productos = productoService.getAll();
        model.addAttribute("productos", productos);
        return "web/templates/nino";
    }
    @GetMapping("/pqrs")
    public String productosPQR() {
        return "web/templates/pqr";
    }
    @GetMapping("/contacto")
    public String productosContacto() {
        return "web/templates/contacto";
    }
    @GetMapping("/producto")
    public String productoRopa(@RequestParam(name="id") int id, Model model) {
        List <Producto> productos = productoService.getAll();
        List <Producto> pr = new ArrayList<>();
        List <Integer> disponibles = new ArrayList<>();
        for (Producto producto : productos) {
            if (producto.getIdProducto() == id) {
                pr.add(producto);
            }
        }
        for (int i = 0; i < pr.size(); i++) {
            for ( int j = 1; j <= pr.get(i).getDisponibles(); j++) {
                disponibles.add(j);
                System.out.println("######"+j);
            }
        }
        model.addAttribute("disponibles", disponibles);
        model.addAttribute("id", id);
        model.addAttribute("productos", pr);
        return "web/templates/producto";
    }
}
