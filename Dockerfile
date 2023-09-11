FROM amazonlinux:2

RUN yum -y update \
    && yum install -y tar unzip gzip bzip2-devel ed gcc gcc-c++ gcc-gfortran \
    less libcurl-devel openssl openssl-devel readline-devel xz-devel \
    zlib-devel glibc-static libcxx libcxx-devel llvm-toolset-7 zlib-static \
    && rm -rf /var/cache/yum

# Graal
ARG GRAAL_VERSION=21.3.3
ARG GRAAL_FOLDERNAME=graalvm-ce-java11-${GRAAL_VERSION}
ARG GRAAL_FILENAME=graalvm-ce-java11-linux-amd64-${GRAAL_VERSION}.tar.gz
RUN curl -4 -L https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/${GRAAL_FILENAME} | tar -xvz && \
    mv $GRAAL_FOLDERNAME /usr/lib/graalvm && \
    /usr/lib/graalvm/bin/gu install native-image && \
    ln -s /usr/lib/graalvm/bin/native-image /usr/bin/native-image && \
    rm -rf $GRAAL_FILENAME

# Graal maven plugin requires Maven 3.3.x
ARG MVN_VERSION=3.6.3
ARG MVN_FOLDERNAME=apache-maven-${MVN_VERSION}
ARG MVN_FILENAME=apache-maven-${MVN_VERSION}-bin.tar.gz
RUN curl -4 -L https://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/${MVN_VERSION}/binaries/${MVN_FILENAME} | tar -xvz && \
    mv $MVN_FOLDERNAME /usr/lib/maven && \
    ln -s /usr/lib/maven/bin/mvn /usr/bin/mvn && \
    rm -rf $MVN_FILENAME

# Gradle
ARG GRADLE_VERSION=7.4.1
ARG GRADLE_FOLDERNAME=gradle-${GRADLE_VERSION}
ARG GRADLE_FILENAME=gradle-${GRADLE_VERSION}-bin.zip
RUN curl -LO https://downloads.gradle-dn.com/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip && \
    mv $GRADLE_FOLDERNAME /usr/lib/gradle && \
    ln -s /usr/lib/gradle/bin/gradle /usr/bin/gradle && \
    rm -rf $GRADLE_FILENAME

ENV JAVA_HOME /usr/lib/graalvm
ENV PATH ${PATH}:${JAVA_HOME}/bin

VOLUME /project
WORKDIR /project
