#!/bin/sh -l

# Get layer digests of my image
OWN=$(skopeo inspect docker://"$1" | jq .Layers)

# Get layer digests of the parent image
PARENT=$(skopeo inspect docker://"$2" | jq .Layers)

# Check if all layers of parent are present in my image. If not, mine is out-of-date.
OUTOFDATE=$(jq -cn "$OWN - ($OWN - $PARENT) | .==[]")

# Return the result.
echo "::set-output name=out-of-date::$OUTOFDATE"
