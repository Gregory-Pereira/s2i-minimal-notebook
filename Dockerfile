FROM quay.io/thoth-station/s2i-thoth-ubi8-py36:latest
LABEL "io.openshift.s2i.build.commit.id"="5bc11dd770de98769bd8eba53d9e8528c383ee3d" \
      "io.openshift.s2i.build.commit.ref"="HEAD" \
      "io.openshift.s2i.build.commit.message"="Release of version 0.2.2 (#501)" \
      "io.openshift.s2i.build.source-location"="/home/grpereir/Documents/thoth-station/s2i-minimal-notebook/." \
      "io.k8s.display-name"="s2i-minimal-notebook" \
      "io.openshift.s2i.build.image"="quay.io/thoth-station/s2i-thoth-ubi8-py36:latest" \
      "io.openshift.s2i.build.commit.author"="khebhut[bot] <64544372+khebhut[bot]@users.noreply.github.com>" \
      "io.openshift.s2i.build.commit.date"="Thu Dec 9 01:38:25 2021 -0500"
ENV ENABLE_PIPENV="1" \
    THOTH_ADVISE="0" \
    THOTH_ERROR_FALLBACK="1" \
    THOTH_DRY_RUN="1" \
    THOTH_PROVENANCE_CHECK="0" \
    THAMOS_RUNTIME_ENVIRONMENT=""
USER root
# Copying in override assemble/run scripts
COPY upload/scripts /tmp/scripts
# Copying in source code
COPY upload/src /tmp/src
# Change file ownership to the assemble user. Builder image must support chown command.
RUN chown -R 1001:0 /tmp/scripts /tmp/src
USER 1001
RUN /tmp/scripts/assemble
CMD /tmp/scripts/run
