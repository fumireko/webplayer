package ca.fubi.player.file;

import java.io.IOException;
import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FilesStorageServiceImpl implements FilesStorageService{
	
	private final Path root = Paths.get("uploads");

	@Override
	public void init() {
		try { Files.createDirectories(root); } 
		catch (IOException e) {
			throw new RuntimeException("Could not initialize root path.");
		}
	}

	public String save(MultipartFile file) {
		try { Files.copy(file.getInputStream(), this.root.resolve(file.getOriginalFilename())); }
		catch (Exception e) {
			if (e instanceof FileAlreadyExistsException) throw new RuntimeException("File already exists.");
			throw new RuntimeException(e.getMessage());
		}
		return this.root.resolve(file.getOriginalFilename()).toString();
	}

	@Override
	public Resource load(String filename) {
		try {
			Path file = root.resolve(filename);
			Resource resource = new UrlResource(file.toUri());
			
			if(resource.exists() || resource.isReadable()) return resource;
			else throw new RuntimeException("Could not load the requested file.");
			
		} catch (Exception e) { e.printStackTrace(); }
		return null;
	}

	@Override
	public void deleteAll() {
		FileSystemUtils.deleteRecursively(root.toFile());		
	}

	@Override
	public Stream<Path> loadAll() {
		try { return Files.walk(this.root,  1).filter(path -> !path.equals(this.root)); }
		catch (IOException e) {	e.printStackTrace(); }
		return null;
	}

}
