variable "iot_thing_groups" {
  description = <<EOT
Map of iot_thing_groups, attributes below
Required:
    - name
Optional:
    - parent_group_name
    - region
    - tags
    - tags_all
    - properties (block):
        - attribute_payload (optional, block):
            - attributes (optional)
        - description (optional)
EOT

  type = map(object({
    name              = string
    parent_group_name = optional(string)
    region            = optional(string)
    tags              = optional(map(string))
    tags_all          = optional(map(string))
    properties = optional(object({
      attribute_payload = optional(object({
        attributes = optional(map(string))
      }))
      description = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.iot_thing_groups : (
        v.parent_group_name == null || (length(v.parent_group_name) >= 1 && length(v.parent_group_name) <= 128)
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

