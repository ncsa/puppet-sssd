# @summary Allow additions to sssd.conf settings from other modules
# @param domain String - The sssd domain to which this applies
# @param setting String - The setting to which items will be appended
# @param items Array - List of items to be added
define sssd::domain::append_array (
  String[1] $domain,
  String[1] $setting,
  Array[String[1], 1] $items,
) {
  $item_str = $items.sort.unique.join(',')
  ensure_resource( 'datacat_fragment', "sssd add items '${item_str}' to '${setting}' in domain '${domain}'", {
      target => "sssd/domain/${domain}/${setting}",
      data   => { 'items' => $items },
  })
}
