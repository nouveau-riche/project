List carNames = [
  'Audi',
  'Chevrolet',
  'Cadillac',
  'Acura',
  'BMW',
  'Chrysler',
  'Ford',
  'Buick',
  'INFINITI',
  'GMC',
  'Honda',
  'Hyundai',
  'Jeep',
  'Genesis',
  'Dodge',
  'Jaguar',
  'Kia',
  'Land',
  'Rover',
  'Lexus',
  'Mercedes - Benz',
  'Mitsubishi',
  'Lincoln',
  'MAZDA',
  'Nissan',
  'MINI',
  'Porsche',
  'Ram',
  'Subaru',
  'Toyota',
  'Volkswagen',
  'Volvo',
  'Alfa',
  'Romeo',
  'FIAT',
  'Freightliner',
  'Maserati',
  'Tesla',
  'Aston',
  'Martin',
  'Bentley',
  'Ferrari',
  'Lamborghini',
  'Lotus',
  'McLaren',
  'Rolls - Royce',
  'smart',
  'Scion',
  'SRT',
  'Suzuki',
  'Fisker',
  'Maybach',
  'Mercury',
  'Saab',
  'HUMMER',
  'Pontiac',
  'Saturn',
  'Isuzu',
  'Panoz',
  'Oldsmobile',
  'Daewoo',
  'Plymouth',
  'Eagle',
  'Geo',
  'Daihatsu'
];

Map carModel = {
  'Audi': [
    'A7',
    'TT',
    'RS 3',
    'A6',
    'A3 Sportback e - tron',
    'R8',
    'A4',
    'A3',
    'Q7',
    'SQ5',
    'Q3',
    'A8',
    'RS 7',
    'S3',
    'Q5',
    'A5',
    'S5',
    'A4 allroad',
    'S6',
    'S8',
    'e - tron',
    'RS 5',
    'S4',
    'Q8',
    'A5 Sport',
    'S7',
    'allroad',
    'RS 4',
    'A4(2005.5)',
    'S4(2005.5)',
    'RS 6',
    'Cabriolet',
    '100',
    '90',
    'Quattro',
    '80'
  ],
  'Chevrolet': [
    'Colorado Crew Cab',
    'Silverado 3500 HD Crew Cab',
    'Bolt EV',
    'Malibu',
    'Camaro',
    'Express 2500 Passenger',
    'Suburban 3500HD',
    'Silverado 1500 Regular Cab',
    'Spark',
    'Silverado 1500 LD Double Cab',
    'Silverado 2500 HD Double Cab',
    'Impala',
    'Silverado 1500 Double Cab',
    'Express 3500 Cargo',
    'Blazer',
    'Tahoe',
    'Silverado 2500 HD Crew Cab',
    'Silverado 1500 Crew Cab',
    'Trax',
    'Traverse',
    'Volt',
    'Colorado Extended Cab',
    'Corvette',
    'Suburban',
    'Sonic',
    'Silverado 2500 HD Regular Cab',
    'Silverado 3500 HD Double Cab',
    'Express 3500 Passenger',
    'Cruze',
    'Equinox',
    'Silverado 3500 HD Regular Cab',
    'Express 2500 Cargo',
    'City Express',
    'SS',
    'Cruze Limited',
    'Malibu Limited',
    'Impala Limited',
    'Captiva Sport',
    'Spark EV',
    'Express 1500 Passenger',
    'Express 1500 Cargo',
    'Suburban 1500',
    'Silverado 1500 Extended Cab',
    'Avalanche',
    'Suburban 2500',
    'Silverado 2500 HD Extended Cab',
    'Silverado 3500 HD Extended Cab',
    'Colorado Regular Cab',
    'Aveo',
    'HHR',
    'Cobalt',
    'TrailBlazer',
    'Uplander Cargo',
    'Malibu (Classic)',
    'Uplander Passenger',
    'Silverado (Classic) 3500 Crew Cab',
  ],
  'Cadillac': [
    'XT4',
    'CT6',
    'Escalade ESV',
    'ATS',
    'Escalade',
    'CTS',
    'ATS - V',
    'SRX',
    'XT5',
    'XTS',
    'XT6',
    'CTS - V',
    'DTS',
    'STS',
    'ELR',
    'Escalade EXT',
    'CT6 - V',
    'CT5',
    'XLR',
    'DeVille',
    'Seville',
    'Catera',
    'Eldorado',
    'Fleetwood',
    'Allante',
    'Brougham',
    'Sixty Special'
  ],
  'Acura': [
    'RLX',
    'RLX Sport Hybrid',
    'MDX',
    'TLX',
    'RDX',
    'TSX',
    'TL',
    'ILX',
    'ZDX',
    'MDX Sport Hybrid',
    'NSX',
    'RL',
    'RSX',
    'Integra',
    'CL',
    'SLX',
    'Legend',
    'Vigor'
  ],
  'BMW': [
    'i3',
    'X6',
    'X6' 'M',
    '3 Series',
    '7 Series',
    '5 Series',
    '2 Series',
    '6 Series',
    'X4',
    'X5',
    '4 Series',
    'X2',
    'X7',
    'M2',
    'X5 M',
    'M6',
    'X1',
    'M5',
    'X3',
    'i8',
    'M3',
    'M4',
    '8 Series',
    'Z4',
    '1 Series',
    'Alpina B7',
    'Z4 M',
    'Z8',
    'Z3',
    'M'
  ],
  'Chrysler': [
    'Pacifica',
    '200',
    'Pacifica Hybrid',
    '300',
    'Crossfire',
    'Voyager',
    'Town & Country',
    'Sebring',
    'Concorde',
    'PT Cruiser',
    'LHS',
    '300M',
    'Grand Voyager',
    'Aspen',
    'Cirrus',
    'Prowler',
    'New Yorker',
    'LeBaron',
    'Fifth Ave',
    'Imperial'
  ],
  'Ford': [
    'Escape',
    'Flex',
    'Taurus',
    'Fusion',
    'F150 Regular Cab',
    'F250 Super Duty Crew Cab',
    'Fiesta',
    'Ranger SuperCrew',
    'C-MAX Hybrid',
    'Expedition MAX',
    'F350 Super Duty Crew Cab',
    'Ranger SuperCab',
    'Explorer',
    'F450 Super Duty Crew Cab',
    'F350 Super Duty Super Cab',
    'F250 Super Duty Regular Cab',
    'Transit Connect Passenger',
    'F150 SuperCrew Cab',
    'Transit Connect Cargo',
    'Transit 250 Van',
    'Edge',
    'F150 Super Cab',
    'EcoSport',
    'Expedition',
    'Transit 150 Wagon',
    'C-MAX Energi',
    'Transit 350 Wagon',
    'F350 Super Duty Regular Cab',
    'Focus',
    'Transit 350 HD Van',
    'Fusion Energi',
    'Mustang',
    'Transit 350 Van',
    'F250 Super Duty Super Cab',
    'Transit 150 Van',
    'Expedition EL',
    'E350 Super Duty Cargo',
    'Focus ST',
    'E150 Passenger',
    'E150 Cargo',
    'E250 Cargo',
    'E350 Super Duty Passenger',
    'Ranger Regular Cab',
    'Ranger Super Cab',
    'Crown Victoria',
    'E150 Super Duty Passenger',
    'Explorer Sport Trac',
    'Taurus X',
    'E150 Super Duty Cargo',
    'E250 Super Duty Cargo',
    'Five Hundred',
    'Freestar Passenger',
    'Freestar Cargo',
    'Freestyle',
    'GT',
    'Excursion',
    'Thunderbird',
    'F150 (Heritage) Regular Cab',
    'F150 (Heritage) Super Cab',
    'Explorer Sport'
  ],
  'Buick': [
    'Encore',
    'Regal',
    'Regal Sportback',
    'LaCrosse',
    'Cascada',
    'Regal TourX',
    'Enclave',
    'Envision',
    'Rainier',
    'Verano',
    'Lucerne',
    'Park Avenue',
    'Century',
    'Terraza',
    'LeSabre',
    'Rendezvous',
    'Riviera',
    'Skylark',
    'Roadmaster'
  ],
  'INFINITI': [],
  'GMC': [
    'Sierra 2500 HD Crew Cab',
    'Acadia',
    'Savana 2500 Cargo',
    'Yukon',
    'Sierra 3500 HD Double Cab',
    'Sierra 2500 HD Double Cab',
    'Savana 3500 Cargo',
    'Sierra 1500 Limited Double Cab',
    'Sierra 1500 Double Cab',
    'Terrain',
    'Canyon Crew Cab',
    'Savana 1500 Passenger',
    'Sierra 3500 HD Crew Cab',
    'Sierra 3500 HD Regular Cab',
    'Sierra 1500 Regular Cab',
    'Yukon XL',
    'Canyon Extended Cab',
    'Sierra 1500 Crew Cab',
    'Savana 2500 Passenger',
    'Savana 3500 Passenger',
    'Sierra 2500 HD Regular Cab',
    'Acadia Limited',
    'Savana 1500 Cargo',
    'Sierra 2500 HD Extended Cab',
    'Yukon XL 1500',
    'Yukon XL 2500',
    'Sierra 1500 Extended Cab',
    'Sierra 3500 HD Extended Cab',
    'Canyon Regular Cab',
    'Envoy',
    'Sierra (Classic)' '1500 Regular Cab',
    'Sierra (Classic) 2500 HD Crew Cab',
    'Sierra (Classic) 1500 Crew Cab',
    'Sierra (Classic) 2500 HD Regular Cab',
    'Sierra (Classic) 2500 HD Extended Cab',
    'Sierra (Classic) 3500 Regular Cab',
    'Sierra (Classic) 1500 Extended Cab',
    'Sierra (Classic) 1500 HD Crew Cab',
    'Sierra (Classic) 3500 Extended Cab',
    'Sierra (Classic) 3500 Crew Cab',
    'Envoy XL',
    'Sierra 1500 HD Crew Cab',
    'Sierra 3500 Crew'
  ],
  'Honda': [
    'Pilot',
    'Clarity Electric',
    'Clarity Fuel Cell',
    'Accord Hybrid',
    'HR-V',
    'Fit',
    'Odyssey',
    'Civic Type R',
    'Accord',
    'CR-V',
    'CR-Z',
    'Ridgeline',
    'Clarity Plug-in Hybrid',
    'Passport',
    'Civic',
    'Insight',
    'Crosstour',
    'Accord Crosstour',
    'Element',
    'S2000',
    'Prelude',
    'del Sol'
  ],
  'Hyundai': [
    'Ioniq Plug-in Hybrid',
    'Kona',
    'Venue',
    'Accent',
    'Tucson',
    'Ioniq Hybrid',
    'Elantra GT',
    'NEXO',
    'Santa Fe',
    'Sonata Hybrid',
    'Equus',
    'Tucson Fuel Cell',
    'Santa Fe XL',
    'Elantra',
    'Sonata',
    'Veloster',
    'Genesis Coupe',
    'Sonata Plug-in Hybrid',
    'Genesis',
    'Santa Fe Sport',
    'Palisade',
    'Azera',
    'Ioniq Electric',
    'Kona Electric',
    'Veracruz',
    'Tiburon',
    'XG350',
    'Entourage',
    'XG300',
    'Scoupe',
    'Excel'
  ],
  'Jeep': [
    'Wrangler Unlimited',
    'Compass',
    'Wrangler',
    'Patriot',
    'Grand Cherokee',
    'Cherokee',
    'Renegade',
    'Commander',
    'Gladiator',
    'Liberty',
    'Comanche Regular Cab'
  ],
  'Genesis': ['G80', 'G70', 'G90'],
  'Dodge': [
    'Grand Caravan Passenger',
    'Durango',
    'Challenger',
    'Journey',
    'Charger',
    'Nitro',
    'Viper',
    'Dart',
    'Ram 3500 Crew Cab',
    'Ram 1500 Quad Cab',
    'Avenger',
    'Ram 1500 Regular Cab',
    'Dakota Extended Cab',
    'Caliber',
    'Ram 2500 Crew Cab',
    'Ram 3500 Regular Cab',
    'Dakota Crew Cab',
    'Ram 2500 Mega Cab',
    'Ram 2500 Regular Cab',
    'Grand Caravan Cargo',
    'Ram 1500 Crew Cab',
    'Ram 3500 Mega Cab',
    'Ram 3500 Quad Cab',
    'Ram 2500 Quad Cab',
    'Sprinter 2500 Cargo',
    'Sprinter 2500 Passenger',
    'Caravan Cargo',
    'Magnum',
    'Sprinter 3500 Cargo',
    'Ram 1500 Mega Cab',
    'Caravan Passenger',
    'Dakota Club Cab',
    'Dakota Quad Cab',
    'Stratus',
    'Neon',
    'Dakota Regular Cab',
    'Intrepid',
    'Ram Van 2500',
    'Ram Van 1500',
    'Ram Van 3500',
    'Ram Wagon 2500',
    'Ram Wagon 1500',
    'Ram Wagon 3500',
    'Ram 1500 Club Cab',
    'Ram 2500 Club Cab',
    'Ram 3500 Club Cab',
    'Stealth',
    'Ram Van B350',
    'Spirit',
    'Ram Van B250',
    'Colt',
    'Ram Van B150',
    'Ram Wagon B250',
    'Ram Wagon B150',
    'Shadow',
    'Ram Wagon B350',
    'D150 Club Cab',
    'D250 Regular Cab',
    'D150 Regular Cab',
    'Daytona',
    'D250 Club Cab',
    'D350 Club Cab',
    'Dynasty',
    'D350 Regular Cab',
    'Ramcharger'
  ],
  'Jaguar': [
    'F-TYPE',
    'XK',
    'F-PACE',
    'XJ',
    'XE',
    'I-PACE',
    'XF',
    'X-Type',
    'S-Type',
    'E-PACE'
  ],
  //'Kia': [],
  'Land': [],
  'Rover': [],
  'Lexus': [],
  'Mercedes - Benz': [],
  'Mitsubishi': [],
  'Lincoln': [],
  'MAZDA': [],
  'Nissan': [
    'NV3500 HD Cargo',
    'Armada',
    'Rogue',
    'Frontier Crew Cab',
    'NV2500 HD Cargo',
    'TITAN XD Single Cab',
    'Frontier King Cab',
    'Altima',
    '370Z',
    'Murano',
    'NV3500 HD Passenger',
    'TITAN XD Crew Cab',
    'GT-R',
    'TITAN XD King Cab',
    'Sentra',
    'Kicks',
    'Pathfinder',
    'NV1500 Cargo',
    'Maxima',
    'NV200',
    'Versa',
    'LEAF',
    'Titan Crew Cab',
    'Titan King Cab',
    'Rogue Sport',
    'TITAN Single Cab',
    'Versa Note',
    'JUKE',
    'NV200 Taxi',
    'Quest',
    'Rogue Select',
    'Xterra',
    'cube',
    '350Z',
    'Pathfinder Armada',
    'Frontier Regular Cab',
    '240SX',
    '200SX',
    '300ZX',
    'Regular Cab',
    'King Cab',
    'NX',
    'Stanza'
  ],
  'MINI': [],
  'Porsche': [],
  'Ram': [],
  'Subaru': [
    'Legacy',
    'Forester',
    'BRZ',
    'Ascent',
    'WRX',
    'Outback',
    'Crosstrek',
    'Impreza',
    'Tribeca',
    'XV Crosstrek',
    'Baja',
    'B9 Tribeca',
    'Justy',
    'SVX',
    'Loyale'
  ],
  'Toyota': [
    'Tacoma Double Cab',
    'GR Supra',
    'RAV4 Hybrid',
    'Sequoia',
    'Corolla',
    'Camry Hybrid',
    'Highlander Hybrid',
    'Tacoma Access Cab',
    'Avalon',
    'RAV4',
    'Mirai',
    'Corolla Hybrid',
    'Yaris',
    '4Runner',
    'Highlander',
    'Yaris Hatchback',
    'Corolla Hatchback',
    'Prius Prime',
    'Tundra CrewMax',
    'Tundra Double Cab',
    'Prius',
    'Avalon Hybrid',
    '86',
    'C-HR',
    'Sienna',
    'Yaris iA',
    'Prius v',
    'Prius c',
    'Land Cruiser',
    'Camry',
    'Corolla iM',
    'Tundra Regular Cab',
    'Prius Plug-in Hybrid',
    'FJ Cruiser',
    'Tacoma Regular Cab',
    'Venza',
    'Matrix',
    'Solara',
    'Tundra Access Cab',
    'Echo',
    'Celica',
    'MR2',
    'Tacoma Xtracab',
    'T100 Regular Cab',
    'Previa',
    'T100 Xtracab',
    'Tercel',
    'Supra',
    'Paseo',
    'Regular Cab',
    'Xtra Cab',
    'Cressida'
  ],
  'Volkswagen': [],
  'Volvo': [
    'XC60',
    'V60',
    'XC90',
    'S90',
    'XC40',
    'S60',
    'C70',
    'C30',
    'S80',
    'V90',
    'S40',
    'V70',
    'XC70',
    'V50',
    'S40 (New)',
    'V40',
    'S70',
    '850',
    '960',
    '940',
    '240',
    '740'
  ],
  'Alfa': [],
  'Romeo': [],
  'FIAT': [],
  'Freightliner': [],
  'Maserati': [],
  'Tesla': [],
  'Aston': [],
  'Martin': [],
  'Bentley': [],
  'Ferrari': [],
  'Lamborghini': [],
  'Lotus': [],
  'McLaren': [],
  'Rolls - Royce': [],
  'smart': [],
  'Scion': [],
  //'SRT': [],
  'Suzuki': [],
  'Fisker': ['Karma'],
  'Maybach': [],
  'Mercury': [],
  'Saab': [],
  'HUMMER': [],
  'Pontiac': [
    'G6',
    'G3',
    'G6 (2009.5)',
    'Aztek',
    'Bonneville',
    'Montana',
    'G8',
    'Grand Prix',
    'Solstice',
    'Montana SV6',
    'Torrent',
    ' Sunfire',
    'Firebird',
    'G5',
    'Grand Am',
    'Vibe',
    'GTO',
    'Trans Sport',
    'LeMans',
    'Sunbird'
  ],
  'Saturn': [
    'VUE',
    'Aura',
    'L-Series',
    'Relay',
    'Ion',
    'S-Series',
    'Outlook',
    'SKY',
    'Astra'
  ],
  'Isuzu': [
    'Ascender',
    'i-350 Crew Cab',
    'Axiom',
    'Rodeo',
    'Amigo',
    'i-370 Crew Cab',
    'i-370 Extended Cab',
    'Rodeo Sport',
    'i-280 Extended Cab',
    'VehiCROSS',
    'Regular Cab',
    'Spacecab',
    'i-290 Extended Cab',
    'Trooper',
    'Oasis',
    'Hombre Regular Cab',
    'Hombre Spacecab',
    'Impulse',
    'Stylus'
  ],
  'Panoz': ['Esperante'],
  'Oldsmobile': [
    'Silhouette',
    'Alero',
    'Aurora',
    '88',
    'Bravada',
    'Cutlass',
    'Achieva',
    'Cutlass',
    'Ciera',
    'Intrigue',
    '98',
    'LSS',
    'Regency',
    'Cutlass Supreme',
    'Custom Cruiser',
    'Cutlass Cruiser',
    'Ciera',
    'Toronado'
  ],
  'Daewoo': ['Nubira', 'Lanos', 'Leganza'],
  'Plymouth': [
    'Voyager',
    'Breeze',
    'Prowler',
    'Grand Voyager',
    'Neon',
    'Colt',
    'Sundance',
    'Acclaim',
    'Colt Vista',
    'Laser'
  ],
  'Eagle': ['Talon', 'Summit', 'Vision', 'Premier'],
  'Geo': ['Metro', 'Prizm', 'Tracker', 'Storm'],
  'Daihatsu': ['Charade', 'Rocky']
};
