#!/bin/bash
 ###############################################################
	#	Copyright (c) 2014, D8 Services Ltd.  All rights reserved.  
	#											
	#	
	#	    THIS SOFTWARE IS PROVIDED BY D8 SERVICES LTD. "AS IS" AND ANY
	#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	#       DISCLAIMED. IN NO EVENT SHALL D8 SERVICES LTD. BE LIABLE FOR ANY
	#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	#
	#	
	###############################################################
	#
	#		Run this script after imaging a machine, this can run as a first run script, but needs no parameters set if used from the Casper Suite

# Determine OS version
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
sw_vers=$(sw_vers -productVersion)

# Determine OS build number
sw_build=$(sw_vers -buildVersion)

# Checks first to see if the Mac is running 10.7.0 or higher.
# If so, the script checks the system default user template
# for the presence of the Library/Preferences directory. Once
# found, the iCloud and Diagnostic pop-up settings are set
# to be disabled.

if [[ ${osvers} -ge 7 ]]; then

for USER_TEMPLATE in "/System/Library/User Template"/*

do

/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"

/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeSyncSetup2 -bool TRUE
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastCacheCleanupStillRunning -bool false
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastPreLoginTasksPerformedBuild "${sw_build}"
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastPreLoginTasksPerformedVersion "${sw_vers}"
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant RunNonInteractive -bool FALSE
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant ShowKeychainSyncBuddyAtLogin -bool FALSE
/usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant SkipFirstLoginOptimization -bool FALSE

done

# Hide 500 Users
# defaults write "/Library/Preferences/com.apple.loginwindow" Hide500Users -bool TRUE


# Checks first to see if the Mac is running 10.7.0 or higher.
# If so, the script checks the existing user folders in /Users
# for the presence of the Library/Preferences directory.
#
# If the directory is not found, it is created and then the
# iCloud and Diagnostic pop-up settings are set to be disabled.
for USER_HOME in /Users/*

do

USER_UID=`basename "${USER_HOME}"`
if [ ! "${USER_UID}" = "Shared" ]; then
	if [ ! -d "${USER_HOME}"/Library/Preferences ]; then
		/bin/mkdir -p "${USER_HOME}"/Library/Preferences
		/usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
		/usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
	fi

	if [ -d "${USER_HOME}"/Library/Preferences ]; then
		/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
		/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
		/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
		/usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"
		/usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist
	fi
fi
done
fi
exit 0