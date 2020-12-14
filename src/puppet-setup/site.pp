
# Always include the baseline configuration settings
include baseline

lookup('modules').each |$modulename| {
  notice("--< ${baseline::fqdn}: ${baseline::scriptprefix}/${modulename}  >--------------------------------------------")
  include $modulename
}