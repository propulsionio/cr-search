# TODO: fetch data from API and remove this
module APIStub
  def self.top_level_us_only_funders
    [
        {
            id: 100000133,
            name: "Agency for Healthcare Research and Quality",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000030,
            name: "Centers for Disease Control and Prevention",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100005222",
                    name: "National Center for Environmental Health",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100000130",
                    name: "National Center for Chronic Disease Prevention and Health Promotion",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100000125",
                    name: "National Institute for Occupational Safety and Health",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005218",
                    name: "National Center for Preparedness, Detection, and Control of Infectious Diseases",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100006088",
                    name: "National Center for Emerging and Zoonotic Infectious Diseases",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005217",
                    name: "National Center for Injury Prevention and Control",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100006090",
                    name: "Center for Global Health",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100006087",
                    name: "National Center on Birth Defects and Developmental Disabilities",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005258",
                    name: "National Center for HIV/AIDS, Viral Hepatitis, STD, and TB Prevention",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005224",
                    name: "National Center for Immunization and Respiratory Diseases",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005265",
                    name: "Office of Public Health Genomics",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005260",
                    name: "National Center for Public Health Informatics",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100006089",
                    name: "Office for State, Tribal, Local and Territorial Support",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005195",
                    name: "Office of Public Health Preparedness and Response",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005220",
                    name: "Agency for Toxic Substances and Disease Registry",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                },
                {
                    id: "100005262",
                    name: "National Center for Health Statistics",
                    level: 1,
                    parent_id: 100000030,
                    descendants: []
                }
            ]
        },
        {
            id: 100000180,
            name: "U.S. Department of Homeland Security",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000005,
            name: "U.S. Department of Defense",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100000774",
                    name: "Defense Threat Reduction Agency",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100005713",
                    name: "Office of the Secretary of Defense",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100000266",
                    name: "National Geospatial-Intelligence Agency",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100005712",
                    name: "Missile Defense Agency",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100006370",
                    name: "Small Business Innovation Research",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100006751",
                    name: "U.S. Army",
                    level: 1,
                    parent_id: 100000005,
                    descendants: [
                        {
                            id: "100006753",
                            name: "U.S. Army Materiel Command",
                            level: 2,
                            parent_id: "100006751",
                            descendants: [
                                {
                                    id: "100006754",
                                    name: "U.S. Army Research Laboratory",
                                    level: 3,
                                    parent_id: "100006753",
                                    descendants: []
                                }
                            ]
                        },
                        {
                            id: "100006752",
                            name: "U.S. Army Corps of Engineers",
                            level: 2,
                            parent_id: "100006751",
                            descendants: [
                                {
                                    id: "100006505",
                                    name: "Engineer Research and Development Center",
                                    level: 3,
                                    parent_id: "100006752",
                                    descendants: []
                                }
                            ]
                        },
                        {
                            id: "100006769",
                            name: "Vertical Lift Research Center of Excellence",
                            level: 2,
                            parent_id: "100006751",
                            descendants: []
                        },
                        {
                            id: "100006754",
                            name: "U.S. Army Research Laboratory",
                            level: 2,
                            parent_id: "100006751",
                            descendants: []
                        },
                        {
                            id: "100006505",
                            name: "Engineer Research and Development Center",
                            level: 2,
                            parent_id: "100006751",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006393",
                    name: "Air Force Civil Engineer Center",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100000181",
                    name: "Air Force Office of Scientific Research",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100000183",
                    name: "Army Research Office",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100005711",
                    name: "Defense Logistics Agency",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100000182",
                    name: "Medical Research and Materiel Command, U.S. Army Medical Department",
                    level: 1,
                    parent_id: 100000005,
                    descendants: [
                        {
                            id: "100006965",
                            name: "Telemedicine and Advanced Technology Research Center",
                            level: 2,
                            parent_id: "100000182",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000090",
                    name: "Congressionally Directed Medical Research Programs",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100000185",
                    name: "Defense Advanced Research Projects Agency",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100006394",
                    name: "Air Force Material Command",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100000006",
                    name: "Office of Naval Research",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100006769",
                    name: "Vertical Lift Research Center of Excellence",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                },
                {
                    id: "100006753",
                    name: "U.S. Army Materiel Command",
                    level: 1,
                    parent_id: 100000005,
                    descendants: [
                        {
                            id: "100006754",
                            name: "U.S. Army Research Laboratory",
                            level: 2,
                            parent_id: "100006753",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006752",
                    name: "U.S. Army Corps of Engineers",
                    level: 1,
                    parent_id: 100000005,
                    descendants: [
                        {
                            id: "100006505",
                            name: "Engineer Research and Development Center",
                            level: 2,
                            parent_id: "100006752",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006965",
                    name: "Telemedicine and Advanced Technology Research Center",
                    level: 1,
                    parent_id: 100000005,
                    descendants: []
                }
            ]
        },
        {
            id: 100000015,
            name: "U.S. Department of Energy",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100006231",
                    name: "Brookhaven National Laboratory, Office of Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006158",
                    name: "Office of Congressional and Intergovernmental Affairs",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006114",
                            name: "Office of Energy Policy",
                            level: 2,
                            parent_id: "100006158",
                            descendants: []
                        },
                        {
                            id: "100006175",
                            name: "Office of Environment and Science",
                            level: 2,
                            parent_id: "100006158",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006120",
                    name: "Office of Fossil Energy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006164",
                            name: "Petroleum Reserves",
                            level: 2,
                            parent_id: "100006120",
                            descendants: []
                        },
                        {
                            id: "100006140",
                            name: "Oil and Natural Gas",
                            level: 2,
                            parent_id: "100006120",
                            descendants: []
                        },
                        {
                            id: "100006181",
                            name: "Clean Coal",
                            level: 2,
                            parent_id: "100006120",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006226",
                    name: "Krell Institute, Office of Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006234",
                    name: "Sandia National Laboratories, National Nuclear Security Administration",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006150",
                    name: "Office of Policy and International Affairs",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006173",
                            name: "Office of Climate Change Policy and Technology",
                            level: 2,
                            parent_id: "100006150",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006134",
                    name: "Office of Energy Efficiency and Renewable Energy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006137",
                            name: "Sustainability Performance Office",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006115",
                            name: "Solar Energy Technologies Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006136",
                            name: "Fuel Cell Technologies Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006160",
                            name: "Biomass Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006117",
                            name: "Weatherization and Intergovernmental Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006116",
                            name: "Advanced Manufacturing Office",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006177",
                            name: "Vehicle Technologies Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006335",
                            name: "Industrial Technologies Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006176",
                            name: "Wind and Water Power Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006178",
                            name: "Office of Federal Energy Management Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006159",
                            name: "Office of Technology Development",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006161",
                            name: "Building Technologies Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        },
                        {
                            id: "100006135",
                            name: "Geothermal Technologies Program",
                            level: 2,
                            parent_id: "100006134",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006233",
                    name: "National Renewable Energy Laboratory, Office of Energy Efficiency and Renewable Energy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006143",
                    name: "Office of Inspector General",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006166",
                            name: "Office of Audits and Inspections",
                            level: 2,
                            parent_id: "100006143",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100007000",
                    name: "Laboratory Directed Research and Development",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100007002",
                    name: "Small Business Innovative Research and Small Business Technology Transfer",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006168",
                    name: "National Nuclear Security Administration",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006128",
                            name: "Office of Infrastructure and Environment",
                            level: 2,
                            parent_id: "100006168",
                            descendants: []
                        },
                        {
                            id: "100006188",
                            name: "Office of Defense Nuclear Security",
                            level: 2,
                            parent_id: "100006168",
                            descendants: []
                        },
                        {
                            id: "100006146",
                            name: "Office of Naval Reactors",
                            level: 2,
                            parent_id: "100006168",
                            descendants: []
                        },
                        {
                            id: "100006127",
                            name: "Office of Defense Programs",
                            level: 2,
                            parent_id: "100006168",
                            descendants: []
                        },
                        {
                            id: "100006169",
                            name: "Office of Emergency Operations",
                            level: 2,
                            parent_id: "100006168",
                            descendants: []
                        },
                        {
                            id: "100006187",
                            name: "Office of Defense Nuclear Nonproliferation",
                            level: 2,
                            parent_id: "100006168",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006186",
                    name: "Office of Legacy Management",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006145",
                            name: "Office of Site Operations",
                            level: 2,
                            parent_id: "100006186",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006122",
                    name: "Office of Health, Safety, and Security",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006184",
                            name: "Office of Security",
                            level: 2,
                            parent_id: "100006122",
                            descendants: []
                        },
                        {
                            id: "100006165",
                            name: "Office of Environmental Protection, Sustainability Support and Corporate Safety Analysis",
                            level: 2,
                            parent_id: "100006122",
                            descendants: []
                        },
                        {
                            id: "100006183",
                            name: "Office of Health and Safety",
                            level: 2,
                            parent_id: "100006122",
                            descendants: []
                        },
                        {
                            id: "100006142",
                            name: "Office of Nuclear Safety",
                            level: 2,
                            parent_id: "100006122",
                            descendants: []
                        },
                        {
                            id: "100006123",
                            name: "Office of Classification",
                            level: 2,
                            parent_id: "100006122",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006228",
                    name: "Oak Ridge National Laboratory",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006131",
                    name: "Office of Public Affairs",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006191",
                            name: "Office of Public Information",
                            level: 2,
                            parent_id: "100006131",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006230",
                    name: "Fermilab, Office of Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006144",
                    name: "Office of Intelligence and Counterintelligence",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006167",
                            name: "Office of Intelligence",
                            level: 2,
                            parent_id: "100006144",
                            descendants: []
                        },
                        {
                            id: "100006126",
                            name: "Office of Counterintelligence",
                            level: 2,
                            parent_id: "100006144",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006157",
                    name: "Office of Secretary of Energy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006227",
                    name: "Lawrence Livermore National Laboratory, Office of Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006130",
                    name: "Office of Electricity Delivery and Energy Reliability",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006149",
                            name: "Permitting, Siting & Analysis",
                            level: 2,
                            parent_id: "100006130",
                            descendants: []
                        },
                        {
                            id: "100006172",
                            name: "Infrastructure Security and Energy Restoration",
                            level: 2,
                            parent_id: "100006130",
                            descendants: []
                        },
                        {
                            id: "100006190",
                            name: "Research and Development",
                            level: 2,
                            parent_id: "100006130",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006124",
                    name: "Office of Chief Information Officer",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006185",
                            name: "Office of IT Planning, Architecture and E-Government",
                            level: 2,
                            parent_id: "100006124",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006174",
                    name: "Office of Under Secretary for Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006133",
                    name: "Advanced Research Projects Agency - Energy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100007001",
                            name: "Small Business Innovative Research and Small Business Technology Transfer",
                            level: 2,
                            parent_id: "100006133",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006229",
                    name: "Oak Ridge Institute for Science and Education",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006147",
                    name: "Office of Nuclear Energy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006170",
                            name: "Office of Nuclear Facility Operations",
                            level: 2,
                            parent_id: "100006147",
                            descendants: []
                        },
                        {
                            id: "100006999",
                            name: "Nuclear Energy University Programs",
                            level: 2,
                            parent_id: "100006147",
                            descendants: []
                        },
                        {
                            id: "100006148",
                            name: "Nuclear Reactor Technologies",
                            level: 2,
                            parent_id: "100006147",
                            descendants: []
                        },
                        {
                            id: "100006998",
                            name: "Nuclear Energy Enabling Technologies",
                            level: 2,
                            parent_id: "100006147",
                            descendants: []
                        },
                        {
                            id: "100006129",
                            name: "Fuel Cycle Technologies",
                            level: 2,
                            parent_id: "100006147",
                            descendants: []
                        },
                        {
                            id: "100006171",
                            name: "Office of Space and Defense Power Systems",
                            level: 2,
                            parent_id: "100006147",
                            descendants: []
                        },
                        {
                            id: "100006189",
                            name: "International Nuclear Energy Policy and Cooperation",
                            level: 2,
                            parent_id: "100006147",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006132",
                    name: "Office of Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006151",
                            name: "Basic Energy Sciences",
                            level: 2,
                            parent_id: "100006132",
                            descendants: []
                        },
                        {
                            id: "100006206",
                            name: "Biological and Environmental Research",
                            level: 2,
                            parent_id: "100006132",
                            descendants: []
                        },
                        {
                            id: "100006208",
                            name: "High Energy Physics",
                            level: 2,
                            parent_id: "100006132",
                            descendants: []
                        },
                        {
                            id: "100006207",
                            name: "Fusion Energy Sciences",
                            level: 2,
                            parent_id: "100006132",
                            descendants: []
                        },
                        {
                            id: "100006209",
                            name: "Nuclear Physics",
                            level: 2,
                            parent_id: "100006132",
                            descendants: []
                        },
                        {
                            id: "100006210",
                            name: "Workforce Development for Teachers and Scientists",
                            level: 2,
                            parent_id: "100006132",
                            descendants: []
                        },
                        {
                            id: "100006192",
                            name: "Advanced Scientific Computing Research",
                            level: 2,
                            parent_id: "100006132",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006113",
                    name: "Office of Under Secretary",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006224",
                    name: "Argonne National Laboratory, Office of Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006235",
                    name: "Lawrence Berkely National Laboratory",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006138",
                    name: "Office of Environmental Management",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006119",
                            name: "Safety and Security Program",
                            level: 2,
                            parent_id: "100006138",
                            descendants: []
                        },
                        {
                            id: "100006201",
                            name: "Program and Site Support",
                            level: 2,
                            parent_id: "100006138",
                            descendants: []
                        },
                        {
                            id: "100006180",
                            name: "Technology Innovation and Development",
                            level: 2,
                            parent_id: "100006138",
                            descendants: []
                        },
                        {
                            id: "100006139",
                            name: "Technical and Regulatory Support",
                            level: 2,
                            parent_id: "100006138",
                            descendants: []
                        },
                        {
                            id: "100006163",
                            name: "Project Management",
                            level: 2,
                            parent_id: "100006138",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006162",
                    name: "Energy Information Administration",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006118",
                            name: "Office of Energy Statistics",
                            level: 2,
                            parent_id: "100006162",
                            descendants: []
                        },
                        {
                            id: "100006179",
                            name: "Office of Energy Analysis",
                            level: 2,
                            parent_id: "100006162",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006121",
                    name: "Office of General Counsel",
                    level: 1,
                    parent_id: 100000015,
                    descendants: [
                        {
                            id: "100006141",
                            name: "Office of Environmental and Nuclear Programs",
                            level: 2,
                            parent_id: "100006121",
                            descendants: []
                        },
                        {
                            id: "100006200",
                            name: "Office of Technology Transfer and Procurement",
                            level: 2,
                            parent_id: "100006121",
                            descendants: []
                        },
                        {
                            id: "100006182",
                            name: "Office of Energy Policy",
                            level: 2,
                            parent_id: "100006121",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100006114",
                    name: "Office of Energy Policy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006175",
                    name: "Office of Environment and Science",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006164",
                    name: "Petroleum Reserves",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006140",
                    name: "Oil and Natural Gas",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006181",
                    name: "Clean Coal",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006173",
                    name: "Office of Climate Change Policy and Technology",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006161",
                    name: "Building Technologies Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006135",
                    name: "Geothermal Technologies Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006137",
                    name: "Sustainability Performance Office",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006115",
                    name: "Solar Energy Technologies Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006136",
                    name: "Fuel Cell Technologies Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006160",
                    name: "Biomass Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006117",
                    name: "Weatherization and Intergovernmental Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006116",
                    name: "Advanced Manufacturing Office",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006177",
                    name: "Vehicle Technologies Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006335",
                    name: "Industrial Technologies Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006176",
                    name: "Wind and Water Power Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006178",
                    name: "Office of Federal Energy Management Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006159",
                    name: "Office of Technology Development",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006166",
                    name: "Office of Audits and Inspections",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006127",
                    name: "Office of Defense Programs",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006169",
                    name: "Office of Emergency Operations",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006187",
                    name: "Office of Defense Nuclear Nonproliferation",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006128",
                    name: "Office of Infrastructure and Environment",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006188",
                    name: "Office of Defense Nuclear Security",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006146",
                    name: "Office of Naval Reactors",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006145",
                    name: "Office of Site Operations",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006184",
                    name: "Office of Security",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006165",
                    name: "Office of Environmental Protection, Sustainability Support and Corporate Safety Analysis",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006183",
                    name: "Office of Health and Safety",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006142",
                    name: "Office of Nuclear Safety",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006123",
                    name: "Office of Classification",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006191",
                    name: "Office of Public Information",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006167",
                    name: "Office of Intelligence",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006126",
                    name: "Office of Counterintelligence",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006149",
                    name: "Permitting, Siting & Analysis",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006172",
                    name: "Infrastructure Security and Energy Restoration",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006190",
                    name: "Research and Development",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006185",
                    name: "Office of IT Planning, Architecture and E-Government",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100007001",
                    name: "Small Business Innovative Research and Small Business Technology Transfer",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006170",
                    name: "Office of Nuclear Facility Operations",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006999",
                    name: "Nuclear Energy University Programs",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006148",
                    name: "Nuclear Reactor Technologies",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006998",
                    name: "Nuclear Energy Enabling Technologies",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006129",
                    name: "Fuel Cycle Technologies",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006171",
                    name: "Office of Space and Defense Power Systems",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006189",
                    name: "International Nuclear Energy Policy and Cooperation",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006151",
                    name: "Basic Energy Sciences",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006206",
                    name: "Biological and Environmental Research",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006208",
                    name: "High Energy Physics",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006207",
                    name: "Fusion Energy Sciences",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006209",
                    name: "Nuclear Physics",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006210",
                    name: "Workforce Development for Teachers and Scientists",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006192",
                    name: "Advanced Scientific Computing Research",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006201",
                    name: "Program and Site Support",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006180",
                    name: "Technology Innovation and Development",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006139",
                    name: "Technical and Regulatory Support",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006163",
                    name: "Project Management",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006119",
                    name: "Safety and Security Program",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006118",
                    name: "Office of Energy Statistics",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006179",
                    name: "Office of Energy Analysis",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006141",
                    name: "Office of Environmental and Nuclear Programs",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006200",
                    name: "Office of Technology Transfer and Procurement",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                },
                {
                    id: "100006182",
                    name: "Office of Energy Policy",
                    level: 1,
                    parent_id: 100000015,
                    descendants: []
                }
            ]
        },
        {
            id: 100000201,
            name: "U.S. Department of the Interior",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100000203",
                    name: "U.S. Geological Survey",
                    level: 1,
                    parent_id: 100000201,
                    descendants: []
                },
                {
                    id: "100007149",
                    name: "U.S. Bureau of Land Management",
                    level: 1,
                    parent_id: 100000201,
                    descendants: []
                },
                {
                    id: "100000202",
                    name: "U.S. Fish and Wildlife Service",
                    level: 1,
                    parent_id: 100000201,
                    descendants: []
                }
            ]
        },
        {
            id: 100000140,
            name: "U.S. Department of Transportation",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100006283",
                    name: "Federal Railroad Administration",
                    level: 1,
                    parent_id: 100000140,
                    descendants: []
                },
                {
                    id: "100006282",
                    name: "Federal Aviation Administration",
                    level: 1,
                    parent_id: 100000140,
                    descendants: []
                },
                {
                    id: "100006286",
                    name: "Federal Motor Carrier Safety Administration",
                    level: 1,
                    parent_id: 100000140,
                    descendants: []
                },
                {
                    id: "100006285",
                    name: "Federal Highway Administration",
                    level: 1,
                    parent_id: 100000140,
                    descendants: []
                },
                {
                    id: "100006287",
                    name: "Federal Transit Administration",
                    level: 1,
                    parent_id: 100000140,
                    descendants: []
                },
                {
                    id: "100006284",
                    name: "Pipeline and Hazardous Materials Safety Administration",
                    level: 1,
                    parent_id: 100000140,
                    descendants: []
                }
            ]
        },
        {
            id: 100000138,
            name: "U.S. Department of Education",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100005247",
                    name: "Office of Communications and Outreach",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005249",
                    name: "Office of English Language Acquisition",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005255",
                    name: "Office of the Secretary",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005252",
                    name: "Office of Safe and Drug-Free Schools",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005251",
                    name: "Office of Postsecondary Education",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005246",
                    name: "Institute of Education Sciences",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005254",
                    name: "Office of Vocational and Adult Education",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005245",
                    name: "Federal Student Aid",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005253",
                    name: "Office of Special Education and Rehabilitative Services",
                    level: 1,
                    parent_id: 100000138,
                    descendants: [
                        {
                            id: "100006663",
                            name: "National Institute on Disability and Rehabilitation Research",
                            level: 2,
                            parent_id: "100005253",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100005248",
                    name: "Office of Elementary and Secondary Education",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100005250",
                    name: "Office of Innovation and Improvement",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                },
                {
                    id: "100006663",
                    name: "National Institute on Disability and Rehabilitation Research",
                    level: 1,
                    parent_id: 100000138,
                    descendants: []
                }
            ]
        },
        {
            id: 100000139,
            name: "U.S. Environmental Protection Agency",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000038,
            name: "U.S. Food and Drug Administration",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000104,
            name: "National Aeronautics and Space Administration",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100006198",
                    name: "Goddard Space Flight Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006205",
                    name: "Stennis Space Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006195",
                    name: "Ames Research Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006194",
                    name: "Kennedy Space Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006193",
                    name: "Glenn Research Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006197",
                    name: "Marshall Space Flight Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006196",
                    name: "Jet Propulsion Laboratory",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006204",
                    name: "Dryden Flight Research Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006203",
                    name: "Johnson Space Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                },
                {
                    id: "100006199",
                    name: "Langley Research Center",
                    level: 1,
                    parent_id: 100000104,
                    descendants: []
                }
            ]
        },
        {
            id: 100000002,
            name: "National Institutes of Health",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100000070",
                    name: "National Institute of Biomedical Imaging and Bioengineering",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000051",
                    name: "National Human Genome Research Institute",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000066",
                    name: "National Institute of Environmental Health Sciences",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000135",
                    name: "NIH Blueprint for Neuroscience Research",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000049",
                    name: "National Institute on Aging",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000072",
                    name: "National Institute of Dental and Craniofacial Research",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000065",
                    name: "National Institute of Neurological Disorders and Stroke",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000092",
                    name: "U.S. National Library of Medicine",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000071",
                    name: "National Institute of Child Health and Human Development",
                    level: 1,
                    parent_id: 100000002,
                    descendants: [
                        {
                            id: "100006937",
                            name: "National Center for Medical Rehabilitation Research",
                            level: 2,
                            parent_id: "100000071",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000054",
                    name: "National Cancer Institute",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000069",
                    name: "National Institute of Arthritis and Musculoskeletal and Skin Diseases",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000053",
                    name: "National Eye Institute",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000060",
                    name: "National Institute of Allergy and Infectious Diseases",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000062",
                    name: "National Institute of Diabetes and Digestive and Kidney Diseases",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100006086",
                    name: "Office of Strategic Coordination",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000061",
                    name: "Fogarty International Center",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000056",
                    name: "National Institute of Nursing Research",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000026",
                    name: "National Institute on Drug Abuse",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000118",
                    name: "Office of Behavioral and Social Sciences Research",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100006545",
                    name: "National Institute on Minority Health and Health Disparities",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000064",
                    name: "National Center for Complementary and Alternative Medicine",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100006085",
                    name: "Office of Disease Prevention",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000055",
                    name: "National Institute on Deafness and Other Communication Disorders",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000057",
                    name: "National Institute of General Medical Sciences",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000025",
                    name: "National Institute of Mental Health",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100006108",
                    name: "National Center for Advancing Translational Sciences",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000093",
                    name: "Center for Information Technology",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100006084",
                    name: "Office of AIDS Research",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000124",
                    name: "Office of Research on Women's Health",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000050",
                    name: "National Heart, Lung, and Blood Institute",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000096",
                    name: "National Center on Minority Health and Health Disparities",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100005440",
                    name: "Center for Scientific Review",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000098",
                    name: "NIH Clinical Center",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000027",
                    name: "National Institute on Alcohol Abuse and Alcoholism",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000097",
                    name: "National Center for Research Resources",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100000052",
                    name: "NIH Office of the Director",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                },
                {
                    id: "100006937",
                    name: "National Center for Medical Rehabilitation Research",
                    level: 1,
                    parent_id: 100000002,
                    descendants: []
                }
            ]
        },
        {
            id: 100000161,
            name: "National Institute of Standards and Technology",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000192,
            name: "National Oceanic and Atmospheric Administration",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000001,
            name: "National Science Foundation",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100006603",
                    name: "Office of Diversity and Inclusion",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000108",
                    name: "National Science Digital Library",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000088",
                    name: "Directorate for Social, Behavioral and Economic Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100005717",
                            name: "SBE Office of Multidisciplinary Activities",
                            level: 2,
                            parent_id: "100000088",
                            descendants: []
                        },
                        {
                            id: "100000077",
                            name: "Division of Social and Economic Sciences",
                            level: 2,
                            parent_id: "100000088",
                            descendants: []
                        },
                        {
                            id: "100000170",
                            name: "National Center for Science and Engineering Statistics",
                            level: 2,
                            parent_id: "100000088",
                            descendants: []
                        },
                        {
                            id: "100000169",
                            name: "Division of Behavioral and Cognitive Sciences",
                            level: 2,
                            parent_id: "100000088",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000087",
                    name: "Office of Polar Programs",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100000175",
                            name: "Office of Polar Environment, Health and Safety",
                            level: 2,
                            parent_id: "100000087",
                            descendants: []
                        },
                        {
                            id: "100000174",
                            name: "Division of Antarctic Infrastructure and Logistics",
                            level: 2,
                            parent_id: "100000087",
                            descendants: []
                        },
                        {
                            id: "100000163",
                            name: "Division of Arctic Sciences",
                            level: 2,
                            parent_id: "100000087",
                            descendants: []
                        },
                        {
                            id: "100000162",
                            name: "Division of Antarctic Sciences",
                            level: 2,
                            parent_id: "100000087",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100005441",
                    name: "Office of Budget, Finance and Award Management",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100005444",
                            name: "Division of Financial Management",
                            level: 2,
                            parent_id: "100005441",
                            descendants: []
                        },
                        {
                            id: "100005446",
                            name: "Division of Institution and Award Support",
                            level: 2,
                            parent_id: "100005441",
                            descendants: []
                        },
                        {
                            id: "100005443",
                            name: "Division of Acquisition and Cooperative Support",
                            level: 2,
                            parent_id: "100005441",
                            descendants: []
                        },
                        {
                            id: "100005445",
                            name: "Division of Grants and Agreements",
                            level: 2,
                            parent_id: "100005441",
                            descendants: []
                        },
                        {
                            id: "100005442",
                            name: "Budget Division",
                            level: 2,
                            parent_id: "100005441",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000105",
                    name: "Office of Cyberinfrastructure",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000076",
                    name: "Directorate for Biological Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100000156",
                            name: "Division of Emerging Frontiers",
                            level: 2,
                            parent_id: "100000076",
                            descendants: []
                        },
                        {
                            id: "100000153",
                            name: "Division of Biological Infrastructure",
                            level: 2,
                            parent_id: "100000076",
                            descendants: []
                        },
                        {
                            id: "100000155",
                            name: "Division of Environmental Biology",
                            level: 2,
                            parent_id: "100000076",
                            descendants: []
                        },
                        {
                            id: "100000152",
                            name: "Division of Molecular and Cellular Biosciences",
                            level: 2,
                            parent_id: "100000076",
                            descendants: []
                        },
                        {
                            id: "100000154",
                            name: "Division of Integrative Organismal Systems",
                            level: 2,
                            parent_id: "100000076",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000089",
                    name: "Office of International Science and Engineering",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000177",
                    name: "Office of Legislative and Public Affairs",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000179",
                    name: "NSF Office of the Director",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005716",
                    name: "National Science Board",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000176",
                    name: "Office of the General Counsel",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000178",
                    name: "Office of Equal Opportunity Program",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005447",
                    name: "Office of Information and Resource Management",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100005449",
                            name: "Division of Information Systems",
                            level: 2,
                            parent_id: "100005447",
                            descendants: []
                        },
                        {
                            id: "100005450",
                            name: "Division of Administrative Services",
                            level: 2,
                            parent_id: "100005447",
                            descendants: []
                        },
                        {
                            id: "100005448",
                            name: "Division of Human Resource Management",
                            level: 2,
                            parent_id: "100005447",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000081",
                    name: "Directorate for Education and Human Resources",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100000171",
                            name: "Division of Human Resource Development",
                            level: 2,
                            parent_id: "100000081",
                            descendants: []
                        },
                        {
                            id: "100005554",
                            name: "Division of Elementary, Secondary, and Informal Education",
                            level: 2,
                            parent_id: "100000081",
                            descendants: []
                        },
                        {
                            id: "100000173",
                            name: "Division of Research on Learning in Formal and Informal Settings",
                            level: 2,
                            parent_id: "100000081",
                            descendants: []
                        },
                        {
                            id: "100000172",
                            name: "Division of Undergraduate Education",
                            level: 2,
                            parent_id: "100000081",
                            descendants: []
                        },
                        {
                            id: "100000082",
                            name: "Division of Graduate Education",
                            level: 2,
                            parent_id: "100000081",
                            descendants: []
                        },
                        {
                            id: "100005553",
                            name: "Division of Research, Evaluation, and Communication",
                            level: 2,
                            parent_id: "100000081",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000110",
                    name: "Nanotechnology Initiative",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000107",
                    name: "Science of Learning Centers",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000084",
                    name: "Directorate for Engineering",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100000151",
                            name: "Division of Industrial Innovation and Partnerships",
                            level: 2,
                            parent_id: "100000084",
                            descendants: []
                        },
                        {
                            id: "100000150",
                            name: "Division of Emerging Frontiers in Research and Innovation",
                            level: 2,
                            parent_id: "100000084",
                            descendants: []
                        },
                        {
                            id: "100000147",
                            name: "Division of Civil, Mechanical and Manufacturing Innovation",
                            level: 2,
                            parent_id: "100000084",
                            descendants: []
                        },
                        {
                            id: "100000146",
                            name: "Division of Chemical, Bioengineering, Environmental, and Transport Systems",
                            level: 2,
                            parent_id: "100000084",
                            descendants: []
                        },
                        {
                            id: "100000149",
                            name: "Division of Engineering Education and Centers",
                            level: 2,
                            parent_id: "100000084",
                            descendants: []
                        },
                        {
                            id: "100000148",
                            name: "Division of Electrical, Communications and Cyber Systems",
                            level: 2,
                            parent_id: "100000084",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000086",
                    name: "Directorate for Mathematical and Physical Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100000165",
                            name: "Division of Chemistry",
                            level: 2,
                            parent_id: "100000086",
                            descendants: []
                        },
                        {
                            id: "100000164",
                            name: "Division of Astronomical Sciences",
                            level: 2,
                            parent_id: "100000086",
                            descendants: []
                        },
                        {
                            id: "100000166",
                            name: "Division of Physics",
                            level: 2,
                            parent_id: "100000086",
                            descendants: []
                        },
                        {
                            id: "100000121",
                            name: "Division of Mathematical Sciences",
                            level: 2,
                            parent_id: "100000086",
                            descendants: []
                        },
                        {
                            id: "100006091",
                            name: "Office of Multidisciplinary Activities",
                            level: 2,
                            parent_id: "100000086",
                            descendants: []
                        },
                        {
                            id: "100000078",
                            name: "Division of Materials Research",
                            level: 2,
                            parent_id: "100000086",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000106",
                    name: "Office of Integrative Activities",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100005714",
                            name: "Office of Experimental Program to Stimulate Competitive Research",
                            level: 2,
                            parent_id: "100000106",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000083",
                    name: "Directorate for Computer and Information Science and Engineering",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100000143",
                            name: "Division of Computing and Communication Foundations",
                            level: 2,
                            parent_id: "100000083",
                            descendants: []
                        },
                        {
                            id: "100000145",
                            name: "Division of Information and Intelligent Systems",
                            level: 2,
                            parent_id: "100000083",
                            descendants: []
                        },
                        {
                            id: "100000144",
                            name: "Division of Computer and Network Systems",
                            level: 2,
                            parent_id: "100000083",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000085",
                    name: "Directorate for Geosciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: [
                        {
                            id: "100000160",
                            name: "Division of Earth Sciences",
                            level: 2,
                            parent_id: "100000085",
                            descendants: []
                        },
                        {
                            id: "100000141",
                            name: "Division of Ocean Sciences",
                            level: 2,
                            parent_id: "100000085",
                            descendants: []
                        },
                        {
                            id: "100000159",
                            name: "Division of Atmospheric and Geospace Sciences",
                            level: 2,
                            parent_id: "100000085",
                            descendants: []
                        }
                    ]
                },
                {
                    id: "100000169",
                    name: "Division of Behavioral and Cognitive Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005717",
                    name: "SBE Office of Multidisciplinary Activities",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000077",
                    name: "Division of Social and Economic Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000170",
                    name: "National Center for Science and Engineering Statistics",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000175",
                    name: "Office of Polar Environment, Health and Safety",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000174",
                    name: "Division of Antarctic Infrastructure and Logistics",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000163",
                    name: "Division of Arctic Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000162",
                    name: "Division of Antarctic Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005442",
                    name: "Budget Division",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005444",
                    name: "Division of Financial Management",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005446",
                    name: "Division of Institution and Award Support",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005443",
                    name: "Division of Acquisition and Cooperative Support",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005445",
                    name: "Division of Grants and Agreements",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000153",
                    name: "Division of Biological Infrastructure",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000155",
                    name: "Division of Environmental Biology",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000152",
                    name: "Division of Molecular and Cellular Biosciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000154",
                    name: "Division of Integrative Organismal Systems",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000156",
                    name: "Division of Emerging Frontiers",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005449",
                    name: "Division of Information Systems",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005450",
                    name: "Division of Administrative Services",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005448",
                    name: "Division of Human Resource Management",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000172",
                    name: "Division of Undergraduate Education",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000082",
                    name: "Division of Graduate Education",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005553",
                    name: "Division of Research, Evaluation, and Communication",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000171",
                    name: "Division of Human Resource Development",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005554",
                    name: "Division of Elementary, Secondary, and Informal Education",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000173",
                    name: "Division of Research on Learning in Formal and Informal Settings",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000147",
                    name: "Division of Civil, Mechanical and Manufacturing Innovation",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000146",
                    name: "Division of Chemical, Bioengineering, Environmental, and Transport Systems",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000149",
                    name: "Division of Engineering Education and Centers",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000148",
                    name: "Division of Electrical, Communications and Cyber Systems",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000151",
                    name: "Division of Industrial Innovation and Partnerships",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000150",
                    name: "Division of Emerging Frontiers in Research and Innovation",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100006091",
                    name: "Office of Multidisciplinary Activities",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000078",
                    name: "Division of Materials Research",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000165",
                    name: "Division of Chemistry",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000164",
                    name: "Division of Astronomical Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000166",
                    name: "Division of Physics",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000121",
                    name: "Division of Mathematical Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100005714",
                    name: "Office of Experimental Program to Stimulate Competitive Research",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000143",
                    name: "Division of Computing and Communication Foundations",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000145",
                    name: "Division of Information and Intelligent Systems",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000144",
                    name: "Division of Computer and Network Systems",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000160",
                    name: "Division of Earth Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000141",
                    name: "Division of Ocean Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                },
                {
                    id: "100000159",
                    name: "Division of Atmospheric and Geospace Sciences",
                    level: 1,
                    parent_id: 100000001,
                    descendants: []
                }
            ]
        },
        {
            id: 100000014,
            name: "Smithsonian Institution",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000200,
            name: "United States Agency for International Development",
            level: 0,
            parent_id: 0,
            descendants: []
        },
        {
            id: 100000199,
            name: "U.S. Department of Agriculture",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100006960",
                    name: "Forest Products Laboratory",
                    level: 1,
                    parent_id: 100000199,
                    descendants: []
                },
                {
                    id: "100006959",
                    name: "US Forest Service",
                    level: 1,
                    parent_id: 100000199,
                    descendants: []
                },
                {
                    id: "100005826",
                    name: "Agricultural Marketing Service",
                    level: 1,
                    parent_id: 100000199,
                    descendants: []
                },
                {
                    id: "100005825",
                    name: "National Institute of Food and Agriculture",
                    level: 1,
                    parent_id: 100000199,
                    descendants: []
                }
            ]
        },
        {
            id: 100000738,
            name: "U.S. Department of Veterans Affairs",
            level: 0,
            parent_id: 0,
            descendants: [
                {
                    id: "100007181",
                    name: "Quality Enhancement Research Initiative",
                    level: 1,
                    parent_id: 100000738,
                    descendants: []
                },
                {
                    id: "100006364",
                    name: "James A. Haley Veterans' Hospital",
                    level: 1,
                    parent_id: 100000738,
                    descendants: []
                }
            ]
        }
    ]
  end
end
