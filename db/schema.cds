namespace training.cap.db;

using {
    managed,
    cuid
} from '@sap/cds/common';

entity Users : managed, cuid {
    //key ID        : UUID;
    firstName         : String @title: '{i18n>firstName}';
    lastName          : String @title: '{i18n>lastName}';
    dob               : Date   @title: '{i18n>dob}';
 //address           : String @title: '{i18n>address}';
    houseNumber       : String @title: '{i18n>houseNumber}';
    street            : String @title: '{i18n>street}';
    city              : String @title: '{i18n>city}';
    stateName         : String;
    state_code        : String;
    countryName       : String;
    country_code      : String;
    // to_state : Association to States on to_state.code = state_code;
    // to_country : Association to Countries on to_country.code = country_code;

    to_userCredential : Association to one UserCredentials;
    to_borrowedBook   : Association to many BorrowedBooks
                           on to_borrowedBook.to_user = $self;

};

entity States {

    key stateName  : String;
        state_code : String;
//to_state   : Association to one Users;
};

entity Countries {
    key country_code : String;
        countryName  : String;

//to_country   : Association to one Users;
};

entity Books : managed {
    key ID              : UUID;
        bookName        : String  @title: '{i18n>bookName}';
        author          : String  @title: '{i18n>author}';
        edition         : Integer @title: '{i18n>edition}';
        noOfCopies      : Integer @title: '{i18n>noOfCopies}';
        yearOfPublish   : String  @title: '{i18n>yearOfPublish}';
        isAvailable     : Boolean @title: '{i18n>isAvailable}';
        to_borrowedBook : Composition of many BorrowedBooks
                              on to_borrowedBook.to_book = $self;
        to_buyer : Composition of many Buyers
                              on to_buyer.to_book = $self;                      

};
entity Buyers : cuid, managed {
    firstName : String @title: '{i18n>firstName}';
    lastName : String @title: '{i18n>lastName}';
    noOfCopies  : Integer @title: '{i18n>noOfCopies}';
    to_book : Association to one Books;
};

entity UserCredentials : managed {
    key ID        : UUID;
        username  : String @mandatory;
        password  : String @mandatory;
        lastLogin : Timestamp;
        to_user   : Association to one Users;
};

entity BorrowedBooks : managed {
    key ID      : UUID;
        to_user : Association to one Users;
        to_book : Association to one Books;
};

view AvailableBooks as
    select from Books {
        ID,
        @UI.HiddenFilter
        bookName,
        author,
        yearOfPublish,
        isAvailable
    }
    where
        isAvailable = false;
