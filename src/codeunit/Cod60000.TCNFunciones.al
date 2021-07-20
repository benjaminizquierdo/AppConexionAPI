codeunit 60000 "TCNFunciones"
{
    var
        cBearerAuth: Label 'Bearer %1';


    procedure MovCierreF(pUrlMovCierre: text)
    var
        rlTCNConfBPC: Record TCNConfBPC;
        culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpHeaders: HttpHeaders;
        xlHttpRequestMessage: HttpRequestMessage;
        xlHttpResponseMessage: HttpResponseMessage;
        clAuthorization: Label 'Authorization';
        clMetodh: Label 'POST';
        xlOutputText: text;
    begin
        xlHttpContent.Clear();
        xlHttpClient.DefaultRequestHeaders.Clear();
        xlHttpClient.DefaultRequestHeaders.Add(clAuthorization, StrSubstNo(cBearerAuth, 'eyJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoibm9EYXRhIn0.MtwfQWFeIBShcwLcDo2ybxKErCLuvhxA0H1tDaX7zL8'));

        xlHttpRequestMessage.Content := xlHttpContent;
        xlHttpRequestMessage.SetRequestUri(pUrlMovCierre);
        xlHttpRequestMessage.Method := clMetodh;

        if xlHttpClient.Send(xlHttpRequestMessage, xlHttpResponseMessage) and (xlHttpResponseMessage.IsSuccessStatusCode) then begin
            xlHttpResponseMessage.Content.ReadAs(xlOutputText);
            Message(xlOutputText);
        end else begin
            // culTCNFuncionesComunes.ErrorF(xlHttpResponseMessage.ReasonPhrase);
            xlHttpResponseMessage.Content.ReadAs(xlOutputText);
            Message(xlOutputText);
        end;
    end;

    procedure MovIntraDiaF(pUrlMovIntraDia: Text)
    var
        rlTCNConfBPC: Record TCNConfBPC;
        culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpHeaders: HttpHeaders;
        xlHttpRequestMessage: HttpRequestMessage;
        xlHttpResponseMessage: HttpResponseMessage;
        clAuthorization: Label 'Authorization';
        clMetodh: Label 'POST';
        xlOutputText: text;
        xlTextBuilder: TextBuilder;
    begin
        xlHttpContent.Clear();
        xlHttpContent.WriteFrom(makeJsonAuth());
        xlHttpClient.DefaultRequestHeaders.Clear();
        xlHttpClient.DefaultRequestHeaders.Add(clAuthorization, StrSubstNo(cBearerAuth, '222222222'));


        xlHttpRequestMessage.Content := xlHttpContent;
        xlHttpRequestMessage.SetRequestUri(pUrlMovIntraDia);
        xlHttpRequestMessage.Method := clMetodh;

        if xlHttpClient.Send(xlHttpRequestMessage, xlHttpResponseMessage) and (xlHttpResponseMessage.IsSuccessStatusCode) then begin
            xlHttpResponseMessage.Content.ReadAs(xlOutputText);
            Message(xlOutputText);
        end else begin
            // culTCNFuncionesComunes.ErrorF(xlHttpResponseMessage.ReasonPhrase);
            xlHttpResponseMessage.Content.ReadAs(xlOutputText);
            Message(xlOutputText);
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
        rlTCNConfBPC: Record TCNConfBPC;
        culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
        xlHttpClient: HttpClient;
        xlHttpContent: HttpContent;
        xlHttpHeaders: HttpHeaders;
        xlHttpRequestMessage: HttpRequestMessage;
        xlHttpResponseMessage: HttpResponseMessage;
        clAplicationJson: Label 'application/json';
        clContentType: Label 'Content-Type';
        clMetodh: Label 'POST';
        xlOutputText: text;
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

    local procedure makeJsonAuth() xlsalida: Text;
    var
        xlTextBuilder: TextBuilder;
    begin
        xlTextBuilder.AppendLine('{');
        xlTextBuilder.AppendLine('"exportados": true,');
        xlTextBuilder.AppendLine('"fechaDesdeOperacion": "01/01/2021",');
        xlTextBuilder.AppendLine('"fechaHastaOperacion": "31/12/2021"');
        xlTextBuilder.AppendLine('}');
        xlsalida := xlTextBuilder.ToText();
    end;



}