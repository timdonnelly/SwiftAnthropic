//
//  MessageInputTokens.swift
//  SwiftAnthropic
//
//  Created by James Rochabrun on 1/3/25.
//

import Foundation

public struct MessageInputTokens: Decodable, AnthropicResponse {
   
   /// The total number of tokens across the provided list of messages, system prompt, and tools.
   public let inputTokens: Int
   
   /// The unique request identifier from the response header (x-request-id).
   public var requestID: String?

   public init(from decoder: Decoder) throws {
      if let container = try? decoder.singleValueContainer(),
         let dict = try? container.decode([String: Int].self),
         let tokens = dict["input_tokens"] {
         self.inputTokens = tokens
      } else {
         // Try regular JSON decoding as fallback
         let container = try decoder.container(keyedBy: CodingKeys.self)
         self.inputTokens = try container.decode(Int.self, forKey: .inputTokens)
      }
   }
   
   private enum CodingKeys: String, CodingKey {
      case inputTokens = "input_tokens"
   }
}
