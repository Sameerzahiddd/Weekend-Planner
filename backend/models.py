class Place:
    def __init__(self, id, name, description, address, website, image, attributes):
        self.id = id
        self.name = name
        self.description = description
        self.address = address
        self.website = website
        self.image = image
        self.attributes = attributes
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "address": self.address,
            "website": self.website,
            "image": self.image,
            "attributes": self.attributes
        }