App.factory 'Instrument', ['$resource', ($resource) ->
  $resource '/api/v2/projects/:project_id/instruments/:id/:memberRoute',
  { project_id: '@project_id', id: '@id', memberRoute: '@memberRoute' },
  { update: { method: 'PUT' },
  copy: {method: 'GET', params: {memberRoute: 'copy'}},
  tabulate: {method: 'GET', params: {memberRoute: 'tabulate'}},
  reorder: {method: 'POST', params: {memberRoute: 'reorder'}},
  importSkipPatterns: {method: 'GET', params: {memberRoute: 'set_skip_patterns'}},
  reorderDisplays: {method: 'POST', params: {memberRoute: 'reorder_displays'}},
  to_pdf: {method: 'POST', params: {memberRoute: 'to_pdf'}, responseType: 'arraybuffer',
  transformResponse: (data, headers) ->
    data = new Blob([data], {type: 'application/pdf'})
    return { response : data }
  }
  }
]
