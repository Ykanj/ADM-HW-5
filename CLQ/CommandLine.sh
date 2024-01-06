#!/bin/bash

# Q1: Is there any node that acts as an important "connector" between the different parts of the graph?

# A node with high betweenness centrality is often considered an important "connector" between different parts of the graph, 
# so to answer this question we are calculating the nodes with the highest betweenness centrality and printing the first ten

echo
echo "The nodes that act as most important connectors between the different parts of the graph are: "

python -c "import networkx as nx; citation_subgraph = nx.read_graphml('citation_subgraph.graphml'); centrality = nx.betweenness_centrality(citation_subgraph); sorted_centrality = sorted(centrality.items(), key=lambda x: x[1], reverse=True); print('\n'.join([f'{node} {centrality}' for node, centrality in sorted_centrality[:10]]))"

# Q2: How does the degree of citation vary among the graph nodes?

echo
echo "Variation of the degree of citation between all the nodes: "

python -c "import networkx as nx; citation_subgraph = nx.read_graphml('citation_subgraph.graphml'); in_degrees = sorted(citation_subgraph.in_degree(), key=lambda x: x[1], reverse=True); out_degrees = sorted(citation_subgraph.out_degree(), key=lambda x: x[1], reverse=True); print(f'Largest In-Degree: {in_degrees[0][0]} {in_degrees[0][1]}'); print(f'Lowest In-Degree: {in_degrees[-1][0]} {in_degrees[-1][1]}'); print(f'Largest Out-Degree: {out_degrees[0][0]} {out_degrees[0][1]}'); print(f'Lowest Out-Degree: {out_degrees[-1][0]} {out_degrees[-1][1]}')"

# Q3: What is the average length of the shortest path among nodes?

# Since the average_shortest_path_length function works only among weakly connected graphs,
# we decided to calculate the average shortest path length manually

echo
echo "The Average Shortest Path Length is:"

python -c "
import networkx as nx

graph = nx.read_graphml('citation_subgraph.graphml')

# first, we calculated the sum of shortest path lengths between all pairs of nodes 
total_len = sum(len(p) - 1 for src in graph for tgt, p in nx.bfs_edges(graph, source=src))

# then, we calculated the total number of paths (excluding self-paths)
total_paths = sum(1 for src in graph for _ in nx.bfs_edges(graph, source=src))

# Finally, the average shortest path length
average_len = total_len / total_paths if total_paths > 0 else 0

print(average_len)
"