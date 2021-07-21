page 60001 TCNConsultarBPC
{

    Caption = 'BANKINPLAY CLIENTES';
    PageType = Card;
    ApplicationArea = all;
    SourceTable = TCNConfBPC;
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {

        }
    }
    actions
    {
        area(Processing)
        {

            action(OpenConf)
            {
                ApplicationArea = All;
                Caption = 'Abrir Configuracion';
                Image = OpenJournal;
                trigger OnAction()
                var
                    culTCNFunciones: Codeunit TCNFunciones;
                    pglTCNConfBPC: Page TCNConfBPC;
                begin
                    pglTCNConfBPC.Run();
                end;
            }

            action(ObtAcceso)
            {
                ApplicationArea = All;
                Caption = 'Obtener Acceso';
                Image = GetBinContent;
                trigger OnAction()
                var
                    culTCNFunciones: Codeunit TCNFunciones;
                    rlTempTCNConfBPC: Record TCNConfBPC temporary;
                begin
                    culTCNFunciones.ObtenerAccesoF();
                end;
            }

            group(Movimientos)
            {
                Caption = 'Lectura de Movimientos';
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
            group(ListaEntidades)
            {
                Caption = 'Lista Entidades';
                action(Sociedades)
                {
                    ApplicationArea = All;
                    Caption = 'Lista Sociedades';
                    Image = AbsenceCategories;
                    trigger OnAction()
                    var
                        culTCNFunciones: Codeunit TCNFunciones;
                    begin
                    end;
                }

                action(Bancos)
                {
                    ApplicationArea = All;
                    Caption = 'Lista Bancos';
                    Image = AbsenceCategories;
                    trigger OnAction()
                    var
                        culTCNFunciones: Codeunit TCNFunciones;
                    begin
                    end;
                }
                action(CuentasBancarias)
                {
                    ApplicationArea = All;
                    Caption = 'Lista Cuentas Bancarias';
                    Image = AbsenceCategories;
                    trigger OnAction()
                    var
                        culTCNFunciones: Codeunit TCNFunciones;
                    begin
                    end;
                }
                action(TiposCuentasBancarias)
                {
                    ApplicationArea = All;
                    Caption = 'Lista Tipos Cuentas Bancarias';
                    Image = AbsenceCategories;
                    trigger OnAction()
                    var
                        culTCNFunciones: Codeunit TCNFunciones;
                    begin
                    end;
                }
            }
        }
    }
}
