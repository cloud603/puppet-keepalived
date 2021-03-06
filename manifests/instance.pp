define keepalived::instance (
  $interface,
  $virtual_ips,
  $state,
  $priority,
  $track_script      = [],
  $notify            = undef,
  $notify_master     = undef,
  $notify_backup     = undef,
  $notify_fault      = undef,
  $smtp_alert        = false,
  $advert_int        = '1',
  $auth_type         = undef,
  $auth_pass         = undef,
  $virtual_router_id = $name,
) {

  include keepalived::variables

  concat::fragment { "keepalived_${name}":
    target  => $keepalived::variables::keepalived_conf,
    content => template( 'keepalived/keepalived_instance.erb' ),
    order   => '50',
    notify  => Class[ 'keepalived::service' ],
    require => Class[ 'keepalived::install' ],
  }
}
