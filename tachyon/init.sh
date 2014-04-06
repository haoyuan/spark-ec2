#!/bin/bash

pushd /root

if [ -d "tachyon" ]; then
  echo "Tachyon seems to be installed. Exiting."
  popd
  return 0
fi

# TACHYON_VERSION=0.4.1
TACHYON_VERSION=9.9.9
TACHYON_HADOOP_VERSION=2.3.0

# Github tag:
if [[ "$TACHYON_VERSION" == 9.9.9 ]]
then
  # Setup Maven

  wget http://apache.claz.org/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz ;
  tar -xzvf apache-maven-3.0.5-bin.tar.gz ;
  mv apache-maven-3.0.5 maven ;
  rm -rf apache-maven-3.0.5-bin.tar.gz ;
  echo "export M2_HOME=/root/maven" >> .bashrc ;
  echo "export M2=\$M2_HOME/bin" >> .bashrc ;
  echo "export MAVEN_OPTS=\"-Xms256m -Xmx512m\"" >> .bashrc ;
  echo "export PATH=\$M2:\$PATH" >> .bashrc ;
  echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> .bashrc ;
  source .bashrc;

  # Setup Tachyon
  echo "Get lastest Tachyon from github:"
  git clone https://github.com/amplab/tachyon.git

  if [[ "$TACHYON_HADOOP_VERSION" == 2.3.0 ]]
  then
    cd /root
    wget https://s3.amazonaws.com/Tachyon/hadoop-2.3.0.tar.gz ;
    tar -xzvf hadoop-2.3.0.tar.gz ;
    cd /root/hadoop-2.3.0 ;
    mkdir conf ;
    cd /root ;
    # rm -rf /root/hadoop-2.3.0/etc/hadoop/* ;
    # cp /root/ephemeral-hdfs/conf/* /root/hadoop-2.3.0/etc/hadoop/. ;
    # /root/spark-ec2/copy-dir /root/hadoop-2.3.0 ;
    # cd /root/hadoop-2.3.0 ;
    # ./bin/hdfs namenode -format ;
    # ./sbin/start-dfs.sh ;

    cd /root/tachyon ;
    mvn clean -Dhadoop.version=2.3.0 -DskipTests install ;
  else
    cd /root/tachyon ;
    mvn clean -DskipTests install ;
  fi
# Pre-package Tachyon version
else
  case "$TACHYON_VERSION" in
    0.3.0)
      wget https://s3.amazonaws.com/Tachyon/tachyon-0.3.0-bin.tar.gz
      ;;
    0.4.0)
      wget https://s3.amazonaws.com/Tachyon/tachyon-0.4.0-bin.tar.gz
      ;;
    0.4.1)
      wget https://s3.amazonaws.com/Tachyon/tachyon-0.4.1-bin.tar.gz
      ;;
    *)
      echo "ERROR: Unknown Tachyon version"
      return -1
  esac

  echo "Unpacking Tachyon"
  tar xvzf tachyon-*.tar.gz > /tmp/spark-ec2_tachyon.log
  rm tachyon-*.tar.gz
  mv `ls -d tachyon-*` tachyon
fi

popd
