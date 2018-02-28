#!/bin/bash


    #######################################################################################
	#			Copyright (c) 2015, D8 Services Ltd.  All rights reserved.    #
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


#cp /System/Library/User\ Template/zh_CN.lproj/Library/Preferences/.GlobalPreferences.plist /Library/Preferences/
#cp /System/Library/User\ Template/zh_CN.lproj/Library/Preferences/.GlobalPreferences.plist /System/Library/User\ Template/English.lproj/Library/Preferences/
#cp /System/Library/User\ Template/zh_CN.lproj/Library/Preferences/.GlobalPreferences.plist /var/wantitadmin/Library/Preferences/

for i in `ls /Users`; do
	cp /System/Library/User\ Template/zh_CN.lproj/Library/Preferences/.GlobalPreferences.plist /Users/$i/Library/Preferences/
	chown -R $i /Users/$i/Library/
done
languagesetup -langspec zh-Hans

/usr/bin/defaults write /Library/Preferences/.GlobalPreferences AppleLocale zh-CN
/usr/bin/defaults write /Library/Preferences/.GlobalPreferences AppleLanguages "(zh-Hans, zh-Hant, ko, en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, )"
/usr/bin/defaults write AppleLanguages "(zh-Hans, zh-Hant, ko, en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, )"
/usr/bin/defaults write /Library/Preferences/.GlobalPreferences Country "zh_CN"
/usr/bin/defaults write -g AppleLanguages "(zh-Hans, zh-Hant, ko, en, ja, fr, de, es, it, nl, sv, nb, da, fi, pt, )"

exit 0