class Doodle {
  final String name;
  final String time;
  final String content;
  final bool status;
  final List image;
  const Doodle({this.name, this.time, this.content, this.status, this.image});
}

const List<Doodle> doodles = [
  Doodle(
      name: "ເຂົ້າຮ່ວມກອງປະຊຸມ",
      time: "08:00 AM",
      content:
          "One of Al-Sufi's greatest works involved fact-checking the Greek astronomer",
      image: [
        "https://image.freepik.com/free-vector/abstract-background-mobile-fluid-shapes-with-gradient-effect_79603-560.jpg",
        "https://media.istockphoto.com/photos/millennial-black-businesswoman-addressing-colleagues-at-a-corporate-picture-id1146472948?k=6&m=1146472948&s=612x612&w=0&h=FuMZ_-_NMc1mvvxsz4OJBfIzo6IfJh1kAxKT_PLpZvs=",
        "https://i.pinimg.com/originals/dc/6b/f6/dc6bf68c3f50b4cea9074dc5b9a1f22f.jpg",
        "https://i.pinimg.com/originals/dc/6b/f6/dc6bf68c3f50b4cea9074dc5b9a1f22f.jpg",
        "https://i.pinimg.com/originals/dc/6b/f6/dc6bf68c3f50b4cea9074dc5b9a1f22f.jpg"
      ],
      status: true),
  Doodle(
      name: "ໃຫ້ຄຳຄິດເຫັນໃນວາລະກອງປະຊຸມ",
      time: "08:30 - 11:30 AM",
      content:
          "One of Al-Sufi's greatest works involved fact-checking the Greek astronomer",
      image: [
        "https://media.istockphoto.com/photos/millennial-black-businesswoman-addressing-colleagues-at-a-corporate-picture-id1146472948?k=6&m=1146472948&s=612x612&w=0&h=FuMZ_-_NMc1mvvxsz4OJBfIzo6IfJh1kAxKT_PLpZvs=",
        "https://i.pinimg.com/originals/dc/6b/f6/dc6bf68c3f50b4cea9074dc5b9a1f22f.jpg"
      ],
      status: true),
  Doodle(
      name: "ຮັບປະຖານອານຫານ",
      time: "12:00 AM",
      content:
          "One of Al-Sufi's greatest works involved fact-checking the Greek astronomer",
      image: [],
      status: false),
];
