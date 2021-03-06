package org.wso2.ballerina.connectors.gmail;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.doc;
import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.utils;

@doc:Description{ value : "Gmail client connector"}
@doc:Param{ value : "userId: The userId of the Gmail account which means the email id"}
@doc:Param{ value : "accessToken: The accessToken of the Gmail account to access the gmail REST API"}
@doc:Param{ value : "refreshToken: The refreshToken of the Gmail App to access the gmail REST API"}
@doc:Param{ value : "clientId: The clientId of the App to access the gmail REST API"}
@doc:Param{ value : "clientSecret: The clientSecret of the App to access the gmail REST API"}
connector ClientConnector (string userId, string accessToken, string refreshToken, string clientId,
                           string clientSecret) {

    string refreshTokenEP = "https://www.googleapis.com/oauth2/v3/token";
    string baseURL = "https://www.googleapis.com/gmail";

    oauth2:ClientConnector gmailEP = create oauth2:ClientConnector(baseURL, accessToken, clientId, clientSecret,
                                                                   refreshToken, refreshTokenEP);

    @doc:Description{ value : "Retrieve the user profile"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Return{ value : "response object"}
    action getUserProfile(ClientConnector g) (message) {

        message request = {};

        string getProfilePath = "/v1/users/" + userId + "/profile";
        message response = oauth2:ClientConnector.get(gmailEP, getProfilePath, request);

        return response;
    }

    @doc:Description{ value : "Create a draft"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "to: Receiver mail ID"}
    @doc:Param{ value : "subject: Subject of the message"}
    @doc:Param{ value : "from: Sender mail ID"}
    @doc:Param{ value : "messageBody: Entire message body"}
    @doc:Param{ value : "cc: To whom sender need to cc the mail"}
    @doc:Param{ value : "bcc: To whom sender need to bcc the mail"}
    @doc:Param{ value : "id: Id of the draft to create"}
    @doc:Param{ value : "threadId: thread Id of the draft to reply"}
    @doc:Return{ value : "response object"}
    action createDraft(ClientConnector g, string to, string subject, string from, string messageBody,
                       string cc , string bcc, string id, string threadId) (message) {

        message request = {};
        string concatRequest = "";

        if(to != "null") {
            concatRequest = concatRequest + "to:" + to + "\n";
        }

        if(subject != "null") {
            concatRequest = concatRequest + "subject:" + subject + "\n";
        }

        if(from != "null") {
            concatRequest = concatRequest + "from:" + from + "\n";
        }

        if(cc != "null") {
            concatRequest = concatRequest + "cc:" + cc + "\n";
        }

        if(bcc != "null") {
            concatRequest = concatRequest + "bcc:" + bcc + "\n";
        }

        if(id != "null") {
            concatRequest = concatRequest + "id:" + id + "\n";
        }

        if(threadId != "null") {
            concatRequest = concatRequest + "threadId:" + threadId + "\n";
        }

        if(messageBody != "null") {
            concatRequest = concatRequest + "\n" + messageBody + "\n";
        }

        string encodedRequest = utils:base64encode(concatRequest);
        json createDraftRequest = `{"message":{"raw": ${encodedRequest}}}`;

        string createDraftPath = "/v1/users/" + userId + "/drafts";
        messages:setJsonPayload(request, createDraftRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message response = oauth2:ClientConnector.post(gmailEP, createDraftPath, request);

        return response;
    }

    @doc:Description{ value : "Update a draft"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "draftId: Id of the draft to update"}
    @doc:Param{ value : "to: Receiver mail ID"}
    @doc:Param{ value : "subject: Subject of the message"}
    @doc:Param{ value : "from: Sender mail ID"}
    @doc:Param{ value : "messageBody: Entire message body"}
    @doc:Param{ value : "cc: To whom sender need to cc the mail"}
    @doc:Param{ value : "bcc: To whom sender need to bcc the mail"}
    @doc:Param{ value : "id: Id of the draft to reply"}
    @doc:Param{ value : "threadId: thread Id of the draft to reply"}
    @doc:Return{ value : "response object"}
    action updateDraft(ClientConnector g, string draftId, string to, string subject, string from,
                       string messageBody, string cc , string bcc, string id, string threadId) (message) {

        message request = {};
        string concatRequest = "";

        if(to != "null") {
            concatRequest = concatRequest + "to:" + to + "\n";
        }

        if(subject != "null") {
            concatRequest = concatRequest + "subject:" + subject + "\n";
        }

        if(from != "null") {
            concatRequest = concatRequest + "from:" + from + "\n";
        }

        if(cc != "null") {
            concatRequest = concatRequest + "cc:" + cc + "\n";
        }

        if(bcc != "null") {
            concatRequest = concatRequest + "bcc:" + bcc + "\n";
        }

        if(id != "null") {
            concatRequest = concatRequest + "id:" + id + "\n";
        }

        if(threadId != "null") {
            concatRequest = concatRequest + "threadId:" + threadId + "\n";
        }

        if(messageBody != "null") {
            concatRequest = concatRequest + "\n" + messageBody + "\n";
        }

        string encodedRequest = utils:base64encode(concatRequest);
        json updateDraftRequest = `{"message":{"raw": ${encodedRequest}}}`;

        string updateDraftPath = "/v1/users/" + userId + "/drafts/" +draftId;
        messages:setJsonPayload(request, updateDraftRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message response = oauth2:ClientConnector.put(gmailEP, updateDraftPath, request);

        return response;
    }

    @doc:Description{ value : "Retrieve a particular draft"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "draftId: Id of the draft to retrieve"}
    @doc:Param{ value : "format: The format to return the draft in"}
    @doc:Return{ value : "response object"}
    action readDraft(ClientConnector g, string draftId, string format) (message) {

        message request = {};

        string readDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;

        if(format != "null") {
            readDraftPath = readDraftPath + "?format=" + format;
        }

        message response = oauth2:ClientConnector.get(gmailEP, readDraftPath, request);

        return response;
    }

    @doc:Description{ value : "Lists the drafts in the user's mailbox"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "includeSpamTrash: Include messages from SPAM and TRASH in the results"}
    @doc:Param{ value : "maxResults: Maximum number of messages to return"}
    @doc:Param{ value : "pageToken: Page token to retrieve a specific page of results in the list"}
    @doc:Param{ value : "q: Only return messages matching the specified query. Supports the same query format as
                   the Gmail search box"}
    @doc:Return{ value : "response object"}
    action listDrafts(ClientConnector g, string includeSpamTrash, string maxResults, string pageToken,
                      string q) (message) {

        message request = {};
        string uriParams;

        string listDraftPath = "/v1/users/" + userId + "/drafts";

        if(includeSpamTrash != "null"){
            uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
        }

        if(maxResults != "null"){
            uriParams = uriParams + "&maxResults=" + maxResults;
        }

        if(pageToken != "null"){
            uriParams = uriParams + "&pageToken=" + pageToken;
        }

        if(q != "null"){
            uriParams = uriParams + "&q=" + q;
        }

        if(uriParams != "") {
            listDraftPath = listDraftPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }

        message response = oauth2:ClientConnector.get(gmailEP, listDraftPath, request);

        return response;
    }

    @doc:Description{ value : "Delete a particular draft"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "draftId: Id of the draft to delete"}
    @doc:Return{ value : "response object"}
    action deleteDraft(ClientConnector g, string draftId) (message) {

        message request = {};

        string deleteDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;
        message response = oauth2:ClientConnector.delete(gmailEP, deleteDraftPath, request);

        return response;
    }

    @doc:Description{ value : "Lists the history to of all changes to the given mailbox"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "labelId: Only return messages with a label matching the ID"}
    @doc:Param{ value : "maxResults: Maximum number of messages to return"}
    @doc:Param{ value : "pageToken: Page token to retrieve a specific page of results in the list"}
    @doc:Param{ value : "startHistoryId: Returns history records after the specified startHistoryId"}
    @doc:Return{ value : "response object"}
    action listHistory(ClientConnector g, string labelId, string maxResults, string pageToken,
                       string startHistoryId) (message){

        message request = {};

        string listHistoryPath = "/v1/users/" + userId + "/history?startHistoryId=" + startHistoryId;

        if(labelId != "null") {
            listHistoryPath = listHistoryPath + "&labelId=" + labelId;
        }

        if(maxResults != "null") {
            listHistoryPath = listHistoryPath + "&maxResults=" + maxResults;
        }

        if(pageToken != "null") {
            listHistoryPath = listHistoryPath + "&pageToken=" + pageToken;
        }

        message response = oauth2:ClientConnector.get(gmailEP, listHistoryPath, request);

        return response;
    }

    @doc:Description{ value : "Create a new label"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "labelName: The display name of the label"}
    @doc:Param{ value : "messageListVisibility: The visibility of messages with this label in the message list in the
                                        Gmail web interface"}
    @doc:Param{ value : "labelListVisibility: The visibility of the label in the label list in the Gmail web interface"}
    @doc:Param{ value : "types: The owner type for the label"}
    @doc:Param{ value : "messagesTotal: The total number of messages with the label"}
    @doc:Param{ value : "messagesUnread: The number of unread messages with the label"}
    @doc:Param{ value : "threadsTotal: The total number of threads with the label"}
    @doc:Param{ value : "threadsUnread: The number of unread threads with the label"}
    @doc:Return{ value : "response object"}
    action createLabel(ClientConnector g, string labelName, string messageListVisibility,
                       string labelListVisibility, string types, string messagesTotal, string messagesUnread,
                       string threadsTotal, string threadsUnread) (message) {

        message request = {};

        json createLabelRequest = `{"name": ${labelName}, "messageListVisibility":
        ${messageListVisibility}, "labelListVisibility": ${labelListVisibility},
        "type": ${types},"messagesTotal": ${messagesTotal}, "messagesUnread": ${messagesUnread},
        "threadsTotal": ${threadsTotal}, "threadsUnread": ${threadsUnread}}`;

        if (types == "null") {
            jsons:remove(createLabelRequest, "$.type");
        }

        if (messagesTotal == "null") {
            jsons:remove(createLabelRequest, "$.messagesTotal");
        }

        if (messagesUnread == "null") {
            jsons:remove(createLabelRequest, "$.messagesUnread");
        }

        if (threadsTotal == "null") {
            jsons:remove(createLabelRequest, "$.threadsTotal");
        }

        if (threadsUnread == "null") {
            jsons:remove(createLabelRequest, "$.threadsUnread");
        }

        string createLabelPath = "/v1/users/" + userId + "/labels";
        messages:setHeader(request, "Content-Type", "Application/json");
        messages:setJsonPayload(request, createLabelRequest);
        message response = oauth2:ClientConnector.post(gmailEP, createLabelPath, request);

        return response;
    }

    @doc:Description{ value : "Delete a particular label"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "labelId: Id of the label to delete"}
    @doc:Return{ value : "response object"}
    action deleteLabel(ClientConnector g, string labelId) (message) {

        message request = {};

        string deleteLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        message response = oauth2:ClientConnector.delete(gmailEP, deleteLabelPath, request);

        return response;
    }

    @doc:Description{ value : "Lists all labels in the user's mailbox"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Return{ value : "response object"}
    action listLabels(ClientConnector g) (message) {

        message request = {};

        string listLabelPath = "/v1/users/" + userId + "/labels/";
        message response = oauth2:ClientConnector.get(gmailEP, listLabelPath, request);

        return response;
    }

    @doc:Description{ value : "Update a particular label"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "labelId: The Id of the label to update"}
    @doc:Param{ value : "labelName: The display name of the label"}
    @doc:Param{ value : "messageListVisibility: The visibility of messages with this label in the message list in the
                                        Gmail web interface"}
    @doc:Param{ value : "labelListVisibility: The visibility of the label in the label list in the Gmail web interface"}
    @doc:Param{ value : "types: The owner type for the label"}
    @doc:Param{ value : "messagesTotal: The total number of messages with the label"}
    @doc:Param{ value : "messagesUnread: The number of unread messages with the label"}
    @doc:Param{ value : "threadsTotal: The total number of threads with the label"}
    @doc:Param{ value : "threadsUnread: The number of unread threads with the label"}
    @doc:Return{ value : "response object"}
    action updateLabel(ClientConnector g, string labelId, string labelName, string messageListVisibility,
                       string labelListVisibility, string types, string messagesTotal, string messagesUnread,
                       string threadsTotal, string threadsUnread) (message) {

        message request = {};

        json updateLabelRequest = `{"id": ${labelId}, "name": ${labelName},
        "messageListVisibility": ${messageListVisibility},
        "labelListVisibility": ${labelListVisibility}, "type": ${types},"messagesTotal":
        ${messagesTotal}, "messagesUnread": ${messagesUnread}, "threadsTotal": ${threadsTotal},
        "threadsUnread": ${threadsUnread}}`;

        if (types == "null") {
            jsons:remove(updateLabelRequest, "$.type");
        }

        if (messagesTotal == "null") {
            jsons:remove(updateLabelRequest, "$.messagesTotal");
        }

        if (messagesUnread == "null") {
            jsons:remove(updateLabelRequest, "$.messagesUnread");
        }

        if (threadsTotal == "null") {
            jsons:remove(updateLabelRequest, "$.threadsTotal");
        }

        if (threadsUnread == "null") {
            jsons:remove(updateLabelRequest, "$.threadsUnread");
        }

        string updateLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        messages:setHeader(request, "Content-Type", "Application/json");
        messages:setJsonPayload(request, updateLabelRequest);
        message response = oauth2:ClientConnector.put(gmailEP, updateLabelPath, request);

        return response;
    }

    @doc:Description{ value : "Retrieve a particular label"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "labelId: Id of the label to retrieve"}
    @doc:Return{ value : "response object"}
    action readLabel(ClientConnector g, string labelId) (message) {

        message request = {};

        string readLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        message response = oauth2:ClientConnector.get(gmailEP, readLabelPath, request);

        return response;
    }

    @doc:Description{ value : "Retrieve a particular Thread"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "threadId: Id of the thread to retrieve"}
    @doc:Param{ value : "format: The format to return the thread in"}
    @doc:Param{ value : "metaDataHeaders: When given and format is METADATA, only include headers specified"}
    @doc:Return{ value : "response object"}
    action readThread(ClientConnector g, string threadId, string format, string metaDataHeaders) (message) {

        message request = {};
        string encodedHeaders = uri:encode(metaDataHeaders);
        string uriParams;

        string readThreadPath = "/v1/users/" + userId + "/threads/" + threadId;

        if(format != "null") {
            uriParams = uriParams + "&format=" + format;
        }

        if(metaDataHeaders != "null") {
            uriParams = uriParams + "&metaDataHeaders=" + metaDataHeaders;
        }

        if(uriParams != "null") {
            readThreadPath = readThreadPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }

        message response = oauth2:ClientConnector.get(gmailEP, readThreadPath, request);

        return response;
    }

    @doc:Description{ value : "Lists the threads in the user's mailbox"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "includeSpamTrash: Include messages from SPAM and TRASH in the results"}
    @doc:Param{ value : "labelIds: Only return messages with labels that match all of the specified label IDs"}
    @doc:Param{ value : "maxResults: Maximum number of messages to return"}
    @doc:Param{ value : "pageToken: Page token to retrieve a specific page of results in the list"}
    @doc:Param{ value : "q: Only return messages matching the specified query. Supports the same query format as
                   the Gmail search box"}
    @doc:Return{ value : "response object"}
    action listThreads(ClientConnector g, string includeSpamTrash, string labelIds, string maxResults,
                       string pageToken, string q) (message) {

        message request = {};
        string uriParams;

        string listThreadPath = "/v1/users/" + userId + "/threads";

        if(includeSpamTrash != "null"){
            uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
        }

        if(labelIds != "null"){
            uriParams = uriParams + "&labelIds=" + labelIds;
        }

        if(maxResults != "null"){
            uriParams = uriParams + "&maxResults=" + maxResults;
        }

        if(pageToken != "null"){
            uriParams = uriParams + "&pageToken=" + pageToken;
        }

        if(q != "null"){
            uriParams = uriParams + "&q=" + q;
        }

        if(uriParams != "") {
            listThreadPath = listThreadPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message response = oauth2:ClientConnector.get(gmailEP, listThreadPath, request);

        return response;
    }

    @doc:Description{ value : "Delete a particular thread"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "threadId: Id of the thread to delete"}
    @doc:Return{ value : "response object"}
    action deleteThread(ClientConnector g, string threadId) (message) {

        message request = {};

        string deleteThreadPath = "/v1/users/" + userId + "/threads/" + threadId;
        message response = oauth2:ClientConnector.delete(gmailEP, deleteThreadPath, request);

        return response;
    }

    @doc:Description{ value : "Trash a particular thread"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "threadId: Id of the thread to Trash"}
    @doc:Return{ value : "response object"}
    action trashThread(ClientConnector g, string threadId) (message) {

        message request = {};

        string trashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/trash";
        http:setContentLength(request, 0);
        message response = oauth2:ClientConnector.post(gmailEP, trashThreadPath, request);

        return response;
    }

    @doc:Description{ value : "UnTrash a particular thread"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "threadId: Id of the thread to unTrash"}
    @doc:Return{ value : "response object"}
    action unTrashThread(ClientConnector g, string threadId) (message) {

        message request = {};

        string unTrashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/untrash";
        http:setContentLength(request, 0);
        message response = oauth2:ClientConnector.post(gmailEP, unTrashThreadPath, request);

        return response;
    }

    @doc:Description{ value : "Lists the messages in the user's mailbox"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "includeSpamTrash: Include messages from SPAM and TRASH in the results"}
    @doc:Param{ value : "labelIds: Only return messages with labels that match all of the specified label IDs"}
    @doc:Param{ value : "maxResults: Maximum number of messages to return"}
    @doc:Param{ value : "pageToken: Page token to retrieve a specific page of results in the list"}
    @doc:Param{ value : "q: Only return messages matching the specified query. Supports the same query format as
                   the Gmail search box"}
    @doc:Return{ value : "response object"}
    action listMails(ClientConnector g, string includeSpamTrash, string labelIds, string maxResults,
                     string pageToken, string q) (message) {

        message request = {};
        string uriParams;

        string listMailPath = "/v1/users/" + userId + "/messages";

        if(includeSpamTrash != "null"){
            uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
        }

        if(labelIds != "null"){
            uriParams = uriParams + "&labelIds=" + labelIds;
        }

        if(maxResults != "null"){
            uriParams = uriParams + "&maxResults=" + maxResults;
        }

        if(pageToken != "null"){
            uriParams = uriParams + "&pageToken=" + pageToken;
        }

        if(q != "null"){
            uriParams = uriParams + "&q=" + q;
        }

        if(uriParams != "") {
            listMailPath = listMailPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message response = oauth2:ClientConnector.get(gmailEP, listMailPath, request);

        return response;
    }

    @doc:Description{ value : "Send a mail"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "to: Receiver mail ID"}
    @doc:Param{ value : "subject: Subject of the message"}
    @doc:Param{ value : "from: Sender mail ID"}
    @doc:Param{ value : "messageBody: Entire message body"}
    @doc:Param{ value : "cc: To whom sender need to cc the mail"}
    @doc:Param{ value : "bcc: To whom sender need to bcc the mail"}
    @doc:Param{ value : "id: Id of the mail to send"}
    @doc:Param{ value : "threadId: thread Id of the mail to reply"}
    @doc:Return{ value : "response object"}
    action sendMail(ClientConnector g, string to, string subject, string from, string messageBody,
                    string cc , string bcc, string id, string threadId) (message) {

        message request = {};
        string concatRequest = "";

        if(to != "null") {
            concatRequest = concatRequest + "to:" + to + "\n";
        }

        if(subject != "null") {
            concatRequest = concatRequest + "subject:" + subject + "\n";
        }

        if(from != "null") {
            concatRequest = concatRequest + "from:" + from + "\n";
        }

        if(cc != "null") {
            concatRequest = concatRequest + "cc:" + cc + "\n";
        }

        if(bcc != "null") {
            concatRequest = concatRequest + "bcc:" + bcc + "\n";
        }

        if(id != "null") {
            concatRequest = concatRequest + "id:" + id + "\n";
        }

        if(threadId != "null") {
            concatRequest = concatRequest + "threadId:" + threadId + "\n";
        }

        if(messageBody != "null") {
            concatRequest = concatRequest + "\n" + messageBody + "\n";
        }

        string encodedRequest = utils:base64encode(concatRequest);
        json sendMailRequest = `{"raw": ${encodedRequest}}`;
        string sendMailPath = "/v1/users/" + userId + "/messages/send";
        messages:setJsonPayload(request, sendMailRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message response = oauth2:ClientConnector.post(gmailEP, sendMailPath, request);

        return response;
    }

    @doc:Description{ value : "Modifies the labels on the specified message"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "messageId: The ID of the message to modifies the labels"}
    @doc:Param{ value : "addLabelIds: A list of IDs of labels to add to this message"}
    @doc:Param{ value : "removeLabelIds: A list IDs of labels to remove from this message"}
    @doc:Return{ value : "response object"}
    action modifyExistingMessage(ClientConnector g, string messageId, string addLabelIds,
                                 string removeLabelIds) (message) {

        message request = {};

        json modifyExistingMessageRequest = `{"addLabelIds":[${addLabelIds}],
        "removeLabelIds":[${removeLabelIds}]}`;

        if(addLabelIds == "null") {
            jsons:remove(modifyExistingMessageRequest, "$.addLabelIds");
        }

        if(removeLabelIds == "null") {
            jsons:remove(modifyExistingMessageRequest, "$.removeLabelIds");
        }

        string modifyExistingMessagePath = "/v1/users/" + userId + "/messages/" + messageId + "/modify";
        messages:setJsonPayload(request, modifyExistingMessageRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message response = oauth2:ClientConnector.post(gmailEP, modifyExistingMessagePath, request);

        return response;
    }

    @doc:Description{ value : "Retrieve a particular Message"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "messageId: Id of the message to retrieve"}
    @doc:Param{ value : "format: The format to return the Message in"}
    @doc:Param{ value : "metaDataHeaders: When given and format is METADATA, only include headers specified"}
    @doc:Return{ value : "response object"}
    action readMail(ClientConnector g, string messageId, string format, string metaDataHeaders) (message) {

        message request = {};
        string uriParams;
        string readMailPath = "/v1/users/" + userId + "/messages/" + messageId;

        string encodedHeaders = uri:encode(metaDataHeaders);

        if(format != "null") {
            uriParams = uriParams + "&format=" + format;
        }

        if(metaDataHeaders != "null") {
            uriParams = uriParams + "&metaDataHeaders=" + metaDataHeaders;
        }

        if(uriParams != "") {
            readMailPath = readMailPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }

        message response = oauth2:ClientConnector.get(gmailEP, readMailPath, request);

        return response;
    }

    @doc:Description{ value : "Delete a particular message"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "messageId: Id of the message to delete"}
    @doc:Return{ value : "response object"}
    action deleteMail(ClientConnector g, string messageId) (message) {

        message request = {};

        string deleteMailPath = "/v1/users/" + userId + "/messages/" + messageId;
        message response = oauth2:ClientConnector.delete(gmailEP, deleteMailPath, request);

        return response;
    }

    @doc:Description{ value : "Trash a particular message"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "messageId: Id of the message to Trash"}
    @doc:Return{ value : "response object"}
    action trashMail(ClientConnector g, string messageId) (message) {

        message request = {};

        string trashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/trash";
        http:setContentLength(request, 0);
        message response = oauth2:ClientConnector.post(gmailEP, trashMailPath, request);

        return response;
    }

    @doc:Description{ value : "UnTrash a particular message"}
    @doc:Param{ value : "g: The gmail Connector instance"}
    @doc:Param{ value : "messageId: Id of the message to unTrash"}
    @doc:Return{ value : "response object"}
    action unTrashMail(ClientConnector g, string messageId) (message) {

        message request = {};

        string unTrashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/untrash";
        http:setContentLength(request, 0);
        message response = oauth2:ClientConnector.post(gmailEP, unTrashMailPath, request);

        return response;
    }
}