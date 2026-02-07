FROM python:3.11-slim

# Install Java 21 and utilities
RUN apt-get update && apt-get install -y \
    openjdk-21-jre-headless \
    curl \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Configure Java
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Apache Spark
ENV SPARK_VERSION=3.5.1
ENV HADOOP_VERSION=3
RUN curl -fsSL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    | tar -xz -C /opt/ \
    && ln -s /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark

# Configure Spark
ENV SPARK_HOME=/opt/spark
ENV PATH="$SPARK_HOME/bin:$PATH"

# Install PySpark
RUN pip install --no-cache-dir pyspark pandas numpy matplotlib seaborn jupyterlab boto3 plotly

# Set Java options for Java 21 compatibility with Spark
ENV _JAVA_OPTIONS="--add-opens=java.base/sun.nio.ch=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/sun.security.action=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.nio=ALL-UNNAMED"

# Set working directory
WORKDIR /workspace

# Keep container running
CMD ["tail", "-f", "/dev/null"]




