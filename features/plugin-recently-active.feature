Feature: List Recently Active WordPress plugins

  Scenario: Verify plugin installation, activation, deactivation and confirm listing recently active plugins list is correct
    Given a WP install
    When I run `wp plugin install bbpress buddypress query-monitor --activate`
    Then STDOUT should contain:
      """
      Activating 'bbpress'...
      """
    And STDOUT should contain:
      """
      Activating 'buddypress'...
      """
    And STDOUT should contain:
      """
      Activating 'query-monitor'...
      """

    When I run `wp plugin activate akismet`
    Then STDOUT should contain:
      """
      Plugin 'akismet' activated.
      """

    When I run `wp plugin deactivate bbpress buddypress`
    Then STDOUT should contain:
      """
      Plugin 'bbpress' deactivated.
      Plugin 'buddypress' deactivated.
      Success: Deactivated 2 of 2 plugins.
      """

    When I run `wp plugin list --recently-active --field=name --format=json`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      ["bbpress","buddypress"]
      """

  Scenario: Re confirm recently active list before and after deactivation
    Given a WP install
    When I run `wp plugin install bbpress buddypress --activate`
    Then STDOUT should contain:
      """
      Activating 'bbpress'...
      """
    And STDOUT should contain:
      """
      Activating 'buddypress'...
      """

    When I run `wp plugin list --recently-active --field=name --format=json`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      []
      """

    When I run `wp plugin deactivate bbpress buddypress`
    Then STDOUT should contain:
      """
      Plugin 'bbpress' deactivated.
      Plugin 'buddypress' deactivated.
      Success: Deactivated 2 of 2 plugins.
      """

    When I run `wp plugin list --recently-active --field=name --format=json`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      ["bbpress","buddypress"]
      """

  Scenario: Use recently active plugin to activate plugins
    Given a WP install
    When I run `wp plugin install bbpress buddypress --activate`
    Then STDOUT should contain:
      """
      Activating 'bbpress'...
      """
    And STDOUT should contain:
      """
      Activating 'buddypress'...
      """

    When I run `wp plugin deactivate bbpress buddypress`
    Then STDOUT should contain:
      """
      Plugin 'bbpress' deactivated.
      Plugin 'buddypress' deactivated.
      Success: Deactivated 2 of 2 plugins.
      """

    When I run `wp plugin activate $(wp plugin list --recently-active --field=name)`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      Plugin 'bbpress' activated.
      Plugin 'buddypress' activated.
      """