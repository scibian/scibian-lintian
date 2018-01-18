Profile: scibian/main
Extends: debian/main
Enable-Tags-From-Check:
  scibian/distribution,
  scibian/maintainer,
  scibian/version,
  scibian/section,
  scibian/vcs,
# Disable a tag
Disable-Tags:
  bad-distribution-in-changes-file,
  changelog-should-mention-nmu,
  source-nmu-has-incorrect-version-number,
