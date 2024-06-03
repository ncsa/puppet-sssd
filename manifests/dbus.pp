# Manage the SSSD InfoPipe responder
#
# @example Declaring the class
#   include ::dbus
#   include ::sssd
#   include ::sssd::dbus
#
# @param package_name
# @param debug
# @param debug_level
# @param debug_timestamps
# @param debug_microseconds
# @param timeout
# @param reconnection_retries
# @param fd_limit
# @param client_idle_timeout
# @param offline_timeout
# @param responder_idle_timeout
# @param cache_first
# @param allowed_uids
# @param user_attributes
# @param wildcard_limit
#
# @see puppet_classes::sssd ::sssd
# @see puppet_defined_types::sssd::service ::sssd::service
#
# @since 1.0.0
class sssd::dbus (
  String                                          $package_name,
  # options for any section
  Optional[Integer[0]]                            $debug,
  Optional[Integer[0]]                            $debug_level,
  Optional[Boolean]                               $debug_timestamps,
  Optional[Boolean]                               $debug_microseconds,
  # generic service options
  Optional[Integer[0]]                            $timeout,
  Optional[Integer[0]]                            $reconnection_retries,
  Optional[Integer[0]]                            $fd_limit,
  Optional[Integer[0]]                            $client_idle_timeout,
  Optional[Integer[0]]                            $offline_timeout,
  Optional[Integer[0]]                            $responder_idle_timeout,
  Optional[Boolean]                               $cache_first,
  # options for [ifp] section
  Optional[Array[Variant[Integer[0], String], 1]] $allowed_uids,
  Optional[Array[String, 1]]                      $user_attributes,
  Optional[Integer[0]]                            $wildcard_limit,
) {
  if ! defined(Class['sssd']) {
    fail('You must include the sssd base class before using the sssd::dbus class')
  }

  contain sssd::dbus::install
  contain sssd::dbus::config

  Class['sssd::dbus::install'] ~> Class['sssd::dbus::config']

  Class['dbus'] -> Class['sssd']
}
