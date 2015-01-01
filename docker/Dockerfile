FROM centos:centos6
MAINTAINER Diffeo <support@diffeo.com>

RUN yum install -y epel-release \
 && yum update -y \
 && yum clean all

# Update the system to current packages;
RUN yum install -y wget \
 && yum install -y tar \
 && yum install -y zip unzip \
 && yum install -y ant java-1.7.0-openjdk-devel ant-apache-regexp java-util \
 && yum install -y java-1.7.0-openjdk \
 && yum install -y java-1.7.0-openjdk-devel \
 && yum install -y ivy \
 && yum clean all 

# Get a tagged release of OpenSextantToolbox -- 2.2.3 has large gaz turned on
RUN wget -O ost.tar.gz https://github.com/streamcorpus/OpenSextantToolbox/archive/2.2.3.tar.gz
RUN tar xzf ost.tar.gz

# Get pre-built "merged" gazetteer files, see full listing: http://opensextant.org/downloads/gazdata/
RUN cd OpenSextantToolbox-*/LanguageResources/resources \
 && mkdir geoGazetteer \
 && wget http://opensextant.org/downloads/gazdata/gazdata-20141229.zip \
 && unzip gazdata*zip

RUN cd OpenSextantToolbox-*/OpenSextantToolbox/ && ant release

# unpack the release
RUN unzip OpenSextantToolbox-*/OpenSextantToolbox/opensextant-toolbox-*zip

# Finally, run the OpenSextant tagger end point
EXPOSE 8182
CMD cd opensextant-toolbox-*/ && bash ./scripts/start.sh
