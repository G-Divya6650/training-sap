using catalogService as service from '../../srv/service';

annotate service.Users with @(

    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            // Label : 'firstName',
            Value: firstName
        },
        {
            $Type: 'UI.DataField',
            // Label : 'lastName',
            Value: lastName
        },
        {
            $Type: 'UI.DataField',
            // Label : 'dob',
            Value: dob
        },
    ],
    //Tab1 General Info
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>firstName}',
                Value: firstName
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>lastName}',
                Value: lastName
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>dob}',
                Value: dob
            },

        ]
    },
    //Tab2 Address Info
    UI.FieldGroup #AddressInfo   : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>houseNumber}',
                Value: houseNumber
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>street}',
                Value: street
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>city}',
                Value: city
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>state}',
                Value: state_code
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>country}',
                Value: country_code
            },
        ]
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInfoTab',
            Label : 'General Info',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AddressTab',
            Label : 'Address Info',
            Target: '@UI.FieldGroup#AddressInfo',
        }
    ],
    UI.HeaderInfo                : {
        TypeName      : 'User',
        TypeNamePlural: 'Users',
        Title         : {
            $Type: 'UI.DataField',
            Value: firstName
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: lastName
        }
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
);


//Mandatory Field
annotate service.Users with {
    firstName @mandatory;
    dob       @mandatory;
};

//-- Value Help (Dropdown) --
annotate service.Users with {

    country_code @(
        Common.ValueListWithFixedValues,
        Common.ValueList: {
            CollectionPath: 'Countries',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'country_code',
                    ValueListProperty: 'country_code'
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: 'countryName',
                    ValueListProperty: 'countryName'
                }
            ]
        },
    );
    firstName @(
        //Common.ValueListWithFixedValues,
        Common.ValueList: {
            CollectionPath: 'Customers',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'firstName',
                    ValueListProperty: 'ContactName'
                },
                // {
                //     $Type            : 'Common.ValueListParameterOut',
                //     LocalDataProperty: 'address',
                //     ValueListProperty: 'Address'
                // }
            ]
        },
        
    );

    state_code   @(Common.ValueList: {

        CollectionPath: 'States',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: 'state_code',
                ValueListProperty: 'state_code'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: 'stateName',
                ValueListProperty: 'stateName'
            }
        ]
    },
    );
};

//Text Arrangement
annotate service.Users with {
    country_code @(Common: {Text : {
        $value : countryName,
        ![@UI.TextArrangement]: #TextFirst
    }});
    state_code @(Common: {Text : {
        $value : stateName,
        ![@UI.TextArrangement]: #TextFirst
    }})
};

//Hide fields in Adapt filters on list report page
annotate service.Users with @Capabilities : {FilterRestrictions : {
    $Type : 'Capabilities.FilterRestrictionsType',
    NonFilterableProperties : [

    ]
}};
