import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtCore import QUrl

from core import Service, Messenger

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    s = Service()
    engine.rootContext().setContextProperty("service", s)
    qmlRegisterType(Messenger, 'Messenger', 1, 0, 'Messenger')
    engine.load(QUrl("qml/main.qml"))
    engine.rootObjects()

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
