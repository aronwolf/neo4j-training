// with indirection array, credit to Michael Hunger

MATCH (a:Legislator) WITH a, size((a)-[:INFLUENCED_BY]->()) as degree ORDER BY id(a) ASC
// setup
WITH collect(a) as nodes, collect(toFloat(degree)) as degrees, collect(id(a)) as ids
WITH ids, nodes, degrees, [x in nodes | 0] as src, [x in nodes | 0.15] as dest, [id in range(0,last(ids)) | case when id in ids then id else 0 end] as _

//have a collection of 0's for src here

// iteration
WITH _, degrees, [id in ids | case degrees[_[id]] when 0.0 then dest[_[id]] else 0.85 * dest[_[id]] / degrees[_[id]] end] as src, [x in dest | 0.15] as dest, nodes, ids
//then nothing but nulls for src from here on out

unwind nodes as e
WITH _, degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[_[id(head(nodes(p)))]]) + dest[_[id(e)]]) as dest, nodes, ids

WITH _, degrees, [id in ids | case degrees[_[id]] when 0.0 then dest[_[id]] else 0.85 * dest[_[id]] / degrees[_[id]] end] as src, [x in dest | 0.15] as dest, nodes, ids

unwind nodes as e
WITH _, degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[_[id(head(nodes(p)))]]) + dest[_[id(e)]]) as dest, nodes, ids

WITH _, degrees, [id in ids | case degrees[_[id]] when 0.0 then dest[_[id]] else 0.85 * dest[_[id]] / degrees[_[id]] end] as src, [x in dest | 0.15] as dest, nodes, ids

unwind nodes as e
WITH _, degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[_[id(head(nodes(p)))]]) + dest[_[id(e)]]) as dest, nodes, ids

WITH _, degrees, [id in ids | case degrees[_[id]] when 0.0 then dest[_[id]] else 0.85 * dest[_[id]] / degrees[_[id]] end] as src, [x in dest | 0.15] as dest, nodes, ids

unwind nodes as e
WITH _, degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[_[id(head(nodes(p)))]]) + dest[_[id(e)]]) as dest, nodes, ids

WITH _, degrees, [id in ids | case degrees[_[id]] when 0.0 then dest[_[id]] else 0.85 * dest[_[id]] / degrees[_[id]] end] as src, [x in dest | 0.15] as dest, nodes, ids

unwind nodes as e
WITH _, degrees, src, collect(reduce(val =  0.0, p in ()-[:INFLUENCED_BY]->(e) | val + src[_[id(head(nodes(p)))]]) + dest[_[id(e)]]) as dest, nodes, ids

unwind nodes as e

RETURN e.lastName, dest[id(e)] AS rank
ORDER BY rank DESC LIMIT 10;
