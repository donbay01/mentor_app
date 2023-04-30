'use strict';

/**
 * New User setup
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'newUser') {
    exports.newUser = require('./src/auth').newUser;
}

/**
 * Session Notification
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'newSessionRequest') {
    exports.newSessionRequest = require('./src/session').newSessionRequest;
}

/**
 * Completed Profile
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'completedProfile') {
    exports.completedProfile = require('./src/auth/completed_profile').completedProfile;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'updateUser') {
    exports.updateUser = require('./src/auth').updateUser;
}

/**
 * Agora Token
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'createToken') {
    exports.createToken = require('./src/agora').createToken;
}

/**
 * Handle Accept / Decline session request
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'sessionAction') {
    exports.sessionAction = require('./src/session/action').sessionAction;
}

/**
 * Free up schedule after session time
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'checkAvailability') {
    exports.checkAvailability = require('./src/session/check').checkAvailability;
}

/**
 * New Availability schedule
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'newSchedule') {
    exports.newSchedule = require('./src/auth/availability').newSchedule;
}

/**
 * Courses
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'indexCourse') {
    exports.indexCourse = require('./src/courses').indexCourse;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'enrollCourse') {
    exports.enrollCourse = require('./src/courses').enrollCourse;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'indexJobs') {
    exports.indexJobs = require('./src/jobs').indexJobs;
}

/**
 * Views
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'addViews') {
    exports.addViews = require('./src/jobs/view').addViews;
}

/**
 * Comments
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'newComment') {
    exports.newComment = require('./src/jobs/comment').newComment;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'deleteComment') {
    exports.deleteComment = require('./src/jobs/comment').deleteComment;
}

/**
 * PayStack
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'genPayLink') {
    exports.genPayLink = require('./src/paystack').genPayLink;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'webhook') {
    exports.webhook = require('./src/paystack/webhook').webhook;
}

// if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'recurringCharges') {
//     exports.recurringCharges = require('./src/paystack/recurring').recurringCharges;
// }

/**
 * Clear notifications
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'clearNotifications') {
    exports.clearNotifications = require('./src/notifications').clearNotifications;
}

/**
 * Rating
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'newReview') {
    exports.newReview = require('./src/session/review').newReview;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'readDecline') {
    exports.readDecline = require('./src/notifications/read').readDecline;
}