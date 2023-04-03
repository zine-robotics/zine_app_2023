const exploreCards = [
  {
    "name": "Teams",
    "route": "team",
    "image": "assets/images/explore/teams.png",
  },
  {
    "name": "Achievements",
    "route": "achievement",
    "image": "assets/images/explore/achievements.png"
  },
  {
    "name": "Projects",
    "route": "project",
    "image": "assets/images/explore/projects.png"
  },
  {
    "name": "Recruitment",
    "route": "workshop",
    "image": "assets/images/explore/workshops.png"
  },
];

final emailReg = RegExp(r'^20\d\d((kucp)|(kuec)|(ucp)|(uec)|(uee)|(uch)|(ume)|(uce)|(umt)|(uar))\d{4}@((mnit)|(iiitkota)).ac.in$');
final passwordReg = RegExp(r'[\w!@#$%^&*()]{6,12}');