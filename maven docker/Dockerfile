FROM microsoft/nanoserver

ADD maven c:\\maven
ADD jdk c:\\jdk

ENV JAVA_HOME c:\\jdk
ENV M2_HOME c:\\maven

RUN MKDIR c:\\src
VOLUME c:\\src

WORKDIR c:\\src

ENTRYPOINT ["c:\\maven\\bin\\mvn.cmd"]

# Build once
#  docker build -t nanomaven .
# Now from the folder containing the pom.xml file run
# docker run --rm -v ${PWD}:c:\src nanomaven install
