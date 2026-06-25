class ProfileResponse {
    ProfileResponse({
        required this.id,
        required this.username,
        required this.email,
    });

    int id;
    String username;
    String email;

    factory ProfileResponse.fromJson(Map<dynamic, dynamic> json) => ProfileResponse(
        id: json["id"],
        username: json["username"],
        email: json["email"],
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
    };
}
