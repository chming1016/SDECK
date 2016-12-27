#!/bin/bash
echo 'making hdfs directory...'
hdfs dfs -mkdir -p /user/root/test
echo 'putting sample data to hdfs...'
hdfs dfs -put raw_data/sample1.csv /user/root/test
i=1
while [ $i -lt 2 ]
do
	echo 'running $i time...'
	spark-submit --master spark://hadoop-master:7077 --executor-memory 512m --executor-cores 1 spark-wordcount.py
	hdfs dfs -rm -R /user/root/test/output
	sleep 1
	i=$(( $i + 1 ))
done
