## 0.2.0 - December 25, 2013

### Improvements

* Add support to Rails 4
* Use the gem `railties` instead of `rails`

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
