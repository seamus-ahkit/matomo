$(document).ready(function() {
    setTimeout(function() {
        const loadingPiwik = $('#localtime .loadingPiwik');
        loadingPiwik.hide();

        const localTimeElement = $('#localtime');
        const siteTimezone = localTimeElement.data("timezone");
        const userTimezone = new Intl.DateTimeFormat().resolvedOptions().timeZone;

        updateTime(siteTimezone, userTimezone);

        setInterval(function() {
            updateTime(siteTimezone, userTimezone)
        }, 60000);
    }, 3000);
});

function displayTime(timezone) {
    const now = new Date();

    const dateTimeFormat = new Intl.DateTimeFormat('en-CA', { 
        timeZone: timezone, 
        hour12: false, 
        year: 'numeric', 
        month: '2-digit', 
        day: '2-digit', 
        hour: '2-digit', 
        minute: '2-digit', 
        second: '2-digit' 
    });

    const parts = dateTimeFormat.formatToParts(now);
    const dateParts = {};
    parts.forEach(({ type, value }) => {
        dateParts[type] = value;
    });

    return `${dateParts.year}-${dateParts.month}-${dateParts.day} ${dateParts.hour}:${dateParts.minute}`;
}

function updateTime(siteTimezone, userTimezone) {
    if (siteTimezone !== userTimezone) {
        $('#siteTime').text(`Website time (${siteTimezone}): ${displayTime(siteTimezone)}`);
        $('#userTime').text(`Local time (${userTimezone}): ${displayTime(userTimezone)}`);
        $('#userTime').show();
    } else {
        $('#siteTime').text(displayTime(siteTimezone));
    }
}
