#!/bin/bash

# function definitions
function make_cpp_sdk() {
    rm -rf build
    rm -rf _install
    mkdir build && cd build || exit 1
    cmake ..
    make -j"$(nproc)"
    sudo make install
}

function make_javascript_sdk() {
    javascript/javascript_sdk/gen_proto.sh
}

function make_python_sdk() {
    python/configure.sh
}

# Main function
if [ $# -ne 1 ]; then
    echo "Usage: $0 generating-language"
    echo "Supported languages: cpp, javascript, python"
    exit 1
else
    if [ "$1" == "cpp" ]; then
        make_cpp_sdk
    elif [ "$1" == "javascript" ]; then
        make_javascript_sdk
    elif [ "$1" == "python" ]; then
        make_python_sdk
    else
        echo "$1 is not supported language."
        exit 1
    fi
    echo "Build $1 sdk complete."
fi
exit 0
