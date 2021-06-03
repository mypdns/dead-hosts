#!/bin/bash
# **********************
# Run PyFunceble Testing
# **********************
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza

# ****************************************************************
# This uses the awesome PyFunceble script created by Nissar Chababy
# Find funceble at: https://github.com/funilrys/PyFunceble
# ****************************************************************

# **********************
# Setting date variables
# **********************

tag=$(date '+%F %X %Z %z')

# ******************
# Set our Input File
# ******************
GIT_DIR="$(git rev-parse --show-toplevel)"

input="${GIT_DIR}/PULL_REQUESTS/domains.txt"

# Global @PyFunceble test file
# input="https://raw.githubusercontent.com/PyFunceble/ci_test/master/test.list"

# **********************
# Run PyFunceble Testing
# **********************************************************
# Find PyFunceble at: https://github.com/funilrys/PyFunceble
# **********************************************************

RunFunceble () {

    cd "${GIT_DIR}/scripts"

    hash PyFunceble

    pyfunceble --ci -q -ex \
        --ci-end-command "bash ${GIT_DIR}/scripts/FinalCommit.sh" \
        --ci-max-minutes 55 \
        --ci-branch master \
        --ci-distribution-branch master \
        --ci-command "sort -u -f ${input} -o ${input}" \
        -f ${input}
}

RunFunceble


exit ${?}
