/* Autocomplete with bootstrap-typeahead */

$(function() {
	var labels
       , mapped
	$('input#search').typeahead({
		source: function (query, process) {
		 $.getJSON(
				$('input#search').data("source"),
				{ name: query },
				function (data) {
					var users = [];
					map = {};
					$.each(data, function (i, user) {
						map[user.name] = user;
						users.push(user.name);
                    });
					return process(users);
				});
		},
		matcher: function (item) { 
			if (item.toLowerCase().indexOf(this.query.trim().toLowerCase()) != -1) {
				return true;
			}
		},
		sorter: function (items) {
			return items.sort();
		},
		highlighter: function (item) {
			var regex = new RegExp( '(' + this.query + ')', 'gi' );
			return item.replace( regex, "<strong>$1</strong>" );
		},
		updater: function (item) {
			window.location = window.location.origin + "/users/" + encodeURIComponent(map[item].id);
			return item;
		},
	});
});