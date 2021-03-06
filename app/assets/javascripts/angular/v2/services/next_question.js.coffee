App.factory 'NextQuestion', ['$resource', ($resource) ->
  $resource('/api/v2/projects/:project_id/instruments/:instrument_id/instrument_questions/:instrument_question_id/next_questions/:id',
    {project_id: '@project_id', instrument_id: '@instrument_id', instrument_question_id: '@instrument_question_id', id: '@id'},
    {update: {method: 'PUT'}}
  )
]
