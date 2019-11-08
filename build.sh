#!/bin/bash
if ! [ -z $IMAGE ] && ! [ -z $VERSION ] ; then
    docker build . -t $IMAGE:$VERSION
    docker tag $IMAGE:$VERSION zooh/$IMAGE:$VERSION
    docker push zooh/$IMAGE:$VERSION
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
