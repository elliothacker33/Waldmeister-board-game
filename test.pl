% Base case: An empty list has no values to collect.
collect_values([], []).

% Recursive case: Process the first list in the input list.
collect_values([List | RestLists], Values) :-
    % Collect values from the first list and append them to the result.
    append_values_from_list(List, NewValues),

    % Recursively process the rest of the lists.
    collect_values(RestLists, RestValues),

    % Append the values from the first list to the values from the rest of the lists.
    append(NewValues, RestValues, Values).

% Base case: An empty list has no values to append.
append_values_from_list([], []).

% Recursive case: Process the first element in the list.
append_values_from_list([Value | RestList], NewValues) :-
    % Check if the value is different than -1.
    (Value =\= -1 -> NewValues = [ | RestNewValues]; NewValues = RestNewValues),

    % Recursively process the rest of the list.
    append_values_from_list(RestList, RestNewValues).
