package com.lankajobshub.service;

import com.lankajobshub.model.Job;
import com.lankajobshub.model.JobStatus;
import com.lankajobshub.model.JobType;
import com.lankajobshub.model.ExperienceLevel;
import com.lankajobshub.model.User;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class JobService {

    @Autowired
    private UserService userService;

    // Temporary in-memory storage until database is enabled
    private static final List<Job> jobs = new java.util.ArrayList<>();

    static {
        // ── Job 1: Software Developer ────────────────────────────────────────
        Job j1 = new Job();
        j1.setId(1L);
        j1.setTitle("Senior Software Engineer");
        j1.setDescription("Dialog Axiata PLC is seeking a Senior Software Engineer to design, develop, and maintain scalable enterprise-grade applications. You will be part of a high-performing agile team delivering innovative digital products to millions of Sri Lankan users.");
        j1.setRequirements("• BSc in Computer Science or related field\n• 4+ years Java/Spring Boot experience\n• Strong knowledge of REST APIs, Microservices\n• Proficiency in SQL & NoSQL databases\n• Experience with CI/CD pipelines (Jenkins, GitLab)");
        j1.setResponsibilities("• Architect and develop high-performance backend services\n• Lead code reviews and mentor junior developers\n• Collaborate with product and UX teams\n• Ensure 99.9% uptime for critical systems\n• Write technical documentation");
        j1.setJobType(JobType.FULL_TIME);
        j1.setExperienceLevel(ExperienceLevel.SENIOR);
        j1.setSalaryMin(new java.math.BigDecimal("180000"));
        j1.setSalaryMax(new java.math.BigDecimal("280000"));
        j1.setLocation("Colombo 03, Sri Lanka");
        j1.setIndustry("Telecommunications / Technology");
        j1.setStatus(JobStatus.ACTIVE);
        j1.setPostedDate(LocalDateTime.now().minusDays(2));
        j1.setDeadline(LocalDateTime.now().plusDays(28));
        j1.setActive(true);
        jobs.add(j1);

        // ── Job 2: Marketing Manager ──────────────────────────────────────────
        Job j2 = new Job();
        j2.setId(2L);
        j2.setTitle("Digital Marketing Manager");
        j2.setDescription("John Keells Holdings is looking for a creative and data-driven Digital Marketing Manager to lead our online marketing strategies across all brands. You will drive brand awareness, customer acquisition and retention through digital channels.");
        j2.setRequirements("• Degree in Marketing, Business or related field\n• 5+ years digital marketing experience\n• Expertise in SEO, SEM, Social Media & Email Marketing\n• Google Analytics, Meta Ads Manager proficiency\n• Strong analytical and copywriting skills");
        j2.setResponsibilities("• Develop and execute integrated digital marketing campaigns\n• Manage marketing budgets and optimize ROI\n• Oversee social media presence across platforms\n• Analyze campaign performance and report to senior management\n• Collaborate with agency partners and creative teams");
        j2.setJobType(JobType.FULL_TIME);
        j2.setExperienceLevel(ExperienceLevel.MANAGER);
        j2.setSalaryMin(new java.math.BigDecimal("150000"));
        j2.setSalaryMax(new java.math.BigDecimal("220000"));
        j2.setLocation("Colombo 02, Sri Lanka");
        j2.setIndustry("FMCG / Retail");
        j2.setStatus(JobStatus.ACTIVE);
        j2.setPostedDate(LocalDateTime.now().minusDays(5));
        j2.setDeadline(LocalDateTime.now().plusDays(21));
        j2.setActive(true);
        jobs.add(j2);

        // ── Job 3: UI/UX Designer ─────────────────────────────────────────────
        Job j3 = new Job();
        j3.setId(3L);
        j3.setTitle("UI/UX Designer");
        j3.setDescription("WSO2 is hiring a passionate UI/UX Designer to craft intuitive and beautiful user experiences for our enterprise software products used globally. You will work in a fast-paced environment where your designs directly impact thousands of developers worldwide.");
        j3.setRequirements("• Degree in Design, HCI or equivalent\n• 3+ years UI/UX design experience\n• Mastery of Figma, Adobe XD or Sketch\n• Portfolio demonstrating web & mobile design\n• Understanding of accessibility standards (WCAG)");
        j3.setResponsibilities("• Create wireframes, prototypes and high-fidelity mockups\n• Conduct user research and usability testing\n• Maintain and evolve our design system\n• Collaborate closely with engineering teams\n• Present designs to stakeholders");
        j3.setJobType(JobType.FULL_TIME);
        j3.setExperienceLevel(ExperienceLevel.MID_LEVEL);
        j3.setSalaryMin(new java.math.BigDecimal("100000"));
        j3.setSalaryMax(new java.math.BigDecimal("160000"));
        j3.setLocation("Colombo 01, Sri Lanka");
        j3.setIndustry("Software / Technology");
        j3.setStatus(JobStatus.ACTIVE);
        j3.setPostedDate(LocalDateTime.now().minusDays(3));
        j3.setDeadline(LocalDateTime.now().plusDays(25));
        j3.setActive(true);
        jobs.add(j3);

        // ── Job 4: Data Analyst ───────────────────────────────────────────────
        Job j4 = new Job();
        j4.setId(4L);
        j4.setTitle("Data Analyst");
        j4.setDescription("Commercial Bank of Ceylon is looking for a Data Analyst to join our Business Intelligence team. You will turn complex financial data into actionable insights that shape strategic decisions across the bank.");
        j4.setRequirements("• BSc in Statistics, Mathematics or Computer Science\n• 2+ years data analysis experience\n• Proficiency in SQL, Python or R\n• Experience with Power BI or Tableau\n• Strong understanding of banking/financial data");
        j4.setResponsibilities("• Collect, clean and analyse large datasets\n• Build interactive dashboards and reports\n• Identify trends and present insights to management\n• Support data governance initiatives\n• Collaborate with IT and business units");
        j4.setJobType(JobType.FULL_TIME);
        j4.setExperienceLevel(ExperienceLevel.JUNIOR);
        j4.setSalaryMin(new java.math.BigDecimal("70000"));
        j4.setSalaryMax(new java.math.BigDecimal("110000"));
        j4.setLocation("Colombo 07, Sri Lanka");
        j4.setIndustry("Banking & Finance");
        j4.setStatus(JobStatus.ACTIVE);
        j4.setPostedDate(LocalDateTime.now().minusDays(7));
        j4.setDeadline(LocalDateTime.now().plusDays(14));
        j4.setActive(true);
        jobs.add(j4);

        // ── Job 5: HR Business Partner ────────────────────────────────────────
        Job j5 = new Job();
        j5.setId(5L);
        j5.setTitle("HR Business Partner");
        j5.setDescription("Hemas Holdings PLC is seeking an experienced HR Business Partner to align human resources practices with business objectives. You will serve as a strategic partner to department heads, driving talent management and organizational development initiatives.");
        j5.setRequirements("• Degree in HRM or Business Administration\n• 5+ years HR experience in a corporate environment\n• Strong knowledge of Sri Lankan Labour Law\n• Experience with HRIS systems\n• Excellent interpersonal and coaching skills");
        j5.setResponsibilities("• Partner with business leaders on workforce planning\n• Lead recruitment drives for key positions\n• Manage employee relations and conflict resolution\n• Drive performance management cycles\n• Develop and deliver HR training programs");
        j5.setJobType(JobType.FULL_TIME);
        j5.setExperienceLevel(ExperienceLevel.SENIOR);
        j5.setSalaryMin(new java.math.BigDecimal("130000"));
        j5.setSalaryMax(new java.math.BigDecimal("190000"));
        j5.setLocation("Wattala, Sri Lanka");
        j5.setIndustry("FMCG / Healthcare");
        j5.setStatus(JobStatus.ACTIVE);
        j5.setPostedDate(LocalDateTime.now().minusDays(4));
        j5.setDeadline(LocalDateTime.now().plusDays(20));
        j5.setActive(true);
        jobs.add(j5);

        // ── Job 6: Frontend Developer (React) ────────────────────────────────
        Job j6 = new Job();
        j6.setId(6L);
        j6.setTitle("React.js Frontend Developer");
        j6.setDescription("IFS R&D International is looking for a talented React.js Frontend Developer to build cutting-edge enterprise software interfaces. You will work on globally distributed projects, collaborating with teams across Sweden, UK and Sri Lanka.");
        j6.setRequirements("• 2+ years React.js experience\n• Proficiency in HTML5, CSS3, TypeScript\n• Experience with Redux or Zustand\n• Familiarity with REST APIs and GraphQL\n• Knowledge of testing frameworks (Jest, Cypress)");
        j6.setResponsibilities("• Develop responsive, high-performance web UIs\n• Translate UX designs into pixel-perfect code\n• Write unit and integration tests\n• Participate in agile ceremonies\n• Conduct peer code reviews");
        j6.setJobType(JobType.FULL_TIME);
        j6.setExperienceLevel(ExperienceLevel.MID_LEVEL);
        j6.setSalaryMin(new java.math.BigDecimal("120000"));
        j6.setSalaryMax(new java.math.BigDecimal("200000"));
        j6.setLocation("Colombo 03, Sri Lanka");
        j6.setIndustry("Enterprise Software");
        j6.setStatus(JobStatus.ACTIVE);
        j6.setPostedDate(LocalDateTime.now().minusDays(1));
        j6.setDeadline(LocalDateTime.now().plusDays(30));
        j6.setActive(true);
        jobs.add(j6);

        // ── Job 7: Civil Engineer ─────────────────────────────────────────────
        Job j7 = new Job();
        j7.setId(7L);
        j7.setTitle("Civil Engineer – Infrastructure");
        j7.setDescription("Maga Engineering (Pvt) Ltd is seeking a skilled Civil Engineer to oversee road and bridge construction projects across Sri Lanka. This is a challenging and rewarding role for someone passionate about nation-building infrastructure.");
        j7.setRequirements("• BSc (Hons) in Civil Engineering\n• Registered with IESL (or eligible)\n• 3+ years site experience in infrastructure projects\n• Proficiency in AutoCAD, STAAD Pro\n• Strong project management skills");
        j7.setResponsibilities("• Supervise construction activities on-site\n• Prepare engineering drawings and BOQs\n• Liaise with government authorities and clients\n• Ensure compliance with safety standards\n• Prepare progress reports for project managers");
        j7.setJobType(JobType.FULL_TIME);
        j7.setExperienceLevel(ExperienceLevel.MID_LEVEL);
        j7.setSalaryMin(new java.math.BigDecimal("90000"));
        j7.setSalaryMax(new java.math.BigDecimal("140000"));
        j7.setLocation("Kandy, Sri Lanka");
        j7.setIndustry("Construction & Engineering");
        j7.setStatus(JobStatus.ACTIVE);
        j7.setPostedDate(LocalDateTime.now().minusDays(10));
        j7.setDeadline(LocalDateTime.now().plusDays(18));
        j7.setActive(true);
        jobs.add(j7);

        // ── Job 8: Business Development Executive ─────────────────────────────
        Job j8 = new Job();
        j8.setId(8L);
        j8.setTitle("Business Development Executive");
        j8.setDescription("MAS Holdings is looking for an energetic Business Development Executive to identify new market opportunities and grow revenue across our apparel manufacturing divisions. You will be the driving force behind strategic partnerships and client relationships.");
        j8.setRequirements("• Degree in Business or Marketing\n• 2+ years B2B sales or BDE experience\n• Excellent negotiation and presentation skills\n• Willingness to travel locally and internationally\n• Experience in the apparel or manufacturing sector is a plus");
        j8.setResponsibilities("• Identify and pursue new business opportunities\n• Develop and maintain relationships with key clients\n• Prepare proposals, tenders and contract negotiations\n• Achieve monthly and quarterly revenue targets\n• Report pipeline activities to the Sales Director");
        j8.setJobType(JobType.FULL_TIME);
        j8.setExperienceLevel(ExperienceLevel.JUNIOR);
        j8.setSalaryMin(new java.math.BigDecimal("60000"));
        j8.setSalaryMax(new java.math.BigDecimal("90000"));
        j8.setLocation("Gampaha, Sri Lanka");
        j8.setIndustry("Manufacturing / Apparel");
        j8.setStatus(JobStatus.ACTIVE);
        j8.setPostedDate(LocalDateTime.now().minusDays(6));
        j8.setDeadline(LocalDateTime.now().plusDays(22));
        j8.setActive(true);
        jobs.add(j8);

        // ── Job 9: Graphic Designer (Part-Time) ──────────────────────────────
        Job j9 = new Job();
        j9.setId(9L);
        j9.setTitle("Graphic Designer (Part-Time)");
        j9.setDescription("A fast-growing Colombo-based digital agency is seeking a creative Graphic Designer for part-time engagement. Ideal for a talented individual who can manage multiple brand identities and deliver stunning visual content on tight deadlines.");
        j9.setRequirements("• Diploma or Degree in Graphic Design or Visual Arts\n• 1+ years professional design experience\n• Proficiency in Adobe Photoshop, Illustrator, InDesign\n• Strong portfolio of branding and social media work\n• Ability to work 4 hours/day, 5 days a week");
        j9.setResponsibilities("• Create social media graphics, banners and ads\n• Design brand identity materials (logos, stationery)\n• Produce marketing collateral for clients\n• Manage multiple projects simultaneously\n• Liaise with clients on design revisions");
        j9.setJobType(JobType.PART_TIME);
        j9.setExperienceLevel(ExperienceLevel.ENTRY_LEVEL);
        j9.setSalaryMin(new java.math.BigDecimal("30000"));
        j9.setSalaryMax(new java.math.BigDecimal("50000"));
        j9.setLocation("Nugegoda, Sri Lanka");
        j9.setIndustry("Creative & Design");
        j9.setStatus(JobStatus.ACTIVE);
        j9.setPostedDate(LocalDateTime.now().minusDays(8));
        j9.setDeadline(LocalDateTime.now().plusDays(15));
        j9.setActive(true);
        jobs.add(j9);

        // ── Job 10: DevOps Engineer ──────────────────────────────────────────
        Job j10 = new Job();
        j10.setId(10L);
        j10.setTitle("DevOps / Cloud Engineer");
        j10.setDescription("Sysco LABS Sri Lanka is hiring a DevOps Engineer to join our Platform Engineering team. You will be responsible for building and maintaining the cloud infrastructure that powers Sysco's global food service supply chain technology.");
        j10.setRequirements("• 3+ years DevOps/Cloud engineering experience\n• Strong knowledge of AWS or Azure\n• Proficiency in Docker, Kubernetes, Terraform\n• Experience with CI/CD tools (Jenkins, GitHub Actions)\n• Linux system administration skills");
        j10.setResponsibilities("• Design, deploy and manage cloud infrastructure\n• Implement and maintain CI/CD pipelines\n• Monitor system performance and respond to incidents\n• Automate operational tasks with scripting\n• Champion security and compliance best practices");
        j10.setJobType(JobType.FULL_TIME);
        j10.setExperienceLevel(ExperienceLevel.SENIOR);
        j10.setSalaryMin(new java.math.BigDecimal("200000"));
        j10.setSalaryMax(new java.math.BigDecimal("320000"));
        j10.setLocation("Colombo 05, Sri Lanka");
        j10.setIndustry("Technology / Cloud");
        j10.setStatus(JobStatus.ACTIVE);
        j10.setPostedDate(LocalDateTime.now().minusDays(0));
        j10.setDeadline(LocalDateTime.now().plusDays(30));
        j10.setActive(true);
        jobs.add(j10);
    }

    public Job createJob(Job job, Long postedByUserId) {
        Optional<User> user = userService.findById(postedByUserId);
        if (user.isEmpty()) {
            throw new RuntimeException("User not found with id: " + postedByUserId);
        }

        job.setId(generateId());
        job.setPostedBy(user.get());
        job.setStatus(JobStatus.ACTIVE);
        job.setPostedDate(LocalDateTime.now());
        job.setActive(true);

        jobs.add(job);
        return job;
    }

    public Optional<Job> findById(Long id) {
        return jobs.stream()
                .filter(job -> job.getId().equals(id))
                .findFirst();
    }

    public List<Job> findAllActiveJobs() {
        return jobs.stream()
                .filter(job -> job.isActive() && job.getStatus() == JobStatus.ACTIVE)
                .collect(Collectors.toList());
    }

    public List<Job> findByCompany(Long companyId) {
        return jobs.stream()
                .filter(job -> job.getCompany() != null && 
                              job.getCompany().getId().equals(companyId) && 
                              job.isActive())
                .collect(Collectors.toList());
    }

    public List<Job> findByPostedBy(Long userId) {
        return jobs.stream()
                .filter(job -> job.getPostedBy() != null && 
                              job.getPostedBy().getId().equals(userId) && 
                              job.isActive())
                .collect(Collectors.toList());
    }

    public List<Job> findByJobType(JobType jobType) {
        return jobs.stream()
                .filter(job -> job.getJobType() == jobType && 
                              job.isActive() && 
                              job.getStatus() == JobStatus.ACTIVE)
                .collect(Collectors.toList());
    }

    public List<Job> findByExperienceLevel(ExperienceLevel level) {
        return jobs.stream()
                .filter(job -> job.getExperienceLevel() == level && 
                              job.isActive() && 
                              job.getStatus() == JobStatus.ACTIVE)
                .collect(Collectors.toList());
    }

    public List<Job> findByLocation(String location) {
        return jobs.stream()
                .filter(job -> job.getLocation() != null && 
                              job.getLocation().toLowerCase().contains(location.toLowerCase()) && 
                              job.isActive() && 
                              job.getStatus() == JobStatus.ACTIVE)
                .collect(Collectors.toList());
    }

    public List<Job> findByIndustry(String industry) {
        return jobs.stream()
                .filter(job -> job.getIndustry() != null && 
                              job.getIndustry().toLowerCase().contains(industry.toLowerCase()) && 
                              job.isActive() && 
                              job.getStatus() == JobStatus.ACTIVE)
                .collect(Collectors.toList());
    }

    public List<Job> searchJobs(String keyword) {
        return jobs.stream()
                .filter(job -> (job.getTitle() != null && job.getTitle().toLowerCase().contains(keyword.toLowerCase())) ||
                              (job.getDescription() != null && job.getDescription().toLowerCase().contains(keyword.toLowerCase())) ||
                              (job.getRequirements() != null && job.getRequirements().toLowerCase().contains(keyword.toLowerCase())) &&
                              job.isActive() && 
                              job.getStatus() == JobStatus.ACTIVE)
                .collect(Collectors.toList());
    }

    public Job updateJob(Job job) {
        Optional<Job> existingJob = findById(job.getId());
        if (existingJob.isPresent()) {
            Job existing = existingJob.get();
            existing.setTitle(job.getTitle());
            existing.setDescription(job.getDescription());
            existing.setRequirements(job.getRequirements());
            existing.setResponsibilities(job.getResponsibilities());
            existing.setJobType(job.getJobType());
            existing.setExperienceLevel(job.getExperienceLevel());
            existing.setSalaryMin(job.getSalaryMin());
            existing.setSalaryMax(job.getSalaryMax());
            existing.setLocation(job.getLocation());
            existing.setIndustry(job.getIndustry());
            existing.setDeadline(job.getDeadline());
            return existing;
        }
        throw new RuntimeException("Job not found with id: " + job.getId());
    }

    public boolean deleteJob(Long id) {
        return jobs.removeIf(job -> job.getId().equals(id));
    }

    public Job changeJobStatus(Long jobId, JobStatus status) {
        Optional<Job> job = findById(jobId);
        if (job.isPresent()) {
            job.get().setStatus(status);
            return job.get();
        }
        throw new RuntimeException("Job not found with id: " + jobId);
    }

    private Long generateId() {
        return jobs.stream()
                .mapToLong(Job::getId)
                .max()
                .orElse(0) + 1;
    }
}
