# 使用支持多架构的JRE基础镜像
FROM eclipse-temurin:17-jre-jammy

# 下载 Kafka 3.3.2 官方二进制包（跨架构通用）
ADD https://archive.apache.org/dist/kafka/3.3.2/kafka_2.13-3.3.2.tgz /opt/

RUN tar -zxvf /opt/kafka_2.13-3.3.2.tgz -C /opt/ \
    && mv /opt/kafka_2.13-3.3.2 /opt/kafka \
    && mkdir -p /var/lib/kafka/data /etc/kafka \
    && rm -rf /opt/kafka_2.13-3.3.2.tgz

WORKDIR /opt/kafka

EXPOSE 9092 9093 8083

# 修复：使用绝对路径启动，避免架构问题
CMD ["/opt/kafka/bin/kafka-server-start.sh", "/opt/kafka/config/server.properties"]
