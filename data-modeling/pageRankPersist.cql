//assumes legislators are node(id) 0..n


MATCH (a:Legislator) WITH a, size((a)-[:INFLUENCED_BY]->()) as degree ORDER BY id(a) ASC
// setup
WITH collect(a) as nodes, [x in collect(a) | 0] as src, [x in collect(a) | 0.15] as dest, collect(toFloat(degree)) as degrees

// iteration
WITH degrees, [n in nodes | case degrees[id(n)] when 0.0 then dest[id(n)] else 0.85 * dest[id(n)] / degrees[id(n)] end] as src, [x in dest | 0.15] as dest, nodes
unwind nodes as e
WITH degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[id(head(nodes(p)))]) + dest[id(e)]) as dest, nodes

WITH degrees, [n in nodes | case degrees[id(n)] when 0.0 then dest[id(n)] else 0.85 * dest[id(n)] / degrees[id(n)] end] as src, [x in dest | 0.15] as dest, nodes
unwind nodes as e
WITH degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[id(head(nodes(p)))]) + dest[id(e)]) as dest, nodes

WITH degrees, [n in nodes | case degrees[id(n)] when 0.0 then dest[id(n)] else 0.85 * dest[id(n)] / degrees[id(n)] end] as src, [x in dest | 0.15] as dest, nodes
unwind nodes as e
WITH degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[id(head(nodes(p)))]) + dest[id(e)]) as dest, nodes

WITH degrees, [n in nodes | case degrees[id(n)] when 0.0 then dest[id(n)] else 0.85 * dest[id(n)] / degrees[id(n)] end] as src, [x in dest | 0.15] as dest, nodes
unwind nodes as e
WITH degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[id(head(nodes(p)))]) + dest[id(e)]) as dest, nodes

WITH degrees, [n in nodes | case degrees[id(n)] when 0.0 then dest[id(n)] else 0.85 * dest[id(n)] / degrees[id(n)] end] as src, [x in dest | 0.15] as dest, nodes
unwind nodes as e
WITH degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[id(head(nodes(p)))]) + dest[id(e)]) as dest, nodes

WITH degrees, [n in nodes | case degrees[id(n)] when 0.0 then dest[id(n)] else 0.85 * dest[id(n)] / degrees[id(n)] end] as src, [x in dest | 0.15] as dest, nodes
unwind nodes as e
WITH degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[id(head(nodes(p)))]) + dest[id(e)]) as dest, nodes

WITH degrees, [n in nodes | case degrees[id(n)] when 0.0 then dest[id(n)] else 0.85 * dest[id(n)] / degrees[id(n)] end] as src, [x in dest | 0.15] as dest, nodes
unwind nodes as e
WITH degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[id(head(nodes(p)))]) + dest[id(e)]) as dest, nodes

unwind nodes as e

SET e.pageRank = dest[id(e)];
