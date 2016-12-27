from pyspark import SparkContext, SparkConf
sc = SparkContext()
text_file = sc.textFile("hdfs://hadoop-master:9000/user/root/test/sample1.csv")
counts = text_file.flatMap(lambda line: line.split(",")) \
             .map(lambda word: (word, 1)) \
             .reduceByKey(lambda a, b: a + b)
counts.saveAsTextFile("hdfs://hadoop-master:9000/user/root/test/output")
