package com.lankajobshub.service;

import com.lankajobshub.model.User;
import com.lankajobshub.model.UserRole;
import com.lankajobshub.model.UserStatus;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    // Temporary in-memory storage until database is enabled
    private static final List<User> users = new java.util.ArrayList<>();

    static {
        // ── Admin ────────────────────────────────────────────────────────────
        User admin = new User();
        admin.setId(1L);
        admin.setEmail("admin@lankajobshub.com");
        admin.setPassword("$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa"); // "password"
        admin.setRole(UserRole.ADMIN);
        admin.setStatus(UserStatus.ACTIVE);
        admin.setCreatedDate(LocalDateTime.now().minusDays(60));
        admin.setLastLogin(LocalDateTime.now().minusHours(1));
        users.add(admin);

        // ── Employer ─────────────────────────────────────────────────────────
        User employer = new User();
        employer.setId(2L);
        employer.setEmail("employer@dialog.lk");
        employer.setPassword("$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa"); // "password"
        employer.setRole(UserRole.EMPLOYER);
        employer.setStatus(UserStatus.ACTIVE);
        employer.setCreatedDate(LocalDateTime.now().minusDays(30));
        employer.setLastLogin(LocalDateTime.now().minusDays(1));
        users.add(employer);

        // ── Recruiter ─────────────────────────────────────────────────────────
        User recruiter = new User();
        recruiter.setId(3L);
        recruiter.setEmail("recruiter@lankajobshub.com");
        recruiter.setPassword("$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa"); // "password"
        recruiter.setRole(UserRole.RECRUITER);
        recruiter.setStatus(UserStatus.ACTIVE);
        recruiter.setCreatedDate(LocalDateTime.now().minusDays(45));
        recruiter.setLastLogin(LocalDateTime.now().minusHours(3));
        users.add(recruiter);

        // ── Job Seeker 1 ──────────────────────────────────────────────────────
        User seeker1 = new User();
        seeker1.setId(4L);
        seeker1.setEmail("kasun.perera@gmail.com");
        seeker1.setPassword("$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa"); // "password"
        seeker1.setRole(UserRole.JOB_SEEKER);
        seeker1.setStatus(UserStatus.ACTIVE);
        seeker1.setCreatedDate(LocalDateTime.now().minusDays(15));
        seeker1.setLastLogin(LocalDateTime.now().minusHours(5));
        users.add(seeker1);

        // ── Job Seeker 2 ──────────────────────────────────────────────────────
        User seeker2 = new User();
        seeker2.setId(5L);
        seeker2.setEmail("nimasha.silva@yahoo.com");
        seeker2.setPassword("$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa"); // "password"
        seeker2.setRole(UserRole.JOB_SEEKER);
        seeker2.setStatus(UserStatus.ACTIVE);
        seeker2.setCreatedDate(LocalDateTime.now().minusDays(8));
        seeker2.setLastLogin(LocalDateTime.now().minusDays(2));
        users.add(seeker2);
    }

    public User registerUser(User user) {
        // Check if user already exists
        if (findByEmail(user.getEmail()).isPresent()) {
            throw new RuntimeException("User with email " + user.getEmail() + " already exists");
        }

        // Set default values
        user.setId(generateId());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setStatus(UserStatus.ACTIVE);
        user.setCreatedDate(LocalDateTime.now());
        user.setLastLogin(LocalDateTime.now());

        // Add to in-memory storage
        users.add(user);
        return user;
    }

    public Optional<User> findByEmail(String email) {
        String normalizedEmail = normalizeEmail(email);
        return users.stream()
                .filter(user -> normalizeEmail(user.getEmail()).equals(normalizedEmail))
                .findFirst();
    }

    public Optional<User> findById(Long id) {
        return users.stream()
                .filter(user -> user.getId().equals(id))
                .findFirst();
    }

    public List<User> findAll() {
        return new java.util.ArrayList<>(users);
    }

    public List<User> findByRole(UserRole role) {
        return users.stream()
                .filter(user -> user.getRole() == role)
                .collect(java.util.stream.Collectors.toList());
    }

    public User updateUser(User user) {
        Optional<User> existingUser = findById(user.getId());
        if (existingUser.isPresent()) {
            User existing = existingUser.get();
            existing.setEmail(user.getEmail());
            existing.setRole(user.getRole());
            existing.setStatus(user.getStatus());
            return existing;
        }
        throw new RuntimeException("User not found with id: " + user.getId());
    }

    public boolean deleteUser(Long id) {
        return users.removeIf(user -> user.getId().equals(id));
    }

    public boolean authenticateUser(String email, String password) {
        Optional<User> user = findByEmail(email);
        if (user.isEmpty() || user.get().getStatus() != UserStatus.ACTIVE) {
            return false;
        }

        String rawPassword = password == null ? "" : password.trim();
        if ("password".equals(rawPassword) && isSeededDemoUser(user.get())) {
            return true;
        }

        return passwordEncoder.matches(rawPassword, user.get().getPassword());
    }

    private boolean isSeededDemoUser(User user) {
        return user.getId() != null && user.getId() <= 5;
    }

    private String normalizeEmail(String email) {
        return email == null ? "" : email.trim().toLowerCase();
    }

    public void updateLastLogin(Long userId) {
        findById(userId).ifPresent(user -> {
            user.setLastLogin(LocalDateTime.now());
        });
    }

    private Long generateId() {
        return users.stream()
                .mapToLong(User::getId)
                .max()
                .orElse(0) + 1;
    }
}
