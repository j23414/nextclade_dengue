#! /usr/bin/env nextflow

nextflow.enable.dsl=2

process foo {
  input:
  val x from 1..10

  output:
  file "foo.txt" into foo_ch

  """
  echo "foo $x" > foo.txt
  """
}

workflow {
  foo_ch.view()
}
```