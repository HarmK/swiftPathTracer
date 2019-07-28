swift build
.build/debug/pathtracer > output.ppm
mogrify -format png output.ppm
