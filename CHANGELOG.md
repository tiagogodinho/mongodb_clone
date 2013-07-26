## 0.1.1 - July 26, 2013

### Bug fixes

* Escape the strings

## 0.1.0 - November 07, 2012

### Improvements

* Drop database before restore

* Accept symbol in dump and restore.

``` ruby
dump(:staging).restore(:development, :backup)
```

## 0.0.1 - October 31, 2012

Initial release.
