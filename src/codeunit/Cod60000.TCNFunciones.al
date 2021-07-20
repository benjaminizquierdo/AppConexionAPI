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
        clContentType: Label 'Content-Type';
        clAccept: Label 'Accept';
        clAplicationJson: Label 'application/json';
        clMetodh: Label 'POST';
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpHeaders: HttpHeaders;
        xlHttpRequestMessage: HttpRequestMessage;
        xlHttpResponseMessage: HttpResponseMessage;
        xlOutputText: text;
        xlBody: text;
    begin
        if rlTCNConfBPC.FindFirst() then begin
            xlHttpContent.Clear();
            xlHttpContent.WriteFrom('{"user": "' + rlTCNConfBPC.User + '","pass": "' + rlTCNConfBPC." Password" + '"}');

            xlHttpContent.GetHeaders(xlHttpHeaders);
            xlHttpHeaders.Remove(clContentType);
            xlHttpHeaders.Add(clContentType, clAplicationJson);

            xlHttpRequestMessage.Content := xlHttpContent;
            xlHttpRequestMessage.SetRequestUri(pUrlLogin);
            xlHttpRequestMessage.Method := clMetodh;
            xlHttpClient.Timeout(-1);
            if xlHttpClient.Send(xlHttpRequestMessage, xlHttpResponseMessage) and xlHttpResponseMessage.IsSuccessStatusCode then begin
                xlHttpResponseMessage.Content.ReadAs(xlOutputText);
                Message(xlOutputText);
            end else begin
                xlHttpResponseMessage.Content.ReadAs(xlOutputText);
                Message(xlOutputText);
            end;
        end;
    end;



}