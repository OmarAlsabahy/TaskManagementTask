class LoginResponse {
    LoginResponse({
        required this.accessToken,
        required this.refreshToken,
    });

    String accessToken;
    String refreshToken;

    factory LoginResponse.fromJson(Map<dynamic, dynamic> json) => LoginResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
    );

    Map<dynamic, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
}
