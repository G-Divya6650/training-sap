using {training.cap.db as db} from '../db/schema';

service catalogService {
      @odata.draft.enabled
      entity Users     as projection on db.Users;

      entity States    as projection on db.States;
      entity Countries as projection on db.Countries;

      @cds.redirection.target
      entity Users1    as projection on db.Users;

      @odata.draft.enabled
      entity Books     as
            projection on db.Books {
                  *,
                  createdAt  @(Common.Label: '{i18n>createdAt}'),
                  createdBy  @(Common.Label: '{i18n>createdBy}'),
                  modifiedAt @(Common.Label: '{i18n>modifiedAt}'),
                  modifiedBy @(Common.Label: '{i18n>modifiedBy}'),
            }

            actions {
                  action sell(firstName : String @Common: {Label: '{i18n>firstName}'},
                              lastName : String @Common: {Label: '{i18n>lastName}'},
                              noOfCopies : Integer @Common: {Label: '{i18n>noOfCopies}'} ) returns String;

            };

      @cds.redirection.target
      view AvailableBooks as select from db.AvailableBooks
};
