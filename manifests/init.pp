# Manage SSSD.
#
# @example Declaring the class
#   include ::sssd
#   ::sssd::service { 'nss': }
#   ::sssd::domain { 'example.com':
#     id_provider => 'ldap',
#     ...
#   }
#
# @param conf_file
# @param domains
# @param package_name
# @param service_name
# @param services
# @param service_enable
# @param service_ensure
# @param socket_services
# @param use_socket_activation
# @param debug
# @param debug_level
# @param debug_timestamps
# @param debug_microseconds
# @param config_file_version
# @param reconnection_retries
# @param re_expression
# @param full_name_format
# @param try_inotify
# @param krb5_rcache_dir
# @param user
# @param default_domain_suffix
# @param override_space
# @param certificate_verification
# @param disable_netlink
# @param enable_files_domain
# @param domain_resolution_order
#
# @see puppet_classes::sssd::dbus ::sssd::dbus
# @see puppet_defined_types::sssd::domain ::sssd::domain
# @see puppet_defined_types::sssd::service ::sssd::service
#
# @since 1.0.0
class sssd (
  Stdlib::Absolutepath                                                  $conf_file,
  Integer[2]                                                            $config_file_version,
  Hash[String, Hash[String, Any]]                                       $domains,
  Variant[String, Array[String, 1]]                                     $package_name,
  String                                                                $service_name,
  Hash[String, Hash[String, Any]]                                       $services,
  Boolean                                                               $service_enable,
  Enum['running', 'stopped']                                            $service_ensure,
  # options for any section
  Optional[Integer[0]]                                                  $debug,
  Optional[Integer[0]]                                                  $debug_level,
  Optional[Boolean]                                                     $debug_timestamps,
  Optional[Boolean]                                                     $debug_microseconds,
  # options for [sssd] section
  Optional[Array[SSSD::Certificate::Verification, 1]]                   $certificate_verification,
  Optional[String]                                                      $default_domain_suffix,
  Optional[Boolean]                                                     $disable_netlink,
  Optional[Array[String, 1]]                                            $domain_resolution_order,
  Optional[Boolean]                                                     $enable_files_domain,
  Optional[String]                                                      $full_name_format,
  Optional[Variant[Stdlib::Absolutepath, Enum['__LIBKRB5_DEFAULTS__']]] $krb5_rcache_dir,
  Optional[String]                                                      $override_space,
  Optional[Integer[0]]                                                  $reconnection_retries,
  Optional[String]                                                      $re_expression,
  Optional[Hash[SSSD::Type, Variant[String, Array[String, 1]]]]         $socket_services,
  Optional[Boolean]                                                     $try_inotify,
  Optional[Boolean]                                                     $use_socket_activation,
  Optional[String]                                                      $user,
) {
  contain sssd::install
  contain sssd::config
  contain sssd::daemon

  Class['sssd::install'] ~> Class['sssd::config']
  ~> Class['sssd::daemon']
}
