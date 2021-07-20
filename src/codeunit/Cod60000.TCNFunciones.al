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

    procedure MovIntraDiaF(pUrlMovCierre: Text)
    var
        rlTCNConfBPC: Record TCNConfBPC;
        culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpHeaders: HttpHeaders;
        xlHttpResponseMessage: HttpResponseMessage;
        xlTextBuilder: TextBuilder;
        xlOutputText: text;
    begin
        xlTextBuilder.AppendLine('{');
        xlTextBuilder.AppendLine('"exportados": true,');
        xlTextBuilder.AppendLine('"fechaDesdeOperacion": "01/01/2021",');
        xlTextBuilder.AppendLine('"fechaHastaOperacion": "31/12/2021"');
        xlTextBuilder.AppendLine('}');
        xlHttpContent.WriteFrom(xlTextBuilder.ToText());

        if xlHttpClient.Put(pUrlMovCierre, xlHttpContent, xlHttpResponseMessage) and (xlHttpResponseMessage.IsSuccessStatusCode) then begin
            xlHttpResponseMessage.Content.ReadAs(xlOutputText);
            Message(xlOutputText);
        end else begin
            culTCNFuncionesComunes.ErrorF(xlHttpResponseMessage.ReasonPhrase);
        end;

    end;



}