FROM centos:centos6
MAINTAINER Diffeo <support@diffeo.com>

RUN yum install -y epel-release \
 && yum update -y \
 && yum clean all

# Update the system to current packages;
RUN yum install -y \
      ant \
      ant-apache-regexp \
      ivy \
      java-1.7.0-openjdk \
      java-1.7.0-openjdk-devel \
      java-util \
      tar \
      unzip \
      wget \
      zip \
 && yum clean all

# Get a tagged release of OpenSextantToolbox -- 2.2.3 has large gaz turned on
ENV OST_VERSION=2.2.3 GAZDATA_VERSION=20141229

RUN wget -O ost.tar.gz https://github.com/streamcorpus/OpenSextantToolbox/archive/${OST_VERSION}.tar.gz \
 && tar xzf ost.tar.gz \
 && rm ost.tar.gz

# Get pre-built "merged" gazetteer files
# See full listing: http://opensextant.org/downloads/gazdata/
RUN cd OpenSextantToolbox-${OST_VERSION}/LanguageResources/resources \
 && mkdir geoGazetteer \
 && cd geoGazetteer \
 && wget http://opensextant.org/downloads/gazdata/gazdata-${GAZDATA_VERSION}.zip \
 && unzip gazdata-${GAZDATA_VERSION}.zip \
 && rm gazdata-${GAZDATA_VERSION}.zip \
 && (grep '\[LATIN\]' MergedGazetteer.txt > latin.tsv) \
 && mv latin.tsv MergedGazetteer.txt

# Build and unpack the release
# Note that the final zip file version includes a date stamp
RUN cd OpenSextantToolbox-${OST_VERSION}/OpenSextantToolbox/ \
 && ant release -Dversion=${OST_VERSION} \
 && cd ../.. \
 && unzip OpenSextantToolbox-${OST_VERSION}/OpenSextantToolbox/opensextant-toolbox-${OST_VERSION}*.zip \
 && cd OpenSextantToolbox-${OST_VERSION}/OpenSextantToolbox/ \
 && ant clean

# Record build number
COPY container-version /etc/

# Finally, run the OpenSextant tagger end point
EXPOSE 8182
WORKDIR opensextant-toolbox-${OST_VERSION}
CMD bash ./scripts/start.sh
