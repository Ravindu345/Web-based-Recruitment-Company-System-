package com.lankajobshub.controller;

import com.lankajobshub.model.User;
import com.lankajobshub.model.UserRole;
import com.lankajobshub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("roles", UserRole.values());
        return "user/register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, 
                              @RequestParam String confirmPassword,
                              RedirectAttributes redirectAttributes) {
        try {
            // Basic validation
            if (!user.getPassword().equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Passwords do not match");
                return "redirect:/users/register";
            }

            if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Email is required");
                return "redirect:/users/register";
            }

            User registeredUser = userService.registerUser(user);
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/users/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/users/register";
        }
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        return "user/login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email, 
                           @RequestParam String password,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        try {
            if (userService.authenticateUser(email, password)) {
                userService.findByEmail(email).ifPresent(user -> {
                    session.setAttribute("user", user);
                    userService.updateLastLogin(user.getId());
                });
                redirectAttributes.addFlashAttribute("success", "Login successful!");
                return "redirect:/dashboard";
            } else {
                redirectAttributes.addFlashAttribute("error", "Invalid email or password");
                return "redirect:/users/login";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Login failed: " + e.getMessage());
            return "redirect:/users/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "Logged out successfully");
        return "redirect:/";
    }

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }
        model.addAttribute("user", user);
        return "user/profile";
    }

    @GetMapping("/profile/edit")
    public String showEditProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("roles", UserRole.values());
        return "user/edit-profile";
    }

    @PostMapping("/profile/edit")
    public String updateProfile(@ModelAttribute User user, 
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                return "redirect:/users/login";
            }

            user.setId(currentUser.getId());
            user.setPassword(currentUser.getPassword()); // Keep existing password
            User updatedUser = userService.updateUser(user);
            session.setAttribute("user", updatedUser);
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
            return "redirect:/users/profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile: " + e.getMessage());
            return "redirect:/users/profile/edit";
        }
    }

    @GetMapping("/admin")
    public String showAdminPanel(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != UserRole.ADMIN) {
            return "redirect:/users/login";
        }
        
        List<User> allUsers = userService.findAll();
        model.addAttribute("users", allUsers);
        return "admin/users";
    }

    @PostMapping("/admin/{id}/delete")
    public String deleteUser(@PathVariable Long id, 
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || currentUser.getRole() != UserRole.ADMIN) {
            return "redirect:/users/login";
        }

        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete user: " + e.getMessage());
        }
        return "redirect:/users/admin";
    }
}
