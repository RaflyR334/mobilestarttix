class GenreResponse {
  bool? success;
  String? message;
  List<Genre>? data;

  GenreResponse({this.success, this.message, this.data});

  GenreResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Genre>[];
      json['data'].forEach((v) {
        data!.add(new Genre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genre {
  int? id;
  String? namaGenre;
  String? slug;
  String? createdAt;
  String? updatedAt;

  Genre({this.id, this.namaGenre, this.slug, this.createdAt, this.updatedAt});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaGenre = json['nama_genre'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_genre'] = this.namaGenre;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}