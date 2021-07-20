codeunit 60000 "TCNFunciones"
{
    procedure NombreAppF() xSalida: Text
    var
        xModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(xModuleInfo);
        xSalida := xModuleInfo.Name();
    end;

    procedure ObtenerAccesoF()
    var
        xlHttpContent: HttpContent;
        xlHttpClient: HttpClient;
        xlHttpHeaders: HttpHeaders;
        xlJsonObj: JsonObject;
        xlJsonToken: JsonToken;
    begin

    end;


}