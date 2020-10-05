import multiprocessing
import os

worlds = {
    "overworld": os.getenv('OVERWORLD_DIR', 'pumpcraft'),
}

renders = {
    "overworld_day": {
        "world": "overworld",
        "title": "Daytime",
        "rendermode": "smooth_lighting",
        "defaultzoom": 8,
    },
    "overworld_night": {
        "world": "overworld",
        "title": "Nighttime",
        "rendermode": "smooth_night",
        "defaultzoom": 8,
    },
    "overworld_cave": {
        "world": "overworld",
        "title": "Caves",
        "rendermode": "cave",
        "defaultzoom": 8,
    },
    "biomes": {
        "world": "overworld",
        "title": "Biomes",
        "rendermode": [ClearBase(), BiomeOverlay()], # pylint: disable=undefined-variable
        "overlay": ["overworld_day"]
    },
}

outputdir = "/output/"
try:
    processes = int(os.getenv("THREADS"))
except TypeError:
    processes = multiprocessing.cpu_count()