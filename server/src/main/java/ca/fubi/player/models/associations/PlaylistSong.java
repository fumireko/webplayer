package ca.fubi.player.models.associations;

import jakarta.persistence.*;
import java.util.Date;

import ca.fubi.player.models.Playlist;
import ca.fubi.player.models.Song;

@Entity
@Table(name = "tb_playlist_songs")
public class PlaylistSong {
    @EmbeddedId
    private PlaylistSongId id;

    @ManyToOne
    @MapsId("songId")
    @JoinColumn(name = "song_id")
    private Song song;

    @ManyToOne
    @MapsId("playlistId")
    @JoinColumn(name = "playlist_id")
    private Playlist playlist;

    @Column(name = "date_added")
    private Date dateAdded;

    @Column(name = "play_count")
    private int playCount;
    
    public PlaylistSong() {}
    
    public PlaylistSong(Song song, Playlist playlist) {
    	this.setSong(song);
    	this.setPlaylist(playlist);
    }

    public PlaylistSongId getId() {
		return id;
	}
    
    public void setId(PlaylistSongId id) {
		this.id = id;
	}
    
    public Song getSong() {
		return song;
	}
    
    public void setSong(Song song) {
		this.song = song;
	}
    
    public Playlist getPlaylist() {
		return playlist;
	}
    
    public void setPlaylist(Playlist playlist) {
		this.playlist = playlist;
	}
    
    public Date getDateAdded() {
		return dateAdded;
	}
    
    public void setDateAdded(Date dateAdded) {
		this.dateAdded = dateAdded;
	}
    
    public int getPlayCount() {
		return playCount;
	}
    
    public void setPlayCount(int playCount) {
		this.playCount = playCount;
	}
}
