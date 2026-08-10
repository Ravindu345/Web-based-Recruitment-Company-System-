package com.lankajobshub.model;

public enum JobStatus {
    ACTIVE("Active"),
    CLOSED("Closed"),
    DRAFT("Draft"),
    EXPIRED("Expired"),
    ON_HOLD("On Hold");
    
    private final String displayName;
    
    JobStatus(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}
