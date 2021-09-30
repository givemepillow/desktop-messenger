# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
#from PySide2.QtCore import QObject, QUrl, Slot

from authentication import Verify

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    v = Verify()
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("v", v)
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/controller.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
