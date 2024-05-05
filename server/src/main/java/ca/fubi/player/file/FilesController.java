package ca.fubi.player.file;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.util.UriComponentsBuilder;

import ca.fubi.player.song.Song;
import ca.fubi.player.song.SongRepository;
import jakarta.servlet.ServletContext;

@CrossOrigin(origins = "http://localhost:4200", 
methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE}, 
allowedHeaders = "*",
allowCredentials = "true", 
maxAge = 3600)
@RestController
@RequestMapping("/files")
public class FilesController {
	
	@Autowired
	FilesStorageService storageService;
	
	@Autowired
	SongRepository songRepository;
		
	@PostMapping("/upload/{id}")
	public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file, @PathVariable Long id){
		try {
			String path = storageService.save(file);
			Song song = songRepository.findById(id).get();
			song.setFile(new FileInfo(file.getOriginalFilename(), path));
			songRepository.save(song);
			return ResponseEntity.ok().body("Upload success: " + file.getOriginalFilename());
		} catch (Exception e) {
			return ResponseEntity.internalServerError().body("Could not upload file " + file.getOriginalFilename() + ", " + e.getMessage());
		}
	}
	
	//Why
	@GetMapping("/") public ResponseEntity<List<FileInfo>> getAllFiles(){
		return ResponseEntity.ok().body(storageService.loadAll().map(p -> new FileInfo(p.getFileName().toString(), MvcUriComponentsBuilder.fromMethodName(FilesController.class, "getFile", UriComponentsBuilder.fromUriString(p.getFileName().toString()).build().encode().toUriString()).build().toString())).collect(Collectors.toList())); 
	}
	
    @GetMapping("/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> getFile(@PathVariable String filename) {
        Resource file = storageService.load(filename);

        // Determine the MIME type based on the file extension
        String contentType = determineContentType(filename);

        // Set Content-Disposition header
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"");

        // Set Content-Type header
        headers.setContentType(MediaType.parseMediaType(contentType));

        return ResponseEntity.ok().headers(headers).body(file);
    }

    private String determineContentType(String filename) {
        Path path = Paths.get(filename);
        try {
            String contentType = Files.probeContentType(path);
            if (contentType == null) {
                // If probeContentType returns null, fallback to a default content type
                return "application/octet-stream";
            }
            return contentType;
        } catch (IOException e) {
            // If an exception occurs, fallback to a default content type
            return "application/octet-stream";
        }
    }
}
