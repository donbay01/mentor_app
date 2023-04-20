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

/**
 * Generate the search index with interests
 * @param {Array} interests 
 */
exports.indexInterests = (interests) => {
    let index = {}
    for (let i = 0; i < interests.length; i++) {
        var interest = interests[i].toLowerCase().split('')
        const searchableIndex = {}
        let prevKey = ''

        for (const char of interest) {
            const key = prevKey + char;
            searchableIndex[key] = true;
            prevKey = key;
        }

        index = { ...index, ...searchableIndex }
    }

    return index
}