package com.lankajobshub.repository;

import com.lankajobshub.model.Company;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CompanyRepository extends JpaRepository<Company, Long> {
    
    Optional<Company> findByName(String name);
    
    boolean existsByName(String name);
    
    @Query("SELECT c FROM Company c WHERE c.isActive = true")
    List<Company> findActiveCompanies();
    
    @Query("SELECT c FROM Company c WHERE c.name LIKE %:name% OR c.description LIKE %:description%")
    List<Company> searchCompanies(@Param("name") String name, @Param("description") String description);
    
    @Query("SELECT c FROM Company c WHERE c.industry LIKE %:industry%")
    List<Company> findByIndustry(@Param("industry") String industry);
}
