#!/system/bin/sh

# Copyright (c) 2013, lioux
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#  - Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#  - Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGE.


# You require ROOT and BUSYBOX to use this script
# Either SuperSU or Superuser have to be installed


###
## Variables
###

# Maximum memory allowed in Kbytes for systemui.
# For example, 80000 for roughly 80 megabytes
SYSTEMUI_MEMORY_LIMIT=80000
#
SYSTEMUI_PROCESS="com.android.systemui"
SYSTEMUI_SERVICE="com.android.systemui/.SystemUIService"

#
ALWAYS_EXECUTE=""
SYSTEMUI_MEMORY_USAGE=""

###
## Functions
###

# Check if the command line argument "conditionally" is given
check_command_line_always_execute() {
	local execute_always
	local is_word_conditionally_present
	
	is_word_conditionally_present=$( echo "${@}" | grep conditionally >/dev/null 2>&1 )
	
	if [ "${?}" -eq 0 ]; then
		# if the word "conditionally" is present
		execute_always="false"
	else
		# if it isn't present
		execute_always="true"
	fi
	
	echo ${execute_always}
}

obtain_systemui_memory_usage() {
	local memory_usage
	
	memory_usage=$( su -c 'dumpsys meminfo' | grep ${SYSTEMUI_PROCESS} | busybox head -1 | busybox awk '{print $1}' )
	
	echo ${memory_usage}
}

restart_systemui() {
	su -c " \
		busybox pkill ${SYSTEMUI_PROCESS} >/dev/null ; \
		am startservice -n ${SYSTEMUI_SERVICE} >/dev/null ; \
	"
}

###
## Execute
###

ALWAYS_EXECUTE=$( check_command_line_always_execute "${@}" )

##
# Either always restart systemui or restart conditionally.
##

##
# Always restart systemui if the command line argument "conditionally" is not given
##
if [ "x${ALWAYS_EXECUTE}" = "xtrue" ]; then
	restart_systemui
else 

        SYSTEMUI_MEMORY_USAGE=$( obtain_systemui_memory_usage )

	##
	# only restart systemui if it is using more than the maximum memory allowed
	##
	if [ "${SYSTEMUI_MEMORY_LIMIT}" -lt "${SYSTEMUI_MEMORY_USAGE}" ]; then
		restart_systemui
	fi

fi
