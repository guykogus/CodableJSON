# CodableJSON

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/CodableJSON.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)

JSON in Swift - the way it should be.

# Requirements

- iOS 8.0+ / macOS 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 10.1+
- Swift 4.2+

# Usage

In the modern era of `Codable` it is rare that we need to handle JSON data manually. Nevertheless there are times when we can't know the structure in advance, but we can still utilise `Codable` to make our lives easier.

When loading JSON data:

```JSON
{
  "Apple": {
    "address": {
      "street": "1 Infinite Loop",
      "city": "Cupertino",
      "state": "CA",
      "zip": "95014"
    },
    "employees": 132000
  }
}
```

### Previously

You would have had to perform a lot of casting to get the inner values.

```Swift
guard let companies = try JSONSerialization.jsonObject(with: companiesData) as? [String: Any] else { return }

if let company = companies["Apple"] as? [String: Any],
    let address = company["address"] as? [String: Any],
    let city = address["city"] as? String {
    print("Apple is in \(city)")
}
```

Changing the inner values would also involve several castings.

```Swift
guard var companies = try JSONSerialization.jsonObject(with: companiesData) as? [String: Any] else { return }

if var apple = companies["Apple"] as? [String: Any],
    var address = apple["address"] as? [String: Any] {
    address["state"] = "California"
    apple["address"] = address
    companies["Apple"] = apple
}
```

### Using `CodableJSON`

Since JSON has a fixed set of types there's no need to perform all these casts in long form. `CodableJSON` uses an `enum` to store each type. With the aid of some helper functions, accessing the JSON values is now significantly shorter and easier.

```Swift
let companies = try JSONDecoder().decode(JSON.self, from: companiesData)

if let city = companies["Apple"]?["address"]?["city"]?.stringValue {
    print("Apple is in \(city)")
}
```

You can even use mutable forms in order to change the inner values. E.g. You could change the state to its full name:

```Swift
var companies = try JSONDecoder().decode(JSON.self, from: companiesData)

companies["Apple"]?["address"]?["state"] = "California"
```

# Installation

<details>
<summary>CocoaPods</summary>
</br>
<p>To integrate CodableJSON into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, specify it in your <code>Podfile</code>:</p>
<pre><code class="ruby language-ruby">pod 'CodableJSON'</code></pre>
</details>

<details>
<summary>Carthage</summary>
</br>
<p>To integrate CodableJSON into your Xcode project using <a href="https://github.com/Carthage/Carthage">Carthage</a>, specify it in your <code>Cartfile</code>:</p>
<pre><code class="ogdl language-ogdl">github "guykogus/CodableJSON"</code></pre>
</details>

<details>
<summary>Swift Package Manager</summary>
</br>
<p>You can use <a href="https://swift.org/package-manager">The Swift Package Manager</a> to install <code>CodableJSON</code> by adding the proper description to your <code>Package.swift</code> file:</p>

<pre><code class="swift language-swift">import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/guykogus/CodableJSON.git", from: "1.2.0")
    ]
)
</code></pre>

<p>Next, add <code>CodableJSON</code> to your targets dependencies like so:</p>
<pre><code class="swift language-swift">.target(
    name: "YOUR_TARGET_NAME",
    dependencies: [
        "CodableJSON",
    ]
),</code></pre>
<p>Then run <code>swift package update</code>.</p>
</details>

# License

CodableJSON is available under the MIT license. See the LICENSE file for more info.
