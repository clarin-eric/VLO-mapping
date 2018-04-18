#!/usr/bin/env bash
set -e

MAPS_DIR=$(dirname "$0")/..

if [[ "$TRAVIS_TAG" ]]; then
	echo "Skipping pushing of changes since we are on a tag"
	exit 0
fi

if [[ `git status --porcelain "${MAPS_DIR}"` ]]; then

	if [[ "$TRAVIS_BRANCH" ]]; then
		if [ "$TRAVIS_BRANCH" = "development" ] \
			|| [ "$TRAVIS_BRANCH" = "beta" ] \
			|| [ "$TRAVIS_BRANCH" = "master" ]
		then
			echo "Will try to commit and push changes on '${TRAVIS_BRANCH}' branch"
		else
			echo "Branch '${TRAVIS_BRANCH}' is not configured for auto commit and push"
			exit 0
		fi
	else
		echo "TRAVIS_BRANCH not set; will not commit and push changes"
		exit 0
	fi

	if ! [[ "$GH_TOKEN" ]] || ! [[ "$GH_USER" ]]; then
		echo "Error: GH_TOKEN and/or GH_USER not set"
		exit 1
	fi

	echo "Committing changes"
	
	if [ "$GIT_COMMIT_USER_EMAIL" ]; then
		git config user.email "$GIT_COMMIT_USER_EMAIL"
	fi
	
	if [ "$GIT_COMMIT_USER_NAME" ]; then
		git config user.name "$GIT_COMMIT_USER_NAME"
	fi
	
	git checkout "${TRAVIS_BRANCH}"
	
	#commit
	git commit "${MAPS_DIR}" -m "Automatic commit of built changes in value maps (Travis build ${TRAVIS_BUILD_NUMBER})"
	
	#push
	URL=`git remote get-url origin`
	echo "Remote: ${URL}"
	git remote add target "https://${GH_USER}:${GH_TOKEN}@${URL#https://}"
	git push -q target 
else
	echo "Nothing to commit"
fi
