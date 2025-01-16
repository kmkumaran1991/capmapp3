using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.boost',
            Label: 'boost',
            Inline: true
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality: ColorCoding
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        Description: {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        ImageUrl : 'https://yt3.googleusercontent.com/zCgSuKDRBWCoEFP52F5WNm-8q6FYKiiIlgpdqjdQaZekQc-PDcyFhi-cO8bkvtvOvH6qPBSg=s900-c-k-c0x00ffffff-no-rj',
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label: 'More Info',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Addional Data',
                    Target : '@UI.Identification',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Data',
                    Target : '@UI.FieldGroup#Spiderman',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Statuses',
                    Target : '@UI.FieldGroup#Superman',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'Items/@UI.LineItem#AQUAMAN',
        },
    ],
    UI.Identification: [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
        }
    ],
    UI.FieldGroup #Spiderman:{
        Label : 'Price Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #Superman: {
        Label : 'Status',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },{
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
        ],
    }

);

annotate service.POItems with @(
    UI.LineItem #AQUAMAN: [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'Item',
        TypeNamePlural : 'Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        Description: {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION,
        },
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Item Info',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label: 'Details',
                    Target : '@UI.FieldGroup#ItemDetail',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label: 'Price',
                    Target : '@UI.FieldGroup#Pricing',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Details',
                    Target : '@UI.FieldGroup#Products',
                },
                
            ],
        },
    ],
    UI.FieldGroup #ItemDetail:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },
    UI.FieldGroup #Pricing:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #Products:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTION,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CATEGORY,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRICE,
            },
        ],
    }


);


//Linking the help with PO
annotate service.POs with  {
    PARTNER_GUID@(
        Common.Text: PARTNER_GUID.COMPANY_NAME,
        Common.ValueList.entity: service.BusinessPartnerSet
    );
};

//Linking the help with PO
annotate service.POItems with  {
    PRODUCT_GUID@(
        Common.Text: PRODUCT_GUID.DESCRIPTION,
        Common.ValueList.entity: service.ProductSet
    );
};

//We created a Value help in SE11
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME,
        }
    ]
);

//We created a Value help in SE11
@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        },
    ]
);
