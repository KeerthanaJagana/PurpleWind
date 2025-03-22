import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUP: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var selectedRole = "customer"  // Default role
    @State private var errorMessage: String?
    @Environment(\.presentationMode) var presentationMode

    let roles = ["vendor", "customer"]  // Role options

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Role Selection Picker
            Picker("Select Role", selection: $selectedRole) {
                ForEach(roles, id: \.self) { role in
                    Text(role.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button(action: signUp) {
                Text("Create Account")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Already have an account? Log In")
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .padding()
    }

    func signUp() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match!"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = "Sign Up failed: \(error.localizedDescription)"
            } else {
                guard let userId = authResult?.user.uid else { return }
                
                // Store user role in Firestore
                let db = Firestore.firestore()
                db.collection("users").document(userId).setData([
                    "email": email,
                    "role": selectedRole
                ]) { error in
                    if let error = error {
                        print("Error saving role: \(error.localizedDescription)")
                    } else {
                        print("User role saved successfully")
                        presentationMode.wrappedValue.dismiss()  // Dismiss Signup View
                    }
                }
            }
        }
    }
}
