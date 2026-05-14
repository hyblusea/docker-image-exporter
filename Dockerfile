FROM eclipse-temurin:17-jre-jammy

# 用 Confluent 社区版镜像替代
# 或者手动下载 Confluent 版本的 Kafka
ADD https://packages.confluent.io/archive/7.3/confluent-community-7.3.2.tar.gz /opt/

RUN tar -zxvf /opt/confluent-community-7.3.2.tar.gz -C /opt/ \
    && mv /opt/confluent-7.3.2 /opt/kafka \
    && mkdir -p /var/lib/kafka/data \
    && rm -rf /opt/confluent-community-7.3.2.tar.gz

WORKDIR /opt/kafka

EXPOSE 9092 9093 8083

CMD ["/opt/kafka/bin/kafka-server-start.sh", "/opt/kafka/etc/kafka/server.properties"]
