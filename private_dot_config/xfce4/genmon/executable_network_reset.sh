#!/bin/bash

ssid=$1
nmcli con down "$ssid"
sleep 3
nmcli con up "$ssid"

