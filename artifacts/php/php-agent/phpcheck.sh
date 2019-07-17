realPathOfExistingFile() {
    local __targetFile=$1
    local __realDir

    if [ -d "${__targetFile}" ] ; then
        cd "${__targetFile}"
        __realDir=$(pwd -P)
        echo "${__realDir}"
        return
    fi

    cd "$(dirname "$__targetFile")"
    __targetFile=$(basename "$__targetFile")

    # Iterate down a (possible) chain of symlinks
    while [ -L "$__targetFile" ]
    do
        __targetFile=$(readlink "$__targetFile")
        cd "$(dirname "$__targetFile")"
        __targetFile=$(basename "$__targetFile")
    done

    # Compute the canonicalized name by finding the physical path
    # for the directory we're in and appending the target file.
    __realDir=$(pwd -P)
    if [ "${__targetFile}" = "." ] ; then
      echo "$__realDir"
      return
    fi
    echo "$__realDir/$__targetFile"
}

realPath() {
    local __targetFile=$1
    local __suffix
    local __currBaseName
    local __currDirName
    local __realPath

    if [ -e "${__targetFile}" ] ; then
        realPathOfExistingFile "${__targetFile}"
        return
    fi

    __suffix=$(basename "${__targetFile}")
    __currDirName=$(dirname "${__targetFile}")

    while [ ! -e "${__currDirName}" ]
    do
        __currBaseName=$(basename "${__currDirName}")
        __suffix="${__currBaseName}/${__suffix}"
        __currDirName=$(dirname "${__currDirName}")
    done
    __realPath=$(realPathOfExistingFile "${__currDirName}")
    __realPath="${__realPath}/${__suffix}"
    echo "${__realPath}"
}

pathadd() {
    case "${PATH}" in
    $1:*) ;;
    *:$1) ;;
    *:$1:*) ;;
    *) if [ -d "$1" ]; then PATH="${PATH}:$1"; fi ;;
    esac
}

getDefaultPHPPath() {
    local __phpBinary __phpPath
    if [ -n "${APPD_PHP_PATH}" -a -x "${APPD_PHP_PATH}/php" ]; then
        __phpPath=${APPD_PHP_PATH}
    else
        __phpBinary=`which php 2>/dev/null`
        [ -n "${__phpBinary}" ] && __phpPath=`dirname ${__phpBinary}`
    fi
    echo $__phpPath
}

# Wraps detectPHPInfo for backwards compatibility with
# pre-install scripts.
getPHPInfo() {
    detectPHPInfo "$1"
    phpExtDir=${detectedPHPExtDir}
    phpConfDir=${detectedPHPConfDir}
    phpVersionNum=${getPHPVersionNum}
    phpVersionId=${detectedPHPVersionId}
    phpSuhosinPatchStatus=${detectedPHPSuhosinPatchStatus}
}

detectPHPInfo() {
    local __phpDir __phpBinary
    __phpDir=$1
    __phpBinary="${__phpDir}/php"
    if [ ! -x "${__phpBinary}" ] ; then
        detectedPHPExtDir=""
        detectedPHPConfDir=""
        detectedPHPVersionNum=""
        detectedPHPVersionId=""
        detectedPHPSuhosinPatchStatus=""
        return
    fi
    detectedPHPExtDir=$(getPHPExtensionsDir "${__phpBinary}")
    detectedPHPConfDir=$(getPHPConfDir "${__phpBinary}")
    detectedPHPVersionNum=$(getPHPVersionNum "${__phpBinary}")
    detectedPHPVersionId=$(getPHPVersionId "${__phpBinary}")
    detectedPHPSuhosinPatchStatus=$(getSuhosinPatchStatus "${__phpBinary}")
}

resolvePHPInfo() {
    phpExtDir=${phpExtDir:-${detectedPHPExtDir}}
    phpConfDir=${phpConfDir:-${detectedPHPConfDir}}
    phpVersionNum=${phpVersionNum:-${detectedPHPVersionNum}}
    phpVersionId=${phpVersionId:-${detectedPHPVersionId}}
    phpSuhosinPatchStatus=${detectedPHPSuhosinPatchStatus}
}

getPHPExtensionsDir() {
    local phpProgram="$1" ; shift
    local extDir
    extDir=$(${phpProgram} -dagent.cli_enabled=0 -r 'print "Extension-Dir:"; print ini_get("extension_dir"); print "\n";' 2>/dev/null)
    extDir=$(echo "${extDir}" | grep -e "^Extension-Dir:" | sed "s/Extension-Dir://")
    extDir=$(realPath "${extDir}")
    echo ${extDir}
}

getPHPConfDir() {
    local phpProgram="$1" ; shift
    local confDir
    confDir=$(${phpProgram} -dagent.cli_enabled=0 -r 'print "Conf-Dir:"; print PHP_CONFIG_FILE_SCAN_DIR;' 2>/dev/null)
    confDir=$(echo "${confDir}" | grep -e "^Conf-Dir:" | sed "s/Conf-Dir://")
    if [ -n "${confDir-}" ]; then
        confDir=$(realPath "${confDir}")
    fi
    echo ${confDir}
}

getPHPVersionNum() {
    local phpProgram="$1" ; shift
    local versionNum
    versionNum=$(${phpProgram} -dagent.cli_enabled=0 -r 'print "PHP-VersionNum:"; print PHP_VERSION_ID; print "\n";' 2>/dev/null)
    versionNum=$(echo "${versionNum}" | grep -e "^PHP-VersionNum:" | sed "s/PHP-VersionNum://")
    echo ${versionNum}
}

getPHPVersionId() {
    local phpProgram="$1" ; shift
    local versionId
    versionId=$(${phpProgram} -dagent.cli_enabled=0 -r 'print "PHP-VersionId:"; print phpversion(); print "\n";' 2>/dev/null)
    versionId=$(echo "${versionId}" | grep -e "^PHP-VersionId:" | sed "s/PHP-VersionId://")
    versionId=$(echo "${versionId}" | ${sedCmd} -e "s,([^.]+)\.([^.]+)\..*$,\1.\2,")
    echo ${versionId}
}

getSuhosinPatchStatus() {
    local phpProgram="$1" ; shift
    local patchApplied
    patchApplied=$(${phpProgram} -dagent.cli_enabled=0 -r 'print "PHP-Suhosin-Patched:" . (defined("SUHOSIN_PATCH") ? "patched" : "notpatched") . "\n";' 2>/dev/null)
    patchApplied=$(echo "${patchApplied}" | grep -e "^PHP-Suhosin-Patched:" | sed "s/PHP-Suhosin-Patched://")
    echo "${patchApplied}"
}
