#! /usr/bin/env bash
#
# Copyright (C) 2013-2015 Bilibili
# Copyright (C) 2013-2015 Zhang Rui <bbcallen@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR=$(dirname "$DIR")

IJK_LIB_NAME=libx264
IJK_LIB_UPSTREAM=https://code.videolan.org/videolan/x264.git
IJK_LIB_FORK=https://code.videolan.org/videolan/x264.git
IJK_LIB_COMMIT=33f9e1474613f59392be5ab6a7e7abf60fa63622
IJK_LIB_LOCAL_REPO=$BASEDIR/extra/libx264

set -e
TOOLS=$BASEDIR/tools

echo "== pull libx264 base =="
sh $TOOLS/pull-repo-base.sh $IJK_LIB_UPSTREAM $IJK_LIB_LOCAL_REPO

function pull_fork()
{
    echo "== pull libx264 fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_LIB_FORK $BASEDIR/android/contrib/libx264-$1 ${IJK_LIB_LOCAL_REPO}
    cd $BASEDIR/android/contrib/libx264-$1
    git checkout ${IJK_LIB_COMMIT} -B ijkplayer
    cd -
}

pull_fork "armv5"
pull_fork "armv7a"
pull_fork "arm64"
pull_fork "x86"
pull_fork "x86_64"