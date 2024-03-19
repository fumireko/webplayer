package ca.fubi.player.playlist;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ca.fubi.player.user.User;

import java.util.List;



@Repository
public interface PlaylistRepository extends JpaRepository<Playlist, Long> {
	Optional<Playlist> findById(Long id);
	Optional<Playlist> findByName(String name);
	List<Playlist> findByUser(User user);
}
