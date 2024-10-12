public static var stageType:Int; // 0 = normal, 1 = 3D

function create() {
    switch (SONG.meta.name) {
        case "house" | "insanity" | "polygonized":
            introSounds = ['intro/dave/intro3_dave', 'intro/dave/intro2_dave', "intro/dave/intro1_dave", "intro/dave/introGo_dave"];
    }
}