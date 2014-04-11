#!/usr/bin/env bash


# Use D200books100GB if 40 nodes, or 20 nodes (remove half books)

#declare -a arr=(D20books10GB D200books100GB D2000books1TB D10books1GB D10books100MB D1000books10GB)
declare -a arr=(D200books100GB D10books1GB)

export HDFS_HOST_ADDRESS=`hostname`
echo "HDFS_HOST_ADDRESS="$HDFS_HOST_ADDRESS

for s3data in ${arr[@]}
do
  echo ./bin/hadoop distcp s3n://Tachyon/$s3data/ hdfs://$HDFS_HOST_ADDRESS:9000/data/$s3data
  ./bin/hadoop distcp s3n://Tachyon/$s3data hdfs://$HDFS_HOST_ADDRESS:9000/data/$s3data &
done

# declare -a arr=(D20books10GB D200books100GB D2000books1TB D10books1GB D10books100MB D1000books10GB)

# export HDFS_HOST_ADDRESS=`hostname`
# echo "HDFS_HOST_ADDRESS="$HDFS_HOST_ADDRESS

# for s3data in ${arr[@]}
# do
#   echo ./bin/hadoop distcp s3n://Tachyon/$s3data/ hdfs://$HDFS_HOST_ADDRESS:9000/data/$s3data
#   ./bin/hadoop distcp s3n://Tachyon/$s3data hdfs://$HDFS_HOST_ADDRESS:9000/data/$s3data &
# done

# echo ./bin/hadoop distcp s3n://Tachyon/D1000books10GB hdfs://$HDFS_HOST_ADDRESS:9000/data/D1000books10GB
# ./bin/hadoop distcp s3n://Tachyon/D1000books10GB hdfs://$HDFS_HOST_ADDRESS:9000/data/D1000books10GB

# # Setup many hours data.
# for i in {0..32}
# do
#   echo ./bin/hadoop distcp hdfs://$HDFS_HOST_ADDRESS:9000/data/D1000books10GB hdfs://$HDFS_HOST_ADDRESS:9000/many/$i &
#   ./bin/hadoop distcp hdfs://$HDFS_HOST_ADDRESS:9000/data/D1000books10GB hdfs://$HDFS_HOST_ADDRESS:9000/many/$i &
# done

# for i in {1..5}
# do
#   echo ./bin/hadoop distcp hdfs://$HDFS_HOST_ADDRESS:9000/data/0 hdfs://$HDFS_HOST_ADDRESS:9000/data/$i &
#   ./bin/hadoop distcp hdfs://$HDFS_HOST_ADDRESS:9000/data/0 hdfs://$HDFS_HOST_ADDRESS:9000/data/$i &
# done