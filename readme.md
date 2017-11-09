Data transformations schemas of US, EU, AU governments sanction lists (dif departments) into the internal data format.

Used Pentaho Data Integration tool. 

Transformation jobs take data from remote sources, transform it and put into internal Postgres DB.
The jobs and transformation schemas are prepared to be executed in AWS lambda (java app. which size around 30mb, average execution time takes less 1 min).