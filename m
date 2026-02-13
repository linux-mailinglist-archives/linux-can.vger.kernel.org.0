Return-Path: <linux-can+bounces-6547-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAnCKDHojmkDFwEAu9opvQ
	(envelope-from <linux-can+bounces-6547-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 10:00:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7413445D
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 10:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E57893041A6B
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4E34C155;
	Fri, 13 Feb 2026 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfsMlhqF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2834C130
	for <linux-can@vger.kernel.org>; Fri, 13 Feb 2026 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973214; cv=none; b=M2xInfIhe4cEuL6B0lSSCKADJsRm6mPPQxFyxH+8iHzTFlbNpLGuvzve8D/n9WcOhql50SbhE/wBbDR+qkg9Q4I/mptf9NQnApY5uMpZHtYk+5g5OG+fc6z8lOhQIjKtWybFmU2AEkzNtQdEY3fVVXA0YFxWqA94PBll7R9UwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973214; c=relaxed/simple;
	bh=QMt8FfN8KplnxAZ7SEihSECQEjA/mEzKp7UgAnlMPjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mx+4y+EVcByqSRPLi4oRuMQ+csY6swRzt4fTrCiUM2gI8GV1cL8Z++4w2JNEYppckPbXjO63T27imGskqMt3JPE2WXBAPRx9fsazqKWIIu2i9RziU5jdJ99sEsdeS6Sx486FEx5ps31QRFKhGLNiSuwR26TUWF74p5AZQ+PiA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfsMlhqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98365C116C6;
	Fri, 13 Feb 2026 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770973214;
	bh=QMt8FfN8KplnxAZ7SEihSECQEjA/mEzKp7UgAnlMPjI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MfsMlhqFhtcqiyVGtzHRp173ujbu6c6DXwpguKAHTD49tkfeZ4w6QK2IV1qDREQt4
	 BGRvLN/zMcDow/PMARlzGThluM3BCKzPY9YjNKduvJGgFmOXZUEjSvv7QYrQNJw6dd
	 7Go5Sq7S0+paJDb+HdmXJ/pOnz93KK7EDOsqFnultXTbsvHZ9vvZU8QZOVHm88nI/1
	 gsv6nhal37+QxvQp2pJTdXLDJuhBUtGRL8EZRr/fHIs80Jg1Y9gHh7+81VEjQG7uWU
	 XIJ575ZZnUt0w/0g5Zh2XHSkkstbVjHCrHwOB8g6m5sYgsAOhofgduWUYepf8Pom80
	 fVwnjRG8X+bWw==
Message-ID: <9bd436f7-b0a1-401c-89c3-bbab2852d533@kernel.org>
Date: Fri, 13 Feb 2026 10:00:11 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: can: es58x: fully try proceeding with partial
 allocations
To: Oliver Neukum <oneukum@suse.com>, swilczek.lx@gmail.com,
 mkl@pengutronix.de, linux-can@vger.kernel.org
References: <20260211104029.83860-1-oneukum@suse.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260211104029.83860-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6547-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,gmail.com,pengutronix.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFD7413445D
X-Rspamd-Action: no action

On 11/02/2026 at 11:40, Oliver Neukum wrote:
> Since b1979778e985 ("can: etas_es58x: allow partial RX URB
> allocation to succeed") es58x_alloc_rx_urbs() sees a failure
> to allocate and submit the full number of URBs as a success
> and the driver will continue at reduced performance.
> 
> However, if you do so, there is no point in abandoning further
> allocations or submissions, just because an earlier one failed.
> 
> Fixes: b1979778e985 ("can: etas_es58x: allow partial RX URB allocation to succeed")
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Thanks. I left some minor comments, but the logic is already
good. Here is my review tag in advance:

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index 19fa51821a89..9dc66932267f 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -1706,12 +1706,13 @@ static int es58x_alloc_rx_urbs(struct es58x_device *es58x_dev)

While at it, can you fix the documentation (which was already
incorrect in the last commmit)?

- * Return: zero on success, errno when any error occurs.
+ * Return: zero if one or more allocation succeeded, errno if all of
+ *	them failed.

>  	u8 *buf;
>  	int i;
>  	int ret = -EINVAL;
> +	int allocated = 0;

Nitpick: put allocated next to i as they are both related:

	int i, allocated = 0;

or

	int allocated;
	int i = 0;

at your convenience.

>  
>  	for (i = 0; i < param->rx_urb_max; i++) {
>  		ret = es58x_alloc_urb(es58x_dev, &urb, &buf, rx_buf_len,
>  				      GFP_KERNEL);
>  		if (ret)
> -			break;
> +			continue;
>  
>  		usb_fill_bulk_urb(urb, es58x_dev->udev, es58x_dev->rx_pipe,
>  				  buf, rx_buf_len, es58x_read_bulk_callback,
> @@ -1723,18 +1724,18 @@ static int es58x_alloc_rx_urbs(struct es58x_device *es58x_dev)
>  			usb_unanchor_urb(urb);
>  			usb_free_coherent(es58x_dev->udev, rx_buf_len,
>  					  buf, urb->transfer_dma);
> -			usb_free_urb(urb);
> -			break;
> +		} else {
> +			allocated++;
>  		}
>  		usb_free_urb(urb);
>  	}
>  
> -	if (i == 0) {
> +	if (allocated == 0) {
>  		dev_err(dev, "%s: Could not setup any rx URBs\n", __func__);
>  		return ret;
>  	}
>  	dev_dbg(dev, "%s: Allocated %d rx URBs each of size %u\n",
> -		__func__, i, rx_buf_len);
> +		__func__, allocated, rx_buf_len);
>  
>  	return 0;
>  }


Yours sincerely,
Vincent Mailhol

