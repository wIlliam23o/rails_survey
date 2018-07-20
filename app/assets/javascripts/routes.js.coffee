App.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', '$httpProvider',
($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->

  $locationProvider.html5Mode
    enabled: true
    requireBase: false

  $stateProvider
    .state '/',
      url: '/'
      templateUrl: 'projects/home.html'
    .state 'projects',
      url: '/projects'
      templateUrl: 'projects/index.html'
      controller: 'ProjectsCtrl'
    .state 'project',
      url: '/projects/:id'
      templateUrl: 'projects/show.html'
      controller: 'ShowProjectCtrl'
    .state 'importInstrument',
      url: '/projects/:id'
      templateUrl: 'projects/import_instrument.html'
      controller: 'ImportInstrumentCtrl'
    .state 'instrument',
      url: '/projects/:project_id/instruments/:id'
      templateUrl: 'instruments/show.html'
      controller: 'ShowInstrumentCtrl'
    .state 'instrumentQuestionsReorder',
      url: '/projects/:project_id/instruments/:id'
      templateUrl: 'instruments/reorder.html'
      controller: 'ReorderInstrumentQuestionsCtrl'
    .state 'copyInstrument',
      url: '/projects/:project_id/instruments/:id'
      templateUrl: 'instruments/copy.html'
      controller: 'CopyInstrumentCtrl'
    .state 'instrumentSkipPatterns',
      url: '/projects/:project_id/instruments/:id'
      templateUrl: 'instruments/skip_patterns.html'
      controller: 'InstrumentSkipPatternsCtrl'
    .state 'questionSets',
      url: '/question_sets'
      templateUrl: 'question_sets/index.html'
      controller: 'QuestionSetsCtrl'
    .state 'questionSet',
      url: '/question_sets/:id'
      templateUrl: 'question_sets/show.html'
      controller: 'ShowQuestionSetCtrl'
    .state 'questionSetQuestion',
      url: '/question_sets/:question_set_id/questions/:id'
      templateUrl: 'questions/show.html'
      controller: 'ShowQuestionCtrl'
    .state 'questionSetNewQuestion',
      url: '/question_sets/:question_set_id/questions/new'
      templateUrl: 'questions/show.html'
      controller: 'ShowQuestionCtrl'
    .state 'optionSets',
      url: '/option_sets'
      templateUrl: 'option_sets/index.html'
      controller: 'OptionSetsCtrl'
    .state 'optionSet',
      url: '/option_sets/:id'
      templateUrl: 'option_sets/show.html'
      controller: 'ShowOptionSetCtrl'
    .state 'instructions',
      url: '/instructions'
      templateUrl: 'instructions/index.html'
      controller: 'InstructionsCtrl'
    .state 'instruction',
      url: '/instructions/:id'
      templateUrl: 'instructions/show.html'
      controller: 'ShowInstructionCtrl'
    .state 'validations',
      url: '/validations'
      templateUrl: 'validations/index.html'
      controller: 'ValidationsCtrl'
    .state 'validation',
      url: '/validations/:id'
      templateUrl: 'validations/show.html'
      controller: 'ShowValidationCtrl'
    .state 'displays',
      url: '/projects/:project_id/instruments/:instrument_id/displays'
      templateUrl: 'displays/index.html'
      controller: 'DisplaysCtrl'
    .state 'newDisplay',
      url: '/projects/:project_id/instruments/:instrument_id/displays/new'
      templateUrl: 'displays/new.html'
      controller: 'NewDisplayCtrl'
    .state 'instrumentQuestion',
      url: '/projects/:project_id/instruments/:instrument_id/instrument_questions/:id'
      templateUrl: 'instrument_questions/show.html'
      controller: 'ShowInstrumentQuestionCtrl'
    .state 'optionTranslations',
      url: '/option_translations/?option_set_id&language'
      templateUrl: 'option_translations/show.html'
      controller: 'OptionTranslationsCtrl'
    .state 'questionTranslations',
      url: '/question_translations/?language&instrument_id&question_set_id&question_id'
      templateUrl: 'question_translations/show.html'
      controller: 'QuestionTranslationsCtrl'
    .state 'instructionTranslations',
      url: '/instruction_translations/?language&instruction_id'
      templateUrl: 'instruction_translations/show.html'
      controller: 'InstructionTranslationsCtrl'
    .state 'validationTranslations',
      url: '/validation_translations/?language&validation_id'
      templateUrl: 'validation_translations/show.html'
      controller: 'ValidationTranslationsCtrl'
    .state 'instrumentTranslations',
      url: '/projects/:project_id/instruments/:instrument_id/instrument_translations'
      templateUrl: 'instrument_translations/index.html'
      controller: 'InstrumentTranslationsCtrl'
    .state 'rules',
      url: '/rules'
      templateUrl: 'rules/index.html'
      controller: 'RulesCtrl'
    .state 'instrumentRules',
      url: '/projects/:project_id/instruments/:instrument_id/instrument_rules'
      templateUrl: 'instrument_rules/index.html'
      controller: 'InstrumentRulesCtrl'
    .state 'display',
      url: '/projects/:project_id/instruments/:instrument_id/displays/:id'
      templateUrl: 'displays/show.html'
      controller: 'ShowDisplayCtrl'
    .state 'options',
      url: '/options'
      templateUrl: 'options/index.html'
      controller: 'OptionsCtrl'

  $httpProvider.interceptors.push('HttpResponseInterceptor')

])
