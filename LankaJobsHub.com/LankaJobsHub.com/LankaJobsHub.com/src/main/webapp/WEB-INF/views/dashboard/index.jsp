<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - LankaJobsHub</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <!-- Navigation -->
    <nav class="bg-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="/lankajobshub/" class="text-2xl font-bold text-blue-600">LankaJobsHub</a>
                </div>
                <div class="flex items-center space-x-4">
                    <a href="/lankajobshub/jobs" class="text-gray-700 hover:text-blue-600">Browse Jobs</a>
                    <div class="relative">
                        <button class="flex items-center text-gray-700 hover:text-blue-600">
                            <span>${user.email}</span>
                            <svg class="ml-1 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </button>
                    </div>
                    <a href="/lankajobshub/users/logout" class="text-gray-700 hover:text-blue-600">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Welcome Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Welcome back, ${user.email}!</h1>
            <p class="text-gray-600">Here's what's happening with your account.</p>
        </div>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100 text-blue-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2-2v2m8 0V6a2 2 0 012 2v6a2 2 0 01-2 2H8a2 2 0 01-2-2V8a2 2 0 012-2V6"></path>
                        </svg>
                    </div>
                    <div class="ml-4">
                        <p class="text-sm font-medium text-gray-600">Total Jobs</p>
                        <p class="text-2xl font-semibold text-gray-900">${totalJobs}</p>
                    </div>
                </div>
            </div>

            <c:if test="${user.role == 'JOB_SEEKER'}">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-green-100 text-green-600">
                            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">My Applications</p>
                            <p class="text-2xl font-semibold text-gray-900">${totalApplications}</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${user.role == 'ADMIN'}">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-purple-100 text-purple-600">
                            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Total Users</p>
                            <p class="text-2xl font-semibold text-gray-900">${totalUsers}</p>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Role-based Content -->
        <c:choose>
            <c:when test="${user.role == 'ADMIN'}">
                <!-- Admin Dashboard -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Recent Jobs -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Recent Jobs</h3>
                        <div class="space-y-4">
                            <c:forEach items="${recentJobs}" var="job">
                                <div class="border-b border-gray-200 pb-4 last:border-b-0">
                                    <h4 class="font-medium text-gray-900">${job.title}</h4>
                                    <p class="text-sm text-gray-600">${job.location} • ${job.jobType.displayName}</p>
                                    <p class="text-xs text-gray-500">Posted ${job.postedDate}</p>
                                </div>
                            </c:forEach>
                        </div>
                        <a href="/lankajobshub/jobs" class="mt-4 inline-block text-blue-600 hover:text-blue-800">View all jobs →</a>
                    </div>

                    <!-- Recent Users -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Recent Users</h3>
                        <div class="space-y-4">
                            <c:forEach items="${recentUsers}" var="userItem">
                                <div class="border-b border-gray-200 pb-4 last:border-b-0">
                                    <h4 class="font-medium text-gray-900">${userItem.email}</h4>
                                    <p class="text-sm text-gray-600">${userItem.role.displayName}</p>
                                    <p class="text-xs text-gray-500">Joined ${userItem.createdDate}</p>
                                </div>
                            </c:forEach>
                        </div>
                        <a href="/lankajobshub/users/admin" class="mt-4 inline-block text-blue-600 hover:text-blue-800">Manage users →</a>
                    </div>
                </div>
            </c:when>

            <c:when test="${user.role == 'JOB_SEEKER'}">
                <!-- Job Seeker Dashboard -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Available Jobs -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Recommended Jobs</h3>
                        <div class="space-y-4">
                            <c:forEach items="${availableJobs}" var="job">
                                <div class="border-b border-gray-200 pb-4 last:border-b-0">
                                    <h4 class="font-medium text-gray-900">${job.title}</h4>
                                    <p class="text-sm text-gray-600">${job.location} • ${job.jobType.displayName}</p>
                                    <div class="flex items-center justify-between mt-2">
                                        <span class="text-xs text-gray-500">${job.experienceLevel.displayName}</span>
                                        <a href="/lankajobshub/jobs/${job.id}" class="text-blue-600 hover:text-blue-800 text-sm">View Details</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <a href="/lankajobshub/jobs" class="mt-4 inline-block text-blue-600 hover:text-blue-800">Browse all jobs →</a>
                    </div>

                    <!-- My Applications -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">My Applications</h3>
                        <div class="space-y-4">
                            <c:forEach items="${myApplications}" var="application">
                                <div class="border-b border-gray-200 pb-4 last:border-b-0">
                                    <h4 class="font-medium text-gray-900">${application.job.title}</h4>
                                    <p class="text-sm text-gray-600">Applied ${application.appliedDate}</p>
                                    <span class="inline-block mt-1 px-2 py-1 text-xs rounded-full 
                                        ${application.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' : 
                                          application.status == 'ACCEPTED' ? 'bg-green-100 text-green-800' : 
                                          application.status == 'REJECTED' ? 'bg-red-100 text-red-800' : 
                                          'bg-gray-100 text-gray-800'}">
                                        ${application.status.displayName}
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <!-- Default Dashboard for other roles -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Recent Jobs</h3>
                    <div class="space-y-4">
                        <c:forEach items="${recentJobs}" var="job">
                            <div class="border-b border-gray-200 pb-4 last:border-b-0">
                                <h4 class="font-medium text-gray-900">${job.title}</h4>
                                <p class="text-sm text-gray-600">${job.location} • ${job.jobType.displayName}</p>
                                <p class="text-xs text-gray-500">Posted ${job.postedDate}</p>
                            </div>
                        </c:forEach>
                    </div>
                    <a href="/lankajobshub/jobs" class="mt-4 inline-block text-blue-600 hover:text-blue-800">View all jobs →</a>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Quick Actions -->
        <div class="mt-8 bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold text-gray-900 mb-4">Quick Actions</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <a href="/lankajobshub/jobs" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                    <div class="p-2 rounded-full bg-blue-100 text-blue-600 mr-3">
                        <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                        </svg>
                    </div>
                    <div>
                        <p class="font-medium text-gray-900">Browse Jobs</p>
                        <p class="text-sm text-gray-600">Find new opportunities</p>
                    </div>
                </a>

                <c:if test="${user.role != 'JOB_SEEKER'}">
                    <a href="/lankajobshub/jobs/post" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                        <div class="p-2 rounded-full bg-green-100 text-green-600 mr-3">
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="font-medium text-gray-900">Post a Job</p>
                            <p class="text-sm text-gray-600">Hire new talent</p>
                        </div>
                    </a>
                </c:if>

                <a href="/lankajobshub/users/profile" class="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                    <div class="p-2 rounded-full bg-purple-100 text-purple-600 mr-3">
                        <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <div>
                        <p class="font-medium text-gray-900">My Profile</p>
                        <p class="text-sm text-gray-600">Update your information</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
