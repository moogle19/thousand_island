# Changelog for v0.5

## [0.5.3] - 2022-02-03

### Added

- [Socket] Support for `Socket.getopts/2` (see PR #11)

### Bug Fixes

- [Socket] Check result of SSL handshake (see PR #10)

## [0.5.2] - 2021-10-13

### Enhancements

- Documentation improvements

## [0.5.1] - 2021-10-12

### Enhancements

- Added code of conduct
- Documentation improvements

## [0.5.0] - 2021-10-12

### Breaking changes

- [Handler] `Handler` dropped `:ok` from the return tuple, e.g `{:ok, :continue, state}` becomes `{:continue, state}`