# build the test target using our custom intermediates directory
# and pipe the output to ocunit2junit

xcodebuild -target Calculator-iOS_LogicTests -configuration Debug -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO TEST_AFTER_BUILD=YES OBJROOT="${WORKSPACE}"/tmp/objs clean build | /usr/local/bin/ocunit2junit


