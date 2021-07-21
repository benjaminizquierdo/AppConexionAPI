page 60000 "TCNConfBPC"
{

    Caption = 'Configuracion BANKINPLAY CLIENTES';
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
            group(Creedenciales)
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
                field(UrlBancos; Rec.UrlBancos)
                {
                    ToolTip = 'Url para obtener la lista de bancos';
                    ApplicationArea = All;
                }
                field(UrlCuentasBancarias; Rec.UrlCuentasBancarias)
                {
                    ToolTip = 'Url para obtener la lista de cuenta bancarias';
                    ApplicationArea = All;
                }
                field(UrlTiposCuentasBancarias; Rec.UrlTiposCuentasBancarias)
                {
                    ToolTip = 'Url para obtener los tipos de cuentas bancarias';
                    ApplicationArea = All;
                }
                field(UrlSociedades; Rec.UrlSociedades)
                {
                    ToolTip = 'Url para obtener la lista de sociedades';
                    ApplicationArea = All;
                }
                field(UrlCallBacks; Rec.UrlCallBacks)
                {
                    ToolTip = 'Url para listado de callbacks registrados y activos. Misma url para registro de CallBacks';
                    ApplicationArea = All;
                }
                field(UrlEliminarCallBacks; Rec.UrlEliminarCallBacks)
                {
                    ToolTip = 'Url para dar de baja la dirección a la que se envía un determinado evento';
                    ApplicationArea = All;
                }
                field(UrlTiposCallBack; Rec.UrlTiposCallBack)
                {
                    ToolTip = 'Url para listado de tipo de eventos que se pueden registrar en el sistema.';
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
                    culTCNFunciones.ObtenerAccesoF();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetF();
    end;

}
