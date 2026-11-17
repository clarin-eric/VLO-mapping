#!/usr/bin/env bash
set -e

MAPS_DIR=$(dirname "$0")/..

if [[ "$CI_TAG" ]]; then
	echo "Skipping pushing of changes since we are on a tag"
	exit 0
fi

if [[ `git status --porcelain "${MAPS_DIR}"` ]]; then

	if [[ "$CI_BRANCH" ]]; then
		if [ "$CI_BRANCH" = "development" ] \
			|| [ "$CI_BRANCH" = "beta" ] \
			|| [ "$CI_BRANCH" = "master" ]
		then
			echo "Will try to commit and push changes on '${CI_BRANCH}' branch"
		else
			echo "Branch '${CI_BRANCH}' is not configured for auto commit and push"
			exit 0
		fi
	else
		echo "CI_BRANCH not set; will not commit and push changes"
		exit 0
	fi

	echo "Committing changes"
	
	if [ "$GIT_COMMIT_USER_EMAIL" ]; then
		git config user.email "$GIT_COMMIT_USER_EMAIL"
	fi
	
	if [ "$GIT_COMMIT_USER_NAME" ]; then
		git config user.name "$GIT_COMMIT_USER_NAME"
	fi
	
	#commit
	git commit "${MAPS_DIR}" -m "Automatic commit of built changes in value maps (CI build ${CI_BUILD_NUMBER})"

	#push (uses the credentials stored by actions/checkout)
	git push -q origin "HEAD:refs/heads/${CI_BRANCH}"
else
	echo "Nothing to commit"
fi
