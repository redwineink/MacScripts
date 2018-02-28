#!/bin/bash
        #######################################################################################
        #	Copyright (c) 2018, D8 Services Ltd.  All rights reserved.                    #
        #                                                                                     #
        #                                                                                     #
        #       THIS SOFTWARE IS PROVIDED BY D8 SERVICES LTD. "AS IS" AND ANY                 #
        #       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED     #
        #       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE        #
        #       DISCLAIMED. IN NO EVENT SHALL D8 SERVICES LTD. BE LIABLE FOR ANY              #
        #       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    #
        #       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;  #
        #       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND   #
        #       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    #
        #       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS #
        #       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                  #
        #                                                                                     #
        #######################################################################################	



#test if they exist
netaccountExist=`dscl . -read /Groups/com.apple.loginwindow.netaccounts > /dev/null; echo $?`
access_loginwindow=`dscl . -read /Groups//Groups/com.apple.access_loginwindow > /dev/null; echo $?`


secureUser=""
while [ -z $secureUser ];do
		secureUser="$(osascript -e 'Tell application "System Events" to display dialog "Please enter the AD Username to assign this computer to:" default answer "" with title "End user AD name" with text buttons {"Cancel","Ok"} default button 2' -e 'text returned of result')"
        if [[ "$secureUser" =~ [^a-zA-Z0-9] ]]; then
        echo "NOTICE: argument contains a space" >&2
        secureUser=""
		osascript -e 'Tell application "System Events" to display dialog "Please ensure no Spaces or illegal characters are entered." with title "Error with ID Entered" with text buttons {"Try Again"} default button 1'
        fi
done

# Delete if they exist
if [ $netaccountExist == 0 ];then
dscl . -delete /Groups/com.apple.loginwindow.netaccounts
fi
if [ $access_loginwindow == 0 ];then
dscl . -delete /Groups//Groups/com.apple.access_loginwindow
fi

# Work out the Group IDs
LastID=`dscl . -list /Groups PrimaryGroupID | awk '{print $2}' | sort -n | tail -1`
GID1=$((LastID + 1))
GID2=$((LastID + 2))

dscl . -create /Groups/com.apple.loginwindow.netaccounts
dscl . -create /Groups/com.apple.loginwindow.netaccounts PrimaryGroupID $GID1
dscl . -create /Groups/com.apple.loginwindow.netaccounts Password \*
dscl . -create /Groups/com.apple.loginwindow.netaccounts RealName "Login Window's custom net accounts"

dscl . -create /Groups/com.apple.access_loginwindow
dscl . -create /Groups/com.apple.access_loginwindow PrimaryGroupID $GID2
dscl . -create /Groups/com.apple.access_loginwindow Password \*
dscl . -create /Groups/com.apple.access_loginwindow RealName "Login Window ACL"

dseditgroup -o edit -n /Local/Default -a $secureUser -t user com.apple.loginwindow.netaccounts
#dseditgroup -o edit -n /Local/Default -a groupName -t group com.apple.loginwindow.netaccounts

dseditgroup -o edit -n /Local/Default -a com.apple.loginwindow.netaccounts -t group com.apple.access_loginwindow
dseditgroup -o edit -n /Local/Default -a localaccounts -t group com.apple.access_loginwindow

jamf recon -endUsername $secureUser
