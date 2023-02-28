package com.Arris.controllers;

import com.Arris.models.Usuario;
import com.Arris.models.UsuarioNotFoundException;
import com.Arris.service.UsuarioServiceImp;
import com.Arris.utilidad.Utility;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

@Controller
public class ForgotPasswordController {

    @Autowired
    UsuarioServiceImp usuarioServiceImp;

    @Autowired
    private JavaMailSender mailSender;

    @GetMapping("/forgot_password")
    public String showForgotPasswordForm(Model model){
        model.addAttribute("pageTitle","Forgot Password");
        return "forgot_password_form";
    }

    @PostMapping("/forgot_password")
    public String processForgotPasswordForm(HttpServletRequest request, Model model){
        String email = request.getParameter("email");
        String token = RandomString.make(45);

        try {
            usuarioServiceImp.updateResetPasswordToken(token,email);

            String resetPasswordLink = Utility.getSiteURL(request) + "/reset_password?token=" + token;


            // generar link para restablecer la contraseña

            sendEmail(email, resetPasswordLink);
            // enviar email


            model.addAttribute("message", "Hemos enviado a tu correo el enlace para restablecer tu contraseña. Por favor revisa.");

        } catch (UsuarioNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        } catch (UnsupportedEncodingException | MessagingException e) {
            model.addAttribute("error", "Error mientras se enviaba el correo.");
        }

        model.addAttribute("pageTitle","Forgot Password");
        return "forgot_password_form";
    }

    private void sendEmail(String email, String resetPasswordLink) throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom("hugo.garciag4@gmail.com", "Arris Soporte");
        helper.setTo(email);

        String subject = "Aqui esta tu enlace para restablecer tu contraseña";

        String content = "<p>Hola,</p>"
                + "<p>Presiona el enlace para restablecer tu contraseña</p>"
                + "<p><b><a href=\"" + resetPasswordLink + "\">Cambiar mi contraseña</a><b></p>"
                + "<p>Haz caso omiso si recuerdas o no deseas cambiar tu contraseña.</p>";

        helper.setSubject(subject);
        helper.setText(content, true);

        mailSender.send(message);
    }

    @GetMapping("/reset_password")
    public String showResetPasswordForm(@Param(value = "token") String token, Model model){

        Usuario usuario = usuarioServiceImp.get(token);
        if(usuario == null){
            model.addAttribute("title","Reset your password");
            model.addAttribute("message","Invalid Token");
            return "message";
        }

        model.addAttribute("token", token);
        model.addAttribute("pageTitle","Reset your Password");
        return "reset_password_form";
    }

    @PostMapping("/reset_password")
    public String processResetPassword(HttpServletRequest request, Model model) {
        String token = request.getParameter("token");
        String password = request.getParameter("password");

        Usuario usuario = usuarioServiceImp.get(token);
        model.addAttribute("title", "Reset your password");

        if (usuario == null) {
            model.addAttribute("message", "Invalid Token");
            return "message";
        } else {
            usuarioServiceImp.updatePassword(usuario, password);

            model.addAttribute("message", "se ha cambia tu contraseña satisfactoriamente.");
        }

        return "login";
    }
}
