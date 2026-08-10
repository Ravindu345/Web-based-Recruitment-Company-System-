<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post a Job - LankaJobsHub</title>
    <meta name="description" content="Post a job opening on LankaJobsHub and find the best talent in Sri Lanka.">
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
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a href="/lankajobshub/dashboard" class="text-gray-700 hover:text-blue-600">Dashboard</a>
                            <a href="/lankajobshub/users/profile" class="text-gray-700 hover:text-blue-600">My Profile</a>
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

    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Post a Job</h1>
            <p class="text-gray-600">Fill in the details below to advertise your job opening.</p>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
                ${error}
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">
                ${success}
            </div>
        </c:if>

        <form action="/lankajobshub/jobs/post" method="POST" class="space-y-8">

            <!-- Basic Info Card -->
            <div class="bg-white rounded-xl shadow-md p-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-6 pb-3 border-b border-gray-100">Basic Information</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    <div class="md:col-span-2">
                        <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Job Title <span class="text-red-500">*</span></label>
                        <input type="text" id="title" name="title" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                               placeholder="e.g. Senior Software Engineer" value="${job.title}">
                    </div>

                    <div>
                        <label for="jobType" class="block text-sm font-medium text-gray-700 mb-1">Job Type <span class="text-red-500">*</span></label>
                        <select id="jobType" name="jobType" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            <option value="">Select Job Type</option>
                            <c:forEach items="${jobTypes}" var="type">
                                <option value="${type}" ${job.jobType == type ? 'selected' : ''}>${type.displayName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label for="experienceLevel" class="block text-sm font-medium text-gray-700 mb-1">Experience Level <span class="text-red-500">*</span></label>
                        <select id="experienceLevel" name="experienceLevel" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            <option value="">Select Experience Level</option>
                            <c:forEach items="${experienceLevels}" var="level">
                                <option value="${level}" ${job.experienceLevel == level ? 'selected' : ''}>${level.displayName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label for="location" class="block text-sm font-medium text-gray-700 mb-1">Location <span class="text-red-500">*</span></label>
                        <input type="text" id="location" name="location" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                               placeholder="e.g. Colombo, Sri Lanka" value="${job.location}">
                    </div>

                    <div>
                        <label for="industry" class="block text-sm font-medium text-gray-700 mb-1">Industry</label>
                        <input type="text" id="industry" name="industry"
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                               placeholder="e.g. Information Technology" value="${job.industry}">
                    </div>

                </div>
            </div>

            <!-- Salary Card -->
            <div class="bg-white rounded-xl shadow-md p-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-6 pb-3 border-b border-gray-100">Salary Range (LKR)</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="salaryMin" class="block text-sm font-medium text-gray-700 mb-1">Minimum Salary</label>
                        <input type="number" id="salaryMin" name="salaryMin" min="0"
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                               placeholder="e.g. 80000" value="${job.salaryMin}">
                    </div>
                    <div>
                        <label for="salaryMax" class="block text-sm font-medium text-gray-700 mb-1">Maximum Salary</label>
                        <input type="number" id="salaryMax" name="salaryMax" min="0"
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                               placeholder="e.g. 150000" value="${job.salaryMax}">
                    </div>
                </div>
            </div>

            <!-- Description Card -->
            <div class="bg-white rounded-xl shadow-md p-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-6 pb-3 border-b border-gray-100">Job Details</h2>
                <div class="space-y-6">
                    <div>
                        <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Job Description</label>
                        <textarea id="description" name="description" rows="5"
                                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                  placeholder="Describe the role, team, and what the candidate will be doing...">${job.description}</textarea>
                    </div>
                    <div>
                        <label for="requirements" class="block text-sm font-medium text-gray-700 mb-1">Requirements <span class="text-red-500">*</span></label>
                        <textarea id="requirements" name="requirements" rows="5" required
                                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                  placeholder="List qualifications, skills, and experience required...">${job.requirements}</textarea>
                    </div>
                    <div>
                        <label for="responsibilities" class="block text-sm font-medium text-gray-700 mb-1">Key Responsibilities</label>
                        <textarea id="responsibilities" name="responsibilities" rows="4"
                                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                  placeholder="What will the candidate be responsible for day-to-day?">${job.responsibilities}</textarea>
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="flex items-center justify-between">
                <a href="/lankajobshub/jobs" class="text-gray-600 hover:text-gray-900 font-medium">← Back to Jobs</a>
                <button type="submit"
                        class="bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
                    Post Job
                </button>
            </div>

        </form>
    </div>
</body>
</html>
