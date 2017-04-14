# == Class: duo_unix::portage
#
# Provides duo_unix for a portage environment (e.g. Gentoo )
#
# === Authors
#
# Kurt Dillen <kurt.dillen@dls-belgium.eu>
#
# Note: If you not manage the ebuild files with puppet
#       make sure you add the ebuild content manually
#       in your portage overlay.  Else this will fail.
#
# Requirement: this needs the ebuild from the following overlay:
#              https://github.com/blackcobra1973/kd-gentoo-overlay.git
#
class duo_unix::portage {
  $package_state = $::duo_unix::package_version

  if $::duo_unix::manage_ssh {
    package { 'openssh':
      ensure => installed,
    }
  }

  package { $duo_unix::duo_package:
    ensure  => $package_state,
  }
}
