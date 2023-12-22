Feature: List Recently Active WordPress plugins

  @require-php-7.0 @require-wp-5.0
  Scenario: Verify plugin installation, activation, deactivation and confirm listing recently active plugins list is correct
    Given a WP install
    When I run `wp plugin install bbpress buddypress gutenberg --activate`
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
      Activating 'gutenberg'...
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

  @require-wp-5.0
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

  @require-wp-5.0
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

  @require-php-7.0 @require-wp-5.0
  Scenario: For a MU site, verify plugin installation, activation, deactivation and confirm listing recently active plugins list is correct
    Given a WP multisite install
    When I run `wp plugin install bbpress buddypress gutenberg --activate-network`
    Then STDOUT should contain:
      """
      Network-activating 'bbpress'...
      """
    And STDOUT should contain:
      """
      Network-activating 'buddypress'...
      """
    And STDOUT should contain:
      """
      Network-activating 'gutenberg'...
      """

    When I run `wp plugin activate akismet --network`
    Then STDOUT should contain:
      """
      Plugin 'akismet' network activated.
      """

    When I run `wp plugin deactivate bbpress buddypress --network`
    Then STDOUT should contain:
      """
      Plugin 'bbpress' network deactivated.
      Plugin 'buddypress' network deactivated.
      Success: Network deactivated 2 of 2 plugins.
      """

    When I run `wp plugin list --recently-active --field=name --format=json`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      ["bbpress","buddypress"]
      """

  @require-wp-5.0
  Scenario: For a MU site, re-confirm recently active list before and after deactivation
    Given a WP install
    When I run `wp plugin install bbpress buddypress --activate-network`
    Then STDOUT should contain:
      """
      Network-activating 'bbpress'...
      """
    And STDOUT should contain:
      """
      Network-activating 'buddypress'...
      """

    When I run `wp plugin list --recently-active --field=name --format=json`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      []
      """

    When I run `wp plugin deactivate bbpress buddypress --network`
    Then STDOUT should contain:
      """
      Plugin 'bbpress' network deactivated.
      Plugin 'buddypress' network deactivated.
      Success: Network deactivated 2 of 2 plugins.
      """

    When I run `wp plugin list --recently-active --field=name --format=json`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      ["bbpress","buddypress"]
      """

  @require-wp-5.0
  Scenario: For a MU site, use recently active plugin to activate plugins
    Given a WP install
    When I run `wp plugin install bbpress buddypress --activate-network`
    Then STDOUT should contain:
      """
      Network-activating 'bbpress'...
      """
    And STDOUT should contain:
      """
      Network-activating 'buddypress'...
      """

    When I run `wp plugin deactivate bbpress buddypress`
    Then STDOUT should contain:
      """
      Plugin 'bbpress' network deactivated.
      Plugin 'buddypress' network deactivated.
      Success: Network deactivated 2 of 2 plugins.
      """

    When I run `wp plugin activate $(wp plugin list --recently-active --field=name) --network`
    Then STDOUT should not be empty
    And STDOUT should contain:
      """
      Plugin 'bbpress' network deactivated.
      Plugin 'buddypress' network deactivated.
      """