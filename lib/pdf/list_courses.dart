class MyTile{
  String title;
  List<MyTile> children;
  MyTile(this.title, [this.children = const <MyTile>[]]);
}

List<MyTile> listOfTiles = <MyTile>[
  new MyTile(
    'College of Agriculture and Natural Resources',
    <MyTile>[
      MyTile('BSc Agriculture'),
      MyTile('BSc Natural Resources Management'),
      MyTile('BSc Agribusiness Management'),
      MyTile('BSc Agricultural Biotechnology'),
    ]
  ),
  new MyTile(
    'College of Humanities and Social Sciences',
    <MyTile>[
      MyTile('BA Economics'),
      MyTile('BA Social Work'),
      MyTile('BA Akan'),
      MyTile('BA English'),
    ]
  ),
  new MyTile(
    'College of Engineering',
    <MyTile>[
      MyTile('BSc Chemical Engineering'),
      MyTile('BSc Civil Engineering'),
      MyTile('BSc Electrical & Electronic Engineering'),
      MyTile('BSc Computer Engineering'),
      MyTile('BSc Petrochemical Engineering'),
    ]
  ),
   new MyTile(
    'College of Art and Built Environment',
    <MyTile>[
      MyTile('BSc Architecture'),
      MyTile('BSc Development Planning'),
      MyTile('BSc Human Settlement Planning'),
      MyTile('BA Communication Design (Graphic Design)'),
      MyTile('BA Integrated Rural Art and Industry'),
    ]
  ),
  new MyTile(
    'College of Science',
    <MyTile>[
      MyTile('BSc Biochemistry'),
      MyTile('BSc Biological Sciences'),
      MyTile('BSc Environmental Science'),
      MyTile('BSc Computer Science'),
      MyTile('BSc Mathematics'),
    ]
  ),
  new MyTile(
    'College of Health Sciences',
    <MyTile>[
      MyTile('Pharm D (Doctor of Pharmacy)'),
      MyTile('BSc Human Biology (Medicine)'),
      MyTile('BSc Nursing'),
      MyTile('BSc Midwifery'),
      MyTile('BSc Medical Laboratory Technology'),
    ]
  ),
];