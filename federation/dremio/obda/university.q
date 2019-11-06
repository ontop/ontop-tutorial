[QueryItem="courses"]
PREFIX : <http://example.org/voc#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

SELECT DISTINCT  ?firstName ?lastName ?course ?t {
  ?student :attends ?course .
  ?student foaf:firstName ?firstName .
  ?student foaf:lastName ?lastName .
  ?course :title ?t .
}
