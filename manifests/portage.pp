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
class duo_unix::portage {
  $portage_overlay_dir = $::duo_unix::portage_overlay_dir
  $package_state = $::duo_unix::package_version

  if $::duo_unix::manage_ssh {
    package { 'openssh':
      ensure => installed,
    }
  }

  ### Manage Portage Overlay dir
  if $::duo_unix::manage_port_overlay_dir {
    file { $portage_overlay_dir:
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   =>  '0755',
    }
  }

  ### Add duo_unix ebuild to Portage Overlay
  ### Install duo_unix
  if $::duo_unix::manage_portage_ebuild {
    file { "${portage_overlay_dir}/duo_unix":
      ensure  => directory,
      recurse => true,
      purge   => true,
      require => File[$portage_overlay_dir],
      source  => 'puppet:///modules/duo_unix/duo_unix',
      mode    => '0644',
      owner   => 'root',
      group   =>  'root',
    }

    package { $duo_unix::duo_packag:
      ensure  => $package_state,
      require => File["${portage_overlay_dir}/duo_unix"]
    }
  }
  else {
    package { $duo_unix::duo_packag:
      ensure  => $package_state,
    }
  }
}
