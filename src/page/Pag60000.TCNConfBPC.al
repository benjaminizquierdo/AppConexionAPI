page 60000 "TCNConfBPC"
{

    Caption = 'Configuracion Conexion API BANKINPLAY CLIENTES';
    PageType = Card;
    SourceTable = TCNConfBPC;
    UsageCategory = Administration;
    ApplicationArea = All;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(User; Rec.User)
                {
                    ToolTip = 'Introduzca su usuario';
                    ApplicationArea = All;
                }
                field(" Password"; Rec." Password")
                {
                    ToolTip = 'Introduzca su contraseña';
                    ApplicationArea = All;
                }
            }
            group(URLs)
            {
                field(UrlLogin; Rec.UrlLogin)
                {
                    ToolTip = 'URL para obtener Acceso (https://app.bankinplay.com/intradia-core/clienteApi/jwt_token)';
                    ApplicationArea = All;
                }
                field(UrlMovIntraDia; Rec.UrlMovIntraDia)
                {
                    ToolTip = 'URL para obtener los movimientos Intradia (https://app.bankinplay.com/intradia-core/api/v1/statement/lectura_intradia)';
                    ApplicationArea = All;
                }
                field(UrlMovCierre; Rec.UrlMovCierre)
                {
                    ToolTip = 'URL para obtener los movimientos de cierre (https://app.bankinplay.com/intradia-core/api/v1/statement/lectura_cierre)';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ObtenerAcceso)
            {
                ApplicationArea = All;
                Caption = 'Obtener Acceso';
                Image = AbsenceCategories;
                trigger OnAction()
                var
                    culTCNFunciones: Codeunit TCNFunciones;
                begin
                    culTCNFunciones.ObtenerAccesoF(Rec.UrlLogin);
                end;
            }
            action(ConsulMovCierre)
            {
                ApplicationArea = All;
                Caption = 'Movimientos Cierre';
                Image = AbsenceCategories;
                trigger OnAction()
                var
                    culTCNFunciones: Codeunit TCNFunciones;
                begin
                    culTCNFunciones.MovCierreF(Rec.UrlMovCierre);
                end;
            }
            action(ConsulMovIntradia)
            {
                ApplicationArea = All;
                Caption = 'Movimientos IntraDia';
                Image = AbsenceCategories;
                trigger OnAction()
                var
                    culTCNFunciones: Codeunit TCNFunciones;
                begin
                    culTCNFunciones.MovIntraDiaF(Rec.UrlMovIntraDia);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetF();
    end;

}
