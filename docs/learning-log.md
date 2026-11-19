# Learning log

One short entry per session. Entries about what broke and how you figured it out make the best interview stories.

## Template

### YYYY-MM-DD: <topic>
- **Goal:**
- **Did:**
- **Broke / surprised me:**
- **Learned:**
- **Next:**

---

<!-- newest entries at the top -->

### 2026-11-17: Starting S3 Bucket Module
- **Goal:** write the s3 bucket module variables, create an s3 bucket, and learn best security practices
- **Did:** read through the aws docs on s3 buckets and keys
- **Broke/surprised me:** the bucket configurations are mostly managed through several smaller resources, rather than once all encompassing bucket resource. this keeps the createbucket api a bit more lightweight and easier to understand.
- **Learned:** using s3 bucket keys can reduce the aws kms cost by up to 99%! that's a crazy cost reduction!
- **Next:** now that i have the basic s3 bucket creation defined, i can move onto the bucket configurations.

### 2026-11-13: KMS Module (Happy Friday the 13th!)
- **Goal:** write the terraform kms module
- **Did:** learned about aws kms keys and the 3 varieties that are available: Customer managed keys, aws managed keys, and aws owned keys. The differences are mainly the amount of control the user has over the key lifecycle, with customer managed keys having the most control. Today was also my first time running some terraform commands! I'm learning the terraform basics, and starting to grasp the terraform concepts of resources, modules, and outputs. I successfully created a kms key and alias in my localstack instance (running via docker) using a combination of terraform plan and apply. i then used tarraform destroy to destroy the alias and the key. the alias is destroyed immediately, but the key now has a keystate of 'pendingdeletion'. this is because when the key was created, the deletion_window_in_days was set to 7. durign this window, the key can be recovered. but after this window, the key is permanently deleted, and any data encrypted with the key will be nonrecoverable.
- **Broke/ surprised me:** since this is my first time using terraform, it took me a while to get it so all terraform i was writing was valid, but while fumbling around, i saw that when i wrote the descriptions for the variables, i ended up seeing my own error message thrown back at me at one point. that was pretty cool! as i use terraform more, i'm sure i'll start to understand it more, practice makes better and all, but i'm happy to see how its working on the very first day of using it.
- **Learned:** the terraform registry is massive, and im sure no one knows everything. but the registry is a good resource to look to when figuring something out.
- **Next:** s3_bucket module!
