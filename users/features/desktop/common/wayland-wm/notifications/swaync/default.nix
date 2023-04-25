{ pkgs,... }: {
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile."swaync/config.json".text = ''
    {
    "$schema": "/etc/xdg/swaync/configSchema.json",
    "positionX": "right",
    "positionY": "top",
    "layer": "top",
    "cssPriority": "application",
    "control-center-margin-top": 0,
    "control-center-margin-bottom": 0,
    "control-center-margin-right": 0,
    "control-center-margin-left": 0,
    "notification-icon-size": 64,
    "notification-body-image-height": 100,
    "notification-body-image-width": 200,
    "timeout": 10,
    "timeout-low": 5,
    "timeout-critical": 0,
    "fit-to-screen": true,
    "control-center-width": 500,
    "control-center-height": 600,
    "notification-window-width": 500,
    "keyboard-shortcuts": true,
    "image-visibility": "when-available",
    "transition-time": 200,
    "hide-on-clear": false,
    "hide-on-action": true,
    "script-fail-notify": true,
    "scripts": {
      "example-script": {
        "exec": "echo 'Do something...'",
        "urgency": "Normal"
      }
    },
    "notification-visibility": {
      "example-name": {
        "state": "muted",
        "urgency": "Low",
        "app-name": "Spotify"
      }
    },
    "widgets": [
      "title",
      "dnd",
      "notifications"
    ],
    "widget-config": {
      "title": {
        "text": "Notifications",
        "clear-all-button": true,
        "button-text": "Clear All"
      },
      "dnd": {
        "text": "Do Not Disturb"
      },
      "label": {
        "max-lines": 5,
        "text": "Label Text"
      },
      "mpris": {
        "image-size": 96,
        "image-radius": 12
      }
    }
  '';

  xdg.configFile."swaync/style.css".text = ''
    @define-color cc-bg rgba(0, 0, 0, 0.7);

    @define-color noti-border-color rgba(255, 255, 255, 0.15);
    @define-color noti-bg rgb(48, 48, 48);
    @define-color noti-bg-hover rgb(56, 56, 56);
    @define-color noti-bg-focus rgba(68, 68, 68, 0.6);
    @define-color noti-close-bg rgba(255, 255, 255, 0.1);
    @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);

    @define-color bg-selected rgb(0, 128, 255);

    .notification-row {
      outline: none;
    }

    .notification-row:focus,
    .notification-row:hover {
      background: @noti-bg-focus;
    }

    .notification {
      border-radius: 12px;
      margin: 6px 12px;
      box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7),
        0 2px 6px 2px rgba(0, 0, 0, 0.3);
      padding: 0;
    }

    /* Uncomment to enable specific urgency colors
    .low {
      background: yellow;
      padding: 6px;
      border-radius: 12px;
    }

    .normal {
      background: green;
      padding: 6px;
      border-radius: 12px;
    }

    .critical {
      background: red;
      padding: 6px;
      border-radius: 12px;
    }
    */

    .notification-content {
      background: transparent;
      padding: 6px;
      border-radius: 12px;
    }

    .close-button {
      background: @noti-close-bg;
      color: white;
      text-shadow: none;
      padding: 0;
      border-radius: 100%;
      margin-top: 10px;
      margin-right: 16px;
      box-shadow: none;
      border: none;
      min-width: 24px;
      min-height: 24px;
    }

    .close-button:hover {
      box-shadow: none;
      background: @noti-close-bg-hover;
      transition: all 0.15s ease-in-out;
      border: none;
    }

    .notification-default-action,
    .notification-action {
      padding: 4px;
      margin: 0;
      box-shadow: none;
      background: @noti-bg;
      border: 1px solid @noti-border-color;
      color: white;
    }

    .notification-default-action:hover,
    .notification-action:hover {
      -gtk-icon-effect: none;
      background: @noti-bg-hover;
    }

    .notification-default-action {
      border-radius: 12px;
    }

    .notification-default-action:not(:only-child) {
      border-bottom-left-radius: 0px;
      border-bottom-right-radius: 0px;
    }

    .notification-action {
      border-radius: 0px;
      border-top: none;
      border-right: none;
    }

    .notification-action:first-child {
      border-bottom-left-radius: 10px;
    }

    .notification-action:last-child {
      border-bottom-right-radius: 10px;
      border-right: 1px solid @noti-border-color;
    }

    .image {
    }

    .body-image {
      margin-top: 6px;
      background-color: white;
      border-radius: 12px;
    }

    .summary {
      font-size: 16px;
      font-weight: bold;
      background: transparent;
      color: white;
      text-shadow: none;
    }

    .time {
      font-size: 16px;
      font-weight: bold;
      background: transparent;
      color: white;
      text-shadow: none;
      margin-right: 18px;
    }

    .body {
      font-size: 15px;
      font-weight: normal;
      background: transparent;
      color: white;
      text-shadow: none;
    }

    .top-action-title {
      color: white;
      text-shadow: none;
    }

    .control-center {
      background: @cc-bg;
    }

    .control-center-list {
      background: transparent;
    }

    .floating-notifications {
      background: transparent;
    }

    .blank-window {
      background: alpha(black, 0.25);
    }

    .widget-title {
      margin: 8px;
      font-size: 1.5rem;
    }
    .widget-title > button {
      font-size: initial;
      color: white;
      text-shadow: none;
      background: @noti-bg;
      border: 1px solid @noti-border-color;
      box-shadow: none;
      border-radius: 12px;
    }
    .widget-title > button:hover {
      background: @noti-bg-hover;
    }

    .widget-dnd {
      margin: 8px;
      font-size: 1.1rem;
    }
    .widget-dnd > switch {
      font-size: initial;
      border-radius: 12px;
      background: @noti-bg;
      border: 1px solid @noti-border-color;
      box-shadow: none;
    }
    .widget-dnd > switch:checked {
      background: @bg-selected;
    }
    .widget-dnd > switch slider {
      background: @noti-bg-hover;
      border-radius: 12px;
    }

    .widget-label {
      margin: 8px;
    }
    .widget-label > label {
      font-size: 1.1rem;
    }

    .widget-mpris {}
    .widget-mpris-player {
      padding: 8px;
      margin: 8px;
    }
    .widget-mpris-title {
      font-weight: bold;
      font-size: 1.25rem;
    }
    .widget-mpris-subtitle {
      font-size: 1.1rem;
    }
  '';
}