class FilmResponse {
  bool? success;
  String? message;
  List<Film>? data;

  FilmResponse({this.success, this.message, this.data});

  FilmResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Film>[];
      json['data'].forEach((v) {
        data!.add(new Film.fromJson(v));
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

class Film {
  int? id;
  String? judul;
  String? slug;
  String? deskripsi;
  int? genreId;
  String? tahunRilis;
  String? poster;
  String? durasi;
  int? ageRating;
  int? harga;
  String? status;
  String? trailer;
  String? createdAt;
  String? updatedAt;
  Genre? genre;

  Film(
      {this.id,
      this.judul,
      this.slug,
      this.deskripsi,
      this.genreId,
      this.tahunRilis,
      this.poster,
      this.durasi,
      this.ageRating,
      this.harga,
      this.status,
      this.trailer,
      this.createdAt,
      this.updatedAt,
      this.genre});

  Film.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    slug = json['slug'];
    deskripsi = json['deskripsi'];
    genreId = json['genre_id'];
    tahunRilis = json['tahun_rilis'];
    poster = json['poster'];
    durasi = json['durasi'];
    ageRating = json['age_rating'];
    harga = json['harga'];
    status = json['status'];
    trailer = json['trailer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    genre = json['genre'] != null ? new Genre.fromJson(json['genre']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['slug'] = this.slug;
    data['deskripsi'] = this.deskripsi;
    data['genre_id'] = this.genreId;
    data['tahun_rilis'] = this.tahunRilis;
    data['poster'] = this.poster;
    data['durasi'] = this.durasi;
    data['age_rating'] = this.ageRating;
    data['harga'] = this.harga;
    data['status'] = this.status;
    data['trailer'] = this.trailer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.genre != null) {
      data['genre'] = this.genre!.toJson();
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