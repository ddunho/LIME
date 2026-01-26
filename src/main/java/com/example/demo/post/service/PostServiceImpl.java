package com.example.demo.post.service;

import com.example.demo.post.mapper.PostMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;

    public PostServiceImpl(PostMapper postMapper) {
        this.postMapper = postMapper;
    }

    @Override
    public List<Map<String, Object>> getPostList() {
        return postMapper.findAll();
    }
}
