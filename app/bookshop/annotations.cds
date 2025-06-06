using catalogService as service from '../../srv/service';

annotate service.Books with @(
    //Header Info in Object Page
    UI.HeaderInfo  : {
      $Type : 'UI.HeaderInfoType',
      TypeName : '{i18n>bookName}',
      TypeNamePlural : '{i18n>bookName}',
      Title : {Value : bookName},
      Description : {Value : author}
  },
  UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#HeaderFiled',
        }
    ],
    UI.FieldGroup #HeaderFiled : {
        $Type : 'UI.FieldGroupType',
        Data :[
            {
                $Type: 'UI.DataField',
                Value: createdAt,
                Label: 'Created At',
            },
            {
                $Type: 'UI.DataField',
                Value: createdBy,
                Label: 'Created By',
            }
        ]
    },
  UI.Identification : [{
    $Type : 'UI.DataFieldForAction',
    Action : 'service.sell',
    Label : 'Sell'
  }, ],


    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                //Label: 'bookName',
                Value: bookName,
            },
            {
                $Type: 'UI.DataField',
                //Label: 'author',
                Value: author,
            },
            {
                $Type: 'UI.DataField',
                //Label: 'edition',
                Value: edition,
            },
            {
                $Type: 'UI.DataField',
                //Label: 'noOfCopies',
                Value: noOfCopies,
            },
            {
                $Type: 'UI.DataField',
                //Label: 'yearOfPublish',
                Value: yearOfPublish,
            },
            {
                $Type: 'UI.DataField',
                //Label: 'isAvailable',
                Value: isAvailable,
            },
        ],
    },
    UI.Facets                    : [
        {
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, 
    {
        $Type : 'UI.ReferenceFacet',
        ID    : 'PurchaseHistory',
        Label : 'Purchase History',
        Target: 'to_buyer/@UI.LineItem#PurchaseHistory',
    }, 
 ],
    UI.LineItem                  : [
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'catalogService.sell',
            Label : 'Sell',

        },
        {
            $Type: 'UI.DataField',
            //Label: 'bookName',
            Value: bookName,
        },
        {
            $Type: 'UI.DataField',
            //Label: 'author',
            Value: author,
        },
        {
            $Type: 'UI.DataField',
            //Label: 'edition',
            Value: edition,
        },
        {
            $Type: 'UI.DataField',
            //Label: 'noOfCopies',
            Value: noOfCopies,
        },
        {
            $Type: 'UI.DataField',
           // Label: 'yearOfPublish',
            Value: yearOfPublish,
        },
    ],
);
annotate service.Buyers with @(UI.LineItem #PurchaseHistory: [
    
          {
            $Type: 'UI.DataField',
            Value: firstName,
        },
        {
            $Type: 'UI.DataField',
            Value: lastName,
        },
        {
            $Type: 'UI.DataField',
            Value: noOfCopies,
        },
], );