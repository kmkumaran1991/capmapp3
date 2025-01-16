namespace anubhavdb;
using { anubhavdb.commons as spiderman } from './commons';
using { cuid, temporal, managed } from '@sap/cds/common';

context master {
    

    //first table for storing students data
    //.INCLUDE - address
    entity student: spiderman.address {
        key ID: spiderman.Guid;
        NAME: String(80);
        CLASS: Association to one standards;
        GENDER: String(1);
    }

    entity standards {
        key ID: Int16;
        CLASSNAME: String(10);
        SECTIONS: Int16;
        CLASSTEACHER: String(80);
    }

    entity books {
        key ID: spiderman.Guid;
        BOOKNAME: String(30);
        AUTHOR: String(80);
    }

}

context trans {
    
    entity rentals : cuid, temporal, managed {
        student: Association to one master.student;
        book: Association to one master.books;
    }

}