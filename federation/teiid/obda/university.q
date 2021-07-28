[QueryItem="students"]
PREFIX : <http://example.org/voc#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

SELECT ?x ?z ?y ?e 
{?x rdf:type :Course . ?x :title ?y . ?x :isGivenAt <http://example.org/voc#uni1/university> . 
?z rdf:type :Course . ?z :title ?y . ?z :isGivenAt <http://example.org/voc#uni2/university> . 
?e :givesLecture ?z. }