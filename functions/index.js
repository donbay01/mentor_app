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