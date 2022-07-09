




class SliderModel{
  String image;
  String title;
  String description;


  // Constructor for variables
  SliderModel({required this.title, required this.description, required this.image});

  void setImage(String getImage){
    image = getImage;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }
  void setDescription(String getDescription){
    description = getDescription;
  }

  String getImage(){
    return image;
  }

  String  getTitle(){
    return title;
  }
  String getDescription(){
    return description;
  }
}

// List created
List<SliderModel> getSlides(){
  List<SliderModel> slides = [];
  slides.add(new SliderModel(title: "Berbuat Baik Kapanpun dan Dimanapun",
      description: "Meningkatkan kesejahteraan rakyat dan kerukunan beragama dengan meningkatkan fasilitas ibadah",
      image: "lib/assets/images/mosque.jpg"));
  slides.add(new SliderModel(title: "Fitur E-Payment Membuat Mudah",
      description: "Dapat membayar wakaf dengan mudah dan cepat dengan pebayaran berbagai metode",
      image: "lib/assets/images/e_money.png"));
  slides.add(new SliderModel(title: "Temukan Program Wakaf Sekitarmu",
      description: "Lebih mudah saat menemukan program wakaf di sekitarmu dengan rekomendasi sesuai keinginan",
      image: "lib/assets/images/map_illustration.png"));
  return slides;
}