#Ramble
Ramble is a easy-to-use blogging gem that allows ruby developers to simply
incorporate blog posts into their applications/websites.

## Set Up
You can add it to your Gemfile:
```
gem 'ramble'
```
then:

```
bundle install
```
(or you can install it yourself)
```
gem install ramble
```


then, create the posts directory

```
mkdir app/blog_posts
```
and add `.md` files to the directory!

The file must follow this format

```
20160706_name_of_blog_post.md
```
You can then access your posts by calling

```
Ramble::BlogPost.all
```
or
```
Ramble::BlogPost.find_by_slug('name-of-blog-post')
```

### Order

for your index page, you can order the post by date like so:
```
Ramble::BlogPost.all(sort_by: :written_on, desc: true)
```


## Maintaining
Ramble is currently being developed, and working on some essential
features.

TODO: 
  -Category tagging for different posts
  -Custom Meta Data attributes for posts

## Contributing

Pull requests are welcome! Be sure to test.

##License
The gem is available as open source under the terms of the MIT License.
