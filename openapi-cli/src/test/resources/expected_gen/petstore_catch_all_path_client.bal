import ballerina/http;

# This is a sample Pet Store Server based on the OpenAPI 3.0 specification.
public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig? apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://petstore3.swagger.io/api/v3") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        if config.auth is ApiKeysConfig {
            self.apiKeyConfig = (<ApiKeysConfig>config.auth).cloneReadOnly();
        } else {
            config.auth = <http:BearerTokenConfig>config.auth;
            self.apiKeyConfig = ();
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Find pet by ID
    #
    # + petId - ID of pet to return 
    # + return - successful operation 
    resource isolated function get '\*(int petId) returns Pet|error {
        string resourcePath = string `/*`;
        map<any> headerValues = {};
        map<anydata> queryParam = {"petId": petId};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["api_key"] = self.apiKeyConfig?.api_key;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Pet response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Update an existing pet
    #
    # + payload - Update an existent pet in the store 
    # + return - Successful operation 
    resource isolated function put pet(Pet payload) returns Pet|error {
        string resourcePath = string `/pet`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Pet response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Add a new pet to the store
    #
    # + payload - Create a new pet in the store 
    # + return - Successful operation 
    resource isolated function post pet(Pet payload) returns Pet|error {
        string resourcePath = string `/pet`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Pet response = check self.clientEp->post(resourcePath, request);
        return response;
    }
}
