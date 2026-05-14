# 社区版，不需要 license
FROM confluentinc/cp-kafka-connect:7.5.4 AS source

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

COPY --from=source /usr/share/java/ /tmp/confluent-libs/

RUN mkdir -p /output && \
    find /tmp/confluent-libs -name "*.jar" | while read jar; do \
      if unzip -l "$jar" 2>/dev/null | grep -q "ReporterConfig"; then \
        cp "$jar" /output/; \
        echo ">>> 找到: $jar"; \
      fi; \
    done && \
    rm -rf /tmp/confluent-libs
