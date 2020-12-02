import multiprocessing
import os

worlds = {
    "overworld": os.getenv('OVERWORLD_DIR'),
    "nether": os.getenv('NETHER_DIR'),
    "the_end": os.getenv('THE_END_DIR'),
}

end_smooth_lighting = [Base(), EdgeLines(), SmoothLighting(strength=0.5)] # pylint: disable=undefined-variable

renders = {
    "overworld_day": {
        "world": "overworld",
        "title": "Daytime",
        "rendermode": "smooth_lighting",
        "northdirection": "upper-right",
        "defaultzoom": 8,
    },
    "overworld_night": {
        "world": "overworld",
        "title": "Nighttime",
        "rendermode": "smooth_night",
        "northdirection": "upper-right",
        "defaultzoom": 8,
    },
    "overworld_cave": {
        "world": "overworld",
        "title": "Caves",
        "rendermode": "cave",
        "northdirection": "upper-right",
        "defaultzoom": 8,
    },
    "biomes": {
        "world": "overworld",
        "title": "Biomes",
        "rendermode": [ClearBase(), BiomeOverlay()], # pylint: disable=undefined-variable
        "northdirection": "upper-right",
        "overlay": ["overworld_day"]
    },
    "nether": {
        "world": "nether",
        "title": "Nether",
        "rendermode": "nether_smooth_lighting",
        "northdirection": "upper-right",
        "defaultzoom": 8,
    },
    "the_end": {
        "world": "the_end",
        "title": "The End",
        "rendermode": end_smooth_lighting,
        "northdirection": "upper-right",
        "defaultzoom": 8,
    }
}

outputdir = "/output/"
try:
    processes = int(os.getenv("THREADS"))
except TypeError:
    processes = multiprocessing.cpu_count()