using {
        cuid,
        managed
} from '@sap/cds/common'; //This is common library declaration and this helps us to use aspect cuid from common library

namespace tutorial.db; //Namespace so taht it cab be used in srv and else where

entity Books : cuid, managed { // Entity should always be created in plural. i.e, Books instead of Book
        title    : String;
        author   : Association to Authors;
        Chapters : Composition of many Chapters     // Links field Chapters to entity Chapters. Note, if composition is used, we can start in block letter
                           on Chapters.book = $self;
}

entity Authors : cuid, managed {
        name  : String;
        books : Association to many Books
                        on books.author = $self;
}

entity Chapters : cuid, managed { // Created to show composition
            number : Integer;
        key book   : Association to Books; 
}
