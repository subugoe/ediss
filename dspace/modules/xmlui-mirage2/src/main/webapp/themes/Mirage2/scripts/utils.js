/*
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
(function($) {
    DSpace.getTemplate = function(name) {
        if (DSpace.dev_mode || DSpace.templates === undefined || DSpace.templates[name] === undefined) {
            $.ajax({
                url : DSpace.theme_path + 'templates/' + name + '.hbs',
                success : function(data) {
                    if (DSpace.templates === undefined) {
                        DSpace.templates = {};
                    }
                    DSpace.templates[name] = Handlebars.compile(data);
                },
                async : false
            });
        }
        return DSpace.templates[name];
    };
		$(document).ready(function(){
				if ($('#aspect_submission_StepTransformer_field_file').length) {
						$('#aspect_submission_StepTransformer_field_file').removeAttr('title');
					
						if (!$('#aspect_submission_StepTransformer_table_submit-upload-summary a:contains(".html")').length) {

                $("#aspect_submission_StepTransformer_table_submit-upload-summary th:first-child").hide();
                $("#aspect_submission_StepTransformer_table_submit-upload-summary td:first-child").hide();
            }

				}
			 
		});

	$('.bookmark').click(function (e) {
    e.stopPropagation();
    var t = $(this).width();
    $(this).hide().after('<input class="bookmark-input" type="text" value="' + $(this).text() + '" />'),
    $('.bookmark-input').width(t + 2).select(),
    $('body').click(function () {
      $('.bookmark-input').remove(),
      $('.bookmark').show(),
      $('body').unbind('click')
    })
  });
})(jQuery);
