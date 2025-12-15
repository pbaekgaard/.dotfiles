#!/usr/bin/env python3
import gi
gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib
from gi.repository.Playerctl import Player
import argparse
import logging
import sys
import signal
import gi
import json
import os
from typing import List

# Global settings
MAX_LENGTH = 30
SCROLL_INTERVAL = 500
PADDING_SPACES = 2

logger = logging.getLogger(__name__)

def signal_handler(sig, frame):
    logger.info("Received signal to stop, exiting")
    sys.stdout.write("\n")
    sys.stdout.flush()
    # loop.quit()
    sys.exit(0)


class PlayerManager:
    def __init__(self, selected_player=None, excluded_player=[], scrolling=False, spotify_only=False):
        self.manager = Playerctl.PlayerManager()
        self.loop = GLib.MainLoop()
        self.manager.connect(
            "name-appeared", lambda *args: self.on_player_appeared(*args))
        self.manager.connect(
            "player-vanished", lambda *args: self.on_player_vanished(*args))

        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        signal.signal(signal.SIGPIPE, signal.SIG_DFL)
        self.selected_player = selected_player
        self.excluded_player = excluded_player.split(',') if excluded_player else []
        self.scrolling = scrolling
        self.spotify_only = spotify_only
        self.scroll_position = 0
        self.current_text = ""
        self.current_player = None

        self.init_players()

    def init_players(self):
        for player in self.manager.props.player_names:
            if player.name in self.excluded_player:
                continue
            if self.selected_player is not None and self.selected_player != player.name:
                logger.debug(f"{player.name} is not the filtered player, skipping it")
                continue
            self.init_player(player)

    def run(self):
        logger.info("Starting main loop")
        if self.scrolling:
            GLib.timeout_add(SCROLL_INTERVAL, self.update_scrolling)
        self.loop.run()

    def init_player(self, player):
        logger.info(f"Initialize new player: {player.name}")
        player = Playerctl.Player.new_from_name(player)
        player.connect("playback-status",
                       self.on_playback_status_changed, None)
        player.connect("metadata", self.on_metadata_changed, None)
        self.manager.manage_player(player)
        self.on_metadata_changed(player, player.props.metadata)

    def get_players(self) -> List[Player]:
        return self.manager.props.players

    def write_output(self, text, player):
        logger.debug(f"Writing output: {text}")

        self.current_text = text
        self.current_player = player

        if self.scrolling and text:
            text = self.scroll_text(text)

        # Add play/pause icon before scrolling
        if text:
            if player.props.status == "Playing":
                text = "▶ " + text
            else:
                text = "⏸ " + text

        status_class = "playing" if player.props.status == "Playing" else "paused"
        output = {"text": text,
                  "class": status_class,
                  "alt": player.props.player_name}

        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()

    def scroll_text(self, text):
        if not text or len(text) <= MAX_LENGTH:
            return text
        
        # Add padding spaces to prevent morphing on wraparound
        text_with_padding = text + (" " * PADDING_SPACES)
        
        if self.scroll_position >= len(text_with_padding):
            self.scroll_position = 0
        
        scrolled = text_with_padding[self.scroll_position:self.scroll_position + MAX_LENGTH]
        if len(scrolled) < MAX_LENGTH:
            scrolled += text_with_padding[:MAX_LENGTH - len(scrolled)]
        
        self.scroll_position += 1
        return scrolled

    def update_scrolling(self):
        if self.scrolling and self.current_text and self.current_player:
            # Don't scroll if player is paused
            if self.current_player.props.status != "Playing":
                return True
            scrolled_text = self.scroll_text(self.current_text)
            
            # Add play/pause icon before scrolling
            if scrolled_text:
                if self.current_player.props.status == "Playing":
                    scrolled_text = "▶ " + scrolled_text
                else:
                    scrolled_text = "⏸  " + scrolled_text
            
            status_class = "playing" if self.current_player.props.status == "Playing" else "paused"
            output = {"text": scrolled_text,
                      "class": status_class,
                      "alt": self.current_player.props.player_name}
            sys.stdout.write(json.dumps(output) + "\n")
            sys.stdout.flush()
        return True

    def clear_output(self):
        sys.stdout.write("\n")
        sys.stdout.flush()

    def on_playback_status_changed(self, player, status, _=None):
        logger.debug(f"Playback status changed for player {player.props.player_name}: {status}")
        self.on_metadata_changed(player, player.props.metadata)

    def get_first_playing_player(self):
        players = self.get_players()
        logger.debug(f"Getting first playing player from {len(players)} players")
        
        if self.spotify_only:
            for player in players[::-1]:
                if player.props.player_name == "spotify":
                    if player.props.status == "Playing":
                        return player
            return None
        
        if len(players) > 0:
            # if any are playing, show the first one that is playing
            # reverse order, so that the most recently added ones are preferred
            for player in players[::-1]:
                if player.props.status == "Playing":
                    return player
            # if none are playing, show the first one
            return players[0]
        else:
            logger.debug("No players found")
            return None

    def show_most_important_player(self):
        logger.debug("Showing most important player")
        # show the currently playing player
        # or else show the first paused player
        # or else show nothing
        current_player = self.get_first_playing_player()
        if current_player is not None:
            self.on_metadata_changed(current_player, current_player.props.metadata)
        else:    
            if self.spotify_only:
                self.clear_output()
            else:
                self.clear_output()

    def on_metadata_changed(self, player, metadata, _=None):
        logger.debug(f"Metadata changed for player {player.props.player_name}")
        player_name = player.props.player_name
        
        if self.spotify_only and player_name != "spotify":
            return
        
        artist = player.get_artist()
        title = player.get_title()

        track_info = ""
        if player_name == "spotify" and "mpris:trackid" in metadata.keys() and ":ad:" in player.props.metadata["mpris:trackid"]:
            track_info = "Advertisement"
        elif artist is not None and title is not None:
            track_info = f"{artist} — {title}"
        else:
            track_info = title

        # only print output if no other player is playing
        current_playing = self.get_first_playing_player()
        if current_playing is None or current_playing.props.player_name == player.props.player_name:
            self.write_output(track_info, player)
        else:
            logger.debug(f"Other player {current_playing.props.player_name} is playing, skipping")

    def on_player_appeared(self, _, player):
        logger.info(f"Player has appeared: {player.name}")
        if player.name in self.excluded_player:
            logger.debug(
                "New player appeared, but it's in exclude player list, skipping")
            return
        if player is not None and (self.selected_player is None or player.name == self.selected_player):
            self.init_player(player)
        else:
            logger.debug(
                "New player appeared, but it's not the selected player, skipping")

    def on_player_vanished(self, _, player):
        logger.info(f"Player {player.props.player_name} has vanished")
        self.show_most_important_player()

def parse_arguments():
    parser = argparse.ArgumentParser()

    # Increase verbosity with every occurrence of -v
    parser.add_argument("-v", "--verbose", action="count", default=0)

    parser.add_argument("-x", "--exclude", "- Comma-separated list of excluded player")

    # Define for which player we"re listening
    parser.add_argument("--player")

    parser.add_argument("--enable-logging", action="store_true")
    
    parser.add_argument("--scrolling", action="store_true", help="Enable scrolling output")
    
    parser.add_argument("--spotify", action="store_true", help="Show only Spotify player")

    return parser.parse_args()


def main():
    arguments = parse_arguments()

    # Initialize logging
    if arguments.enable_logging:
        logfile = os.path.join(os.path.dirname(
            os.path.realpath(__file__)), "media-player.log")
        logging.basicConfig(filename=logfile, level=logging.DEBUG,
                            format="%(asctime)s %(name)s %(levelname)s:%(lineno)d %(message)s")

    # Logging is set by default to WARN and higher.
    # With every occurrence of -v it's lowered by one
    logger.setLevel(max((3 - arguments.verbose) * 10, 0))

    logger.info("Creating player manager")
    if arguments.player:
        logger.info(f"Filtering for player: {arguments.player}")
    if arguments.exclude:
        logger.info(f"Exclude player {arguments.exclude}")
    if arguments.spotify:
        logger.info("Spotify-only mode enabled")
    if arguments.scrolling:
        logger.info("Scrolling mode enabled")

    player = PlayerManager(arguments.player, arguments.exclude, arguments.scrolling, arguments.spotify)
    player.run()


if __name__ == "__main__":
    main()
