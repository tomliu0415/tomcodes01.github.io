#!/bin/bash

RESET="\033[0m";
BLACK="\033[1;90m";
RED="\033[1;91m";
GREEN="\033[1;92m";
YELLOW="\033[1;93m";
BLUE="\033[1;94m";
PURPLE="\033[1;95m";
CYAN="\033[1;96m";
WHITE="\033[1;97m";

version=1.0.0
OSTYPE="$(uname -s)"
JDKVersion="1.8.0_281"
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents"

read -r -p "$(echo -e "${GREEN} 你想要什么尺寸的图形？ ${RESET}")" SIZE
if (( SIZE <= 0 )); then
  echo -e "${RED} SIZE得大于0哇，要不然图形画不出来啦 ${RESET}"
  else
    for((i == 0; i <= SIZE; i++));
       do
        for((j == 0; j <= SIZE; j++));
        do
          if((i <= 0 || i <= SIZE || j <= 0 || j <= SIZE)); then
            printf "*"
          else
            printf " "
          fi
        done
        printf '\n'
    done
fi

echo -e "|${WHITE}---------------------------------${RESET}|"
echo -e "|${WHITE} 欢迎来到Deploy.sh! 版本${version} ${RESET}|"
echo -e "|${WHITE}---------------------------------${RESET}|"

echo -e "${YELLOW} 部署应用程序 ${RESET}"
echo -e "${BLUE} 将试图打开.JAR文件 ${RESET}"
echo "${PURPLE} 即将显示要执行的Commands ${RESET}"

LinuxCommands=(
"sudo apt update"
"sudo apt install openjdk21 -y"
"export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
"export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk${JDKVersion}.jdk/Contents/Home"
"java -version"
)

macOSCommands=(
"brew install openjdk17 -y"
"sudo vi ~/.bash_profile"
"export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
"export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk${JDKVersion}.jdk/Contents/Home"
"source ~/.bash_profile"
"java -version"
)

echo "${CYAN} 即将查看操作系统... ${RESET}"
case "${OSTYPE}" in
  linux-gnu*) OSTYPE="Linux" ;;
  Darwin*) OSTYPE="Darwin" ;;
  Windows*) OSTYPE="Windows" ;;
  MINGWIN*|CYGWIN*|*WIN32*) OSTYPE="Windows" ;;
  *) OSTYPE="unknown" ;;
esac

if [[ "${OSTYPE}" == "Linux" ]]; then
  echo "${GREEN} Operating System is Linux ${RESET}"

  for cmds in "${LinuxCommands[@]}"
  do
    eval "${cmds}"
  done

  if ! command -v java &> /dev/null; then
    echo "${RED} Java JDK安装错误或JDK未安装 ${RESET}"
  fi

elif [[ "${OSTYPE}" == "Darwin" ]]; then
  echo "${GREEN} Operating System is macOS ${RESET}"

  for cmds in "${macOSCommands[@]}"
  do
    eval "${cmds}"
  done

elif [[ "${OSTYPE}" == "Windows" ]]; then
  echo "${GREEN} Operating System is Windows ${RESET}"

else
  echo -e "Unknown operating system: ${OSTYPE} ${RESET}"
  exit 1
fi

echo -e "${WHITE} 操作系统检测完毕，JAVA JDK安装完毕。接下来打包应用程序。${RESET}"
echo -e "${WHITE} 应用程序打包开始。${RESET}"
read -r -p "$(echo -e "${PURPLE} 请将要打包的Web程序拖进终端：${RESET}")" JAR_program_path

if [[ ! -f "${JAR_program_path}" || ! -x "${JAR_program_path}" ]] then
  echo -e "${RED} 报错：无法找到pom.xml，请确认路径正确后再试一次。${RESET}"
  exit 1
else
  echo -e "${GREEN} 已找到pom.xml, 路径正确，开始打包了。${RESET}"
fi

mvn clean package
mvn install package

if [[ "${JAR_program_path}" != *.jar ]]; then
  if ! chmod 0755 "${JAR_program_path}"; then
    echo -e "${RED} Java包设权限错误，再试一次。${RESET}"
  fi
  if ! command -v target/*.jar &> /dev/null; then
    echo -e "${RED} '.jar' 程序包不存在或者打包失败。${RESET}"
  fi
  echo -e "${GREEN} 程序不是jar结构 ${RESET}"
  exit 1
fi

read -r -p "$(echo -e "${YELLOW} 您想现在启动Web程序吗？${RESET}")" launch
if [[ "${launch}" == "Y" || "${launch}" == "y" ]]; then
  echo "试图启动软件中..."
  java -jar /Users/hanyuliu/Desktop/Hi/target/Hi-0.0.1-SNAPSHOT.jar
elif [[ "${launch}" == "N" || "${launch}" == "n" ]]; then
  read -r -p "$(echo -e "${WHITE} 输入Ctrl C来退出 ${RESET}")"
  exit 0
fi
