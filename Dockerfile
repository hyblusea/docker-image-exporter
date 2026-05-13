FROM eclipse-temurin:17-jre-jammy

# 从 Apache 官方镜像站下载（GitHub 可以访问）
ADD https://archive.apache.org/dist/kafka/3.3.2/kafka_2.13-3.3.2.tgz /opt/

RUN tar -zxvf /opt/kafka_2.13-3.3.2.tgz -C /opt/ \
    && mv /opt/kafka_2.13-3.3.2 /opt/kafka \
    && mkdir -p /var/lib/kafka/data /etc/kafka \
    && rm -rf /opt/kafka_2.13-3.3.2.tgz

WORKDIR /opt/kafka

EXPOSE 9092 9093 8083

CMD ["/opt/kafka/bin/kafka-server-start.sh", "/opt/kafka/config/server.properties"]
