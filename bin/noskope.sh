sudo launchctl unload /Library/LaunchDaemons/com.netskope.client.auxsvc.plist
ps auxw | grep -i netsk | awk '{print $2}' | xargs kill -9
#https://www.atpeaz.com/disable-netskope-client-temporarily-on-your-mac/
# sudo launchctl load /Library/LaunchDaemons/com.netskope.client.auxsvc.plist

