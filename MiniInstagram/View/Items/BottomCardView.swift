//
//  BottomCardView.swift
//  MiniInstagram
//
//  Created by İsmail on 12.03.2022.
//

import SwiftUI

struct BottomCardView: View {
//    let content: Content
    let height: CGFloat
    let commentUid: String
    let commentViewModel: CommentViewModel
    
    @Binding var cardShown: Bool
    @Binding var cardDismissal: Bool
    
    init(cardShown: Binding<Bool>, cardDismissal: Binding<Bool>, height: CGFloat, post: Post, commentUid: String) {
        _cardShown = cardShown
        _cardDismissal = cardDismissal
        self.height = height
        self.commentUid = commentUid
        self.commentViewModel = CommentViewModel(post: post)
//        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Dimmed out view
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(cardShown ? 1 : 0)
            .animation(Animation.easeIn)
            .onTapGesture {
                // dismiss
                self.dismiss()
            }
            
            // Card
            VStack {
                Spacer()
                
                VStack {    
//                    content
                    
                    Button {
                        commentViewModel.deleteComment(commentId: commentUid)
                    } label: {
                        Text("Delete comment")
                            .bold()
                            .foregroundColor(.red)
                    }
        //            .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: 50)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(8)
                    .padding()
                    
                    Button {
                        self.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: 50)
                    .background(Color.pink)
                    .cornerRadius(8)
                    .padding()

                } //: VStack
                .padding(.bottom)
                .background(Color(UIColor.secondarySystemBackground))
                .frame(height: height)
                .offset(y: cardDismissal && cardShown ? 0 : height)
                .animation(Animation.default.delay(0.2))
                
            } //: VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
        } //: ZStack
        .edgesIgnoringSafeArea(.all)
    }
    
    func dismiss() {
        cardDismissal.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            cardShown.toggle()
        }
    }
}

//struct CardContent: View {
//    
//    let commentUid: String
//    let commentViewModel: CommentViewModel
//    
//    var body: some View {
//        
//        init(post: Post, commentUid: String) {
//            self.commentViewModel = CommentViewModel(post: post)
//            self.commentUid = commentUid
//        }
//        
//        VStack {
//            Button {
//                commentViewModel.deleteComment(uid: commentUid)
//            } label: {
//                Text("Delete comment")
//                    .bold()
//                    .foregroundColor(.red)
//            }
////            .foregroundColor(.white)
//            .frame(width: UIScreen.main.bounds.width / 1.5, height: 50)
//            .background(Color(UIColor.tertiarySystemBackground))
//            .cornerRadius(8)
//            .padding()
//            
//        } //: VStack
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .edgesIgnoringSafeArea(.all)
//        
//       
//
//    }
//}

//struct BottomCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomCardView()
//    }
//}
