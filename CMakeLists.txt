cmake_minimum_required(VERSION 3.16)

project(WardView VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.11.1 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.11)

set_source_files_properties(Theme.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_executable(wardview
    main.cpp
)

qt_add_qml_module(wardview
    URI WardView
    QML_FILES
        Main.qml
        Theme.qml
        Sidebar.qml
        OverviewPage.qml
        VitalCard.qml
        TrendsPage.qml
        TrendRow.qml
)

set_target_properties(wardview PROPERTIES
    OUTPUT_NAME WardView
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(wardview
    PRIVATE Qt6::Quick Qt6::QuickControls2
)

install(TARGETS wardview
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
