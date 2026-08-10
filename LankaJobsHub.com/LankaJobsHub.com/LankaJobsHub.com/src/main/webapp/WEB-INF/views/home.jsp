<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LankaJobsHub - Find Your Dream Job</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <!-- Navigation -->
    <nav class="bg-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <h1 class="text-2xl font-bold text-blue-600">LankaJobsHub</h1>
                </div>
                <div class="flex items-center space-x-4">
                    <a href="/lankajobshub/jobs" class="text-gray-700 hover:text-blue-600">Browse Jobs</a>
                    <a href="/lankajobshub/users/login" class="text-gray-700 hover:text-blue-600">Login</a>
                    <a href="/lankajobshub/users/register" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
                        Register
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="bg-gradient-to-r from-blue-600 to-blue-800 text-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24">
            <div class="text-center">
                <h1 class="text-4xl md:text-6xl font-bold mb-6">
                    Find Your Dream Job in Sri Lanka
                </h1>
                <p class="text-xl mb-8 max-w-3xl mx-auto">
                    Connect with top employers and discover opportunities that match your skills and aspirations
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="/lankajobshub/jobs" class="bg-white text-blue-600 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100">
                        Browse Jobs
                    </a>
                    <a href="/lankajobshub/users/register" class="border-2 border-white text-white px-8 py-3 rounded-lg font-semibold hover:bg-white hover:text-blue-600">
                        Post a Job
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="bg-white py-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
                <div>
                    <div class="text-4xl font-bold text-blue-600 mb-2">${totalJobs}</div>
                    <div class="text-gray-600">Active Jobs</div>
                </div>
                <div>
                    <div class="text-4xl font-bold text-blue-600 mb-2">100+</div>
                    <div class="text-gray-600">Companies</div>
                </div>
                <div>
                    <div class="text-4xl font-bold text-blue-600 mb-2">1000+</div>
                    <div class="text-gray-600">Job Seekers</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Jobs Section -->
    <div class="bg-gray-50 py-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <h2 class="text-3xl font-bold text-gray-900 mb-8 text-center">Recent Job Openings</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach items="${recentJobs}" var="job">
                    <div class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
                        <h3 class="text-xl font-semibold text-gray-900 mb-2">${job.title}</h3>
                        <p class="text-gray-600 mb-4">${job.location}</p>
                        <div class="flex items-center justify-between">
                            <span class="bg-blue-100 text-blue-800 px-2 py-1 rounded text-sm">${job.jobType.displayName}</span>
                            <a href="/lankajobshub/jobs/${job.id}" class="text-blue-600 hover:text-blue-800">View Details</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-8">
                <a href="/lankajobshub/jobs" class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700">
                    View All Jobs
                </a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <h3 class="text-xl font-bold mb-4">LankaJobsHub</h3>
                    <p class="text-gray-300">Connecting talent with opportunity in Sri Lanka</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">For Job Seekers</h4>
                    <ul class="space-y-2 text-gray-300">
                        <li><a href="/lankajobshub/jobs" class="hover:text-white">Browse Jobs</a></li>
                        <li><a href="/lankajobshub/users/register" class="hover:text-white">Create Profile</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">For Employers</h4>
                    <ul class="space-y-2 text-gray-300">
                        <li><a href="/lankajobshub/jobs/post" class="hover:text-white">Post a Job</a></li>
                        <li><a href="/lankajobshub/users/register" class="hover:text-white">Register Company</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">Contact</h4>
                    <ul class="space-y-2 text-gray-300">
                        <li>info@lankajobshub.com</li>
                        <li>+94 11 123 4567</li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-300">
                <p>&copy; 2025 LankaJobsHub. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html> 