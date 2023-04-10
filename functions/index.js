'use strict';

/**
 * New User setup
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'newUser') {
    exports.newUser = require('./src/auth').newUser;
}
