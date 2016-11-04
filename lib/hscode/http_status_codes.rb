require 'hscode/storage_hash'

module Hscode
  HTTP_STATUS_CODES = {
    100 => {
      title: 'Continue',
      description: [
        "The initial part of a request has been received and has not yet \
        been rejected by the server. The server intends to send a final \
        response after the request has been fully received and acted upon.",
        "When the request contains an Expect header field that includes a \
        100-continue expectation, the 100 response indicates that the server \
        wishes to receive the request payload body. The client ought to \
        continue sending the request and discard the 100 response.",
        "If the request did not contain an Expect header field containing \
        the 100-continue expectation, the client can simply discard this \
        interim response."
      ]
    },
    101 => {
      title: 'Switching Protocols',
      description: [
        "The server understands and is willing to comply with the client's \
        request, via the Upgrade header field, for a change in the \
        application protocol being used on this connection.",
        "The server MUST generate an Upgrade header field in the response \
        that indicates which protocol(s) will be switched to immediately \
        after the empty line that terminates the 101 response.",
        "It is assumed that the server will only agree to switch protocols \
        when it is advantageous to do so. For example, switching to a newer \
        version of HTTP might be advantageous over older versions, and \
        switching to a real-time, synchronous protocol might be advantageous \
        when delivering resources that use such features."
      ]
    },
    102 => {
      title: 'Processing',
      description: [
        "An interim response used to inform the client that the server has \
        accepted the complete request, but has not yet completed it.",
        "This status code SHOULD only be sent when the server has a \
        reasonable expectation that the request will take significant \
        time to complete. As guidance, if a method is taking longer than \
        20 seconds (a reasonable, but arbitrary value) to process the \
        server SHOULD return a 102 (Processing) response. The server MUST \
        send a final response after the request has been completed.",
        "Methods can potentially take a long period of time to process, \
        especially methods that support the Depth header. In such cases the \
        client may time-out the connection while waiting for a response. To \
        prevent this the server may return a 102 Processing status code to \
        indicate to the client that the server is still processing the method."
      ]
    },
    200 => {
      title: 'OK',
      description: [
        'The request has succeeded.',
        "The payload sent in a 200 response depends on the request method. \
        For the methods defined by this specification, the intended \
        meaning of the payload can be summarized as:",
        "Aside from responses to CONNECT, a 200 response always has a \
        payload, though an origin server MAY generate a payload body of \
        zero length. If no payload is desired, an origin server ought to \
        send 204 No Content instead.  For CONNECT, no payload is allowed \
        because the successful result is a tunnel, which begins immediately \
        after the 200 response header section.",
        "A 200 response is cacheable by default; i.e., unless otherwise \
        indicated by the method definition or explicit cache controls."
      ]
    },
    201 => {
      title: 'Created',
      description: [
        "The request has been fulfilled and has resulted in one or more new \
        resources being created.",
        "The primary resource created by the request is identified by \
        either a Location header field in the response or, if no Location \
        field is received, by the effective request URI.",
        "The 201 response payload typically describes and links to the \
        resource(s) created. See Section 7.2 of RFC7231 for a discussion of \
        the meaning and purpose of validator header fields, such as ETag and \
        Last-Modified, in a 201 response."
      ]
    },
    202 => {
      title: 'Accepted',
      description: [
        "The request has been accepted for processing, but the processing \
        has not been completed. The request might or might not eventually \
        be acted upon, as it might be disallowed when processing actually \
        takes place.",
        "There is no facility in HTTP for re-sending a status code from an \
        asynchronous operation.",
        "The 202 response is intentionally noncommittal. Its purpose is \
        to allow a server to accept a request for some other process \
        (perhaps a batch-oriented process that is only run once per day) \
        without requiring that the user agent's connection to the server \
        persist until the process is completed. The representation sent \
        with this response ought to describe the request's current status \
        and point to (or embed) a status monitor that can provide the user \
        with an estimate of when the request will be fulfilled."
      ]
    },
    203 => {
      title: 'Non-authoritative Information',
      description: [
        "The request was successful but the enclosed payload has been \
         modified from that of the origin server's 200 OK response by a \
         transforming proxy.",
        "This status code allows the proxy to notify recipients when a \
        transformation has been applied, since that knowledge might impact \
        later decisions regarding the content. For example, future cache \
        validation requests for the content might only be applicable along \
        the same request path (through the same proxies).",
        "The 203 response is similar to the Warning code of 214 \
        Transformation Applied2, which has the advantage of being applicable \
        to responses with any status code.",
        "A 203 response is cacheable by default; i.e., unless otherwise \
        indicated by the method definition or explicit cache controls3."
      ]
    },
    204 => {
      title: 'No Content',
      description: [
        "The server has successfully fulfilled the request and that there is \
        no additional content to send in the response payload body.",
        "Metadata in the response header fields refer to the target resource \
        and its selected representation after the requested action was \
        applied.",
        "For example, if a 204 status code is received in response to a PUT \
        request and the response contains an ETag header field, then the PUT \
        was successful and the ETag field-value contains the entity-tag for \
        the new representation of that target resource.",
        "The 204 response allows a server to indicate that the action has \
        been successfully applied to the target resource, while implying that \
        the user agent does not need to traverse away from its \
        current \"document view\" (if any). The server assumes that the user \
        agent will provide some indication of the success to its user, in \
        accord with its own interface, and apply any new or updated metadata \
        in the response to its active representation.",
        "For example, a 204 status code is commonly used with document \
        editing interfaces corresponding to a \"save\" action, such that the \
        document being saved remains available to the user for editing. \
        It is also frequently used with interfaces that expect automated \
        data transfers to be prevalent, such as within distributed \
        version control systems.",
        "A 204 response is terminated by the first empty line after the \
        header fields because it cannot contain a message body.",
        "A 204 response is cacheable by default; i.e., unless otherwise \
        indicated by the method definition or explicit cache controls."
      ]
    },
    205 => {
      title: 'Reset Content',
      description: [
        "The server has fulfilled the request and desires that the user \
        agent reset the \"document view\", which caused the request to be \
        sent, to its original state as received from the origin server.",
        "This response is intended to support a common data entry use case \
        where the user receives content that supports data entry \
        (a form, notepad, canvas, etc.), enters or manipulates data in \
        that space, causes the entered data to be submitted in a request, \
        and then the data entry mechanism is reset for the next entry so \
        that the user can easily initiate another input action.",
        "Since the 205 status code implies that no additional content will \
        be provided, a server MUST NOT generate a payload in a 205 response. \
        In other words, a server MUST do one of the following for a 205 \
        response: a) indicate a zero-length body for the response by \
        including a Content-Length header field with a value of 0; b) \
        indicate a zero-length payload for the response by including a \
        Transfer-Encoding header field with a value of chunked and a \
        message body consisting of a single chunk of zero-length; or, c) \
        close the connection immediately after sending the blank line \
        terminating the header section."
      ]
    },
    206 => {
      title: 'Partial Content',
      description: [
        "The server is successfully fulfilling a range request for the \
        target resource by transferring one or more parts of the selected \
        representation that correspond to the satisfiable ranges found in \
        the request's Range header field.",
        "If a single part is being transferred, the server generating the \
        206 response MUST generate a Content-Range header field, describing \
        what range of the selected representation is enclosed, and a \
        payload consisting of the range. For example:",
        "If multiple parts are being transferred, the server generating the \
        206 response MUST generate a \"multipart/byteranges\" payload2, and \
        a Content-Type header field containing the multipart/byteranges \
        media type and its required boundary parameter. To avoid confusion \
        with single-part responses, a server MUST NOT generate a \
        Content-Range header field in the HTTP header section of a multiple \
        part response (this field will be sent in each part instead).",
        "Within the header area of each body part in the multipart payload, \
        the server MUST generate a Content-Range header field corresponding \
        to the range being enclosed in that body part. If the selected \
        representation would have had a Content-Type header field in a 200 \
        OK response, the server SHOULD generate that same Content-Type \
        field in the header area of each body part. For example:",
        "When multiple ranges are requested, a server MAY coalesce any of \
        the ranges that overlap, or that are separated by a gap that is \
        smaller than the overhead of sending multiple parts, regardless of \
        the order in which the corresponding byte-range-spec appeared in \
        the received Range header field. Since the typical overhead between \
        parts of a multipart/byteranges payload is around 80 bytes, \
        depending on the selected representation's media type and the \
        chosen boundary parameter length, it can be less efficient to \
        transfer many small disjoint parts than it is to transfer the \
        entire selected representation.",
        "A server MUST NOT generate a multipart response to a request for \
        a single range, since a client that does not request multiple parts \
        might not support multipart responses. However, a server MAY \
        generate a multipart/byteranges payload with only a single body \
        part if multiple ranges were requested and only one range was found \
        to be satisfiable or only one range remained after coalescing. \
        A client that cannot process a multipart/byteranges response MUST \
        NOT generate a request that asks for multiple ranges.",
        "When a multipart response payload is generated, the server \
        SHOULD send the parts in the same order that the corresponding \
        byte-range-spec appeared in the received Range header field, \
        excluding those ranges that were deemed unsatisfiable or that \
        were coalesced into other ranges. A client that receives a multipart \
        response MUST inspect the Content-Range header field present in each \
        body part in order to determine which range is contained in that \
        body part; a client cannot rely on receiving the same ranges that \
        it requested, nor the same order that it requested.",
        "When a 206 response is generated, the server MUST generate the \
        following header fields, in addition to those required above, if \
        the field would have been sent in a 200 OK response to the same \
        request: Date, Cache-Control, ETag, Expires, Content-Location, \
        and Vary.",
        "If a 206 is generated in response to a request with an If-Range \
        header field, the sender SHOULD NOT generate other representation \
        header fields beyond those required above, because the client is \
        understood to already have a prior response containing those header \
        fields. Otherwise, the sender MUST generate all of the \
        representation header fields that would have been sent in a 200 OK \
        response to the same request.",
        "A 206 response is cacheable by default; i.e., unless otherwise \
        indicated by explicit cache controls3."
      ]
    },
    207 => {
      title: 'Multi-Status',
      description: [
        "A Multi-Status response conveys information about multiple \
        resources in situations where multiple status codes might \
        be appropriate.",
        "The default Multi-Status response body is a text/xml or \
        application/xml HTTP entity with a 'multistatus' root element. \
        Further elements contain 200, 300, 400, and 500 series status \
        codes generated during the method invocation. 100 series status \
        codes SHOULD NOT be recorded in a 'response' XML element.",
        "Although '207' is used as the overall response status code, the \
        recipient needs to consult the contents of the multistatus response \
        body for further information about the success or failure of the \
        method execution. The response MAY be used in success, partial \
        success and also in failure situations.",
        "The 'multistatus' root element holds zero or more 'response' \
        elements in any order, each with information about an individual \
        resource. Each 'response' element MUST have an 'href' element to \
        identify the resource.",
        "A Multi-Status response uses one out of two distinct formats for \
        representing the status:",
        "1. A 'status' element as child of the 'response' element indicates \
        the status of the message execution for the identified resource as \
        a whole. Some method definitions provide information about specific \
        status codes clients should be prepared to see in a response. \
        However, clients MUST be able to handle other status codes, using \
        the generic rules defined in RFC2616 Section 10.",
        "2. For PROPFIND and PROPPATCH, the format has been extended using \
        the 'propstat' element instead of 'status', providing information \
        about individual properties of a resource.  This format is specific \
        to PROPFIND and PROPPATCH, and is described in detail in RFC4918 \
        Section 9.1 and RFC4918 Section 9.2."
      ]
    },
    208 => {
      title: 'Already Reported',
      description: [
        "Used inside a DAV: propstat response element to avoid enumerating \
        the internal members of multiple bindings to the same \
        collection repeatedly.",
        "For each binding to a collection inside the request's scope, \
        only one will be reported with a 200 status, while subsequent \
        DAV:response elements for all other bindings will use the 208 \
        status, and no DAV:response elements for their descendants \
        are included.", "Note that the 208 status will only occur \
        for \"Depth: infinity\" requests, and that it is of particular \
        importance when the multiple collection bindings cause a bind \
        loop.", "A client can request the DAV:resource-id property in a \
        PROPFIND request to guarantee that they can accurately \
        reconstruct the binding structure of a collection with multiple \
        bindings to a single resource.",
        "For backward compatibility with clients not aware of the 208 \
        status code appearing in multistatus response bodies, it SHOULD \
        NOT be used unless the client has signaled support for this \
        specification using the \"DAV\" request header2. Instead, a 508 \
        Loop Detected status should be returned when a binding loop is \
        discovered. This allows the server to return the 508 as the \
        top-level return status, if it discovers it before it started the \
        response, or in the middle of a multistatus, if it discovers it \
        in the middle of streaming out a multistatus response."
      ]
    },
    226 => {
      title: 'IM Used',
      description: [
        "The server has fulfilled a GET request for the resource, and \
        the response is a representation of the result of one or more \
        instance-manipulations applied to the current instance.",
        "The actual current instance might not be available except by \
        combining this response with other previous or future responses, \
        as appropriate for the specific instance-manipulation(s). If so, \
        the headers of the resulting instance are the result of combining \
        the headers from the 226 response and the other instances, \
        following the rules in section 13.5.3 of the HTTP/1.1 specification.",
        "The request MUST have included an A-IM header field listing at \
        least one instance-manipulation. The response MUST include an Etag \
        header field giving the entity tag of the current instance.",
        "A response received with a status code of 226 MAY be stored by a \
        cache and used in reply to a subsequent request, subject to the \
        HTTP expiration mechanism and any Cache-Control headers, and to \
        the requirements in section 10.6.",
        "A response received with a status code of 226 MAY be used by a \
        cache, in conjunction with a cache entry for the base instance, to \
        create a cache entry for the current instance."
      ]
    },
    300 => {
      title: 'Multiple Choices',
      description: [
        "The target resource has more than one representation, each with \
        its own more specific identifier, and information about the \
        alternatives is being provided so that the user (or user agent) \
        can select a preferred representation by redirecting its request \
        to one or more of those identifiers.",
        "In other words, the server desires that the user agent engage \
        in reactive negotiation to select the most appropriate \
        representation(s) for its needs.",
        "If the server has a preferred choice, the server SHOULD generate \
        a Location header field containing a preferred choice's URI \
        reference. The user agent MAY use the Location field value for \
        automatic redirection.",
        "For request methods other than HEAD, the server SHOULD generate \
        a payload in the 300 response containing a list of representation \
        metadata and URI reference(s) from which the user or user agent can \
        choose the one most preferred. The user agent MAY make a selection \
        from that list automatically if it understands the provided media \
        type. A specific format for automatic selection is not defined by \
        this specification because HTTP tries to remain orthogonal to the \
        definition of its payloads. In practice, the representation is \
        provided in some easily parsed format believed to be acceptable to \
        the user agent, as determined by shared design or content \
        negotiation, or in some commonly accepted hypertext format.",
        "A 300 response is cacheable by default; i.e., unless otherwise \
        indicated by the method definition or explicit cache controls2.",
        "Note: The original proposal for the 300 status code defined the \
        URI header field as providing a list of alternative \
        representations, such that it would be usable for 200, 300, and 406 \
        responses and be transferred in responses to the HEAD method. \
        However, lack of deployment and disagreement over syntax led to \
        both URI and Alternates (a subsequent proposal) being dropped from \
        this specification. It is possible to communicate the list using a \
        set of Link header fields3, each with a relationship \
        of \"alternate\", though deployment is a chicken-and-egg problem."
      ]
    },
    301 => {
      title: 'Moved Permanently',
      description: [
        "The target resource has been assigned a new permanent URI and any \
        future references to this resource ought to use one of the \
        enclosed URIs.",
        "Clients with link-editing capabilities ought to automatically \
        re-link references to the effective request URI to one or more of \
        the new references sent by the server, where possible.",
        "The server SHOULD generate a Location header field in the response \
        containing a preferred URI reference for the new permanent URI. The \
        user agent MAY use the Location field value for automatic redirection. \
        The server's response payload usually contains a short hypertext note \
        with a hyperlink to the new URI(s).",
        "Note: For historical reasons, a user agent MAY change the request \
        method from POST to GET for the subsequent request. If this behavior \
        is undesired, the 307 Temporary Redirect status code can be \
        used instead.",
        "A 301 response is cacheable by default; i.e., unless otherwise \
        indicated by the method definition or explicit cache controls."
      ]
    },
    302 => {
      title: 'Found',
      description: [
        "The target resource resides temporarily under a different URI. \
        Since the redirection might be altered on occasion, the client ought \
        to continue to use the effective request URI for future requests.",
        "The server SHOULD generate a Location header field in the response \
        containing a URI reference for the different URI. The user agent MAY \
        use the Location field value for automatic redirection. \
        The server's response payload usually contains a short hypertext \
        note with a hyperlink to the different URI(s).",
        "Note: For historical reasons, a user agent MAY change the request \
        method from POST to GET for the subsequent request. If this behavior \
        is undesired, the 307 Temporary Redirect status code can be \
        used instead."
      ]
    },
    303 => {
      title: 'See Other',
      description: [
        "The server is redirecting the user agent to a different resource, \
        as indicated by a URI in the Location header field, which is \
        intended to provide an indirect response to the original request.",
        "A user agent can perform a retrieval request targeting that URI \
        (a GET or HEAD request if using HTTP), which might also be \
        redirected, and present the eventual result as an answer to the \
        original request. Note that the new URI in the Location header \
        field is not considered equivalent to the effective request URI.",
        "This status code is applicable to any HTTP method. It is primarily \
        used to allow the output of a POST action to redirect the user \
        agent to a selected resource, since doing so provides the \
        information corresponding to the POST response in a form that can \
        be separately identified, bookmarked, and cached, independent of \
        the original request.",
        "A 303 response to a GET request indicates that the origin server \
        does not have a representation of the target resource that can be \
        transferred by the server over HTTP. However, the Location field \
        value refers to a resource that is descriptive of the target \
        resource, such that making a retrieval request on that other \
        resource might result in a representation that is useful to \
        recipients without implying that it represents the original \
        target resource. Note that answers to the questions of what can be \
        represented, what representations are adequate, and what might be \
        a useful description are outside the scope of HTTP.",
        "Except for responses to a HEAD request, the representation of a \
        303 response ought to contain a short hypertext note with a \
        hyperlink to the same URI reference provided in the \
        Location header field."
      ]
    },
    304 => {
      title: 'Not Modified',
      description: [
        "A conditional GET or HEAD request has been received and would \
        have resulted in a 200 OK response if it were not for the fact \
        that the condition evaluated to false.",
        "In other words, there is no need for the server to transfer a \
        representation of the target resource because the request indicates \
        that the client, which made the request conditional, already has a \
        valid representation; the server is therefore redirecting the client \
        to make use of that stored representation as if it were the payload \
        of a 200 OK response.",
        "The server generating a 304 response MUST generate any of the \
        following header fields that would have been sent in a 200 OK \
        response to the same request: Cache-Control, Content-Location, Date, \
        ETag, Expires, and Vary.",
        "Since the goal of a 304 response is to minimize information \
        transfer when the recipient already has one or more cached \
        representations, a sender SHOULD NOT generate representation \
        metadata other than the above listed fields unless said metadata \
        exists for the purpose of guiding cache updates \
        (e.g., Last-Modified might be useful if the response does not have \
        an ETag field).", "Requirements on a cache that receives a 304 \
        response are defined in Section 4.3.4 of RFC7234. If the conditional \
        request originated with an outbound client, such as a user agent \
        with its own cache sending a conditional GET to a shared proxy, \
        then the proxy SHOULD forward the 304 response to that client.",
        "A 304 response cannot contain a message-body; it is always \
        terminated by the first empty line after the header fields."
      ]
    },
    305 => {
      title: 'Use Proxy',
      description: [
        "Defined in a previous version of this specification and is now \
        deprecated, due to security concerns regarding in-band \
        configuration of a proxy."
      ]
    },
    307 => {
      title: 'Temporary Redirect',
      description: [
        "The target resource resides temporarily under a different URI and \
        the user agent MUST NOT change the request method if it performs an \
        automatic redirection to that URI.",
        "Since the redirection can change over time, the client ought to \
        continue using the original effective request URI for \
        future requests.", "The server SHOULD generate a Location header \
        field in the response containing a URI reference for the \
        different URI. The user agent MAY use the Location field value for \
        automatic redirection. The server's response payload usually \
        contains a short hypertext note with a hyperlink to \
        the different URI(s).",
        "Note: This status code is similar to 302 Found, except that it \
        does not allow changing the request method from POST to GET. \
        This specification defines no equivalent counterpart for 301 \
        Moved Permanently (RFC7238, however, proposes defining the status \
        code 308 Permanent Redirect for this purpose)."
      ]
    }
  }.freeze
end
