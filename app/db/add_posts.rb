Sequel.migration do
  Post.create(
    title: "What is Lorem Ipsum?",
    content: "Lorem Ipsum is a dummy text...",
  )
  Post.create(
    title: "Why do we use it?",
    content: "It is a long established fact that a reader...",
  )
  Post.create(
    title: "Where does it come from?",
    content: "Contrary to popular belief, Lorem Ipsum is not simply...",
  )
end
