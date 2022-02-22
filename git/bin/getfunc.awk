# Used for comparing git diff by function name
# https://stackoverflow.com/questions/10478210/limit-git-diff-to-one-or-more-functions
# Used by grit 

BEGIN {
        ## 'f' variable is the function to search, set a regexp with it.
        f_regex = "^" f "[^a-zA-Z0-9]"
        ## When set, print line. Otherwise omit line. It is set when found the function searched. It is unset when found any character different from '#' with less spaces before it.
        in_func = 0
}
## Found function.
$1 == "def" && $2 ~ f_regex {
        ## Get position of first 'd' in the line.
        i = index( $0, "d" )
        ## Sanity check. Never should success because the condition was checked before.
        if ( i == 0 ) {
                next
        }
        ## Get characters until matched index before, check that all of them are spaces, and get its length.
        indent = substr( $0, 0, i - 1 )
        if ( indent ~ /^[[:space:]]*$/ ) {
                num_spaces = length( indent )
        }
        ## Set variable, print line and read next one.
        in_func = 1
        print
        next
}
## When we are inside the function, line doesn't begin with '#' and it's not a blank line (only spaces).
in_func == 1 && $1 ~ /^[^#]/ && $0 ~ /[^[:space:]]/ {
        ## Get how many characters there are until first non-space. The result is the position of first non-blank, so substract one to get the number of spaces.
        spaces = match( $0, /[^[:space:]]/ )
        spaces -= 1
        ## If current indent is less or equal that the indent of function definition, then end of function found, so end processing.
        if ( spaces <= num_spaces ) {
                in_func = 0
        }
}
## Self-explanatory.
in_func == 1 {
        print
}
