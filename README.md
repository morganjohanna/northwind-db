# Northwind Database
_Code for setting up a PostgreSQL database containing Microsoft's Northwind test dataset and some basic EDA_

Data are contained in the **data** directory; this directory was forked from [pawlodkowski](https://github.com/pawlodkowski/northwind_data_clean/commits?author=pawlodkowski) and contain his README in that folder.

## Design and Implementation
- The data were downloaded to my local machine and explored as .csv files to best determine how to define individual columns
- I wrote the code to create individual tables with practical restrictions to future-proof in case of further data input (see **table-creation.sql**)
- I explored the data using a variety of queries, several of which are contained within **queries.sql**

The following are not part of this repository, but were the next steps I followed as part of the broader project
- An AWS EC2 instance (Linus) was provisioned and SSH tunnel configured for secure access; Metabase was installed
- An AWS RDS instance (PostgreSQL) was provisioned and networked to the EC2 instance via SSH tunnel configured to the EC2 instance
- The database was created in the RDS instance and dumped from my local machine into the RDS with pg_dump
- A Metabase dashboard was created and tested for public access

## Next
This was quite a lot of fun for me to make as I find analytics and EDA with SQL quite intuitive. I may replicate it again and leave the EC2/RDS instances spun up or do something similar with a different dataset.
