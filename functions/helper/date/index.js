exports.addWeekMidNight = (date) => {
    const newWeek = new Date(date.getTime() + (7 * 24 * 60 * 60 * 1000))
    newWeek.setHours(0, 0, 0, 0)
    return newWeek
}

exports.newWeek = (date) => {
    const newWeek = new Date(date.getTime() + (7 * 24 * 60 * 60 * 1000))
    return newWeek
}