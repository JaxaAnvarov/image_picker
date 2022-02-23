class ImagesUrl {
    ImagesUrl({
        this.id,
        this.index,
        this.imageUrl,
        this.v,
    });

    String? id;
    String? index;
    String? imageUrl;
    int? v;

    factory ImagesUrl.fromJson(Map<String, dynamic> json) => ImagesUrl(
        id: json["_id"],
        index: json["index"],
        imageUrl: json["imageUrl"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "index": index,
        "imageUrl": imageUrl,
        "__v": v,
    };
}
