
variable "appname"{
    description = "name of application to deploy"
    type        = string
    default     = "web-application-two-tier"
} 

variable "environment" {
	description ="enviromnet dev val ref prod for the application"
	type = string
	default= "dev"
}
