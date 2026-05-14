# 从 Confluent 官方镜像中提取 reporter JAR
FROM confluentinc/cp-server-connect:7.5.4 AS source

# 用一个轻量基础镜像来收集 JAR
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# 从 Confluent 镜像中复制所有共享 JAR
COPY --from=source /usr/share/java/ /tmp/confluent-libs/

# 找出包含 ReporterConfig 的 JAR 并复制到输出目录
RUN mkdir -p /output && \
    find /tmp/confluent-libs -name "*.jar" | while read jar; do \
      if unzip -l "$jar" 2>/dev/null | grep -q "ReporterConfig"; then \
        cp "$jar" /output/; \
        echo ">>> 找到: $jar"; \
      fi; \
    done && \
    rm -rf /tmp/confluent-libs
