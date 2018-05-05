TOMCAT_HOME=/root/tomcat85
war=$1
bin=$(cd `dirname $0`; pwd)

if [ ! -n "${war}" ]; then
    echo "***Usage: $0 [project.war]"
    exit 0
fi
if [ ! -f "${war}" ]; then
    echo "***Error: ${war} does not exist."
    exit 0
fi
if [ ! "${war##*.}" = "war" ]; then
    echo "***Error: ${war} is not a war file."
    exit 0
fi

echo "Deploy ${war##*/}..."
rm -rf ${TOMCAT_HOME}/webapps/${war} && unzip -qo ${war} -d ${TOMCAT}/webapps/
rm -rf ${TOMCAT_HOME}/work/Catalina/localhost/
echo "Restart tomcat..."
exec ${bin}/restart.sh