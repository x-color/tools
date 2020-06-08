# godoc is alias command of 'go doc'.
# Searching types, const variables and functions in godoc.
# If you want to check the godoc of these in browser, you types 'ctrl-o'.
# Usage:
#   You want to view 'net/http' package:
#   $ godoc http
#   You want to view Server struct in 'net/http' package:
#   $ godoc http.Server
function godoc() {
    local R=$(go doc $1 |
            tail -r |
            sed -e "/^$/,$ d" -e "s/^[[:space:]]*//" | 
            tail -r |
            sort |
            fzf --preview-window down \
                --preview '(){
                    local FLAG=$(echo {} | cut -d " " -f2 | cut -c 1)
                    local FUNC
                    if [[ "$FLAG" = "(" ]]; then
                        FUNC=$(echo {} | cut -d"(" -f2 | rev | cut -d" " -f1 | rev)
                        go doc '$1'.$FUNC
                    else
                        FUNC=$(echo {} | cut -d " " -f2 | cut -d "(" -f1)
                        go doc '${1%.*}'.$FUNC
                    fi
                }' \
                --bind 'ctrl-o:execute-silent((){
                    local FLAG=$(echo {} | cut -d " " -f2 | cut -c 1)
                    local PKG=$(go doc $(echo '$1' | cut -d "." -f1) | head -1 | cut -d "\"" -f2 | cut -d "\"" -f1)
                    local TYPE=$(echo '$1' | cut -d "." -f2-)
                    local FUNC
                    if [[ "$FLAG" = "(" ]]; then
                        FUNC=$(echo {} | cut -d"(" -f2 | rev | cut -d" " -f1 | rev)
                        open https://godoc.org/$PKG#$TYPE.$FUNC
                    else
                        FUNC=$(echo {} | cut -d " " -f2 | cut -d "(" -f1)
                        open https://godoc.org/$PKG#$FUNC
                    fi
                })')

    local FLAG=$(echo $R | cut -d " " -f2 | cut -c 1)
    local FUNC
    if [[ "$FLAG" = "(" ]]; then
        FUNC=$(echo $R | cut -d"(" -f2 | rev | cut -d" " -f1 | rev)
        go doc $1.$FUNC
    elif [[ "$FLAG" != "" ]]; then
        FUNC=$(echo $R | cut -d " " -f2 | cut -d "(" -f1)
        go doc ${1%.*}.$FUNC
    fi
}