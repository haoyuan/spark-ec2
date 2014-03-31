export HDFS_HOST_ADDRESS=`hostname`
echo $HDFS_HOST_ADDRESS

./bin/hadoop distcp s3n://tpch-data/tpch10g/ hdfs://$HDFS_HOST_ADDRESS:9000/tpch/gb10 &
./bin/hadoop distcp s3n://tpch-data/tpch/tpch100g/ hdfs://$HDFS_HOST_ADDRESS:9000/tpch/gb100 &
./bin/hadoop distcp s3n://tpch-data/tpch/tpch1t/ hdfs://$HDFS_HOST_ADDRESS:9000/tpch/tb1 &