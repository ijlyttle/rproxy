# rproxy 0.0.0 (development)

* Added functions `local_proxy_for_url()`, `with_proxy_for_url()`, and `without_proxy()` to temporarily set the proxy variables. (#4)

* Added functions `uses_proxy()` and `get_proxy()` to determine if a proxy should be used, and what its value should be. (#3)

* Added functions `envvar_proxy()` and `envvar_no_proxy()` to return values for environment variables for proxy and no-proxy. (#1)

* Added a `NEWS.md` file to track changes to the package.
