module.exports = {
  extends: ['stylelint-config-standard', 'stylelint-config-recess-order'],
  rules: {
    'selector-class-pattern': null,
    'no-empty-source': [true, { severity: 'warning' }],
    'comment-word-disallowed-list': [
      ['TODO', 'FIX'],
      {
        severity: process.env.NODE_ENV === 'production' ? 'error' : 'warning',
      },
    ],
  },
}
