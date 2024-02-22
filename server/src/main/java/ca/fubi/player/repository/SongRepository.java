package ca.fubi.player.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import ca.fubi.player.models.Song;
import java.util.List;
import ca.fubi.player.models.Album;



public interface SongRepository extends JpaRepository<Song, Long>{
	Optional<Song> findById(Long id);
	List<Song> findByTitle(String title);
	List<Song> findByAlbum(Album album);
}
