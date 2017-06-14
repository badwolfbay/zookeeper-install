# Copyright 2016 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# TODO: get rid of bash dependency and switch to plain busybox.
# The tar in busybox also doesn't seem to understand compression.
FROM debian:jessie
MAINTAINER Prashanth.B <beeps@google.com>

RUN apt-get update && apt-get install -y wget netcat

ADD on-start.sh /
ADD on-change.sh /
# See contrib/pets/peer-finder for details
RUN wget -qO /peer-finder https://storage.googleapis.com/kubernetes-release/pets/peer-finder
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.5.0-alpha/zookeeper-3.5.0-alpha.tar.gz | tar -xzf - -C /opt

ADD install.sh /
RUN chmod -c 755 /install.sh /on-start.sh /on-change.sh /peer-finder
Entrypoint ["/install.sh"]