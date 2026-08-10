<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Jobs - LankaJobsHub</title>
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
                    <a href="/lankajobshub/jobs" class="text-blue-600 font-medium">Browse Jobs</a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a href="/lankajobshub/dashboard" class="text-gray-700 hover:text-blue-600">Dashboard</a>
                            <a href="/lankajobshub/users/logout" class="text-gray-700 hover:text-blue-600">Logout</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/lankajobshub/users/login" class="text-gray-700 hover:text-blue-600">Login</a>
                            <a href="/lankajobshub/users/register" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">Register</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Browse Jobs</h1>
            <p class="text-gray-600">Find your next career opportunity</p>
        </div>

        <!-- Search and Filters -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-8">
            <form action="/lankajobshub/jobs" method="GET" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label for="keyword" class="block text-sm font-medium text-gray-700 mb-1">Keywords</label>
                    <input type="text" id="keyword" name="keyword" value="${keyword}" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           placeholder="Job title, skills, company...">
                </div>
                <div>
                    <label for="location" class="block text-sm font-medium text-gray-700 mb-1">Location</label>
                    <input type="text" id="location" name="location" value="${location}" 
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           placeholder="City, province...">
                </div>
                <div>
                    <label for="jobType" class="block text-sm font-medium text-gray-700 mb-1">Job Type</label>
                    <select id="jobType" name="jobType" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                        <option value="">All Types</option>
                        <c:forEach items="${jobTypes}" var="type">
                            <option value="${type}" ${selectedJobType == type ? 'selected' : ''}>${type.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label for="experienceLevel" class="block text-sm font-medium text-gray-700 mb-1">Experience</label>
                    <select id="experienceLevel" name="experienceLevel" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                        <option value="">All Levels</option>
                        <c:forEach items="${experienceLevels}" var="level">
                            <option value="${level}" ${selectedExperienceLevel == level ? 'selected' : ''}>${level.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="md:col-span-4">
                    <button type="submit" 
                            class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                        Search Jobs
                    </button>
                </div>
            </form>
        </div>

        <!-- Job Results -->
        <div class="space-y-6">
            <c:choose>
                <c:when test="${empty jobs}">
                    <div class="text-center py-12">
                        <div class="text-gray-400 text-6xl mb-4">🔍</div>
                        <h3 class="text-xl font-semibold text-gray-900 mb-2">No jobs found</h3>
                        <p class="text-gray-600">Try adjusting your search criteria or browse all available jobs.</p>
                        <a href="/lankajobshub/jobs" class="mt-4 inline-block bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700">
                            View All Jobs
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-sm text-gray-600 mb-4">
                        Showing ${jobs.size()} job${jobs.size() == 1 ? '' : 's'}
                    </div>
                    
                    <div class="grid gap-6">
                        <c:forEach items="${jobs}" var="job">
                            <div class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
                                <div class="flex justify-between items-start">
                                    <div class="flex-1">
                                        <h3 class="text-xl font-semibold text-gray-900 mb-2">
                                            <a href="/lankajobshub/jobs/${job.id}" class="hover:text-blue-600">${job.title}</a>
                                        </h3>
                                        <div class="flex items-center text-gray-600 mb-3">
                                            <span class="mr-4">📍 ${job.location}</span>
                                            <span class="mr-4">💰 ${job.salaryMin != null ? job.salaryMin : 'N/A'} - ${job.salaryMax != null ? job.salaryMax : 'N/A'}</span>
                                            <span>📅 ${job.postedDate}</span>
                                        </div>
                                        <p class="text-gray-700 mb-4 line-clamp-2">${job.description}</p>
                                        <div class="flex flex-wrap gap-2">
                                            <span class="bg-blue-100 text-blue-800 px-2 py-1 rounded text-sm">${job.jobType.displayName}</span>
                                            <span class="bg-green-100 text-green-800 px-2 py-1 rounded text-sm">${job.experienceLevel.displayName}</span>
                                            <c:if test="${not empty job.industry}">
                                                <span class="bg-purple-100 text-purple-800 px-2 py-1 rounded text-sm">${job.industry}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <a href="/lankajobshub/jobs/${job.id}" 
                                           class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 text-sm">
                                            View Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Post Job CTA -->
        <c:if test="${not empty sessionScope.user}">
            <div class="mt-12 bg-blue-50 rounded-lg p-6 text-center">
                <h3 class="text-xl font-semibold text-gray-900 mb-2">Looking to hire?</h3>
                <p class="text-gray-600 mb-4">Post a job and find the perfect candidate for your team.</p>
                <a href="/lankajobshub/jobs/post" 
                   class="bg-blue-600 text-white px-6 py-3 rounded-md hover:bg-blue-700 font-medium">
                    Post a Job
                </a>
            </div>
        </c:if>
    </div>
</body>
</html>
