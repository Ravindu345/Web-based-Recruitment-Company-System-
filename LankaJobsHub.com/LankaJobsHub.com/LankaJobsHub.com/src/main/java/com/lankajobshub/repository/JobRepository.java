package com.lankajobshub.repository;

import com.lankajobshub.model.Job;
import com.lankajobshub.model.JobStatus;
import com.lankajobshub.model.JobType;
import com.lankajobshub.model.ExperienceLevel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface JobRepository extends JpaRepository<Job, Long> {
    
    @Query("SELECT j FROM Job j WHERE j.isActive = true AND j.status = 'ACTIVE'")
    Page<Job> findActiveJobs(Pageable pageable);
    
    @Query("SELECT j FROM Job j WHERE j.company.id = :companyId AND j.isActive = true")
    List<Job> findByCompanyId(@Param("companyId") Long companyId);
    
    @Query("SELECT j FROM Job j WHERE j.postedBy.id = :userId AND j.isActive = true")
    List<Job> findByPostedBy(@Param("userId") Long userId);
    
    @Query("SELECT j FROM Job j WHERE j.jobType = :jobType AND j.isActive = true AND j.status = 'ACTIVE'")
    List<Job> findByJobType(@Param("jobType") JobType jobType);
    
    @Query("SELECT j FROM Job j WHERE j.experienceLevel = :level AND j.isActive = true AND j.status = 'ACTIVE'")
    List<Job> findByExperienceLevel(@Param("level") ExperienceLevel level);
    
    @Query("SELECT j FROM Job j WHERE j.location LIKE %:location% AND j.isActive = true AND j.status = 'ACTIVE'")
    List<Job> findByLocation(@Param("location") String location);
    
    @Query("SELECT j FROM Job j WHERE j.industry LIKE %:industry% AND j.isActive = true AND j.status = 'ACTIVE'")
    List<Job> findByIndustry(@Param("industry") String industry);
    
    @Query("SELECT j FROM Job j WHERE j.title LIKE %:keyword% OR j.description LIKE %:keyword% OR j.requirements LIKE %:keyword% AND j.isActive = true AND j.status = 'ACTIVE'")
    List<Job> searchJobs(@Param("keyword") String keyword);
    
    @Query("SELECT j FROM Job j WHERE j.deadline > :now AND j.isActive = true AND j.status = 'ACTIVE'")
    List<Job> findJobsNotExpired(@Param("now") LocalDateTime now);
    
    @Query("SELECT j FROM Job j WHERE j.salaryMin >= :minSalary AND j.isActive = true AND j.status = 'ACTIVE'")
    List<Job> findByMinSalary(@Param("minSalary") Double minSalary);
}
