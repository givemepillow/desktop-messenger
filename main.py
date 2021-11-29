import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtCore import QUrl

from core import Service, Messenger
from core.system import Storage

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    Storage.initialize()
    service = Service()

    engine.rootContext().setContextProperty("service", service)
    qmlRegisterType(Messenger, 'Messenger', 1, 0, 'Messenger')

    engine.load(QUrl("qml/main.qml"))
    engine.rootObjects()

    if not engine.rootObjects():
        Storage.close()
        sys.exit(-1)
    
    status = app.exec()
    Storage.close()
    sys.exit(status)
