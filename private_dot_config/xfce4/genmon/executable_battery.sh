#!/usr/bin/env fish

set bat_energy_full_at_threshold "true"

set bat0_energy_now_raw (cat /sys/class/power_supply/BAT0/energy_now)
set bat0_energy_full_raw (cat /sys/class/power_supply/BAT0/energy_full)
set bat0_energy_now (echo "$bat0_energy_now_raw/1000" | qalc -t -f -)
set bat0_energy_full (echo "$bat0_energy_full_raw/1000" | qalc -t -f -)
if test $bat_energy_full_at_threshold = "true"
    set bat0_threshold (cat /sys/class/power_supply/BAT0/charge_stop_threshold)
    set bat0_energy_full (echo "$bat0_threshold/100*$bat0_energy_full" | qalc -t -f -)
end
set bat0_pct (echo "100*$bat0_energy_now/$bat0_energy_full" | qalc -t -f - | awk '{printf("%.0f"), $1}')

set bat1_energy_now_raw (cat /sys/class/power_supply/BAT1/energy_now)
set bat1_energy_full_raw (cat /sys/class/power_supply/BAT1/energy_full)
set bat1_energy_now (echo "$bat1_energy_now_raw/1000" | qalc -t -f -)
set bat1_energy_full (echo "$bat1_energy_full_raw/1000" | qalc -t -f -)
if test $bat_energy_full_at_threshold = "true"
    set bat1_threshold (cat /sys/class/power_supply/BAT1/charge_stop_threshold)
    set bat1_energy_full (echo "$bat1_threshold/100*$bat1_energy_full" | qalc -t -f -)
end
set bat1_pct (echo "100*$bat1_energy_now/$bat1_energy_full" | qalc -t -f - | awk '{printf("%.0f"), $1}')

set bat_pct (echo "100*($bat0_energy_now + $bat1_energy_now)/($bat0_energy_full + $bat1_energy_full)" | qalc -t -f - | awk '{printf("%.0f"), $1}')

if test (cat /sys/class/power_supply/AC/online) -eq 1
    if test $bat_pct -ge 99
        set icon "$(echo \UF0085) "
    else if test $bat_pct -ge 90
        set icon "$(echo \UF008B) "
    else if test $bat_pct -ge 80
        set icon "$(echo \UF008A) "
    else if test $bat_pct -ge 70
        set icon "$(echo \UF089E) "
    else if test $bat_pct -ge 60
        set icon "$(echo \UF0089) "
    else if test $bat_pct -ge 50
        set icon "$(echo \UF089D) "
    else if test $bat_pct -ge 40
        set icon "$(echo \UF0088) "
    else if test $bat_pct -ge 30
        set icon "$(echo \UF0087) "
    else if test $bat_pct -ge 20
        set icon "$(echo \UF0086) "
    else if test $bat_pct -ge 10
        set icon "$(echo \UF089C) "
    else
        set icon "$(echo \UF089F) "
    end
else
    if test $bat_pct -ge 99
        set icon "$(echo \UF0079)"
    else if test $bat_pct -ge 90
        set icon "$(echo \UF0082)"
    else if test $bat_pct -ge 80
        set icon "$(echo \UF0081)"
    else if test $bat_pct -ge 70
        set icon "$(echo \UF0080)"
    else if test $bat_pct -ge 60
        set icon "$(echo \UF007F)"
    else if test $bat_pct -ge 50
        set icon "$(echo \UF007E)"
    else if test $bat_pct -ge 40
        set icon "$(echo \UF007D)"
    else if test $bat_pct -ge 30
        set icon "$(echo \UF007C)"
    else if test $bat_pct -ge 20
        set icon "$(echo \UF007B)"
    else if test $bat_pct -ge 10
        set icon "$(echo \UF007A)"
    else
        set icon "$(echo \UF10CD)"
    end
end

if test $bat_pct -ge 80
    set color "green"
else if test $bat_pct -ge 10; and test $bat_pct -lt 20
    set color "yellow"
else if test $bat_pct -lt 10
    set color "red"
else
    set color "white"
end

set txt "<txt>"
set txt $txt"<span foreground='$color'>$icon</span> $bat_pct%"
set txt $txt"</txt>"

set tool "<tool>"
set tool $tool"internal: $bat0_pct% ($bat0_energy_now mWh/$bat0_energy_full mWh)\nexternal: $bat1_pct% ($bat1_energy_now mWh/$bat1_energy_full mWh)"
set tool $tool"</tool>"

set txtclick "<txtclick>"
set txtclick $txtclick"xfce4-power-manager-settings"
set txtclick $txtclick"</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
