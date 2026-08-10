package com.lankajobshub.repository;

import com.lankajobshub.model.JobApplication;
import com.lankajobshub.model.ApplicationStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JobApplicationRepository extends JpaRepository<JobApplication, Long> {
    
    @Query("SELECT ja FROM JobApplication ja WHERE ja.job.id = :jobId AND ja.isActive = true")
    List<JobApplication> findByJobId(@Param("jobId") Long jobId);
    
    @Query("SELECT ja FROM JobApplication ja WHERE ja.applicant.id = :applicantId AND ja.isActive = true")
    List<JobApplication> findByApplicantId(@Param("applicantId") Long applicantId);
    
    @Query("SELECT ja FROM JobApplication ja WHERE ja.job.company.id = :companyId AND ja.isActive = true")
    List<JobApplication> findByCompanyId(@Param("companyId") Long companyId);
    
    @Query("SELECT ja FROM JobApplication ja WHERE ja.status = :status AND ja.isActive = true")
    List<JobApplication> findByStatus(@Param("status") ApplicationStatus status);
    
    @Query("SELECT ja FROM JobApplication ja WHERE ja.job.id = :jobId AND ja.status = :status AND ja.isActive = true")
    List<JobApplication> findByJobIdAndStatus(@Param("jobId") Long jobId, @Param("status") ApplicationStatus status);
    
    @Query("SELECT ja FROM JobApplication ja WHERE ja.applicant.id = :applicantId AND ja.status = :status AND ja.isActive = true")
    List<JobApplication> findByApplicantIdAndStatus(@Param("applicantId") Long applicantId, @Param("status") ApplicationStatus status);
    
    @Query("SELECT ja FROM JobApplication ja WHERE ja.job.id = :jobId AND ja.applicant.id = :applicantId AND ja.isActive = true")
    JobApplication findByJobIdAndApplicantId(@Param("jobId") Long jobId, @Param("applicantId") Long applicantId);
    
    @Query("SELECT COUNT(ja) FROM JobApplication ja WHERE ja.job.id = :jobId AND ja.isActive = true")
    Long countByJobId(@Param("jobId") Long jobId);
    
    @Query("SELECT COUNT(ja) FROM JobApplication ja WHERE ja.job.id = :jobId AND ja.status = :status AND ja.isActive = true")
    Long countByJobIdAndStatus(@Param("jobId") Long jobId, @Param("status") ApplicationStatus status);
}
