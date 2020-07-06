#-------------------------------------------------
#
# Project created by QtCreator 2018-07-05T22:26:31
#
#-------------------------------------------------

QT       += core gui network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = Beslyric-for-X
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# To enable qDebug() under "release", disable QT_NO_DEBUG_OUTPUT bellow
CONFIG (release, debug|release) {
DEFINES *= QT_NO_DEBUG_OUTPUT
}

INCLUDEPATH +=$$PWD BesWidgets
include(BesWidgets/BesWidgets.pri)

INCLUDEPATH +=$$PWD StackFrame
include(StackFrame/StackFrame.pri)

INCLUDEPATH +=$$PWD TopWidgets
include(TopWidgets/TopWidgets.pri)

INCLUDEPATH +=$$PWD MiddleWidgets
include(MiddleWidgets/MiddleWidgets.pri)

INCLUDEPATH +=$$PWD BottomWidgets
include(BottomWidgets/BottomWidgets.pri)

INCLUDEPATH +=$$PWD Entities
include(Entities/Entities.pri)

INCLUDEPATH +=$$PWD Utility
include(Utility/Utility.pri)


SOURCES += main.cpp \
    StackFrame.cpp

HEADERS  += \
    Define/Define.h\
    Define/Enum.h\
    Define/Struct.h\
    Define/Static.h\
    global.h \
    StackFrame.h \
    MyApplication.h

DISTFILES += \
    BesLyric.rc \
    version.txt

RESOURCES += \
    resource.qrc


# windows icon and exe file infomation
win32{
RC_FILE = Beslyric.rc
}

# set icon under Mac Os
macx{
ICON = Beslyric.icns
}

# ubuntu icon recoginition
#  No test on other Linux distros!
# from: https://stackoverflow.com/questions/45329372/ubuntu-recognizes-executable-as-shared-library-and-wont-run-it-by-clicking
!macx:unix{
    QMAKE_LFLAGS *= -no-pie
}

#--------------------------------

# Separate the binary file.
CONFIG(debug, debug|release){
    DESTDIR = $${OUT_PWD}/debug_bin
}
CONFIG(release, debug|release){
    DESTDIR = $${OUT_PWD}/release_bin
}

#--------------------------------

#屏蔽 msvc 编译器对 rational.h 的 warning: C4819: 该文件包含不能在当前代码页(936)中表示的字符。请将该文件保存为 Unicode 格式以防止数据丢失
win32-msvc*:QMAKE_CXXFLAGS += /wd"4819"


unix:!macx{

#消除ffmpeg中对使用旧接口的警告
QMAKE_CXXFLAGS += -Wno-deprecated-declarations

}

#--------------------------------

# Third party libraries for Windows and macOS
win32|macx{
    B4X_LIB_PATH = $$getenv(B4X_LIB_PATH)

    isEmpty(B4X_LIB_PATH){
        error("env \"B4X_LIB_PATH\" is NOT set.")
    }

    !exists($${B4X_LIB_PATH}){
        error("\"$${B4X_LIB_PATH}\" is NOT existed.")
    }

    B4X_LIB_PATH_INCLUDE = $${B4X_LIB_PATH}/include

    win32{
        # Distinguish the architectures of the Windows platform.
        # Don't use "QMAKE_HOST.arch" because it reported "x86" when the 64 bit kit enabled.
        message(QT_ARCH = $${QT_ARCH})
        equals(QT_ARCH, i386){
            B4X_LIB_PATH_LIB = $${B4X_LIB_PATH}/win32/lib
        }else:equals(QT_ARCH, x86_64){
            B4X_LIB_PATH_LIB = $${B4X_LIB_PATH}/win64/lib
        }
    }
    macx{
        B4X_LIB_PATH_LIB = $${B4X_LIB_PATH}/lib
    }

    !exists($${B4X_LIB_PATH_INCLUDE}){
        error("\"$${B4X_LIB_PATH_INCLUDE}\" is NOT existed.")
    }

    !exists($${B4X_LIB_PATH_LIB}){
        error("\"$${B4X_LIB_PATH_LIB}\" is NOT existed.")
    }

    INCLUDEPATH *= $${B4X_LIB_PATH_INCLUDE}
    message("Added \"$${B4X_LIB_PATH_INCLUDE}\" to \"INCLUDEPATH\".")

    LIBS *= -L$${B4X_LIB_PATH_LIB}
    message("Added \"$${B4X_LIB_PATH_LIB}\" to \"LIBS\".")
}

LIBS *= -lavcodec \
        -lavdevice \
        -lavfilter \
        -lavformat \
        -lavutil \
        -lpostproc \
        -lswresample \
        -lswscale \
        -lSDL2

message(INCLUDEPATH = $$INCLUDEPATH)
message(LIBS = $$LIBS)

#--------------------------------
