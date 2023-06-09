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

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'createSchedule') {
    exports.createSchedule = require('./src/auth/availability').createSchedule;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'monthlyRemdinder') {
    exports.monthlyRemdinder = require('./src/auth/availability').monthlyRemdinder;
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

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'nextLesson') {
    exports.nextLesson = require('./src/courses/next').nextLesson;
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

/**
 * Send Reviewed Email
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'updatedAccount') {
    exports.updatedAccount = require('./src/auth').updatedAccount;
}

/**
 * Video call notification
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'joinedNotification') {
    exports.joinedNotification = require('./src/agora/notification').joinedNotification;
}

/**
 * Video call reminder
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'reminder') {
    exports.reminder = require('./src/session/reminder').reminder;
}

/**
 * Call Started
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'callStarted') {
    exports.callStarted = require('./src/agora/call_started').callStarted;
}

/**
 * Bank Information
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'verifyBankInformation') {
    exports.verifyBankInformation = require('./src/paystack/verify').verifyBankInformation;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'getAllBanks') {
    exports.getAllBanks = require('./src/paystack/banks').getAllBanks;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'saveInformation') {
    exports.saveInformation = require('./src/paystack/save').saveInformation;
}

if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'withdrawPoints') {
    exports.withdrawPoints = require('./src/paystack/withdraw').withdrawPoints;
}

/**
 * Switch User Role
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME == 'switchRole') {
    exports.switchRole = require('./src/auth/switch').switchRole;
}