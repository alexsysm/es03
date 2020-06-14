# Elasticsearch 7.6.0

FROM docker.elastic.co/elasticsearch/elasticsearch:7.6.0@sha256:fb37d2e15d897b32bef18fed6050279f68a76d8c4ea54c75e37ecdbe7ca10b4b

# user 설정
#USER root

# shell 설정
SHELL ["/bin/bash", "-c"]

# vm.max 설정
RUN echo "vm.max_map_count=262144" >> /etc/sysctl.conf

# copy elasticsearch.yml
COPY config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

# 한글 nori 분석기 설치
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-nori

# copy 사용자 정의 사전 및 유의어 사전
COPY plugins/analysis/user_dic.txt config/analysis/user_dic.txt
COPY plugins/analysis/synonyms.txt config/analysis/synonyms.txt

# 한글 자모/초성 분석기 설치
COPY plugins/elasticsearch-hangul-jamo-analyzer-7.6.0.zip /
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///elasticsearch-hangul-jamo-analyzer-7.6.0.zip 
