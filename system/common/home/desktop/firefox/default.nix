{
  pkgs,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [nur.repos.rycee.mozilla-addons-to-nix];
    sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };

  programs.firefox = {
    enable = true;
    profiles = {
      nyx = {
        name = "nyx";
        id = 777; # TODO: wtf is this?
        isDefault = true;
        search = {
          force = true;
          default = "Brave";
          engines = {
            "WikiWand" = {
              urls = [
                {
                  template = "https://www.wikiwand.com/en/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
            "Brave" = {
              urls = [
                {
                  template = " https://search.brave.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "Home Manager Options" = {
              urls = [
                {
                  template = "https://mipmip.github.io/home-manager-option-search/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hmo"];
            };

            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };

            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://nixos.wiki/index.php?search={searchTerms}";
                }
              ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@nw"];
            };

            "Wikipedia (en)".metaData.alias = "@wiki";
            "Google".metaData.hidden = true;
          };
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          clearurls
          copy-selected-links
          copy-selection-as-markdown
          decentraleyes
          enhanced-github
          floccus
          hover-zoom-plus
          image-search-options
          localcdn
          sidebery
          ublock-origin
          user-agent-string-switcher
        ];

        /*
        settings = {
          # Disable Telemetry (https://support.mozilla.org/kb/share-telemetry-data-mozilla-help-improve-firefox) sends data about the performance and responsiveness of Firefox to Mozilla.
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.cachedClientID" = "";
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          # Disable health report - Disable sending Firefox health reports(https://www.mozilla.org/privacy/firefox/#health-report) to Mozilla.
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          # Disable shield studies (https://wiki.mozilla.org/Firefox/Shield) is a feature which allows mozilla to remotely install experimental addons.
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "app.shield.optoutstudies.enabled" = false;
          "extensions.shield-recipe-client.enabled" = false;
          "extensions.shield-recipe-client.api_url" = "";
          # Disable experiments (https://wiki.mozilla.org/Telemetry/Experiments) allows automatically download and run specially-designed restartless addons based on certain conditions.
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "experiments.supported" = false;
          "experiments.activeExperiment" = false;
          "network.allow-experiments" = false;
          # Disable Crash Reports (https://www.mozilla.org/privacy/firefox/#crash-reporter) as it may contain data that identifies you or is otherwise sensitive to you.
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.enabled" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "extensions.getAddons.cache.enabled" = false; # Opt out metadata updates about installed addons as metadata updates (https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/), so Mozilla is able to recommend you other addons.
          # Disable google safebrowsing - Detect phishing and malware but it also sends informations to google together with an unique id called wrkey (http://electroholiker.de/?p=1594).
          "browser.safebrowsing.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.appRepURL" = "";
          "browser.safebrowsing.malware.enabled" = false; # Disable malware scan -  sends an unique identifier for each downloaded file to Google.
          "network.trr.mode" = 5; # Disable DNS over HTTPS  aka. Trusted Recursive Resolver (TRR)
          "browser.newtab.preload" = false; # Disable preloading of the new tab page. By default Firefox preloads the new tab page (with website thumbnails) in the background before it is even opened.
          "extensions.getAddons.showPane" = false; # Disable about:addons' Get Add-ons panel  The start page with recommended addons uses google analytics.
          "extensions.webservice.discoverURL" = ""; # Disable about:addons' Get Add-ons panel  The start page with recommended addons uses google analytics.
          "network.captive-portal-service.enabled" = false; # Disable check for captive portal. By default, Firefox checks for the presence of a captive portal on every startup.  This involves traffic to Akamai. (https://support.mozilla.org/questions/1169302).
          "media.eme.enabled" = true; # Disables playback of DRM-controlled HTML5 content otherwise automatically downloads the Widevine Content Decryption Module provided by Google Inc.
          "media.gmp-widevinecdm.enabled" = true; # Disables the Widevine Content Decryption Module provided by Google Inc. Used for the playback of DRM-controlled HTML5 content Details (https://support.mozilla.org/en-US/kb/enable-drm#w_disable-the-google-widevine-cdm-without-uninstalling)
          "device.sensors.ambientLight.enabled" = false; # Disable access to device sensor data - Disallow websites to access sensor data (ambient light, motion, device orientation and proximity data).
          "device.sensors.enabled" = false; # Disable access to device sensor data - Disallow websites to access sensor data (ambient light, motion, device orientation and proximity data).
          "device.sensors.motion.enabled" = false; # Disable access to device sensor data - Disallow websites to access sensor data (ambient light, motion, device orientation and proximity data).
          "device.sensors.orientation.enabled" = false; # Disable access to device sensor data - Disallow websites to access sensor data (ambient light, motion, device orientation and proximity data).
          "device.sensors.proximity.enabled" = false; # Disable access to device sensor data - Disallow websites to access sensor data (ambient light, motion, device orientation and proximity data).
          "browser.urlbar.groupLabels.enabled" = false; # Disable Firefox Suggest(https://support.mozilla.org/en-US/kb/navigate-web-faster-firefox-suggest) feature allows Mozilla to provide search suggestions in the US, which uses your city location and search keywords to send suggestions. This is also used to serve advertisements.
          "browser.urlbar.quicksuggest.enabled" = false; # Disable Firefox Suggest(https://support.mozilla.org/en-US/kb/navigate-web-faster-firefox-suggest) feature allows Mozilla to provide search suggestions in the US, which uses your city location and search keywords to send suggestions. This is also used to serve advertisements.
          "pdfjs.enableScripting" = true; # Disable Javascript in PDF viewer - It is possible that some PDFs are not rendered correctly due to missing functions.

          ## Privacy
          "browser.cache.offline.enable" = false; # Disable the Offline Cache.
          "browser.fixup.alternate.enabled" = false; # Disable Fixup URLs
          "browser.search.suggest.enabled" = false; # Disable Search Suggestions
          "browser.sessionstore.privacy_level" = 2; # Sessionstore Privacy
          "browser.urlbar.speculativeConnect.enabled" = false; # Disable speculative website loading.
          "dom.event.clipboardevents.enabled" = true; # Disable the clipboardevents.
          "dom.indexedDB.enabled" = true; # Enable IndexedDB (disabling breaks things)
          "dom.private-attribution.submission.enabled" = false; # Disable Advertiser Attribution
          "dom.storage.enabled" = true; # Disable DOM storage
          "keyword.enabled" = true; # Disable Search Keyword
          "media.peerconnection.enabled" = true; # Disable WebRTC
          "network.cookie.cookieBehavior" = 1; # Block 3rd-Party cookies or even all cookies. 0 Default 1 Originating Server 2 None 3 Third only if site already has stored
          "network.dns.disablePrefetch" = true; # Disable Link Prefetching
          "network.dns.disablePrefetchFromHTTPS" = true; # Disable Link Prefetching
          "network.http.referer.spoofSource" = false; # Block Referer - This breaks Google Docs if true
          "network.http.speculative-parallel-limit" = 0; # Disable speculative website loading.
          "network.predictor.enable-prefetch" = false; # Disable Link Prefetching
          "network.predictor.enabled" = false; # Disable Link Prefetching
          "network.prefetch-next" = false; # Disable Link Prefetching
          "privacy.usercontext.about_newtab_segregation.enabled" = true; # Use a private container for new tab page thumbnails
          "webgl.disabled" = false; # WebGL is part of some fingerprinting scripts used in the wild. Some interactive websites will not work, which are mostly games.
          "webgl.renderer-string-override" = " "; # Override graphics card vendor and model strings in the WebGL API
          "webgl.vendor-string-override" = " "; # Override graphics card vendor and model strings in the WebGL API

          ## Security
          "app.update.auto" = true; # Disable automatic updates.
          "browser.aboutConfig.showWarning" = false; # Disable about:config warning.
          "browser.disableResetPrompt" = true; # Disable reset prompt.
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # Disable Pocket
          "browser.newtabpage.enhanced" = false; # Content of the new tab page
          "browser.newtabpage.introShown" = false; # Disable the intro to the newtab page on the first run
          "browser.selfsupport.url" = ""; # Disable Heartbeat Userrating
          "browser.shell.checkDefaultBrowser" = false; # Disable checking if Firefox is the default browser
          "browser.startup.homepage_override.mstone" = "ignore"; # Disable the first run tabs with advertisements for the latest firefox features.
          "browser.urlbar.trimURLs" = false; # Do not trim URLs in navigation bar
          "dom.security.https_only_mode" = true; # Enable HTTPS only mode
          "dom.security.https_only_mode_ever_enabled" = true; # Enable HTTPS only mode
          "extensions.blocklist.enabled" = false; # Disable extension blocklist from mozilla.
          "extensions.pocket.enabled" = false; # Disable Pocket
          "media.autoplay.default" = 0; # Disable autoplay of video tags.
          "media.autoplay.enabled" = true; # Disable autoplay of video tags.
          "network.IDN_show_punycode" = true; # Show Punycode.
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false; # Disable Sponsored Top Sites

          ## Extra Settings
          "browser.cache.disk.enable" = false;
          "browser.compactmode.show" = true;
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.engagement.ctrlTab.has-used" = true;
          "browser.engagement.downloads-button.has-used" = true;
          "browser.engagement.fxa-toolbar-menu-button.has-used" = true;
          "browser.engagement.library-button.has-used" = true;
          "browser.formfill.enable" = false;
          "browser.tabs.closeTabByDblclick" = true;
          "browser.tabs.insertAfterCurrent" = true;
          "browser.tabs.loadBookmarksInTabs" = true;
          "browser.tabs.tabmanager.enabled" = false; # Tab
          "browser.tabs.warnOnClose" = false;
          "browser.toolbars.bookmarks.visibility" = "always";
          "browser.uitour.enabled" = false;
          "browser.urlbar.clickSelectsAll" = true;
          "browser.urlbar.suggest.quickactions" = false; # URL Suggestions
          "browser.urlbar.suggest.topsites" = false; # URL Suggestions
          "devtools.everOpened" = true;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
          "extensions.screenshots.disabled" = true;
          "font.internaluseonly.changed" = false; # Fonts
          "font.name.monospace.x-western" = "Droid Sans Mono"; # Fonts
          "font.name.sans-serif.x-western" = "Noto Sans"; # Fonts
          "font.name.serif.x-western" = "Noto Sans"; # Fonts
          "font.size.fixed.x-western" = "11"; # Fonts
          "font.size.variable.x-western" = "15"; # Fonts
          "general.smoothScroll" = true; # enable smooth scrolling
          "gfx.webrender.all" = true; # Force using WebRender. Improve performance
          "gfx.webrender.enabled" = true; # Force using WebRender. Improve performance
          "media.ffmpeg.vaapi.enabled" = true; # https://wiki.archlinux.org/title/firefox#Hardware_video_acceleration
          "media.ffvpx.enabled" = false; # https://wiki.archlinux.org/title/firefox#Hardware_video_acceleration
          "media.videocontrols.picture-in-picture.allow-multiple" = true; # Enable multi-pip
          "pref.general.disable_button.default_browser" = false;
          "pref.privacy.disable_button.cookie_exceptions" = false;
          "pref.privacy.disable_button.tracking_protection_exceptions" = false;
          "pref.privacy.disable_button.view_passwords" = false;
          "print.more-settings.open" = true;
          "privacy.clearOnShutdown.cache" = false; # Privacy
          "privacy.clearOnShutdown.cookies" = false; # Privacy
          "privacy.clearOnShutdown.downloads" = false; # Privacy
          "privacy.clearOnShutdown.formdata" = false; # Privacy
          "privacy.clearOnShutdown.history" = false; # Privacy
          "privacy.clearOnShutdown.sessions" = false; # Privacy
          "privacy.cpd.cache" = false; # Privacy
          "privacy.cpd.cookies" = false; # Privacy
          "privacy.cpd.downloads" = false; # Privacy
          "privacy.cpd.formdata" = false; # Privacy
          "privacy.cpd.history" = false; # Privacy
          "privacy.cpd.offlineApps" = true; # Privacy
          "privacy.cpd.sessions" = false; # Privacy
          "privacy.donottrackheader.enabled" = true; # Privacy
          "privacy.history.custom" = true; # Privacy
          "privacy.partition.network_state.ocsp_cache" = true; # Privacy
          "privacy.trackingprotection.enabled" = true; # Privacy
          "privacy.trackingprotection.socialtracking.enabled" = true; # Privacy
          "privacy.userContext.enabled" = true; # Privacy
          "privacy.userContext.longPressBehavior" = "2"; # Privacy
          "privacy.userContext.newTabContainerOnLeftClick.enabled" = false; # Privacy
          "privacy.userContext.ui.enabled" = true; # Privacy
          "signon.management.page.breach-alerts.enabled" = false;
          "signon.rememberSignons" = false;
          "ui.context_menus.after_mouseup" = true;
          "widget.use-xdg-desktop-portal" = true;
        };
        */

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
        '';

        userContent = "\n";
      };
    };
  };
}
