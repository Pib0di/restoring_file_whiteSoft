List<Map<String, dynamic>> doubleRepeatsList = [
  {
    "replacement": "Ha-haaa, hacked you",
    "source": "I doubted if I should ever come back"
  },
  {
    "replacement": "Ha-haaa, hacked you",
    "source": "I doubted if I should ever come back"
  },
  {"replacement": "1", "source": "l"},
  {
    "replacement": "sdshdjdskfm sfjsdif jfjfidjf",
    "source": "Somewhere ages and ages hence:"
  },
];

List<Map<String, dynamic>> outputList = [
  {
    "replacement": "sdshdjdskfm sfjsdif jfjfidjf",
    "source": "Somewhere ages and ages hence:"
  },
  {
    "replacement": "Ha-haaa, hacked you",
    "source": "I doubted if I should ever come back"
  },
  {"replacement": "1", "source": "l"},
];

//final test
List<Map<String, dynamic>> replacementList = [
  {
    "replacement": "Ha-haaa, hacked you",
    "source": "I doubted if I should ever come back"
  },
  {
    "replacement": "sdshdjdskfm sfjsdif jfjfidjf",
    "source": "Somewhere ages and ages hence:"
  },
  {
    "replacement": "1",
    "source": "l"
  },
  {
    "replacement": "Emptry... or NOT!",
    "source": null
  },
  {
    "replacement": "d12324344rgg6f5g6gdf2ddjf",
    "source": "wood"
  },
  {
    "replacement": "Random text, yeeep",
    "source": "took"
  },
  {
    "replacement": "Bla-bla-bla-blaaa, just some RANDOM tExT",
    "source": null
  },
  {
    "replacement": "parentheses - that is a smart word",
    "source": "the better claim"
  },
  {
    "replacement": "sdshdjdskfm sfjsdif jfjfidjf",
    "source": "Somewhere ages and ages hence:"
  },
  {
    "replacement": "Emptry... or NOT!",
    "source": "Had worn"
  },
  {
    "replacement": "Skooby-dooby-doooo",
    "source": "knowing how way leads on"
  },
  {
    "replacement": "sdshdjdskfm sfjsdif jfjfidjf",
    "source": "Somewhere ages and ages hence:"
  },
  {
    "replacement": "An other text",
    "source": null
  },
  {
    "replacement": "Skooby-dooby-doooo",
    "source": "knowing how way"
  },
];

List<Map<String, dynamic>> actualOutput = [
  {
    'replacement': 'sdshdjdskfm sfjsdif jfjfidjf',
    'source': 'Somewhere ages and ages hence:'
  },
  {
    'replacement': 'parentheses - that is a smart word',
    'source': 'the better claim',
  },
  {
    'replacement': 'd12324344rgg6f5g6gdf2ddjf',
    'source': 'wood',
  },
  {
    'replacement': 'Skooby-dooby-doooo',
    'source': 'knowing how way',
  },
  {
    'replacement': 'Random text, yeeep',
    'source': 'took',
  },
  {
    'replacement': 'Ha-haaa, hacked you',
    'source': 'I doubted if I should ever come back',
  },
  {
    'replacement': 'Emptry... or NOT!',
    'source': 'Had worn',
  },
  {
    'replacement': 'Bla-bla-bla-blaaa, just some RANDOM tExT',
    'source': null,
  },
  {
    'replacement': 'An other text',
    'source': null,
  },
  {
    'replacement': '1',
    'source': 'l',
  }
];
