table 60000 "TCNConfBPC"
{
    Caption = 'TCNConfBPC';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Code[20])
        {
            Caption = 'Id';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; User; Text[250])
        {
            Caption = 'User';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; " Password"; Text[250])
        {
            ExtendedDatatype = Masked;
            Caption = ' Password';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(4; Access_Token; Text[250])
        {
            Caption = 'Access_Token';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(5; UrlLogin; Text[250])
        {
            Caption = 'UrlLogin';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(6; UrlMovIntraDia; Text[250])
        {
            Caption = 'UrlMovIntraDia';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(7; UrlMovCierre; Text[250])
        {
            Caption = 'UrlMovCierre';
            DataClassification = OrganizationIdentifiableInformation;
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }

    procedure GetF(): Boolean
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert(true);
        end;
        exit(true);
    end;
}


