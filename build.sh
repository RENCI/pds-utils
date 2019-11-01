#!/bin/bash
if ! [ -z $IMAGE ] && ! [ -z $VERSION ] ; then
    docker build . -t $IMAGE:$VERSION
    docker tag $IMAGE:0.1.0 zooh/$IMAGE:$VERSION
    docker push zooh/$IMAGE:0.1.0
fi

if [ -z $COMMIT_MSG ]; then
    COMMIT_MSG=update
fi

git add -u
git commit -m $COMMIT_MSG
for o in $(git remote)
do
    git push $o
done

if ! [ -z $VERSION ] ; then
    git tag v$VERSION -f
    for o in $(git remote)
    do
	git push $o --tags -f
    done
fi
