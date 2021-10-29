let CURRENT_WINDOW = null;

function replaceWindows(newWindow) {
    if (CURRENT_WINDOW !== null) {
        CURRENT_WINDOW.close()
        CURRENT_WINDOW.destroy();
    }
    CURRENT_WINDOW = newWindow;
    CURRENT_WINDOW.show();
}

function createWindow(componentFile) {
    let component = Qt.createComponent(componentFile);
    let window = component.createObject();
    replaceWindows(window);
}
