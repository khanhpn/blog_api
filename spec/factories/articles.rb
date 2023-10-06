FactoryBot.define do
  factory :article do
    association :user, factory: :user
    association :category, factory: :category
    name { 'Test Article' }
    content {'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quisque id diam vel quam elementum pulvinar etiam non. Nibh tellus molestie nunc non. Felis donec et odio pellentesque diam volutpat. Vel facilisis volutpat est velit egestas dui id. Tempor commodo ullamcorper a lacus vestibulum sed arcu non. Lectus sit amet est placerat in egestas erat imperdiet sed. Amet justo donec enim diam vulputate ut. In egestas erat imperdiet sed euismod. Rhoncus mattis rhoncus urna neque viverra. Feugiat in ante metus dictum at. Enim tortor at auctor urna nunc. Nibh ipsum consequat nisl vel pretium lectus quam id leo. Id venenatis a condimentum vitae sapien. Quam elementum pulvinar etiam non quam lacus suspendisse faucibus interdum. Non consectetur a erat nam at.'}
    isShow { true }
  end
end
