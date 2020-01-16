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
input=${TRAVIS_BUILD_DIR}/PULL_REQUESTS/domains.txt
pyfuncebleConfigurationFileLocation=${TRAVIS_BUILD_DIR}/dev-tools/.PyFunceble.yaml
pyfuncebleProductionConfigurationFileLocation=${TRAVIS_BUILD_DIR}/dev-tools/.PyFunceble_production.yaml

# **********************
# Run PyFunceble Testing
# **********************************************************
# Find PyFunceble at: https://github.com/funilrys/PyFunceble
# **********************************************************

RunFunceble () {

    tag=$(date '+%F %X %Z %z')
    ulimit -u
    cd ${TRAVIS_BUILD_DIR}/dev-tools

    hash PyFunceble

    if [[ -f "${pyfuncebleConfigurationFileLocation}" ]]
    then
        rm "${pyfuncebleConfigurationFileLocation}"
        rm "${pyfuncebleProductionConfigurationFileLocation}"
    fi

    PyFunceble --ci -q -ex --plain --idna -db -h --http --database-type mariadb -m -p 4 \
        --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/FinalCommit.sh" \
        --cmd "cat ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/INACTIVE/list >> ${TRAVIS_BUILD_DIR}/PULL_REQUESTS/inactive.txt" \
        --autosave-minutes 20 --ci-branch master --ci-distribution-branch master \
        --commit-autosave-message "V1.${tag}.${TRAVIS_BUILD_NUMBER} [Auto Saved]" \
        --commit-results-message "V1.${tag}.${TRAVIS_BUILD_NUMBER}" \
        --dns 127.0.0.1 -f ${input}
}

RunFunceble


exit ${?}
