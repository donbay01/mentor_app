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

/**
 * Agora Token
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'createToken') {
    exports.createToken = require('./src/agora').createToken;
}