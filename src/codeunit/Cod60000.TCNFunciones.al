codeunit 60000 "TCNFunciones"
{

    procedure MovCierreF(pUrlMovCierre: text)
    var
        rlTCNConfBPC: Record TCNConfBPC;
        culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpResponseMessage: HttpResponseMessage;
        xlOutputText: text;
    begin
        if xlHttpClient.Post(pUrlMovCierre, xlHttpContent, xlHttpResponseMessage) and (xlHttpResponseMessage.IsSuccessStatusCode) then begin
            xlHttpResponseMessage.Content.ReadAs(xlOutputText);
            Message(xlOutputText);
        end else begin
            culTCNFuncionesComunes.ErrorF(xlHttpResponseMessage.ReasonPhrase);
        end;
    end;

    procedure MovIntraDiaF(pUrlMovIntraDia: Text)
    var
        rlTCNConfBPC: Record TCNConfBPC;
        culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpHeaders: HttpHeaders;
        xlHttpResponseMessage: HttpResponseMessage;
        xlOutputText: text;
        xlTextBuilder: TextBuilder;
    begin
        xlTextBuilder.AppendLine('{');
        xlTextBuilder.AppendLine('"exportados": true,');
        xlTextBuilder.AppendLine('"fechaDesdeOperacion": "01/01/2021",');
        xlTextBuilder.AppendLine('"fechaHastaOperacion": "31/12/2021"');
        xlTextBuilder.AppendLine('}');
        xlHttpContent.WriteFrom(xlTextBuilder.ToText());

        if xlHttpClient.Post(pUrlMovIntraDia, xlHttpContent, xlHttpResponseMessage) and (xlHttpResponseMessage.IsSuccessStatusCode) then begin
            xlHttpResponseMessage.Content.ReadAs(xlOutputText);
            Message(xlOutputText);
        end else begin
            culTCNFuncionesComunes.ErrorF(xlHttpResponseMessage.ReasonPhrase);
        end;
    end;

    procedure NombreAppF() xSalida: Text
    var
        xModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(xModuleInfo);
        xSalida := xModuleInfo.Name();
    end;

    procedure ObtenerAccesoF(pUrlLogin: text)
    var
        culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
        rlTCNConfBPC: Record TCNConfBPC;
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpHeaders: HttpHeaders;
        xlsd: HttpRequestMessage;
        xlJsonObj: JsonObject;
        xlJsonToken: JsonToken;
        xlTextBuilder: TextBuilder;
        xlHttpResponseMessage: HttpResponseMessage;
        xlOutputText: text;
    begin
        if rlTCNConfBPC.FindFirst() then begin
            xlTextBuilder.AppendLine('{');
            xlTextBuilder.AppendLine('"user": ' + rlTCNConfBPC.User + ',');
            xlTextBuilder.AppendLine('"pass": ' + rlTCNConfBPC." Password");
            xlTextBuilder.AppendLine('}');
            xlHttpContent.WriteFrom(xlTextBuilder.ToText());

            xlHttpHeaders.Add('Content-Type', 'application/json');
            xlHttpHeaders.Add('Accept', 'application/json');

            xlHttpContent.GetHeaders(xlHttpHeaders);

            if xlHttpClient.Post(pUrlLogin, xlHttpContent, xlHttpResponseMessage) and (xlHttpResponseMessage.IsSuccessStatusCode) then begin
                xlHttpResponseMessage.Content.ReadAs(xlOutputText);
                Message(xlOutputText);
            end else begin
                culTCNFuncionesComunes.ErrorF(xlHttpResponseMessage.ReasonPhrase);
            end;


        end;
    end;



}