package com.markys.markys.controller;

import com.markys.markys.model.Platillo;
import com.markys.markys.model.Rol;
import com.markys.markys.model.Usuario;
import com.markys.markys.repository.RolRepository;
import com.markys.markys.repository.UsuarioRepository;
import com.markys.markys.service.RegistroService;
import com.markys.markys.service.ServicioPlatillo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@Controller
public class HomeController {

    @Autowired
    private ServicioPlatillo servicioPlatillo;

    @Autowired
    private UsuarioRepository usuarioRepo;

    @Autowired
    private RolRepository rolRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RegistroService registroService;

    @GetMapping("/")
    public String inicio() {
        return "inicio";
    }

    @GetMapping("/carta")
    public String mostrarCarta(Model model) {
        List<Platillo> platillos = servicioPlatillo.obtenerTodos();
        model.addAttribute("platillos", platillos);
        return "carta";
    }

    @GetMapping("/contacto")
    public String contacto() {
        return "contacto";
    }

    @GetMapping("/delivery")
    public String delivery() {
        return "delivery";
    }

    @GetMapping("/carrito")
    public String carrito() {
        return "carrito";
    }

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    @GetMapping("/registro")
    public String mostrarFormularioRegistro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "registro";
    }

    @PostMapping("/registro")
    public String procesarRegistro(@ModelAttribute Usuario usuario, Model model) {
        boolean registrado = registroService.registrarUsuario(usuario);

        if (!registrado) {
            model.addAttribute("error", "El nombre de usuario ya existe");
            return "registro";
        }

        return "redirect:/login";
    }
}
