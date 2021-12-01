function send() {
    if (textArea.text !== '')
        messenger.sendMessage(textArea.text)
    textArea.text = ''
}

let months = {
    0: "января",
    10: "ноября",
    11: "декабря",
    9: "октября",
    8: "сентября",
    7: "августа",
    6: "июля",
    5: "июня",
    4: "мая",
    3: "апреля",
    2: "марта",
    1: "февраля"
}

function getMessageTime(timestamp) {
    var date = new Date(timestamp)
    if (date.getDate() == new Date().getDate())
        return ('0' + date.getHours()).slice(-2) +
        ":"+
        ('0' + date.getMinutes()).slice(-2)
    else
        return date.getDate() +
        " " +
        months[date.getMonth()] +
        " " +
        ('0' + date.getHours()).slice(-2) +
        ":"+
        ('0' + date.getMinutes()).slice(-2)
}


function getUserTime(timestamp) {
    let date = new Date(timestamp)
    if (date.getDate() == new Date().getDate())
        return "в " + 
        ('0' + date.getHours()).slice(-2) +
        ":"+
        ('0' + date.getMinutes()).slice(-2)
    else
        return date.getDate() + 
        " " +
        months[date.getMonth()] +
        " в " +
        ('0' + date.getHours()).slice(-2) +
        ":"+
        ('0' + date.getMinutes()).slice(-2)
}
