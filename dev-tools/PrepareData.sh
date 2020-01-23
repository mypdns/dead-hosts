#!/bin/bash
# Hosts file generator for Badd Boyz Hosts
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/Badd-Boyz-Hosts
# MIT License

# **********************************
# Setup input bots and referer lists
# **********************************

input1="${TRAVIS_BUILD_DIR}/PULL_REQUESTS/domains.txt"

# *********************************************
# Get Travis CI Prepared for Committing to Repo
# *********************************************

#PrepareTravis () {
#    git remote rm origin
#    git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git
#    git config --global user.email "${GIT_EMAIL}"
#    git config --global user.name "${GIT_NAME}"
#    git config --global push.default simple
#    git checkout "${GIT_BRANCH}"
#    ulimit -u
#}
#PrepareTravis

printf "\n\n\nImport rpz.mypdns.cloud from https://www.mypdns.org/\n\n\n"

printf "\n\n\nThe test file contains: $(wc -l < ${input1}) records\n\n\n"

mysql --batch --raw --host="${RPZ_DB_SERVER}" --user="${RPZ_DB_USER}" --password="${RPZ_DB_PASS}" --database="${RPZ_DB}" -N -q -e "SELECT \`name\` FROM ${RPZ_DB_TABLE} WHERE \`domain_id\`=$RPZ_DOMAIN_ID AND name NOT REGEXP '^[*]\.'\;" | sed 's/\.mypdns\.cloud//;/\.mypdns\.cloud/d;/^name$/d' >> "${input1}"

#mysql --host="${RPZ_DB_SERVER}" --user="${RPZ_DB_USER}" --password="${RPZ_DB_PASS}" --database="${RPZ_DB}"

printf "\n\n\nThe test file contains: $(wc -l < ${input1}) records\n\n\n"

dig axfr @axfr.ipv4.mypdns.cloud -p 5353 rpz.mypdns.cloud >> "${input1}"

printf "\n\n\nThe test file contains: $(wc -l < ${input1}) records\n\n\n"

# **************************************************************************
# Sort lists alphabetically and remove duplicates before cleaning Dead Hosts
# **************************************************************************


PrepareLists () {
    #wget -qO- 'https://gitlab.com/my-privacy-dns/matrix/matrix/raw/master/source/adware/domains.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/matrix/matrix/raw/master/source/adware/wildcard.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/dg-malicious/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/fademind_blocklists-facebook/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/phishing_army_blocklist_extended/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/suspiciousdomains_medium/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/mvps/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/notrack-malware/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/windowsspyblocker_extra/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/BBcan177_MS-4/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/ransomware.abuse.ch/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_ransomeware/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_tracking/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_malware/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_redirect/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_fraud/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/malwaredomainlist/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/yoyo.org/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/windowsspyblocker/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_hjk/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_ad_servers/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_emd/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/badd_boyz_hosts/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/StevenBlack/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/fademind_extras/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/the-big-list-of-hacked-malware-web-sites/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_mmt/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_grm/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/suspiciousdomains_low/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/urlhaus/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/BBcan177_MS-2/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/dg-ads/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_fsa/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_scam/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_exp/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/mobileadtrackers/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_phising/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/fademind_add_spam/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/CoinBlockerLists/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/someonewhocares/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/joewein/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_pup/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/xorcan/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/hphosts_psh/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/notrack-blocklist/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/cedia/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_ads/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/fademind_add_risk/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/fademind_antipopads/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/suspiciousdomains_high/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/my-privacy-dns/external-sources/hosts-sources/raw/master/data/blocklist_spam/domain.list' >> ${input1}
    #wget -qO- 'https://gitlab.com/spirillen/world-dumbest-ultimate-hosts-blacklist/raw/master/UltimateWorldBiggestDumbestHosts.hosts' >> ${input1}

    sort -u -f ${input1} -o ${input1}
    dos2unix ${input1}
 }
PrepareLists

# ***********************************
# Deletion of all whitelisted domains
# ***********************************

WhiteListing () {
    if [[ "$(git log -1 | tail -1 | xargs)" =~ "ci skip" ]]
        then
            hash uhb_whitelist
            uhb_whitelist -f "${input1}" -o "${input1}"
    fi
}
WhiteListing

exit ${?}

# MIT License

# Copyright (c) 2017, 2018, 2019 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
