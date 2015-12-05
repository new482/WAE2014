# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
$ ->
  $('#srch-term').tokenInput '/application/courses.json',
    tokenLimit: 1,
    theme: 'facebook'
