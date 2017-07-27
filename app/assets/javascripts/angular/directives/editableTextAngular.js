angular.module('xeditable').directive('editableTextAngular', ['editableDirectiveFactory',
  function (editableDirectiveFactory) {
    return editableDirectiveFactory({
      directiveName: 'editableTextAngular',
      inputTpl: '<div text-angular></div>',
      addListeners: function () {
        var self = this;
        self.parent.addListeners.call(self);
        // submit textarea by ctrl+enter even with buttons
        if (self.single && self.buttons !== 'no') {
          self.autosubmit();
        }
      },
      autosubmit: function () {
        var self = this;
        self.inputEl.bind('keydown', function (e) {
          if ((e.ctrlKey || e.metaKey) && (e.keyCode === 13)) {
            self.scope.$apply(function () {
              self.scope.$form.$submit();
            });
          }
        });
      }
    });
  }]);