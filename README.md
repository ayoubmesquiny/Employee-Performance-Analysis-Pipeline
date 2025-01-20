# Employee Performance Analysis Pipeline

## Overview
This project implements a data pipeline to analyze employee performance. The pipeline follows an end-to-end architecture, starting from data ingestion and progressing to data visualization. It uses containerized components orchestrated by **Apache Airflow** to ensure scalability, modularity, and automation.

---

## Architecture

The pipeline is composed of the following key stages:

![Image](https://github.com/user-attachments/assets/1e7aa4f0-a9cf-4358-a188-2c5b40cf5719)

1. **Data Source**: Raw data is provided in CSV format.
2. **Data Ingestion**: Python scripts are used to extract, clean, and load data into the storage layer.
3. **Data Storage & Transformation**:
   - **PostgreSQL**: Acts as the central database to store raw and processed data.
   - **dbt (Data Build Tool)**: Used for data transformations and modeling.
4. **Data Visualization**: The transformed data is visualized using **Metabase**.
5. **Orchestration**: **Apache Airflow** schedules and manages the execution of the entire pipeline.

---

## Technology Stack

| Component              | Technology        |
|------------------------|-------------------|
| Containerization       | Docker            |
| Data Ingestion         | Python            |
| Database               | PostgreSQL        |
| Data Transformation    | dbt               |
| Visualization          | Metabase          |
| Orchestration          | Apache Airflow    |

---

## Setup Instructions

### Prerequisites
Ensure the following are installed on your machine:
- Docker and Docker Compose
- Python 3.8 or above

### Steps

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd employee-performance-analysis-pipeline
   ```

2. **Configure Environment Variables**
   - Create a `.env` file in the root directory with the following variables:
     ```env
     POSTGRES_USER=<your_postgres_user>
     POSTGRES_PASSWORD=<your_postgres_password>
     POSTGRES_DB=employee_performance
     METABASE_USER=<your_metabase_user>
     METABASE_PASSWORD=<your_metabase_password>
     ```

3. **Build and Start Containers**
   ```bash
   docker-compose up --build
   ```

4. **Run Airflow DAGs**
   - Access the Airflow web UI at `http://localhost:8080`.
   - Enable and trigger the DAG for the pipeline.

5. **Access Visualization**
   - Open Metabase at `http://localhost:3000`.
   - Login using your credentials.
   - Explore dashboards and reports.

---

## Detailed Workflow

### 1. Data Source
- Employee performance data is provided as a CSV file.
- Ensure the data follows the required schema:
  | Column Name      | Data Type  |
  |------------------|------------|
  | EmployeeID       | Integer    |
  | Name             | String     |
  | Department       | String     |
  | PerformanceScore | Float      |

### 2. Data Ingestion
- Python scripts:
  - Validate CSV data.
  - Load validated data into PostgreSQL.
- Key libraries used: `pandas`, `sqlalchemy`.

### 3. Data Storage & Transformation
- **PostgreSQL**:
  - Stores both raw and processed data.
- **dbt**:
  - Implements SQL models to clean and aggregate data.
  - Executes transformations as part of the Airflow pipeline.

### 4. Data Visualization
- **Metabase**:
  - Connects to PostgreSQL to visualize transformed data.
  - Dashboards provide insights into employee performance metrics.

### 5. Orchestration
- **Apache Airflow**:
  - Automates the execution of data ingestion, transformation, and visualization tasks.
  - DAG structure:
    1. Ingest CSV data.
    2. Run dbt transformations.
    3. Trigger Metabase refresh.
