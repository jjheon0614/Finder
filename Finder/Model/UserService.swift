/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author & ID:
     Sanghwa Jung       s3768999
     Nguyen Gia Khanh   s3927238
     Jaeheon Jeong      s3821004
     Hanjun Lee         s3732878
     Hoang Duc Anh      s3847506
  Created date: 2023/09/16.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


class UserService {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func getAllUsers(completion: @escaping ([User]?) -> Void) {
        // Reference to Firestore
        let db = Firestore.firestore()
        
        // Reference to the "users" collection
        let usersCollection = db.collection("users")
        
        // Define a closure to handle the query result
        let queryCompletion: (QuerySnapshot?, Error?) -> Void = { (querySnapshot, error) in
            if let error = error {
                print("Error getting all users: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(nil)
                return
            }
            
            // Process documents and map to User objects
            let users = self.processUserDocuments(documents)
            completion(users)
        }
        
        // Fetch documents
        usersCollection.getDocuments(completion: queryCompletion)
    }
    
    
    func processUserDocuments(_ documents: [QueryDocumentSnapshot]) -> [User] {
        return documents.compactMap { (queryDocumentSnapshot) -> User? in
            let data = queryDocumentSnapshot.data()
            
            // Map document data to a User object
            var user = User()
            
            user.id = data["id"] as? String ?? ""
            user.nickname = data["nickname"] as? String ?? ""
            user.documentID = data["documentID"] as? String ?? ""
            user.email = data["email"] as? String ?? ""
            user.password = data["password"] as? String ?? ""
            user.gender = data["gender"] as? String ?? ""
            user.preferenceOne = data["LoveStyle"] as? String ?? ""
            user.preferenceTwo = data["RelationshipGoal"] as? String ?? ""
            user.preferenceThree = data["MBTI"] as? String ?? ""
            user.preferenceFour = data["DrinkingStatus"] as? String ?? ""
            user.preferenceFive = data["Smoking"] as? String ?? ""
            user.phoneNumber = data["phoneNumber"] as? String ?? ""
            user.age = data["age"] as? String ?? ""
            user.likeArray = data["like"] as? [String] ?? []
            user.hateArray = data["hate"] as? [String] ?? []
            
            return user
        }
    }
    
    func updateUser(email: String, newData: [String: Any], completion: @escaping (Error?) -> Void) {
        // Reference to the "users" collection
        let usersCollection = db.collection("users")
        
        // Reference to the document with the provided email
        let userDocument = usersCollection.document(email)
        
        // Update the document with the new data
        userDocument.updateData(newData) { error in
            if let error = error {
                print("Error updating user data: \(error.localizedDescription)")
                completion(error)
            } else {
                print("User data updated successfully!")
                completion(nil)
            }
        }
    }
    
    
    func updateAuthentication(email: String, newPassword: String, currentPassword: String, completion: @escaping (Error?) -> Void) {
        // Reauthenticate the user
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        user?.reauthenticate(with: credential) { _, reauthError in
            if let reauthError = reauthError {
                // Handle the reauthentication error
                print("Error reauthenticating user: \(reauthError.localizedDescription)")
                completion(reauthError)
            } else {
                // Reauthentication succeeded, update the password
                Auth.auth().currentUser?.updatePassword(to: newPassword) { updateError in
                    if let updateError = updateError {
                        // Handle the password update error
                        print("Error updating password: \(updateError.localizedDescription)")
                        completion(updateError)
                    } else {
                        // Password update succeeded
                        print("Password updated successfully!")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func getUserByEmail(email: String, completion: @escaping (User?) -> Void) {
        db.collection("users")
            .whereField("email", isEqualTo: email)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting user by email: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    completion(nil)
                    return
                }
                
                if let userData = documents.first?.data() {
                    var user = User()
                    user.id = userData["id"] as? String ?? ""
                    user.nickname = userData["nickname"] as? String ?? ""
                    user.documentID = userData["documentID"] as? String ?? ""
                    user.email = userData["email"] as? String ?? ""
                    user.password = userData["password"] as? String ?? ""
                    user.gender = userData["gender"] as? String ?? ""
                    user.preferenceOne = userData["LoveStyle"] as? String ?? ""
                    user.preferenceTwo = userData["RelationshipGoal"] as? String ?? ""
                    user.preferenceThree = userData["MBTI"] as? String ?? ""
                    user.preferenceFour = userData["DrinkingStatus"] as? String ?? ""
                    user.preferenceFive = userData["Smoking"] as? String ?? ""
                    user.phoneNumber = userData["phoneNumber"] as? String ?? ""
                    user.age = userData["age"] as? String ?? ""
                    user.likeArray = userData["like"] as? [String] ?? []
                    user.hateArray = userData["hate"] as? [String] ?? []
                    
                    completion(user)
                } else {
                    print("User not found")
                    completion(nil)
                }
            }
    }
    
    func getImagesByEmail(email: String, completion: @escaping ([UIImage]?) -> Void) {
        // Fetch user data by email
        getUserByEmail(email: email) { user in
            guard let user = user else {
                print("User not found for email: \(email)")
                completion(nil)
                return
            }
            var images: [UIImage] = []
            
            // Loop through user's images and download them from Firebase Storage
            if let userEmail = user.email {
                let storageReference = self.storage.reference().child("images") // Use 'self' here
                for index in 0..<5 { // Assuming you have up to 5 images
                    let fileName = "\(userEmail)_\(index).jpg"
                    let imageReference = storageReference.child(fileName)
                    
                    imageReference.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("Error downloading image \(index): \(error.localizedDescription)")
                        } else if let data = data, let image = UIImage(data: data) {
                            images.append(image)
                            
                            // Print the image count for debugging
                            print("Downloaded \(images.count) images")
                            
                            if images.count == 5 { // Check if all images have been fetched
                                completion(images)
                            }
                        } else {
                            print("Failed to convert data to UIImage for image \(index)")
                        }
                        completion(images)
                    }
                }
            } else {
                print("User email is nil.")
                completion(nil)
            }
        }
    }
    
    func getImageByEmail(email: String, completion: @escaping (UIImage?) -> Void) {
            let storageReference = self.storage.reference().child("images")
            let fileName = "\(email)_0.jpg" // Assuming you want to fetch the image at index 0
            let imageReference = storageReference.child(fileName)

            imageReference.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                    completion(nil)
                } else if let data = data, let image = UIImage(data: data) {
                    // Image fetched successfully
                    completion(image)
                } else {
                    print("Failed to convert data to UIImage")
                    completion(nil)
                }
            }
        }
    
    func updateImages(selectedImages: [UIImage], userEmail: String, completion: @escaping (Error?) -> Void) {
        guard !selectedImages.isEmpty else {
            completion(nil) // No images to update
            return
        }
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let imageOperationGroup = DispatchGroup()
        
        for index in 0..<5 {
            let fileNameToDelete = "\(userEmail)_\(index).jpg"
            let imageReferenceToDelete = storageReference.child("images").child(fileNameToDelete)
            
            // Enter the dispatch group for deletion
            imageOperationGroup.enter()
            
            imageReferenceToDelete.delete { error in
                // Leave the dispatch group for deletion regardless of success or failure
                imageOperationGroup.leave()
                
                if let error = error {
                    print("Error deleting image \(index): \(error.localizedDescription)")
                } else {
                    print("Image \(index) deleted successfully.")
                }
            }
        }
        
        for (index, selectedImage) in selectedImages.enumerated() {
            // Convert the UIImage to Data
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])
                completion(error)
                return
            }
            
            // Create a unique filename for each image based on user's email and index
            let fileName = "\(userEmail)_\(index).jpg"
            
            // Create a reference to Firebase Storage where you want to store the image
            let imageReference = storageReference.child("images").child(fileName)
            
            // Upload the image data to Firebase Storage
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imageReference.putData(imageData, metadata: metadata) { metadata, error in
                if let error = error {
                    print("Error updating image \(index): \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Image \(index) updated successfully.")
                    // You can perform additional actions here, such as saving the download URL or updating your UI.
                }
            }
        }
        
        // All images have been updated successfully
        completion(nil)
    }
    //
    //
    //       func updateImages(email: String, newImages: [UIImage], completion: @escaping (Error?) -> Void) {
    //           // Reference to Firebase Storage
    //           let storage = Storage.storage()
    //
    //           // Reference to the "images" folder in Firebase Storage
    //           let storageReference = storage.reference().child("images")
    //
    //           // Get the user's email
    //           let userEmail = email
    //
    //           // Create a dispatch group to track the completion of all image operations (deletion and upload)
    //           let imageOperationGroup = DispatchGroup()
    //
    //           // Create a list of file names to delete
    //           var fileNamesToDelete: [String] = []
    //           for index in 0..<3 {
    //               let oldFileName = "\(userEmail)_\(index).jpg"
    //               fileNamesToDelete.append(oldFileName)
    //           }
    //
    //           // Delete existing images
    //           for fileNameToDelete in fileNamesToDelete {
    //               let oldImageReference = storageReference.child(fileNameToDelete)
    //
    //               // Enter the dispatch group for deletion
    //               imageOperationGroup.enter()
    //
    //               oldImageReference.delete { error in
    //                   // Leave the dispatch group for deletion regardless of success or failure
    //                   imageOperationGroup.leave()
    //
    //                   if let error = error {
    //                       print("Error deleting image \(fileNameToDelete): \(error.localizedDescription)")
    //                   }
    //               }
    //           }
    //
    //           // Wait for all deletions to complete
    //           imageOperationGroup.notify(queue: .main) {
    //               // Now, upload the new images
    //               // Create another dispatch group for image uploads
    //               let uploadGroup = DispatchGroup()
    //
    //               for (index, selectedImage) in newImages.enumerated() {
    //                   // Create a file name for the new image
    //                   let newFileName = "\(userEmail)_\(index).jpg"
    //                   let newImageReference = storageReference.child(newFileName)
    //
    //                   // Enter the dispatch group for upload
    //                   uploadGroup.enter()
    //
    //                   // Convert the UIImage to data
    //                   guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
    //                       completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"]))
    //                       return
    //                   }
    //
    //                   // Upload the new image data to Firebase Storage
    //                   newImageReference.putData(imageData, metadata: nil) { _, error in
    //                       // Leave the dispatch group for upload regardless of success or failure
    //                       uploadGroup.leave()
    //
    //                       if let error = error {
    //                           completion(error)
    //                       }
    //                   }
    //               }
    //
    //               // Notify the completion handler when all uploads are finished
    //               uploadGroup.notify(queue: .main) {
    //                   completion(nil)
    //               }
    //           }
    //       }
    
    func addEmailToRelationshipArr(userEmail: String, likedUserEmail: String, likeOrHate : String) {
        // Access user collection
        let usersCollection = db.collection("users")
        
        // Access userEmail's document
        let userDocument = usersCollection.document(userEmail)
        
        // Update append userEmail to corresponding like or hate array.
        userDocument.updateData([
            likeOrHate : FieldValue.arrayUnion([likedUserEmail])
        ]) { error in
            if let error = error {
                print("Error in appending email to like array of user \(userEmail): \(error.localizedDescription)")
            } else {
                print("Appended \(likedUserEmail) successfully into \(userEmail)'s \(likeOrHate) array")
            }
        }
    }
    
    
    /* IN DEVELOPMENT, HAS NOT BEEN TESTED
    func createChatIfMatched(user1Email: String, user2Email: String){
        let usersCollection = db.collection("users")
        let chatsCollection = db.collection("chats")
        let chatIdCounterDocRef = db.collection("metadata").document("chatIdCounter")
        
        // Get user1 'like' array
        usersCollection.document(user1Email).getDocument { (user1Document, error) in
            if let error = error {
                print("Error checking \(user1Email)'s likes: \(error.localizedDescription)")
                return
            }
            
            guard let user1Data = user1Document?.data(),
                  let user1Likes = user1Data["like"] as? [String] else {
                print("\(user1Email) document or 'like' field not found.")
                return
            }
            
            // Get user2 'like' array
            usersCollection.document(user2Email).getDocument { (user2Document, error) in
                if let error = error {
                    print("Error checking \(user2Email)'s likes: \(error.localizedDescription)")
                    return
                }
                
                guard let user2Data = user2Document?.data(),
                      let user2Likes = user2Data["like"] as? [String] else {
                    print("\(user1Email) document or 'like' field not found.")
                    return
                }
                
                // Check if both user1 and user2 likes each other
                if user1Likes.contains(user2Email) && user2Likes.contains(user1Email) {
                    let newChatDocument = chatsCollection.document()
                    
                    // Use transaction to ensure that each creation is done concurrently and not simulantenously which would result in chatId being the same.
                    
                    //Creates a chat room with incremental ID (+1 from previous IDs)
                    self.db.runTransaction({ (transaction, errorPointer) -> Any? in
                        do {
                            let chatIdCounterDoc = try transaction.getDocument(chatIdCounterDocRef)
                            if var currentChatId = chatIdCounterDoc.data()?["currentChatId"] as? Int {
                                let newChatDocRef = usersCollection.document("\(currentChatId)")
                                let chatData : [String: Any] = [
                                    "chatId": currentChatId,
                                    "user1": user1Email,
                                    "user2": user2Email
                                ]
                                transaction.setData(chatData, forDocument: newChatDocument)
                                
                                currentChatId += 1
                                transaction.updateData(["currentChatId": currentChatId], forDocument: chatIdCounterDocRef)
                            }
                        } catch let fetchError as NSError {
                            errorPointer?.pointee = fetchError
                            return nil
                        }
                        return nil
                    }) { (_, error) in
                        if let error = error {
                            print("Error creating user: \(error.localizedDescription)")
                        } else {
                            print("User created successfully.")
                        }
                    }
                }
            }
        }
    }
    */
}
