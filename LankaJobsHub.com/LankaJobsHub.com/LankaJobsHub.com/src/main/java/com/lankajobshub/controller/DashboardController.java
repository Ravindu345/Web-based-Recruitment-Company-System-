package com.lankajobshub.controller;

import com.lankajobshub.model.User;
import com.lankajobshub.model.UserRole;
import com.lankajobshub.service.JobService;
import com.lankajobshub.service.JobApplicationService;
import com.lankajobshub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class DashboardController {

    @Autowired
    private JobService jobService;

    @Autowired
    private JobApplicationService applicationService;

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }

        model.addAttribute("user", user);

        // Load different data based on user role
        switch (user.getRole()) {
            case ADMIN:
                loadAdminDashboard(model);
                break;
            case RECRUITER:
                loadRecruiterDashboard(model, user);
                break;
            case EMPLOYER:
                loadHiringManagerDashboard(model, user);
                break;
            case JOB_SEEKER:
                loadJobSeekerDashboard(model, user);
                break;
            default:
                loadDefaultDashboard(model);
                break;
        }

        return "dashboard/index";
    }

    private void loadAdminDashboard(Model model) {
        // Admin sees all jobs and applications
        List<com.lankajobshub.model.Job> allJobs = jobService.findAllActiveJobs();
        List<User> allUsers = userService.findAll();
        
        model.addAttribute("totalJobs", allJobs.size());
        model.addAttribute("totalUsers", allUsers.size());
        model.addAttribute("recentJobs", allJobs.stream().limit(5).toList());
        model.addAttribute("recentUsers", allUsers.stream().limit(5).toList());
    }

    private void loadRecruiterDashboard(Model model, User user) {
        // Recruiters see jobs they posted and applications for those jobs
        List<com.lankajobshub.model.Job> myJobs = jobService.findByPostedBy(user.getId());
        
        model.addAttribute("myJobs", myJobs);
        model.addAttribute("totalJobs", myJobs.size());
        
        // Count applications for each job
        myJobs.forEach(job -> {
            Long applicationCount = applicationService.countApplicationsByJobId(job.getId());
            job.setId(applicationCount); // Temporary use of ID field to store count
        });
    }

    private void loadHiringManagerDashboard(Model model, User user) {
        // Hiring managers see jobs for their company
        List<com.lankajobshub.model.Job> companyJobs = jobService.findByPostedBy(user.getId());
        
        model.addAttribute("companyJobs", companyJobs);
        model.addAttribute("totalJobs", companyJobs.size());
    }

    private void loadJobSeekerDashboard(Model model, User user) {
        // Job seekers see available jobs and their applications
        List<com.lankajobshub.model.Job> availableJobs = jobService.findAllActiveJobs();
        List<com.lankajobshub.model.JobApplication> myApplications = applicationService.findByApplicantId(user.getId());
        
        model.addAttribute("availableJobs", availableJobs.stream().limit(10).toList());
        model.addAttribute("myApplications", myApplications);
        model.addAttribute("totalApplications", myApplications.size());
    }

    private void loadDefaultDashboard(Model model) {
        // Default dashboard for other roles
        List<com.lankajobshub.model.Job> recentJobs = jobService.findAllActiveJobs().stream().limit(5).toList();
        model.addAttribute("recentJobs", recentJobs);
    }

    @GetMapping("/")
    public String home(Model model) {
        // Show recent jobs on home page
        List<com.lankajobshub.model.Job> recentJobs = jobService.findAllActiveJobs().stream().limit(6).toList();
        model.addAttribute("recentJobs", recentJobs);
        model.addAttribute("totalJobs", jobService.findAllActiveJobs().size());
        return "home";
    }
}
