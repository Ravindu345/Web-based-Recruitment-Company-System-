<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${job.title} - LankaJobsHub</title>
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

    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Breadcrumb -->
        <nav class="flex mb-8" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                <li class="inline-flex items-center">
                    <a href="/lankajobshub/" class="text-gray-700 hover:text-blue-600">Home</a>
                </li>
                <li>
                    <div class="flex items-center">
                        <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                        </svg>
                        <a href="/lankajobshub/jobs" class="ml-1 text-gray-700 hover:text-blue-600 md:ml-2">Jobs</a>
                    </div>
                </li>
                <li aria-current="page">
                    <div class="flex items-center">
                        <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                        </svg>
                        <span class="ml-1 text-gray-500 md:ml-2">${job.title}</span>
                    </div>
                </li>
            </ol>
        </nav>

        <!-- Job Header -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex justify-between items-start">
                <div class="flex-1">
                    <h1 class="text-3xl font-bold text-gray-900 mb-2">${job.title}</h1>
                    <div class="flex items-center text-gray-600 mb-4">
                        <span class="mr-4">📍 ${job.location}</span>
                        <span class="mr-4">💰 ${job.salaryMin != null ? job.salaryMin : 'N/A'} - ${job.salaryMax != null ? job.salaryMax : 'N/A'}</span>
                        <span>📅 Posted ${job.postedDate}</span>
                    </div>
                    <div class="flex flex-wrap gap-2">
                        <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">${job.jobType.displayName}</span>
                        <span class="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">${job.experienceLevel.displayName}</span>
                        <c:if test="${not empty job.industry}">
                            <span class="bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-sm">${job.industry}</span>
                        </c:if>
                        <span class="bg-gray-100 text-gray-800 px-3 py-1 rounded-full text-sm">${job.status.displayName}</span>
                    </div>
                </div>
                <div class="ml-6">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <c:if test="${sessionScope.user.role == 'JOB_SEEKER'}">
                                <button onclick="showApplyModal()" class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-medium">
                                    Apply Now
                                </button>
                            </c:if>
                            <c:if test="${sessionScope.user.id == job.postedBy.id || sessionScope.user.role == 'ADMIN'}">
                                <div class="space-y-2">
                                    <a href="/lankajobshub/jobs/${job.id}/edit" class="block bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700 text-sm">
                                        Edit Job
                                    </a>
                                    <form action="/lankajobshub/jobs/${job.id}/delete" method="POST" class="inline" onsubmit="return confirm('Are you sure you want to delete this job?')">
                                        <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 text-sm">
                                            Delete Job
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <a href="/lankajobshub/users/login" class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-medium">
                                Login to Apply
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Job Details -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Main Content -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Job Description -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Job Description</h2>
                    <div class="prose max-w-none">
                        <p class="text-gray-700 whitespace-pre-wrap">${job.description}</p>
                    </div>
                </div>

                <!-- Requirements -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Requirements</h2>
                    <div class="prose max-w-none">
                        <p class="text-gray-700 whitespace-pre-wrap">${job.requirements}</p>
                    </div>
                </div>

                <!-- Responsibilities -->
                <c:if test="${not empty job.responsibilities}">
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Responsibilities</h2>
                        <div class="prose max-w-none">
                            <p class="text-gray-700 whitespace-pre-wrap">${job.responsibilities}</p>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Sidebar -->
            <div class="space-y-6">
                <!-- Job Summary -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Job Summary</h3>
                    <div class="space-y-3">
                        <div class="flex justify-between">
                            <span class="text-gray-600">Job Type:</span>
                            <span class="font-medium">${job.jobType.displayName}</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-gray-600">Experience:</span>
                            <span class="font-medium">${job.experienceLevel.displayName}</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-gray-600">Location:</span>
                            <span class="font-medium">${job.location}</span>
                        </div>
                        <c:if test="${not empty job.industry}">
                            <div class="flex justify-between">
                                <span class="text-gray-600">Industry:</span>
                                <span class="font-medium">${job.industry}</span>
                            </div>
                        </c:if>
                        <c:if test="${job.salaryMin != null || job.salaryMax != null}">
                            <div class="flex justify-between">
                                <span class="text-gray-600">Salary:</span>
                                <span class="font-medium">${job.salaryMin != null ? job.salaryMin : 'N/A'} - ${job.salaryMax != null ? job.salaryMax : 'N/A'}</span>
                            </div>
                        </c:if>
                        <c:if test="${job.deadline != null}">
                            <div class="flex justify-between">
                                <span class="text-gray-600">Deadline:</span>
                                <span class="font-medium">${job.deadline}</span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Posted By -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Posted By</h3>
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                            <span class="text-blue-600 font-semibold">${job.postedBy.email.charAt(0).toUpperCase()}</span>
                        </div>
                        <div class="ml-3">
                            <p class="font-medium text-gray-900">${job.postedBy.email}</p>
                            <p class="text-sm text-gray-600">${job.postedBy.role.displayName}</p>
                        </div>
                    </div>
                </div>

                <!-- Similar Jobs -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Similar Jobs</h3>
                    <p class="text-gray-600 text-sm">More jobs in ${job.industry != null ? job.industry : 'this field'} coming soon...</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Apply Modal -->
    <div id="applyModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden z-50">
        <div class="flex items-center justify-center min-h-screen p-4">
            <div class="bg-white rounded-lg shadow-xl max-w-md w-full">
                <div class="p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Apply for ${job.title}</h3>
                    <form action="/lankajobshub/applications/apply" method="POST">
                        <input type="hidden" name="jobId" value="${job.id}">
                        <div class="mb-4">
                            <label for="coverLetter" class="block text-sm font-medium text-gray-700 mb-2">Cover Letter *</label>
                            <textarea id="coverLetter" name="coverLetter" rows="6" required
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                      placeholder="Tell us why you're interested in this position..."></textarea>
                        </div>
                        <div class="mb-6">
                            <label for="additionalNotes" class="block text-sm font-medium text-gray-700 mb-2">Additional Notes</label>
                            <textarea id="additionalNotes" name="additionalNotes" rows="3"
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                      placeholder="Any additional information..."></textarea>
                        </div>
                        <div class="flex justify-end space-x-3">
                            <button type="button" onclick="hideApplyModal()" 
                                    class="px-4 py-2 text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300">
                                Cancel
                            </button>
                            <button type="submit" 
                                    class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
                                Submit Application
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showApplyModal() {
            document.getElementById('applyModal').classList.remove('hidden');
        }
        
        function hideApplyModal() {
            document.getElementById('applyModal').classList.add('hidden');
        }
        
        // Close modal when clicking outside
        document.getElementById('applyModal').addEventListener('click', function(e) {
            if (e.target === this) {
                hideApplyModal();
            }
        });
    </script>
</body>
</html>
