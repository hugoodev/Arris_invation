package com.Arris.service;


import com.Arris.controllers.UsuarioController;
import com.Arris.controllers.dto.UsuarioRegistroDTO;
import com.Arris.models.DetallePedido;
import com.Arris.models.Rol;
import com.Arris.models.Usuario;
import com.Arris.repository.RolRepository;
import com.Arris.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UsuarioServiceImp implements UsuarioService {


   @Autowired
   UsuarioRepository usuarioRepository;

   @Autowired
    RolRepository rolRepository;

   @Autowired
   private BCryptPasswordEncoder passwordEncoder;



    @Override
    public Usuario guardarUsuario(UsuarioRegistroDTO registroDTO) {
        Rol rol = rolRepository.findByName("ROLE_CLIENTE");
        Usuario usuario = new Usuario(registroDTO.getIdUsuario(),registroDTO.getNombre(),registroDTO.getTelefono(),registroDTO.getEmail(),registroDTO.getDireccion(),passwordEncoder.encode(registroDTO.getPassword()));
        usuario.agregarRol(rol);
        return usuarioRepository.save(usuario);
    }



    @Override
    public List<Usuario> listarUsuarios() {
        return usuarioRepository.findAll();
    }

    @Override
    public List<Usuario> listarC() {
        return usuarioRepository.listarClientes();
    }

    @Override
    public List<Usuario> listarE() {
        return usuarioRepository.listarEmpleados();
    }

    @Override
    public Usuario actualizarUsuario(Usuario usuario,String nombreRol) {

        Rol rol = rolRepository.findByName(nombreRol);
        usuario.agregarRol(rol);
        return usuarioRepository.save(usuario);
    }


    @Override
    public Usuario save(Usuario usuario) {
        Usuario usuarios = new Usuario(usuario.getIdUsuario(),usuario.getNombre(),usuario.getTelefono(),usuario.getEmail(),usuario.getDireccion(),passwordEncoder.encode(usuario.getPassword()));
        return usuarioRepository.save(usuarios);
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByEmail(username);
        if (usuario == null){
            throw new UsernameNotFoundException("Usuario o password invalidos");
        }
        return new User(usuario.getEmail(), usuario.getPassword(), mapearAutoridadesRoles(usuario.getRoles()));
    }

    private Collection<? extends GrantedAuthority> mapearAutoridadesRoles(Collection<Rol> roles){
        return roles.stream().map(role -> new SimpleGrantedAuthority(role.getNombreRol())).collect(Collectors.toList());
    }


}
