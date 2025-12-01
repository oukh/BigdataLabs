Lab 3 — MapReduce (Part: Exercise — Top Products)
===============================================

Summary
-------
- Task: identify most-sold products from `purchases.txt` using Hadoop Streaming (Python mapper/reducer).
- Result: job completed successfully. Top products (counts):
  - Baby — 4
  - Books — 4
  - Cameras — 4
  - DVDs — 3
  - Sporting Goods — 3
  - CDs — 2
  - Computers — 2
  - Consumer Electronics — 2
  - Crafts — 2
  - Garden — 2
  - Men's Clothing — 2
  - Women's Clothing — 2

Files added/used
----------------
- `top_products_mapper.py` — mapper that extracts product name and emits (product,1)
- `top_products_reducer.py` — reducer that sums counts per product
- `exercise_mapper.py`, `exercise_reducer.py` — earlier exercise scripts

Commands run (examples)
-----------------------
Copy scripts to shared volume (Windows):
```
copy c:\Users\oussa\BigdataLabs\lab3_mapreduce\top_products_mapper.py C:\Users\oussa\Documents\hadoop_project\
copy c:\Users\oussa\BigdataLabs\lab3_mapreduce\top_products_reducer.py C:\Users\oussa\Documents\hadoop_project\
```
Run Hadoop Streaming (inside master container):
```
docker exec hadoop-master bash -c "hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.2.0.jar \
 -files /shared_volume/top_products_mapper.py,/shared_volume/top_products_reducer.py \
 -mapper 'python3 top_products_mapper.py' -reducer 'python3 top_products_reducer.py' \
 -input /user/root/input/purchases.txt -output /user/root/output_top_products_v1"
```
Show top products (sorted):
```
docker exec hadoop-master bash -c "hdfs dfs -cat /user/root/output_top_products_v1/part-00000 | sort -t$'\t' -k2,2nr | head -n 20"
```

Verification
------------
- Ensure output dir exists in HDFS: `hdfs dfs -ls /user/root/output_top_products_v1`
- Confirm sum of counts equals number of transactions in `purchases.txt`:
  - `hdfs dfs -cat /user/root/input/purchases.txt | wc -l`
  - `hdfs dfs -cat /user/root/output_top_products_v1/part-00000 | awk -F'\t' '{s+=$2} END{print s}'`

Notes
-----
- The job uses `python3` inside containers. If you run locally, ensure `python3` is available in the container images.

If you want, I can append this README to the Git repo and push the commit now.
