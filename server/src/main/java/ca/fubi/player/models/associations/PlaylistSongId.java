package ca.fubi.player.models.associations;

import java.io.Serializable;
import jakarta.persistence.*;

@Embeddable
public class PlaylistSongId implements Serializable {
    @Column(name = "song_id")
    private Long songId;

    @Column(name = "playlist_id")
    private Long playlistId;
    
    public PlaylistSongId() {}
    
    public PlaylistSongId(Long songId, Long playlistId) {
    	this.setSongId(songId);
    	this.setPlaylistId(playlistId);
    }

    public Long getSongId() {
		return songId;
	}
    
    public void setSongId(Long songId) {
		this.songId = songId;
	}
    
    public Long getPlaylistId() {
		return playlistId;
	}
    
    public void setPlaylistId(Long playlistId) {
		this.playlistId = playlistId;
	}
}
