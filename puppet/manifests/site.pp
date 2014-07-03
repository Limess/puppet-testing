#hiera_include('classes')

node 'test.example.com' { 
  include roles::test
}
