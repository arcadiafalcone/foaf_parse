require 'rdf'
require 'linkeddata'
require 'sparql'
require 'set'

graph = RDF::Graph.load("foaf_files/arcadia_foaf.rdf")
puts graph.inspect

query = "PREFIX foaf: <http://xmlns.com/foaf/0.1/>
  SELECT *
  WHERE {?s foaf:knows ?o}"

result_set = Set.new

puts 'iteration'
sse = SPARQL.parse(query)
sse.execute(graph) do |result|
  puts result.o
  result_set.add(result.o)
  rdf = RDF::Resource(RDF::URI.new(result.o))
  graph.load(rdf)
end
puts 'set'
result_set.each do |r|
  puts r
end
