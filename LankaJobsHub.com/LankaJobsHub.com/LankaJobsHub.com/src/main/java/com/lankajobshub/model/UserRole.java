package com.lankajobshub.model;

public enum UserRole {
    ADMIN("Administrator"),
    EMPLOYER("Employer"),
    JOB_SEEKER("Job Seeker"),
    RECRUITER("Recruiter");
    
    private final String displayName;
    
    UserRole(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}
