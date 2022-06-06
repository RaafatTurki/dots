// Gnome Fox
// Enable CSD
//user_pref("browser.tabs.drawInTitlebar", true);

//MaterialFox
// user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// user_pref("svg.context-properties.content.enabled", true);
// user_pref("security.insecure_connection_text.enabled", true);
// user_pref("browser.tabs.tabClipWidth", 83); // default is 140

// Fonts
// user_pref("font.name.sans-serif.x-western",	"IBM Plex Sans");
// user_pref("font.name.serif.x-western",		"IBM Plex Serif");
// user_pref("font.name.monospace.x-western",	"IBM Plex Mono");

// Proton UI
// user_pref("browser.proton.enabled", true);
// user_pref("browser.proton.places-tooltip.enabled", true);
// user_pref("browser.proton.appmenu.enabled", true);
// user_pref("browser.proton.contextmenus.enabled", true);
// user_pref("browser.proton.tabs.enabled", true);
// user_pref("browser.proton.toolbar.enabled", true);
// user_pref("browser.proton.urlbar.enabled", true);
// user_pref("browser.newtabpage.activity-stream.newNewtabExperience.enabled", true);

user_pref("browser.startup.page", 3); // Restoring session
user_pref("browser.uidensity", 1); // Compact UI
user_pref("browser.download.dir", "/home/potato/down/brow"); // Download Dir (TODO: tokenize)
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // Enable userChrome.css and userContent.css
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false); // Disable PIP
user_pref("browser.tabs.closeWindowWithLastTab", true); // terminate FF if last tab is closed
user_pref("gfx.webrender.all", true); // Enable WebRenderer
//user_pref("browser.tabs.remote.autostart", false); // Disable Multi-Process Windows
user_pref("security.external_protocol_requires_permission", false);
user_pref("browser.tabs.tabMinWidth", 100);
user_pref("signon.showAutoCompleteFooter", false);

// Performance
user_pref("dom.ipc.processCount", 4); // Max spawned processes
user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
// user_pref("browser.sessionstore.interval", 600000); // write session to disk every 10 mins (15 secs default)

// Smooth scrolling
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 250);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 450);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 450);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 50);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio;0", 4);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 5000);
user_pref("mousewheel.min_line_scroll_amount", 44);
user_pref("toolkit.scrollbox.verticalScrollDistance", 5);
user_pref("toolkit.scrollbox.horizontalScrollDistance", 4);

// user_pref("general.smoothScroll.lines.durationMaxMS", 125);
// user_pref("general.smoothScroll.lines.durationMinMS", 125);
// user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 200);
// user_pref("general.smoothScroll.mouseWheel.durationMinMS", 100);
// user_pref("general.smoothScroll.msdPhysics.enabled", true);
// user_pref("general.smoothScroll.other.durationMaxMS", 125);
// user_pref("general.smoothScroll.other.durationMinMS", 125);
// user_pref("general.smoothScroll.pages.durationMaxMS", 125);
// user_pref("general.smoothScroll.pages.durationMinMS", 125);
// user_pref("mousewheel.min_line_scroll_amount", 30);
// user_pref("mousewheel.system_scroll_override_on_root_content.enabled", true);
// user_pref("mousewheel.system_scroll_override_on_root_content.horizontal.factor", 175);
// user_pref("mousewheel.system_scroll_override_on_root_content.vertical.factor", 175);
// user_pref("toolkit.scrollbox.horizontalScrollDistance", 6);
// user_pref("toolkit.scrollbox.verticalScrollDistance", 2);

// Fullscreen transition
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.transition.timeout", 0);
user_pref("full-screen-api.warning.timeout", 0); // Hide fullscreen warning

// Remote Debugging
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.chrome.enabled", true);

// Inspector
user_pref("devtools.theme", "dark");
user_pref("devtools.command-button-paintflashing.enabled", true);
user_pref("devtools.chrome.three-pane-enabled", false);
user_pref("devtools.inspector.three-pane-enabled", false);

user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.update.auto", false);
user_pref("beacon.enabled", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.disableResetPrompt", true);
user_pref("browser.newtab.preload", false);
user_pref( "browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.selfsupport.url", "");
user_pref("browser.sessionstore.privacy_level", 0);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
// user_pref("dom.event.clipboardevents.enabled", false);
user_pref("experiments.activeExperiment", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.screenshots.disabled", true);
user_pref("extensions.screenshots.upload-disabled", true);
user_pref("extensions.shield-recipe-client.api_url", "");
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("extensions.webservice.discoverURL", "");
user_pref("media.autoplay.default", 0);
user_pref("media.autoplay.enabled", true);
user_pref("media.video_stats.enabled", false);
user_pref("network.IDN_show_punycode", true);
user_pref("network.allow-experiments", false);
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.cookie.cookieBehavior", 1);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.http.referer.XOriginPolicy", 2);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.predictor.enabled", false);
user_pref("network.prefetch-next", false);
user_pref("network.trr.mode", 5);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.donottrackheader.value", 1);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite", false);
// user_pref("signon.autofillForms", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
