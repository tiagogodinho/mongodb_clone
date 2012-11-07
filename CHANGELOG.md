## Next Release

### Improvements

* Drop database before restore

* Accept symbol in dump and restore.

``` ruby
dump(:staging).restore(:development, :backup)
```

## 0.0.1 - October 31, 2012

Initial release.
