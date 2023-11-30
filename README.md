## overview

the image and tests support the following languages:

* Bash
* C++
* Go
* Python
* R

## usage

1. build the image and other tooling with `make setup`. if new python dependencies are ever needed, add them to [requirements.txt](requirements.txt) and rerun `make setup`.
2. input data should be in `<dd>/input.txt`.
3. write solutions in files named `<dd>/{a,b}/main.{sh,cpp,go,py,R}`.
    1. starter files can be created using `./starter`. usage is below.
    2. each program/script should output the answer (and only the answer) followed by a newline to stdout. do not include quotes if the answer is a string.
    3. each program/script should expect exactly one command line argument: the file containing the input data.
    4. these source files are available in the running container via a volume, so the image does not need to be rebuilt after writing a new solution.
4. see your answer from each language for a given day/part with `make solve path=<dd>/{a,b}/`, e.g. `make solve path=05/a/`.
5. test all solutions for a given day/part with `make test path=<dd>/{a,b}/`, e.g. `make test path=05/a/`.
6. once there is a correct solution for a given day/part, add it to [answers.json](answers.json) in a format like the following:

```json
{
  "ans01": {"a": "foo", "b": "bar"},
  "ans02": {"a": "123"}
}
```

### notes
* the solutions run in docker, but some of the tooling has requirements for what is installed in the system.
* test all solutions in the above languages for all days/parts with `make test`.
* clean up the repo, build the image, and test all solutions with `make all`.
* `./starter` usage:
```
  -day uint
        day {1,...,25} (default 1)
  -lang string
        language {cpp,go,R,py,sh} (default "cpp")
  -part string
        part {a,b} (default "a")
```

## original development

the beginning of this functionality was developed in [this repository](https://github.com/bfgray3/aoc22/).
