App.factory 'InstrumentTranslation', ['$resource', ($resource) ->
  $resource('/api/v1/frontend/projects/:project_id/instruments/:instrument_id/instrument_translations/:id',
    {project_id: '@project_id', instrument_id: '@instrument_id', id: '@id'},
    {update: {method: 'PUT'}}
  )
]