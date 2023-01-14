import sys
import os
from PySide6.QtQml import *
from PySide6.QtGui import *

if __name__ == "__main__":
    # os.environ["QT_QUICK_BACKEND"] = "software"
    # ^ If the code doesn't work and gives and error use this
    # It might fix your problem
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.path.join(os.path.dirname(__file__), "app.qml"))
    if not engine.rootContext():
        sys.exit(-1)
    try:
        sys.exit(app.exec())
    except:pass