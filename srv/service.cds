using { tutorial.db as db } from '../db/schema'; //Create alias db so that we can use the entities that are created in schema.cds in db folder
service BookstoreService {
    entity Books as projection on db.Books; //creates a projection for entity Books from db namespace as declared above 
    entity Authors as projection on db.Authors;
    entity Chapters as projection on db.Chapters;
}