
# Refer to the docs for a detailed description of the variables - https://docs.appdynamics.com/display/latest/Java+Agent+Configuration+Properties

variable "APPDYNAMICS_CONTROLLER_HOST_NAME" {
  type        = string
  description = "The controller host name without http(s) or port number."

  validation {
    condition     = length(var.APPDYNAMICS_CONTROLLER_HOST_NAME) > 4 && substr(var.APPDYNAMICS_CONTROLLER_HOST_NAME, 0, 4) != "http"
    error_message = "The APPDYNAMICS_CONTROLLER_HOST_NAME value must NOT be empty or null, and must not contain http(s)."
  }
}

variable "APPDYNAMICS_CONTROLLER_PORT" {
  type    = string
  default = "443"
}

variable "APPDYNAMICS_CONTROLLER_SSL_ENABLED" {
  type    = bool
  default = true
}

variable "APPDYNAMICS_AGENT_ENABLE_CONTAINERIDASHOSTID" {
  type    = bool
  default = true
}

variable "APPDYNAMICS_SIM_ENABLED" {
  type = bool
  default = true
  
}

variable "APPDYNAMICS_DOCKER_ENABLED" {
  type = bool
  default = false
  
}

variable "APPDYNAMICS_AGENT_ACCOUNT_NAME" {
  type        = string
  description = "The AppDynamics controller account name."

  validation {
    condition     = length(var.APPDYNAMICS_AGENT_ACCOUNT_NAME) > 0
    error_message = "The APPDYNAMICS_AGENT_ACCOUNT_NAME value must NOT be empty or null."
  }
}

variable "APPDYNAMICS_EVENTS_API_URL" {
  type = string
  validation {
    condition     = length(var.APPDYNAMICS_EVENTS_API_URL) > 4 && substr(var.APPDYNAMICS_EVENTS_API_URL, 0, 4) == "http"
    error_message = "The APPDYNAMICS_EVENTS_API_URL value contain the full URL string and port number, for example: 'https://<host>:9080' ."
  }
}

variable "APPDYNAMICS_GLOBAL_ACCOUNT_NAME" {
  type = string
  validation {
    condition     = length(var.APPDYNAMICS_GLOBAL_ACCOUNT_NAME) > 0
    error_message = "The APPDYNAMICS_GLOBAL_ACCOUNT_NAME value must NOT be empty or null."
  }
}

# Read the access key from vault or environment variable as shown below. Do NOT include it in the code please
# export TF_VAR_APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=xxxx
variable "APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY" {
  type = string

  validation {
    condition     = length(var.APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY) > 0
    error_message = "The APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY value must NOT be empty or null."
  }
  sensitive = true # valid in TF >= 0.14
}

variable "custom_namespace" {
  type = string

}

variable "service_account" {
  type    = string
  default = "appdynamics"

}
