#!/usr/bin/env fish

set updates "$(checkupdates | cut -d ' ' -f 1)"

set txt "<txt>"
set tool "<tool>"
set txtclick "<txtclick>"

if test $updates != ""
    set txt $txt"$(echo \UF487)  update"
    set tool $tool$updates
    set txtclick $txtclick"kitty fish -i -c 'pm -U'"
end

set txt $txt"</txt>"
set tool $tool"</tool>"
set txtclick $txtclick"</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
