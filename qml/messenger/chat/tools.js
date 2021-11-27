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
        return date.getHours()+":"+date.getMinutes()
    else
        return date.getDate() + " " + months[date.getMonth()] + " " + date.getHours()+":"+date.getMinutes()

}


function getUserTime(timestamp) {
    let date = new Date(timestamp)
    if (date.getDate() == new Date().getDate())
        return "в " + date.getHours()+":"+date.getMinutes()
    else
        return date.getDate() + " " + months[date.getMonth()] + " в " + date.getHours()+":"+date.getMinutes()
}
