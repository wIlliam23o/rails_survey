App.controller 'InstrumentTranslationsCtrl', ['$scope', '$stateParams', 'Setting',
'InstrumentTranslation', 'Instrument', ($scope, $stateParams, Setting,
InstrumentTranslation, Instrument) ->

  $scope.showInstrumentTranslations = true
  $scope.project_id = $stateParams.project_id
  $scope.instrumentTranslations = InstrumentTranslation.query({
      'project_id': $stateParams.project_id,
      'instrument_id': $stateParams.instrument_id
  })
  $scope.settings = Setting.get({}, ->
    $scope.languages = $scope.settings.languages
  )
  $scope.instrument = Instrument.get({
      'project_id': $stateParams.project_id,
      'id': $stateParams.instrument_id
  })

  $scope.languageName = (code) ->
    lang = ""
    angular.forEach $scope.languages, (language, index) ->
      if language[1] == code
        lang = language[0]
    lang

  $scope.newInstrumentTranslation = () ->
    $scope.showInstrumentTranslations = false
    $scope.instrumentTranslation = new InstrumentTranslation()

  $scope.saveInstrumentTranslation = (instrumentTranslation) ->
    instrumentTranslation.project_id = $stateParams.project_id
    instrumentTranslation.instrument_id = $stateParams.instrument_id
    if instrumentTranslation.id
      instrumentTranslation.$update({},
        (data, headers) ->
          $scope.showInstrumentTranslations = true
          updated = _.findWhere($scope.instrumentTranslations, {id: data.id})
          updated = data
        (result, headers) ->
          alert(result.data.errors)
      )
    else
      instrumentTranslation.$save({},
        (data, headers) ->
          $scope.showInstrumentTranslations = true
          $scope.instrumentTranslations.push(data)
        (result, headers) ->
          alert(result.data.errors)
      )

  $scope.deleteInstrumentTranslation = (translation) ->
    translation.project_id = $stateParams.project_id
    translation.instrument_id = $stateParams.instrument_id
    if confirm('Are you sure you want to delete ' + translation.title + '?')
      if translation.id
        translation.$delete({} ,
          (data, headers) ->
            index = $scope.instrumentTranslations.indexOf(translation)
            $scope.instrumentTranslations.splice(index, 1)
          (result, headers) ->
            alert(result.data.errors)
        )

]

App.controller 'SectionTranslationsCtrl', ['$scope', '$stateParams', 'Setting', 'SectionTranslation',
'Section', ($scope, $stateParams, Setting, SectionTranslation, Section) ->
  $scope.sections = Section.query({
    'project_id': $stateParams.project_id,
    'instrument_id': $stateParams.instrument_id
  })

  $scope.settings = Setting.get({}, ->
    $scope.languages = $scope.settings.languages
  )

  $scope.sectionTranslations = SectionTranslation.query({
    'project_id': $stateParams.project_id,
    'instrument_id': $stateParams.instrument_id
  })

  $scope.translationFor = (section) ->
    sectionTranslation = _.findWhere($scope.sectionTranslations, {
      section_id: section.id, language: $scope.language
    })
    if sectionTranslation == undefined
      sectionTranslation = new SectionTranslation()
      sectionTranslation.language = $scope.language
      sectionTranslation.section_id = section.id
      sectionTranslation.text = ""
      if $scope.language != undefined
        $scope.sectionTranslations.push(sectionTranslation)
    sectionTranslation

  $scope.saveTranslations = () ->
    sectionTranslation = new SectionTranslation()
    sectionTranslation.project_id = $stateParams.project_id
    sectionTranslation.instrument_id = $stateParams.instrument_id
    sectionTranslation.section_translations = $scope.sectionTranslations
    sectionTranslation.$batch_update({},
      (data, headers) ->
      (result, headers) ->
        alert(result.data.errors)
    )

]

App.controller 'DisplayTranslationsCtrl', ['$scope', '$stateParams', 'Setting', 'DisplayTranslation',
'Display', ($scope, $stateParams, Setting, DisplayTranslation, Display) ->
  $scope.displays = Display.query({
    'project_id': $stateParams.project_id,
    'instrument_id': $stateParams.instrument_id
  })

  $scope.settings = Setting.get({}, ->
    $scope.languages = $scope.settings.languages
  )

  $scope.displayTranslations = DisplayTranslation.query({
    'project_id': $stateParams.project_id,
    'instrument_id': $stateParams.instrument_id
  })

  $scope.translationFor = (display) ->
    displayTranslation = _.findWhere($scope.displayTranslations, {
      display_id: display.id, language: $scope.language
    })
    if displayTranslation == undefined
      displayTranslation = new DisplayTranslation()
      displayTranslation.language = $scope.language
      displayTranslation.display_id = display.id
      displayTranslation.text = ""
      if $scope.language != undefined
        $scope.displayTranslations.push(displayTranslation)
    displayTranslation

  $scope.saveTranslations = () ->
    displayTranslation = new DisplayTranslation()
    displayTranslation.project_id = $stateParams.project_id
    displayTranslation.instrument_id = $stateParams.instrument_id
    displayTranslation.display_translations = $scope.displayTranslations
    displayTranslation.$batch_update({},
      (data, headers) ->
      (result, headers) ->
        alert(result.data.errors)
    )

]

App.controller 'ShowInstrumentTranslationsCtrl', ['$scope', '$stateParams', 'InstrumentTranslation',
'Instrument', 'InstrumentQuestion', 'QuestionTranslation', 'QuestionBackTranslation', 'Options',
'OptionInOptionSet', 'OptionTranslation', 'OptionBackTranslation'
($scope, $stateParams, InstrumentTranslation, Instrument, InstrumentQuestion, QuestionTranslation,
QuestionBackTranslation, Options, OptionInOptionSet, OptionTranslation, OptionBackTranslation) ->
  $scope.project_id = $stateParams.project_id
  $scope.instrument_id = $stateParams.instrument_id
  $scope.questionBackTranslations = []
  $scope.instrumentQuestions = []
  $scope.questionTranslations = []

  $scope.instrument = Instrument.get({
      'project_id': $stateParams.project_id,
      'id': $stateParams.instrument_id
  }, ->
    $scope.instrumentQuestions = InstrumentQuestion.query({
      'project_id': $scope.project_id,
      'instrument_id': $scope.instrument_id
    })
  )
  $scope.instrumentTranslation = InstrumentTranslation.get({
    'project_id': $stateParams.project_id,
    'instrument_id': $stateParams.instrument_id,
    'id': $stateParams.id
  }, ->
    $scope.language = $scope.instrumentTranslation.language
    $scope.questionBackTranslations = QuestionBackTranslation.query({
      'language': $scope.language,
      'instrument_id': $scope.instrument_id
    })
    $scope.questionTranslations = QuestionTranslation.query({
      'language': $scope.language,
      'instrument_id': $scope.instrument_id
    })
    $scope.options = Options.query({'instrument_id': $scope.instrument_id})
    $scope.optionInOptionSets = OptionInOptionSet.query({
      'instrument_id': $scope.instrument_id
    })
    $scope.optionTranslations = OptionTranslation.query({
      'language': $scope.language,
      'instrument_id': $stateParams.instrument_id
    })
    $scope.optionBackTranslations = OptionBackTranslation.query({
      'language': $scope.language,
      'instrument_id': $scope.instrument_id
    })
  )

  $scope.optionBackTranslationFor = (optionTranslationId) ->
    _.findWhere($scope.optionBackTranslations, { backtranslatable_id: optionTranslationId })

  $scope.optionTranslationFor = (option) ->
    _.findWhere($scope.optionTranslations, { option_id: option.id})

  $scope.questionOptionInOptionSets = (optionSetId) ->
    _.where($scope.optionInOptionSets, { option_set_id: optionSetId})

  $scope.getOption = (optionId) ->
    _.findWhere($scope.options, {id: optionId})

  $scope.translationFor = (instrumentQuestion) ->
    _.findWhere($scope.questionTranslations, {question_id: instrumentQuestion.question_id})

  $scope.backTranslationFor = (instrumentQuestion) ->
    questionTranslation = $scope.translationFor(instrumentQuestion)
    if questionTranslation != undefined
      _.findWhere($scope.questionBackTranslations, { language: questionTranslation.language,
      backtranslatable_id: questionTranslation.id, backtranslatable_type: 'QuestionTranslation' })

]
