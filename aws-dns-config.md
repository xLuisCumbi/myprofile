# AWS DNS Configuration for xluiscumbi.com

This document provides the necessary DNS configurations to set up your domain with AWS services.

## Route 53 Configuration

### Primary Domain Records

| Record Type | Name               | Value/Target                                                          | TTL     |
| ----------- | ------------------ | --------------------------------------------------------------------- | ------- |
| A           | xluiscumbi.com     | CloudFront Distribution Domain (example: d1234abcdef8.cloudfront.net) | 300 sec |
| AAAA        | xluiscumbi.com     | CloudFront Distribution Domain (example: d1234abcdef8.cloudfront.net) | 300 sec |
| A           | www.xluiscumbi.com | CloudFront Distribution Domain (example: d1234abcdef8.cloudfront.net) | 300 sec |
| AAAA        | www.xluiscumbi.com | CloudFront Distribution Domain (example: d1234abcdef8.cloudfront.net) | 300 sec |

### Email Records (if using a third-party email provider)

| Record Type | Name           | Value/Target                          | TTL      |
| ----------- | -------------- | ------------------------------------- | -------- |
| MX          | xluiscumbi.com | 10 mail.provider.com                  | 3600 sec |
| TXT         | xluiscumbi.com | v=spf1 include:_spf.provider.com ~all | 3600 sec |

## S3 Bucket Configuration

### Primary Bucket (xluiscumbi.com)
- Static website hosting: Enabled
- Index document: index.html
- Error document: index.html (for SPA support)
- Bucket policy: Allow public access for website

### Redirect Bucket (www.xluiscumbi.com)
- Static website hosting: Enabled
- Redirect all requests to: https://xluiscumbi.com

## CloudFront Configuration

### Distribution Settings
- Origin: S3 bucket website endpoint (xluiscumbi.com.s3-website-us-east-1.amazonaws.com)
- Viewer protocol policy: Redirect HTTP to HTTPS
- Allowed HTTP methods: GET, HEAD, OPTIONS
- Cached HTTP methods: GET, HEAD
- Cache policy: Managed-CachingOptimized
- Custom error responses:
  - 404: /index.html, 200 (for SPA support)
  - 403: /index.html, 200 (for SPA support)

### SSL/TLS Certificate
- Use AWS Certificate Manager to create a certificate for:
  - xluiscumbi.com
  - www.xluiscumbi.com

## Security Recommendations

1. Enable AWS WAF for CloudFront distribution with basic rules:
   - Block common web exploits
   - Rate limiting
   - Geo-restrictions (if needed)

2. Implement bucket policies that restrict access to only CloudFront

3. Use Origin Access Identity (OAI) or Origin Access Control (OAC) to secure S3 access

## Post-Deployment Verification

- Test https://xluiscumbi.com
- Test https://www.xluiscumbi.com (should redirect to non-www)
- Verify SSL certificate is valid and working
- Check response headers for security headers
- Test mobile responsiveness
- Verify that page loads quickly (< 3 seconds)

---

*Note: Replace placeholder domains and values with your actual configuration details.* 