inputfile=$1
outputdir=$2
osmosis --read-pbf $inputfile \
        --bounding-box \
          left=-122.1432 \
          bottom=47.6365 \
          right=-122.1321 \
          top=47.6497 \
          clipIncompleteEntities=true \
          outPipe.0=source \
\
        --tee inPipe.0=source \
          outputCount=3 \
          outPipe.0=transportation_in \
          outPipe.1=streets_in \
          outPipe.2=barriers_in \
\
        --tf inPipe.0=transportation_in \
          accept-ways highway=footway,cycleway,path,pedestrian,service,steps \
        --un \
        --write-xml $outputdir/transportation.osm \
\
        --tf inPipe.0=streets_in \
          accept-ways highway=primary,secondary,tertiary,residential,service \
        --write-xml $outputdir/streets.osm \
\
        --tf inPipe.0=barriers_in \
          accept-nodes kerb=* amenity=* tactile_paving=* traffic_signals=* traffic_sign=* barrier=* highway=* man_made=* \
        --tf reject-ways \
        --tf reject-relations \
        --write-xml $outputdir/barriers.osm \
