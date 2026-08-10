<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Job - LankaJobsHub</title>
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
                    <a href="/lankajobshub/dashboard" class="text-gray-700 hover:text-blue-600">Dashboard</a>
                    <a href="/lankajobshub/users/profile" class="text-gray-700 hover:text-blue-600">My Profile</a>
                    <a href="/lankajobshub/users/logout" class="text-gray-700 hover:text-blue-600">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Edit Job</h1>
            <p class="text-gray-600">Update the details for <strong>${job.title}</strong></p>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">${success}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty job}">
                <div class="bg-white rounded-xl shadow-md p-12 text-center">
                    <div class="text-gray-400 text-6xl mb-4">⚠️</div>
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">Job Not Found</h3>
                    <p class="text-gray-600 mb-4">You may not have permission to edit this job.</p>
                    <a href="/lankajobshub/jobs" class="bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700">Back to Jobs</a>
                </div>
            </c:when>
            <c:otherwise>
                <form action="/lankajobshub/jobs/${job.id}/edit" method="POST" class="space-y-8">

                    <div class="bg-white rounded-xl shadow-md p-8">
                        <h2 class="text-xl font-semibold text-gray-800 mb-6 pb-3 border-b border-gray-100">Basic Information</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="md:col-span-2">
                                <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Job Title <span class="text-red-500">*</span></label>
                                <input type="text" id="title" name="title" required value="${job.title}"
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label for="jobType" class="block text-sm font-medium text-gray-700 mb-1">Job Type</label>
                                <select id="jobType" name="jobType" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <c:forEach items="${jobTypes}" var="type">
                                        <option value="${type}" ${job.jobType == type ? 'selected' : ''}>${type.displayName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label for="experienceLevel" class="block text-sm font-medium text-gray-700 mb-1">Experience Level</label>
                                <select id="experienceLevel" name="experienceLevel" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <c:forEach items="${experienceLevels}" var="level">
                                        <option value="${level}" ${job.experienceLevel == level ? 'selected' : ''}>${level.displayName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label for="location" class="block text-sm font-medium text-gray-700 mb-1">Location <span class="text-red-500">*</span></label>
                                <input type="text" id="location" name="location" required value="${job.location}"
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label for="industry" class="block text-sm font-medium text-gray-700 mb-1">Industry</label>
                                <input type="text" id="industry" name="industry" value="${job.industry}"
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl shadow-md p-8">
                        <h2 class="text-xl font-semibold text-gray-800 mb-6 pb-3 border-b border-gray-100">Salary Range (LKR)</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="salaryMin" class="block text-sm font-medium text-gray-700 mb-1">Minimum Salary</label>
                                <input type="number" id="salaryMin" name="salaryMin" value="${job.salaryMin}"
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label for="salaryMax" class="block text-sm font-medium text-gray-700 mb-1">Maximum Salary</label>
                                <input type="number" id="salaryMax" name="salaryMax" value="${job.salaryMax}"
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl shadow-md p-8">
                        <h2 class="text-xl font-semibold text-gray-800 mb-6 pb-3 border-b border-gray-100">Job Details</h2>
                        <div class="space-y-6">
                            <div>
                                <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Job Description</label>
                                <textarea id="description" name="description" rows="5"
                                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none">${job.description}</textarea>
                            </div>
                            <div>
                                <label for="requirements" class="block text-sm font-medium text-gray-700 mb-1">Requirements <span class="text-red-500">*</span></label>
                                <textarea id="requirements" name="requirements" rows="5" required
                                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none">${job.requirements}</textarea>
                            </div>
                            <div>
                                <label for="responsibilities" class="block text-sm font-medium text-gray-700 mb-1">Key Responsibilities</label>
                                <textarea id="responsibilities" name="responsibilities" rows="4"
                                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none">${job.responsibilities}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-between">
                        <a href="/lankajobshub/jobs/${job.id}" class="text-gray-600 hover:text-gray-900 font-medium">← Back to Job</a>
                        <button type="submit"
                                class="bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
                            Save Changes
                        </button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
