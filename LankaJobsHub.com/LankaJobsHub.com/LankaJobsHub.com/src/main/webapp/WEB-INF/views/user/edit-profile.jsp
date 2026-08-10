<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - LankaJobsHub</title>
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

    <div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Edit Profile</h1>
            <p class="text-gray-600">Update your account information below.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">${success}</div>
        </c:if>

        <!-- Avatar -->
        <div class="flex justify-center mb-8">
            <div class="w-24 h-24 rounded-full bg-blue-600 flex items-center justify-center text-4xl font-bold text-white shadow-lg">
                ${user.email.substring(0,1).toUpperCase()}
            </div>
        </div>

        <form action="/lankajobshub/users/profile/edit" method="POST" class="space-y-6">

            <div class="bg-white rounded-xl shadow-md p-8 space-y-6">
                <h2 class="text-xl font-semibold text-gray-800 pb-3 border-b border-gray-100">Account Details</h2>

                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address <span class="text-red-500">*</span></label>
                    <input type="email" id="email" name="email" required value="${user.email}"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           placeholder="your@email.com">
                </div>

                <div>
                    <label for="role" class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                    <select id="role" name="role"
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        <c:forEach items="${roles}" var="r">
                            <option value="${r}" ${user.role == r ? 'selected' : ''}>${r.toString().replace('_', ' ')}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
                    <p class="text-yellow-800 text-sm">
                        <strong>🔒 Password:</strong> To change your password, please contact the admin or use the password reset feature.
                        Your existing password remains unchanged.
                    </p>
                </div>
            </div>

            <div class="flex items-center justify-between">
                <a href="/lankajobshub/users/profile" class="text-gray-600 hover:text-gray-900 font-medium">← Cancel</a>
                <button type="submit"
                        class="bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
                    Save Changes
                </button>
            </div>
        </form>
    </div>
</body>
</html>
