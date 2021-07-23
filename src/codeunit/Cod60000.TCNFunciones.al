codeunit 60000 "TCNFunciones"
{
    var
        cBearerAuth: Label 'Bearer %1';


    // //PENDIENTE PRUEBA OBTENER JSON
    // procedure Prueba1()
    // var
    //     rlField: Record "Field";
    //     rlTCNConfBPC: Record TCNConfBPC;
    //     culTCNFuncionesComunes: Codeunit TCN_FuncionesComunes;
    //     pglTCNDatosConsultasBPC: Page TCNDatosConsultasBPC;
    //     rlTempTCNPrueba1: Record TCNPrueba1 temporary;
    //     xlHttpClient: HttpClient;
    //     xlHttpContent: HttpContent;
    //     xlHttpHeaders: HttpHeaders;
    //     xlHttpRequestMessage: HttpRequestMessage;
    //     xlHttpResponseMessage: HttpResponseMessage;
    //     clMetodh: Label 'GET';
    //     xlOutputText: text;
    //     xlSeguir: Boolean;
    //     xlArrayJson: JsonArray;
    //     xlObjectJson: JsonObject;
    //     xlKey: text;
    //     xlJsonToken: JsonToken;
    //     xlTextoJson: text;

    // begin
    //     xlHttpRequestMessage.SetRequestUri('https://jsonplaceholder.typicode.com/posts?_limit=10');
    //     xlHttpRequestMessage.Method := clMetodh;
    //     xlSeguir := false;

    //     if xlHttpClient.Send(xlHttpRequestMessage, xlHttpResponseMessage) and (xlHttpResponseMessage.IsSuccessStatusCode) then begin
    //         xlHttpResponseMessage.Content.ReadAs(xlOutputText);

    //         if xlArrayJson.ReadFrom(xlOutputText) then begin
    //             repeat
    //                 xlArrayJson.Get(1, xlJsonToken);
    //                 xlObjectJson := xlJsonToken.AsObject();
    //                 foreach xlKey in xlObjectJson.Keys do begin
    //                     xlObjectJson.Get(xlKey, xlJsonToken);
    //                     xlTextoJson := xlJsonToken.AsValue().AsText();

    //                     rlField.SetRange(TableNo, SacaraNumTablaPorNombreF(rlTempTCNPrueba1.TableName));
    //                     rlField.SetRange(FieldName, xlKey);

    //                     if rlField.FindFirst() then begin

    //                     end
    //                 end;
    //             until not xlSeguir;
    //             Message(Format(xlArrayJson.Count) + 'keys');
    //         end;
    //         // pglTCNDatosConsultasBPC.SetRecord(rlTempTCNPrueba1);
    //         Message(xlOutputText);
    //     end else begin
    //         // culTCNFuncionesComunes.ErrorF(xlHttpResponseMessage.ReasonPhrase);
    //         xlHttpResponseMessage.Content.ReadAs(xlOutputText);
    //         Message(xlOutputText);
    //     end;
    // end;


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
        xlHttpClient.DefaultRequestHeaders.Add(clAuthorization, StrSubstNo(cBearerAuth, '222222222'));

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

    procedure ObtenerAccesoF()
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
            xlHttpRequestMessage.SetRequestUri(rlTCNConfBPC.UrlLogin);
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