Slim::Engine.set_default_options(shortcut: {
  '#' => {attr: 'id'},
  '.' => {attr: 'class'},
  '&' => {tag: 'input', attr: 'type'},
  '$$' => {attr: 'ng-controller'},
  '$' => {attr: 'ng-model'}
})
