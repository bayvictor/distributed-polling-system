grep -rl "com\.android\.tools\.build\:gradle\:0\..*\' *$" * -R | cut -d":" -f1
