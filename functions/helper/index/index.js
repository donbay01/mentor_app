/**
 * Generate the Search Index
 * @param {string} name 
 * @param {string} description 
 * @returns {Object} index
 */
exports.indexDocument = (name, description) => {
    const arr = name.toLowerCase().split('');
    const arrName = description.toLowerCase().split('');
    const searchableIndex = {};
    const secondObject = {};
    let prevKey = '', secondkey = '';

    for (const char of arr) {
        const key = prevKey + char;
        searchableIndex[key] = true;
        prevKey = key;
    }

    for (const char of arrName) {
        const key = secondkey + char;
        secondObject[key] = true;
        secondkey = key;
    }

    const grape = { ...searchableIndex, ...secondObject };
    return grape;
}