<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Jobs - LankaJobsHub</title>
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

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex justify-between items-center mb-8">
            <div>
                <h1 class="text-3xl font-bold text-gray-900 mb-1">My Posted Jobs</h1>
                <p class="text-gray-600">Manage the jobs you have posted</p>
            </div>
            <a href="/lankajobshub/jobs/post"
               class="bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                + Post New Job
            </a>
        </div>

        <c:if test="${not empty success}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty jobs}">
                <div class="bg-white rounded-xl shadow-md p-16 text-center">
                    <div class="text-gray-300 text-7xl mb-4">📋</div>
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">No Jobs Posted Yet</h3>
                    <p class="text-gray-600 mb-6">You haven't posted any jobs. Start hiring today!</p>
                    <a href="/lankajobshub/jobs/post" class="bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold hover:bg-blue-700">
                        Post Your First Job
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-4">
                    <c:forEach items="${jobs}" var="job">
                        <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition-shadow">
                            <div class="flex justify-between items-start">
                                <div class="flex-1">
                                    <div class="flex items-center gap-3 mb-2">
                                        <h3 class="text-xl font-semibold text-gray-900">
                                            <a href="/lankajobshub/jobs/${job.id}" class="hover:text-blue-600">${job.title}</a>
                                        </h3>
                                        <span class="px-2 py-1 rounded-full text-xs font-medium
                                            ${job.status == 'ACTIVE' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-600'}">
                                            ${job.status}
                                        </span>
                                    </div>
                                    <div class="flex flex-wrap gap-4 text-sm text-gray-600 mb-3">
                                        <span>📍 ${job.location}</span>
                                        <span>💼 ${job.jobType.displayName}</span>
                                        <span>📊 ${job.experienceLevel.displayName}</span>
                                        <c:if test="${not empty job.salaryMin}">
                                            <span>💰 LKR ${job.salaryMin} – ${job.salaryMax}</span>
                                        </c:if>
                                        <span>📅 Posted: ${job.postedDate}</span>
                                    </div>
                                    <p class="text-gray-600 text-sm line-clamp-2">${job.description}</p>
                                </div>
                                <div class="ml-6 flex flex-col gap-2 min-w-fit">
                                    <a href="/lankajobshub/jobs/${job.id}/edit"
                                       class="text-center bg-yellow-500 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-yellow-600 transition-colors">
                                        ✏️ Edit
                                    </a>
                                    <form action="/lankajobshub/jobs/${job.id}/delete" method="POST"
                                          onsubmit="return confirm('Are you sure you want to delete this job?')">
                                        <button type="submit"
                                                class="w-full bg-red-500 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-red-600 transition-colors">
                                            🗑️ Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
