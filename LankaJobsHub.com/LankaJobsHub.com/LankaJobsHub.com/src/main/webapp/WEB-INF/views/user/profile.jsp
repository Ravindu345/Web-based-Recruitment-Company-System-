<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - LankaJobsHub</title>
    <meta name="description" content="View and manage your LankaJobsHub profile.">
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
                    <a href="/lankajobshub/users/profile" class="text-blue-600 font-medium">My Profile</a>
                    <a href="/lankajobshub/users/logout" class="text-gray-700 hover:text-blue-600">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">

        <c:if test="${not empty success}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">${error}</div>
        </c:if>

        <!-- Profile Header Card -->
        <div class="bg-white rounded-xl shadow-md overflow-hidden mb-6">
            <div class="bg-gradient-to-r from-blue-600 to-blue-800 px-8 py-10">
                <div class="flex items-center gap-6">
                    <div class="w-24 h-24 rounded-full bg-white flex items-center justify-center text-4xl font-bold text-blue-600 shadow-lg">
                        ${user.email.substring(0,1).toUpperCase()}
                    </div>
                    <div class="text-white">
                        <h1 class="text-3xl font-bold mb-1">${user.email}</h1>
                        <div class="flex items-center gap-3">
                            <span class="bg-white bg-opacity-20 px-3 py-1 rounded-full text-sm font-medium">
                                ${user.role.toString().replace('_', ' ')}
                            </span>
                            <span class="bg-white bg-opacity-20 px-3 py-1 rounded-full text-sm font-medium
                                ${user.status == 'ACTIVE' ? 'text-green-100' : 'text-red-100'}">
                                ● ${user.status}
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Details -->
            <div class="px-8 py-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Email Address</p>
                        <p class="text-gray-800 font-medium">${user.email}</p>
                    </div>
                    <div>
                        <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Account Role</p>
                        <p class="text-gray-800 font-medium">${user.role.toString().replace('_', ' ')}</p>
                    </div>
                    <div>
                        <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Account Status</p>
                        <p class="font-medium ${user.status == 'ACTIVE' ? 'text-green-600' : 'text-red-600'}">${user.status}</p>
                    </div>
                    <div>
                        <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Member Since</p>
                        <p class="text-gray-800 font-medium">${user.createdDate}</p>
                    </div>
                    <div>
                        <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Last Login</p>
                        <p class="text-gray-800 font-medium">
                            <c:choose>
                                <c:when test="${not empty user.lastLogin}">${user.lastLogin}</c:when>
                                <c:otherwise>Never</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Actions -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
            <a href="/lankajobshub/users/profile/edit"
               class="flex items-center justify-center gap-2 bg-blue-600 text-white py-3 px-6 rounded-xl font-semibold hover:bg-blue-700 transition-colors shadow-md">
                ✏️ Edit Profile
            </a>
            <a href="/lankajobshub/dashboard"
               class="flex items-center justify-center gap-2 bg-white text-gray-700 py-3 px-6 rounded-xl font-semibold hover:bg-gray-50 border border-gray-200 transition-colors shadow-md">
                📊 Go to Dashboard
            </a>
        </div>

        <!-- Role-specific Quick Links -->
        <div class="bg-white rounded-xl shadow-md p-6">
            <h2 class="text-lg font-semibold text-gray-800 mb-4">Quick Actions</h2>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
                <c:if test="${user.role == 'ADMIN'}">
                    <a href="/lankajobshub/users/admin"
                       class="flex flex-col items-center p-4 bg-gray-50 rounded-lg hover:bg-blue-50 hover:text-blue-700 transition-colors text-center text-gray-700">
                        <span class="text-2xl mb-2">🛡️</span>
                        <span class="text-sm font-medium">Admin Panel</span>
                    </a>
                </c:if>
                <c:if test="${user.role != 'JOB_SEEKER'}">
                    <a href="/lankajobshub/jobs/post"
                       class="flex flex-col items-center p-4 bg-gray-50 rounded-lg hover:bg-blue-50 hover:text-blue-700 transition-colors text-center text-gray-700">
                        <span class="text-2xl mb-2">📝</span>
                        <span class="text-sm font-medium">Post a Job</span>
                    </a>
                    <a href="/lankajobshub/jobs/my-jobs"
                       class="flex flex-col items-center p-4 bg-gray-50 rounded-lg hover:bg-blue-50 hover:text-blue-700 transition-colors text-center text-gray-700">
                        <span class="text-2xl mb-2">💼</span>
                        <span class="text-sm font-medium">My Posted Jobs</span>
                    </a>
                </c:if>
                <a href="/lankajobshub/jobs"
                   class="flex flex-col items-center p-4 bg-gray-50 rounded-lg hover:bg-blue-50 hover:text-blue-700 transition-colors text-center text-gray-700">
                    <span class="text-2xl mb-2">🔍</span>
                    <span class="text-sm font-medium">Browse Jobs</span>
                </a>
                <a href="/lankajobshub/users/logout"
                   class="flex flex-col items-center p-4 bg-gray-50 rounded-lg hover:bg-red-50 hover:text-red-700 transition-colors text-center text-gray-700">
                    <span class="text-2xl mb-2">🚪</span>
                    <span class="text-sm font-medium">Logout</span>
                </a>
            </div>
        </div>

    </div>
</body>
</html>
