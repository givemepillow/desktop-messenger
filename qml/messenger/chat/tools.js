function send() {
    if (textArea.text !== '') {
            messagesContainer.model.append({
            "messageText":  textArea.text,
            "messageTime": Qt.formatTime(new Date(), "hh:mm")
        })
        textArea.text = ''
    }
}
