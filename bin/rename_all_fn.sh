find . -print0 | xargs -0 rename "s/[^0-9a-zA-Z]/-/g"
