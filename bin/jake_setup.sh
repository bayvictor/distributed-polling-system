echo "nstalling

Requirements: Jake requires Node.js. Of course.

Get Jake:
"
git clone git://github.com/mde/node-jake.git

echo "Build Jake:
"
cd node-jake && make && sudo make install

echo "Or install with NPM:
"
npm install jake
jake
echo "
(Or, get the code, and npm link in the code root.)
Basic usage

jake [options] target (commands/options ...)

You can see what other options Jake supports by doing jake -h or jake --help Probably the most important option starting off is the -T or --tasks option that lets you see what tasks are defined in a Jakefile.
"

