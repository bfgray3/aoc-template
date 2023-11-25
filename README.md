## overview

the image and tests support the following languages:

* Bash
* C++
* Go
* Python
* R

## usage

1. build the image for testing with `make build`.
2. write solutions in files named `<dd>/{a,b}/main.{sh,cpp,go,py,R}`.
    1. starter files can be created using `starter.go`. usage is below.
    2. each program/script should output the answer (and only the answer) to stdout.
    3. each program/script should expect exactly one command line argument, which is the file containing the input data.
    4. these are available in the running container via a volume, so the image does not need to be rebuilt after writing a new solution.
3. test all solutions for a given day/part with `make test path=<dd>/{a,b}/`, e.g. `make test path=05/a/`.
4. once there is a correct solution for a given day/part, add it to [answers.json](answers.json) in a format like the following:

```json
{
  "ans01": {"a": "foo", "b": "bar"},
  "ans02": {"a": "123"}
}
```

### notes
* test all solutions in the above languages for all days/parts with `make test`.
* clean up the repo, build the image, and test all solutions with `make all`.
* `starter.go` usage:
```
  -day uint
        day {1,...,25} (default 1)
  -lang string
        language {cpp,go,R,py,sh} (default "cpp")
  -part string
        part {a,b} (default "a")
```
