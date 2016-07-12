#!/usr/bin/ruby

require 'rdf'
require 'linkeddata'
require 'sparql'

graph = RDF::Graph.load("http://stanford.edu/~arcadia/foaf.rdf")

query = "PREFIX foaf: <http://xmlns.com/foaf/0.1/>
  SELECT ?o
  WHERE {?s foaf:knows ?o}"

puts "Before loading"
sse = SPARQL.parse(query)
sse.execute(graph) do |result|
  puts result.o
  graph.load(result.o)
end

puts "After loading"
sse.execute(graph) do |result|
  puts result.o
end

#sse.execute(graph) do |result|
#  puts result.o
#  result_set.add(result.o)
#  rdf = RDF::Resource(RDF::URI.new(result.o))
#  graph.load(rdf)
#end
