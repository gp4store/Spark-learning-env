# Spark Learning Environment

A lightweight Docker environment for learning and practicing Apache Spark with PySpark. This setup provides everything you need to get started with Spark development without the hassle of local installation.

## What's Included

- **Python 3.11** - Modern Python runtime
- **Apache Spark 3.5.1** - Latest stable Spark with Hadoop 3
- **Java 21** - OpenJDK runtime configured for Spark compatibility
- **Data Science Libraries** - pandas, numpy, matplotlib, seaborn, plotly
- **JupyterLab** - Interactive notebook environment
- **AWS Support** - boto3 for S3 integration

## Quick Start

### 1. Build the Image

```bash
docker build -t my-pyspark:latest .
```

### 2. Run the Container

```bash
docker run -it --rm \
  --name pyspark-dev \
  -v "$(pwd)":/workspace \
  -p 4040:4040 \
  -p 8080:8080 \
  my-pyspark:latest bash
```

**Port Mappings:**
- `4040` - Spark UI (job monitoring)
- `8080` - Spark Master UI (if running standalone cluster)

### 3. Start Coding

Inside the container, you can:

**Run a PySpark script:**
```bash
spark-submit your_script.py
```

**Use the run.sh wrapper (suppresses verbose logs):**
```bash
./run.sh your_script.py
```

**Start PySpark shell:**
```bash
pyspark
```

**Launch JupyterLab:**
```bash
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```
Then access it at `http://localhost:8888`

## Example PySpark Script

```python
from pyspark.sql import SparkSession

# Create Spark session
spark = SparkSession.builder \
    .appName("Learning Spark") \
    .getOrCreate()

# Create a simple DataFrame
data = [("Alice", 34), ("Bob", 45), ("Cathy", 29)]
df = spark.createDataFrame(data, ["Name", "Age"])

# Show the data
df.show()

# Stop the session
spark.stop()
```

## Working with Your Files

The current directory is mounted to `/workspace` in the container, so any files you create inside the container will persist on your host machine.

## Exiting the Container

Simply type:
```bash
exit
```

Since we use the `--rm` flag, the container will be automatically removed when you exit.

## Java Compatibility Notes

This image uses Java 21 with Spark 3.5.1. The `_JAVA_OPTIONS` environment variable includes flags that allow Spark to access internal Java APIs that are restricted in newer Java versions. This is normal and necessary for Spark to function properly with Java 21.

## Learning Resources

- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [PySpark API Reference](https://spark.apache.org/docs/latest/api/python/)
- [Spark SQL Guide](https://spark.apache.org/docs/latest/sql-programming-guide.html)

