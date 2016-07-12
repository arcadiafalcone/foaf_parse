#!/usr/bin/ruby

require 'rdf'
require 'linkeddata'
require 'sparql'

graph = RDF::Graph.load("http://stanford.edu/~arcadia/foaf.rdf")

knows_query = "PREFIX foaf: <http://xmlns.com/foaf/0.1/>
  SELECT DISTINCT ?o
  WHERE {?s foaf:knows ?o}"

#puts "Before loading"
skq = SPARQL.parse(knows_query)
skq.execute(graph) do |result|
#  puts result.o
  graph.load(result.o)
end

#puts "After loading"
#sse.execute(graph) do |result|
#  puts result.o
#end

#puts "Interests"
interest_query = "
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

SELECT DISTINCT ?s ?o ?name
WHERE {?s foaf:interest ?o ;
      foaf:name ?name }"

def abstract_for(person, interest)
  interest_query = "
  PREFIX foaf: <http://xmlns.com/foaf/0.1/>
  PREFIX dbo: <http://dbpedia.org/ontology/>
  PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  SELECT ?abs ?int
    WHERE {?s dbo:abstract ?abs ;
              rdfs:label ?int
    FILTER (lang(?abs) = 'en')
    FILTER (lang(?int) = 'en')}"
  interest_graph = RDF::Graph.load(interest)
  sparql_interest_query = SPARQL.parse(interest_query)
  sparql_interest_query.execute(interest_graph) do |result|
    puts "#{person} is interested in #{result.int}"
    puts result.abs
  end
end

sparql_interest_query = SPARQL.parse(interest_query)
sparql_interest_query.execute(graph) do |result|
#  puts "#{result.name} is interested in #{result.int}"
#  puts result.name
#  puts result.o
  abstract_for(result.name, result.o)
end
