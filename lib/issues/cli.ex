defmodule Issues.CLI do
  @default_display_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions that end up generating a table of the last _n_ issues in a github project.
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  'argv' can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally) the number of entries to format.

  Return a tuple of '{ user_name, project_name, display_count }', or ':help' if help was given.
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases:  [ h:    :help    ])
    case parse do
    { [ help: true ], _, _ }
      -> :help

    { _, [ user_name, project_name, display_count ], _ }
      -> { user_name, project_name, String.to_integer(display_count) }

    { _, [ user_name, project_name ], _ }
      -> { user_name, project_name, @default_display_count }

    _ -> :help
    end
  end
end
