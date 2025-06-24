Return-Path: <linux-can+bounces-3887-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95013AE6DB6
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 19:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7773BA675
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0052D8DB9;
	Tue, 24 Jun 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tL1iALCh"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161A2222D2;
	Tue, 24 Jun 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786739; cv=none; b=P84+6Vjv9Umb2JqsiFhPN81O/rN1VDSm1t4kPOFyw2iyd4vKerLhnicSw334+3al/mxdSsrt3PfdG68FFiFzOI0v2vBZkxTjZsLaeJ319JCb25tG1lwtuJCwDkaT1rtZXWAJ/WK1WKa9FKBU0CEkgSFsQV8VT0Kl7trX+0rRK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786739; c=relaxed/simple;
	bh=ZkCWn0QHam7a5R0rFc2IsQMa/sN1/gjIDqPehWFjAZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffd1l0Ny2sUbI3p8UazIQoFm1rypU3EQWHQ3bqrEh4ALfeVUa/ldgMqSTusVwcO4wPzqZ5NQTHqIghNXiW8bMhICvh1Q1nWW5KRaF6nXv6RXqG6EmPviRsdtlCJN4SlMGriPR6vxNpymiLvC2wNS4jneaQRozCfYmvBENtbiu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tL1iALCh; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id U7T2uunxGIvsEU7T4unzHj; Tue, 24 Jun 2025 19:30:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750786201;
	bh=62W6P0RSf4KxMB1WJp+8zhpz6t6u4Bl2crtn8XVEMj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tL1iALChBzynpGLudnIP/nnGC18KGldMrh0P91m1pYe1TLL+OOcXRhWn+pve8vCef
	 d03I3kPtDAfMFdThhixyjYwlT53DwBuoDAdozQk7qX6kJhienlHYkCNifKXjNDvok4
	 A4OrcrvAmxJWrtYgeYtkbUFfVcMidMlHQJ8VK95j6q0EnmgSEwgZEjGylO6fqO/5Z9
	 XScJAJTqhDbJhp4thcLsD11yllXSBvh7wmpeY0KW/L3jlSQFVx/zEI3AKIyZUpRnre
	 I+1NLFdtjK2WpH12ccDmDCD0sp34lY3ONk3u+/8vaKITiCVuz1cO4mGWYVOIZY4R7f
	 ivWB+V2VRt5QQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Jun 2025 19:30:01 +0200
X-ME-IP: 124.33.176.97
Message-ID: <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
Date: Wed, 25 Jun 2025 02:29:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: ucan: Use usb_endpoint_type() rather than
 duplicating its implementation
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Markus,

On 25/06/2025 at 02:12, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 24 Jun 2025 19:05:04 +0200
> 
> Reuse existing functionality from usb_endpoint_type() instead of keeping
> duplicate source code.
> 
> The source code was transformed by using the Coccinelle software.

Looking at the helpers in linux/usb/ch9.h, it seems that Coccinelle missed many
simplifications.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Can you use the same e-mail address for signing and for sending the patch?

> ---
>  drivers/net/can/usb/ucan.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index 07406daf7c88..3c8dad8bcca4 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -1353,16 +1353,14 @@ static int ucan_probe(struct usb_interface *intf,
>  		ep = &iface_desc->endpoint[i].desc;
>  
>  		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is:

	usb_endpoint_dir_in(ep)

> -		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> -		     USB_ENDPOINT_XFER_BULK)) {
> +		    usb_endpoint_type(ep) == USB_ENDPOINT_XFER_BULK) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is:

	usb_endpoint_xfer_bulk(ep)

>  			/* In Endpoint */
After changing to usb_endpoint_dir_in(ep), this comment can be removed.

>  			in_ep_addr = ep->bEndpointAddress;
>  			in_ep_addr &= USB_ENDPOINT_NUMBER_MASK;
>  			in_ep_size = le16_to_cpu(ep->wMaxPacketSize);
>  		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) ==
>  			    0) &&
> -			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> -			    USB_ENDPOINT_XFER_BULK)) {
> +			   usb_endpoint_type(ep) == USB_ENDPOINT_XFER_BULK) {

Similarly as above use:

	usb_endpoint_dir_out(ep)

and:

	usb_endpoint_xfer_bulk(ep)

>  			/* Out Endpoint */
>  			out_ep_addr = ep->bEndpointAddress;
>  			out_ep_addr &= USB_ENDPOINT_NUMBER_MASK;


Yours sincerely,
Vincent Mailhol


