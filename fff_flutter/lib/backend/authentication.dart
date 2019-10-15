String _authToken;

Map<String, String> getAuthHeaders() {
  if (_authToken == null) {
    throw new Exception("Can't get auth headers when not authenticated.");
  }
  return {"Authorization": "Token $_authToken"};
}

void authenticate(String accessToken, String code) {
  //TODO: Perform actual authentication
  _authToken = "dfde53379d7316eeb8cc35d9064462974e5ca50a";
}
