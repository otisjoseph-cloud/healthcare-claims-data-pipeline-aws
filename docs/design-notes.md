# Design Notes

## Purpose

This project demonstrates an AWS data pipeline architecture for healthcare claims analytics using synthetic data. The design focuses on secure ingestion, storage, cataloging, transformation, query, monitoring, and cost-aware operations.

## Data Handling

This project uses sample or synthetic claims data only. No real patient, member, provider, payment, or protected health information is included.

## Architecture Decisions

### Amazon S3 Raw Zone

The raw zone stores incoming claims data before transformation. Keeping raw data separate supports auditability, replay, and future processing needs.

### AWS Glue Data Catalog

The Data Catalog stores table metadata and makes the data discoverable for Athena queries.

### AWS Glue Crawler

The crawler supports schema discovery and updates metadata as data structure changes.

### AWS Glue ETL Job

The ETL job represents the transformation layer. In a fuller implementation, this stage could clean data, standardize fields, remove invalid records, and partition output data.

### Amazon S3 Processed Zone

The processed zone stores curated, analytics-ready data. This separation improves governance and reduces query complexity.

### Amazon Athena

Athena enables SQL analysis directly against data stored in S3 without managing database servers.

### Amazon CloudWatch

CloudWatch supports operational monitoring for Glue jobs, query issues, and pipeline health indicators.

## Security Considerations

- Use synthetic or de-identified data only
- Block public S3 access
- Encrypt S3 data at rest
- Restrict access with least-privilege IAM permissions
- Separate raw and processed data zones
- Monitor access and operational events where appropriate

## Cost Considerations

- Partition processed data to reduce Athena scan costs
- Use efficient file formats such as Parquet where appropriate
- Apply lifecycle policies to older raw data
- Monitor Glue job runtime and Athena query volume
- Avoid always-on compute resources when serverless services are sufficient

## Interview Explanation

This design shows how I approach healthcare data architecture on AWS. I separated raw and processed data, used Glue for cataloging and transformation, used Athena for SQL analytics, and included controls for IAM, security, monitoring, and cost. The main tradeoff is keeping the design simple and serverless while still accounting for governance, visibility, and cost management.
