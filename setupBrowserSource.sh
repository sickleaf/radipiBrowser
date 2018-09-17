#!/bin/bash

# NAME

SCRIPTNAME=Script;
BROWSERNAME=browserScript;
KEYDIRNAME=radikoInfo;
CONFIGNAME=config;
RESOURCENAME=

# USER

OWNGROUP=www-data;
RADIPIUSER=radipi;

# DIR

SCRIPTDIR=/home/${RADIPIUSER}/${SCRIPTNAME}
BROWSERSCRIPTDIR=/home/${RADIPIUSER}/${SCRIPTNAME}/${BROWSERNAME}
KEYDIR=/home/${RADIPIUSER}/${KEYDIRNAME}
ROOTDIR=$(cd $(dirname $0); pwd)
CONFIGDIR=${SCRIPTDIR}/${CONFIGNAME}
WEBBASEDIR=/var/www/html
WEBBASECONFIGDIR=/var/www/html/${CONFIGNAME}


echo "######################################";
echo "<< setupBrowserSource.sh>> setup START.";
echo "######################################";

#################################################
# [mkdir] BROWSERSCRIPTDIR
#################################################

mkdir -p ${BROWSERSCRIPTDIR};
if [ $? -eq 0 ]; then
	echo "[make directory] ${BROWSERSCRIPTDIR}";
fi

################################################
# [cp]scripts in SCRIPTDIR into BROWSERSCRIPTDIR
################################################

cp ${SCRIPTDIR}/*.sh ${BROWSERSCRIPTDIR};
if [ $? -eq 0 ]; then
	echo "[copy script] ${SCRIPTDIR}/*.sh -> ${BROWSERSCRIPTDIR}/*.sh";
fi


################################################
# [chmod,chown]change scripts permission,owner user:group in BROWSERSCRIPTDIR
################################################

chown root:${OWNGROUP} ${BROWSERSCRIPTDIR}/*.sh
chmod 550 ${BROWSERSCRIPTDIR}/*.sh
if [ $? -eq 0 ]; then
	echo "[chown,chmod] ${BROWSERSCRIPTDIR}/*.sh set permission as 550, set owner:group as root:${OWNGROUP}";
fi


################################################
# [chmod,chown]change keyfiles permission,owner user:group in KEYDIR
################################################

if [ -d ${KEYDIR} ]; then
	chown ${RADIPIUSER}:${OWNGROUP} ${KEYDIR}/*
	chmod +r ${KEYDIR}/*
	if [ $? -eq 0 ]; then
		echo "[chown,chmod] ${KEYDIR}/* add +r permission, and set owner:group as ${RADIPIUSER}:${OWNGROUP}";
	fi
fi

################################################
# [cp]files in ROOTDIR into WEBBASEDIR
################################################

cp -r ${ROOTDIR}/*  ${WEBBASEDIR}
if [ $? -eq 0 ]; then
	echo "[copy] ${ROOTDIR}/* -> ${WEBBASEDIR}";
fi


################################################
# [cp]configfiles from CONFIGDIR to WEBBASEDIR
################################################

mkdir -p ${WEBBASECONFIGDIR};
cp -r ${CONFIGDIR}/*  ${WEBBASECONFIGDIR}
if [ $? -eq 0 ]; then
	echo "[copy] ${CONFIGDIR}/* -> ${WEBBASECONFIGDIR}";
fi

echo "######################################";
echo "<< setupBrowserSource.sh>> setup COMPLETE.";
echo "######################################";
