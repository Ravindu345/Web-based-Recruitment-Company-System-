package com.lankajobshub.service;

import com.lankajobshub.model.JobApplication;
import com.lankajobshub.model.ApplicationStatus;
import com.lankajobshub.model.Job;
import com.lankajobshub.model.User;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class JobApplicationService {

    @Autowired
    private UserService userService;

    @Autowired
    private JobService jobService;

    // Temporary in-memory storage until database is enabled
    private static final List<JobApplication> applications = new java.util.ArrayList<>();

    // Note: Sample applications are seeded lazily in findByApplicantId to avoid circular init issues.
    // See seedSampleApplicationsIfEmpty() below.
    private static boolean seeded = false;

    private void seedSampleApplicationsIfEmpty() {
        if (seeded) return;
        seeded = true;
        try {
            // Application 1 – Kasun Perera applied for Senior Software Engineer (PENDING)
            com.lankajobshub.model.Job job1 = jobService.findById(1L).orElse(null);
            com.lankajobshub.model.User seeker1 = userService.findById(4L).orElse(null);
            if (job1 != null && seeker1 != null) {
                JobApplication a1 = new JobApplication();
                a1.setId(1L);
                a1.setJob(job1);
                a1.setApplicant(seeker1);
                a1.setCoverLetter("I am a passionate Java developer with 5 years of experience at WSO2. I have built scalable microservices and led teams of 4 engineers. I am excited about the opportunity to join Dialog Axiata and contribute to Sri Lanka's leading telecom provider.");
                a1.setAdditionalNotes("Available to start within 2 weeks. Open to relocation.");
                a1.setAppliedDate(LocalDateTime.now().minusDays(2));
                a1.setStatus(ApplicationStatus.PENDING);
                a1.setActive(true);
                applications.add(a1);
            }

            // Application 2 – Kasun Perera applied for React Frontend Developer (REVIEWED)
            com.lankajobshub.model.Job job6 = jobService.findById(6L).orElse(null);
            if (job6 != null && seeker1 != null) {
                JobApplication a2 = new JobApplication();
                a2.setId(2L);
                a2.setJob(job6);
                a2.setApplicant(seeker1);
                a2.setCoverLetter("Although my primary background is backend Java, I have been building React frontends for the past 2 years. My portfolio includes a logistics dashboard and an e-commerce platform. I am excited about this opportunity at IFS.");
                a2.setAppliedDate(LocalDateTime.now().minusDays(5));
                a2.setReviewedDate(LocalDateTime.now().minusDays(3));
                a2.setStatus(ApplicationStatus.REVIEWING);
                a2.setActive(true);
                applications.add(a2);
            }

            // Application 3 – Nimasha Silva applied for Digital Marketing Manager (SHORTLISTED)
            com.lankajobshub.model.Job job2 = jobService.findById(2L).orElse(null);
            com.lankajobshub.model.User seeker2 = userService.findById(5L).orElse(null);
            if (job2 != null && seeker2 != null) {
                JobApplication a3 = new JobApplication();
                a3.setId(3L);
                a3.setJob(job2);
                a3.setApplicant(seeker2);
                a3.setCoverLetter("I have 6 years of digital marketing experience, having managed campaigns for brands like Nestlé and Unilever across South Asia. My SEO-led strategy increased organic traffic by 340% at my current employer. I am thrilled to apply for the JKH Digital Marketing Manager role.");
                a3.setAppliedDate(LocalDateTime.now().minusDays(4));
                a3.setReviewedDate(LocalDateTime.now().minusDays(2));
                a3.setStatus(ApplicationStatus.SHORTLISTED);
                a3.setActive(true);
                applications.add(a3);
            }

            // Application 4 – Nimasha Silva applied for Data Analyst (REJECTED)
            com.lankajobshub.model.Job job4 = jobService.findById(4L).orElse(null);
            if (job4 != null && seeker2 != null) {
                JobApplication a4 = new JobApplication();
                a4.setId(4L);
                a4.setJob(job4);
                a4.setApplicant(seeker2);
                a4.setCoverLetter("I am transitioning into data analytics from a marketing background. I have completed an online Data Science certification and am proficient in Power BI and basic SQL.");
                a4.setAppliedDate(LocalDateTime.now().minusDays(7));
                a4.setReviewedDate(LocalDateTime.now().minusDays(5));
                a4.setStatus(ApplicationStatus.REJECTED);
                a4.setRejectionReason("Candidate does not meet the minimum 2 years data analysis experience requirement.");
                a4.setActive(true);
                applications.add(a4);
            }

            // Application 5 – Kasun Perera applied for DevOps Engineer (WITHDRAWN)
            com.lankajobshub.model.Job job10 = jobService.findById(10L).orElse(null);
            if (job10 != null && seeker1 != null) {
                JobApplication a5 = new JobApplication();
                a5.setId(5L);
                a5.setJob(job10);
                a5.setApplicant(seeker1);
                a5.setCoverLetter("I have been managing AWS infrastructure for 3 years and have strong Kubernetes and Terraform skills. Sysco LABS is a company I have admired for its engineering culture.");
                a5.setAppliedDate(LocalDateTime.now().minusDays(1));
                a5.setStatus(ApplicationStatus.WITHDRAWN);
                a5.setActive(false);
                applications.add(a5);
            }
        } catch (Exception ignored) {}
    }

    public JobApplication applyForJob(Long jobId, Long applicantId, String coverLetter, String additionalNotes) {
        // Check if job exists
        Optional<Job> job = jobService.findById(jobId);
        if (job.isEmpty()) {
            throw new RuntimeException("Job not found with id: " + jobId);
        }

        // Check if applicant exists
        Optional<User> applicant = userService.findById(applicantId);
        if (applicant.isEmpty()) {
            throw new RuntimeException("Applicant not found with id: " + applicantId);
        }

        // Check if already applied
        if (hasAlreadyApplied(jobId, applicantId)) {
            throw new RuntimeException("You have already applied for this job");
        }

        JobApplication application = new JobApplication();
        application.setId(generateId());
        application.setJob(job.get());
        application.setApplicant(applicant.get());
        application.setCoverLetter(coverLetter);
        application.setAdditionalNotes(additionalNotes);
        application.setAppliedDate(LocalDateTime.now());
        application.setStatus(ApplicationStatus.PENDING);
        application.setActive(true);

        applications.add(application);
        return application;
    }

    public Optional<JobApplication> findById(Long id) {
        return applications.stream()
                .filter(app -> app.getId().equals(id))
                .findFirst();
    }

    public List<JobApplication> findByJobId(Long jobId) {
        seedSampleApplicationsIfEmpty();
        return applications.stream()
                .filter(app -> app.getJob().getId().equals(jobId) && app.isActive())
                .collect(Collectors.toList());
    }

    public List<JobApplication> findByApplicantId(Long applicantId) {
        seedSampleApplicationsIfEmpty();
        return applications.stream()
                .filter(app -> app.getApplicant().getId().equals(applicantId) && app.isActive())
                .collect(Collectors.toList());
    }

    public List<JobApplication> findByCompanyId(Long companyId) {
        return applications.stream()
                .filter(app -> app.getJob().getCompany() != null && 
                              app.getJob().getCompany().getId().equals(companyId) && 
                              app.isActive())
                .collect(Collectors.toList());
    }

    public List<JobApplication> findByStatus(ApplicationStatus status) {
        return applications.stream()
                .filter(app -> app.getStatus() == status && app.isActive())
                .collect(Collectors.toList());
    }

    public List<JobApplication> findByJobIdAndStatus(Long jobId, ApplicationStatus status) {
        return applications.stream()
                .filter(app -> app.getJob().getId().equals(jobId) && 
                              app.getStatus() == status && 
                              app.isActive())
                .collect(Collectors.toList());
    }

    public List<JobApplication> findByApplicantIdAndStatus(Long applicantId, ApplicationStatus status) {
        return applications.stream()
                .filter(app -> app.getApplicant().getId().equals(applicantId) && 
                              app.getStatus() == status && 
                              app.isActive())
                .collect(Collectors.toList());
    }

    public JobApplication updateApplicationStatus(Long applicationId, ApplicationStatus status, Long reviewedById, String rejectionReason) {
        Optional<JobApplication> application = findById(applicationId);
        if (application.isPresent()) {
            JobApplication app = application.get();
            app.setStatus(status);
            app.setReviewedDate(LocalDateTime.now());
            
            if (reviewedById != null) {
                Optional<User> reviewer = userService.findById(reviewedById);
                reviewer.ifPresent(app::setReviewedBy);
            }
            
            if (status == ApplicationStatus.REJECTED && rejectionReason != null) {
                app.setRejectionReason(rejectionReason);
            }
            
            return app;
        }
        throw new RuntimeException("Application not found with id: " + applicationId);
    }

    public boolean hasAlreadyApplied(Long jobId, Long applicantId) {
        return applications.stream()
                .anyMatch(app -> app.getJob().getId().equals(jobId) && 
                               app.getApplicant().getId().equals(applicantId) && 
                               app.isActive());
    }

    public Long countApplicationsByJobId(Long jobId) {
        return applications.stream()
                .filter(app -> app.getJob().getId().equals(jobId) && app.isActive())
                .count();
    }

    public Long countApplicationsByJobIdAndStatus(Long jobId, ApplicationStatus status) {
        return applications.stream()
                .filter(app -> app.getJob().getId().equals(jobId) && 
                              app.getStatus() == status && 
                              app.isActive())
                .count();
    }

    public boolean withdrawApplication(Long applicationId, Long applicantId) {
        Optional<JobApplication> application = findById(applicationId);
        if (application.isPresent() && application.get().getApplicant().getId().equals(applicantId)) {
            application.get().setStatus(ApplicationStatus.WITHDRAWN);
            return true;
        }
        return false;
    }

    private Long generateId() {
        return applications.stream()
                .mapToLong(JobApplication::getId)
                .max()
                .orElse(0) + 1;
    }
}
