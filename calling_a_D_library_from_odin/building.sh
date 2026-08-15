pushd ${PWD}
cd ../mylib
dub build
LIBS=${PWD}
popd
echo ${PWD}
odin build . -extra-linker-flags:"-L${LIBS} -lphobos2 -pthread -lexample_mylib"

