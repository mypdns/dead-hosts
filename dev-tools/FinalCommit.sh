#!/bin/bash

# ***********************************************************
# Remove our inactive and invalid domains from PULL_REQUESTS
# ***********************************************************

printf "\n\n\n\tExecuting FinalCommit.sh\n\n\n"

exit 0

grep -Ev "^($|#)" ${TRAVIS_BUILD_DIR}/dev-tools/output/domains/ACTIVE/list > tempdomains.txt
mv tempdomains.txt ${TRAVIS_BUILD_DIR}/PULL_REQUESTS/domains.txt

dead="${TRAVIS_BUILD_DIR}/dev-tools/output/domains/INACTIVE/list"
inactive="${TRAVIS_BUILD_DIR}/PULL_REQUESTS/inactive.txt"

if [ -f "$dead" ]
then
 cat "${dead}" | grep -Ev "^($|#)" >> "${inactive}"
 sort -u -f "${inactive}" -o "${inactive}"
fi

exit ${?}
