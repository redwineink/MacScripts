#!/bin/bash


    #######################################################################################
	#			Copyright (c) 2018, D8 Services Ltd.  All rights reserved.    #
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

	# HARDCODED VALUE FOR "languageCode" IS SET HERE
	languageCode=""


	# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 4 AND, IF SO, ASSIGN TO "languageCode"
	if [ "$4" != "" ] && [ "$languageCode" == "" ];then
		languageCode=$4
	fi

	if [ -z "$languageCode" ]; then
		echo "Error:  The parameter 'languageCode' is blank.  Please specify a user."
	fi
	if [[ "$languageCode" == "zh" ]]; then
		echo "NOTICE:  Setting language to Chinese"
		cd /Users
		homes=`ls -d *`
		for i in ${homes}; do
			if [ ! $i == "Shared" ];then
				cp /System/Library/User\ Template/zh_CN.lproj/Library/Preferences/.GlobalPreferences.plist /Users/$i/Library/Preferences/
				chown -R $i /Users/$i/Library/
			fi
		done
		languagesetup -langspec zh-Hans

		/usr/bin/defaults write /Library/Preferences/.GlobalPreferences AppleLocale zh-CN
		/usr/bin/defaults write /Library/Preferences/.GlobalPreferences AppleLanguages "(zh-Hans, zh-Hant, ko, en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, )"
		/usr/bin/defaults write AppleLanguages "(zh-Hans, zh-Hant, ko, en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, )"
		/usr/bin/defaults write /Library/Preferences/.GlobalPreferences Country "zh_CN"
		/usr/bin/defaults write -g AppleLanguages "(zh-Hans, zh-Hant, ko, en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, )"
	elif [[ "$languageCode" == "en" ]]; then
		echo "NOTICE:  Setting language to English"
		cd /Users
		homes=`ls -d *`
		for i in ${homes}; do
			if [ ! $i == "Shared" ];then
			cp /System/Library/User\ Template/English.lproj/Library/Preferences/.GlobalPreferences.plist /Users/$i/Library/Preferences/
			chown -R $i /Users/$i/Library/
			fi
		done
		languagesetup -langspec uk

		/usr/bin/defaults write /Library/Preferences/.GlobalPreferences AppleLocale en_uk
		/usr/bin/defaults write /Library/Preferences/.GlobalPreferences AppleLanguages "(en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt,zh-Hans, zh-Hant, ko,  )"
		/usr/bin/defaults write AppleLanguages "(en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, zh-Hans, zh-Hant, ko, )"
		/usr/bin/defaults write /Library/Preferences/.GlobalPreferences Country "UK"
		/usr/bin/defaults write -g AppleLanguages "(en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, zh-Hans, zh-Hant, ko, )"

	fi
exit 0