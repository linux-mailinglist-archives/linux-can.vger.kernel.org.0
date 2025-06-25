Return-Path: <linux-can+bounces-3898-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD379AE88C8
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 17:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8589D3AE728
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14B289371;
	Wed, 25 Jun 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SybvCI35"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987561C6FEC;
	Wed, 25 Jun 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866694; cv=none; b=BI/HkmLWv7BNLnGSbwjSlFR69iT3bTfbqElmKS4wqlsTemVA1F3pa5K2a4pI6eXaUQN1zWEwj3PQhFl/LjK4lKD+WNPlOQgLZCPklsoLFw9jSY8fhrHVdJc/k68kngnCGwYbWc8UxLQOH90+kIDpZTsNE618251sw0e9Zh6yX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866694; c=relaxed/simple;
	bh=Lh+Fs56s5iuB2XZIAVcn4VB3LtPRtc9SeX5P0H7rWHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzo14qj1OsifFJtg2KRp+C05eyUDMQiIZq2bAwbb45DKEC4F9tqYhwZ8tbjacfowPx7dKoUGvPmHorNQu180F6TUddRQws13TccBSTlIEjHWUveb58UxdRvppxCDM+RmpJnIhkF0POqFOiOH0HBxe5tWESqvbS/xh7dCS1maxAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SybvCI35; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id USPEuXvuXTg88USPFuIrxp; Wed, 25 Jun 2025 17:51:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750866688;
	bh=IJC95HDaDGixU28OmDl2k4GhpotG5diJ0LI0qo0ZsRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SybvCI35aPVjgaOgNbURyu75B+S0oQlK1ctNa73vXLnVIUiQeybJuNDPZmLowoWZl
	 lrPB/c2ss8AqNAy1BazEvRAVTTqOdnB+mX67OpJH7Hwl6k32HIAOsb2vVoKNAoZM07
	 tBmDrHWwDVqZ2StB+c3WZjCpzLi/pBz8Ai9/YqZ28ITLEhUaL3EkWPIsYj0NF1dfhe
	 lHh1eDVQ5IRS1iYq00yfian2TaWsQjV8tjiG4HpBKSGVDOHCX2MJjXSD/R1rctQtmY
	 agOF+q3HSK/rrpLwuSsg2ro+UF2VaKR8XsiaPymrj/kvKHL2nWHfoCXkI8L7jJbdOX
	 xhSNYuR/T2ZiQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 25 Jun 2025 17:51:28 +0200
X-ME-IP: 124.33.176.97
Message-ID: <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
Date: Thu, 26 Jun 2025 00:51:24 +0900
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
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
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
In-Reply-To: <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2025 at 14:47, Markus Elfring wrote:
>>>> it seems that Coccinelle missed many simplifications.
>>> Would such software transformations become better supported anyhow?
>> Maybe?
>>
>> I am not involved in the development of Coccinelle and thus, I don't have an answer.
> 
> This can be fine (in principle).
> 
> 
>> Nor do I have the time to read and understand the Coccinelle source code
>> to which you pointed me to.
> 
> I hope that more users can become interested in presented information.
> I would appreciate if knowledge representations can be improved also for
> better automatic data processing and corresponding transformations.

A real quick search shows me that this ucan driver is not an isolated case. Here
is an example:

https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/media/rc/imon.c#L2137-L2148

But it does not seem to occur so often either. So not sure what is the best: do
a manual hunt or write a coccinelle checker. I let you be judge here.

>> My stance is that such static analyzers should never be trusted 100%.
> 
> This is generally fine.
> 
> 
>> The output is more an indicator.
> 
> This is usual.
> 
> 
>>                       And in this present case, a quick review made it very
>> clear that Coccinelle saw one simplification but missed two other ones.
> 
> Would you find another source code adjustment (like the following) more appropriate?

Yes. What you are proposing below is aligned with my initial comments.

> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index 07406daf7c88..6c6cee3895c6 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -1352,17 +1352,12 @@ static int ucan_probe(struct usb_interface *intf,
>  	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
>  		ep = &iface_desc->endpoint[i].desc;
>  
> -		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
> -		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> -		     USB_ENDPOINT_XFER_BULK)) {
> +		if (usb_endpoint_dir_in(ep) && usb_endpoint_xfer_bulk(ep)) {
>  			/* In Endpoint */
                           ^^^^^^^^^^^
Maybe just remove this comment. After migrating to usb_endpoint_dir_in(ep), this
comment is just paraphrasing the code and has no more reasons to stay.

>  			in_ep_addr = ep->bEndpointAddress;
>  			in_ep_addr &= USB_ENDPOINT_NUMBER_MASK;
>  			in_ep_size = le16_to_cpu(ep->wMaxPacketSize);
> -		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) ==
> -			    0) &&
> -			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> -			    USB_ENDPOINT_XFER_BULK)) {
> +		} else if (usb_endpoint_dir_out(ep) && usb_endpoint_xfer_bulk(ep)) {
>  			/* Out Endpoint */
                           ^^^^^^^^^^^^
Same.

>  			out_ep_addr = ep->bEndpointAddress;
>  			out_ep_addr &= USB_ENDPOINT_NUMBER_MASK;
> 
> 
> Can the functions “usb_endpoint_is_bulk_in” and “usb_endpoint_is_bulk_out”
> be applied here?
> https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/usb/ch9.h#L572-L595

Further simplification, nice :)

I didn't see that last one, so glad you found what seems to be the optimal solution!


Yours sincerely,
Vincent Mailhol


