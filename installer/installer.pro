TEMPLATE = aux

INSTALLER = installerApp

INPUT = $$PWD/config/config.xml $$PWD/packages
installerApp.input = INPUT
installerApp.output = $$INSTALLER

QT_DIR = $$dirname(QMAKE_QMAKE)
LUPDATE = $$QT_DIR/lupdate
LRELEASE = $$QT_DIR/lrelease

OUT_FILE = installerApp

win32 {
    OUT_FILE = installerApp.exe
    LUPDATE = $$QT_DIR/lupdate.exe
    LRELEASE = $$QT_DIR/lrelease.exe
}

message( QT_DIR = $$QT_DIR)
message( LUPDATE = $$LUPDATE)
message( LRELEASE = $$LRELEASE)

installerApp.commands = $$QT_DIR/../../../Tools/QtInstallerFramework/3.0/bin/binarycreator --offline-only -c $$PWD/config/config.xml -p $$PWD/packages $$PWD/$$OUT_FILE --verbose

installerApp.CONFIG += target_predeps no_link combine

commands += "$$LUPDATE $$PWD/packages/app/meta/installscript.js -ts $$PWD/packages/app/meta/ru.ts"
commands += "$$LRELEASE $$PWD/packages/app/meta/ru.ts"

for(command, commands) {
    system($$command)|error("Failed to run: $$command")
}


QMAKE_EXTRA_COMPILERS += installerApp

OTHER_FILES =

DISTFILES += \
    config/controlScript.js \
    config/config.xml \
    README.md \
    config/ru.ts \
    packages/app/meta/installscript.js \
    packages/app/meta/package.xml \
    packages/app/meta/ru.ts
