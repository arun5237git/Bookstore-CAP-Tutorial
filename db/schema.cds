using {
        cuid,
        managed,
        sap.common.Currencies,
} from '@sap/cds/common'; //This is common library declaration and this helps us to use aspect cuid from common library

namespace tutorial.db; //Namespace so taht it cab be used in srv and else where

entity Books : cuid, managed { // Entity should always be created in plural. i.e, Books instead of Book
        title       : String;
        author      : Association to Authors;
        genre       : Association to Genres;
        publishedAt : Date;
        pages       : Integer;
        price       : Decimal(9, 2);
        currency    : Association to Currencies;
        stock       : Integer;
        status      : Association to BookStatus;
        Chapters    : Composition of many Chapters // Links field Chapters to entity Chapters. Note, if composition is used, we can start in block letter
                              on Chapters.book = $self;
}

entity BookStatus { //To introduce criticality
        key code        : String(1) enum { //Enumerators are like Domains in ABAP that has fixed values
                    Available = 'A';
                    Low_Stock = 'L';
                    Unavailable = 'U';
            }
            criticality : Integer;
            displayText : String;
}

entity Authors : cuid, managed {
        name  : String;
        books : Association to many Books
                        on books.author = $self;
}

entity Chapters : cuid, managed { // Created to show composition
        key book   : Association to Books;
            number : Integer;
            title  : String;
            pages  : Integer;
}

entity Genres {
        key code        : String;
            description : String;
}
