package com.lankajobshub.controller;

import com.lankajobshub.model.Job;
import com.lankajobshub.model.JobStatus;
import com.lankajobshub.model.JobType;
import com.lankajobshub.model.ExperienceLevel;
import com.lankajobshub.model.User;
import com.lankajobshub.model.UserRole;
import com.lankajobshub.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/jobs")
public class JobController {

    @Autowired
    private JobService jobService;

    @GetMapping
    public String listJobs(Model model, 
                          @RequestParam(required = false) String keyword,
                          @RequestParam(required = false) String location,
                          @RequestParam(required = false) JobType jobType,
                          @RequestParam(required = false) ExperienceLevel experienceLevel) {
        
        List<Job> jobs;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            jobs = jobService.searchJobs(keyword);
        } else if (location != null && !location.trim().isEmpty()) {
            jobs = jobService.findByLocation(location);
        } else if (jobType != null) {
            jobs = jobService.findByJobType(jobType);
        } else if (experienceLevel != null) {
            jobs = jobService.findByExperienceLevel(experienceLevel);
        } else {
            jobs = jobService.findAllActiveJobs();
        }
        
        model.addAttribute("jobs", jobs);
        model.addAttribute("jobTypes", JobType.values());
        model.addAttribute("experienceLevels", ExperienceLevel.values());
        model.addAttribute("keyword", keyword);
        model.addAttribute("location", location);
        model.addAttribute("selectedJobType", jobType);
        model.addAttribute("selectedExperienceLevel", experienceLevel);
        
        return "job/list";
    }

    @GetMapping("/{id}")
    public String viewJob(@PathVariable Long id, Model model) {
        jobService.findById(id).ifPresent(job -> {
            model.addAttribute("job", job);
        });
        return "job/view";
    }

    @GetMapping("/post")
    public String showPostJobForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }
        
        model.addAttribute("job", new Job());
        model.addAttribute("jobTypes", JobType.values());
        model.addAttribute("experienceLevels", ExperienceLevel.values());
        return "job/post";
    }

    @PostMapping("/post")
    public String postJob(@ModelAttribute Job job, 
                         HttpSession session,
                         RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/users/login";
            }

            Job postedJob = jobService.createJob(job, user.getId());
            redirectAttributes.addFlashAttribute("success", "Job posted successfully!");
            return "redirect:/jobs/" + postedJob.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to post job: " + e.getMessage());
            return "redirect:/jobs/post";
        }
    }

    @GetMapping("/{id}/edit")
    public String showEditJobForm(@PathVariable Long id, 
                                 HttpSession session, 
                                 Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }

        jobService.findById(id).ifPresent(job -> {
            // Check if user is the one who posted the job or is admin
            if (job.getPostedBy().getId().equals(user.getId()) || user.getRole() == UserRole.ADMIN) {
                model.addAttribute("job", job);
                model.addAttribute("jobTypes", JobType.values());
                model.addAttribute("experienceLevels", ExperienceLevel.values());
            }
        });
        
        return "job/edit";
    }

    @PostMapping("/{id}/edit")
    public String updateJob(@PathVariable Long id, 
                           @ModelAttribute Job job,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/users/login";
            }

            job.setId(id);
            Job updatedJob = jobService.updateJob(job);
            redirectAttributes.addFlashAttribute("success", "Job updated successfully!");
            return "redirect:/jobs/" + updatedJob.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update job: " + e.getMessage());
            return "redirect:/jobs/" + id + "/edit";
        }
    }

    @PostMapping("/{id}/delete")
    public String deleteJob(@PathVariable Long id, 
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/users/login";
            }

            jobService.deleteJob(id);
            redirectAttributes.addFlashAttribute("success", "Job deleted successfully");
            return "redirect:/jobs";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete job: " + e.getMessage());
            return "redirect:/jobs/" + id;
        }
    }

    @PostMapping("/{id}/status")
    public String changeJobStatus(@PathVariable Long id, 
                                 @RequestParam JobStatus status,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/users/login";
            }

            jobService.changeJobStatus(id, status);
            redirectAttributes.addFlashAttribute("success", "Job status updated successfully");
            return "redirect:/jobs/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update job status: " + e.getMessage());
            return "redirect:/jobs/" + id;
        }
    }

    @GetMapping("/my-jobs")
    public String showMyJobs(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }

        List<Job> myJobs = jobService.findByPostedBy(user.getId());
        model.addAttribute("jobs", myJobs);
        return "job/my-jobs";
    }
}
