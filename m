Return-Path: <linux-can+bounces-7860-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Yf0DGAsMWrMdAUAu9opvQ
	(envelope-from <linux-can+bounces-7860-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:58:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C268E8E5
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kkjnEe68;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7860-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7860-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0C973004DD7
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63937438FF3;
	Tue, 16 Jun 2026 10:58:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830D438FEE;
	Tue, 16 Jun 2026 10:58:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607512; cv=none; b=WIYcpmVjbmDtHLL9x1shWJZ1aPYs2s9VmsAHOuiRIvYxrf9JA2O0q5UV0TIoWAVgk6EBa+u17B2vryb6Ebd0Br/85h9UGuzaWqk8ohObVcPCzJtGsW6Bdk7C524Pk9wos+y34gDd7CxTOwSWrNdKB/+jPCmlv1HMgfnKRxBRLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607512; c=relaxed/simple;
	bh=gdQ/OQE4KvajHnBO+LPgKQOhQ4VIJh1CV5auB0zG3+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjnFdGfRWb/yTmt2wu20yInHIR5fR0W/mW9sV4EzUBuM4e0vLNjsbhRnZWlFC5TaR41KddaNM6Al+fxm1ZqT6DDgZb5LXZm+xPCZbFvC+kIfE6qstL+fopO4fQo2kYzwJcYeIwwYD3jt8grd6yJTz5KuRtcNwOSzzwwKZ80C7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkjnEe68; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7E31F000E9;
	Tue, 16 Jun 2026 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607510;
	bh=uTtFW87xdgLkBr+tFLMF/ATH9JwQOvw5EFnjNVaZaeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kkjnEe68pRqyW5Vg2DRyhbTv0bAP3VC4Ln+Fdw00CeeP9yXeV82Fuvn7Rfulzoam1
	 +xgCvtGHRykRPjv63eMsIKkOtxWsI3hDi8XLkvMzE4f50xrGfPDROBYuTcBPHSm4Ml
	 xKKEjGBdNIipHfU3gqfeZpTrtm+GlWMCTNJ+CQERVdDSBd3dZ9F+5RzKhlRoZXMYPt
	 UN2UH7zFK5f4iWLd3Nsuyf7pnUqpbUyXdth0xrp9r9IqUFad1cqF/5/PfnyoDt9hhf
	 x0JKvBfj5fpjZkdkW/wNT9Tsi/bpNY/LCCi55fmQUVi9yomogcf75+PjrsJBXsTCe2
	 lNp4uDCqAPqzg==
Message-ID: <d4b8d6ed-e3ab-45a4-a278-a2f240425f31@kernel.org>
Date: Tue, 16 Jun 2026 12:58:27 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: peak_usb_start(): double free of RX buffer when usb_submit_urb()
 fails
To: Maoyi Xie <maoyixie.tju@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <178159320216.2154888.16953451793788581739@maoyixie.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <178159320216.2154888.16953451793788581739@maoyixie.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:mkl@pengutronix.de,m:stephane.grosjean@hms-networks.com,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7860-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D28C268E8E5

On 16/06/2026 at 09:00, Maoyi Xie wrote:
> Hi all,
> 
> I was going over the USB CAN drivers that use URB_FREE_BUFFER after the lan78xx
> double-free fix, and I think peak_usb_start() in
> drivers/net/can/usb/peak_usb/pcan_usb_core.c can free an RX transfer buffer
> twice on the usb_submit_urb() error path. I am not totally sure, so I would
> appreciate it if you could let me know whether you see this as a real problem.
> 
> This is the relevant part of the RX URB loop in 7.1-rc7.
> 
> 	buf = kmalloc(dev->adapter->rx_buffer_size, GFP_KERNEL);
> 	...
> 	usb_fill_bulk_urb(urb, dev->udev,
> 		usb_rcvbulkpipe(dev->udev, dev->ep_msg_in),
> 		buf, dev->adapter->rx_buffer_size,
> 		peak_usb_read_bulk_callback, dev);
> 
> 	/* ask last usb_free_urb() to also kfree() transfer_buffer */
> 	urb->transfer_flags |= URB_FREE_BUFFER;
> 	usb_anchor_urb(urb, &dev->rx_submitted);
> 
> 	err = usb_submit_urb(urb, GFP_KERNEL);
> 	if (err) {
> 		if (err == -ENODEV)
> 			netif_device_detach(dev->netdev);
> 
> 		usb_unanchor_urb(urb);
> 		kfree(buf);
> 		usb_free_urb(urb);
> 		break;
> 	}
> 
> URB_FREE_BUFFER is set on the URB before submit, so buf belongs to the URB. When
> the URB is finally destroyed, urb_destroy() frees that buffer for us with
> 
> 	if (urb->transfer_flags & URB_FREE_BUFFER)
> 		kfree(urb->transfer_buffer);
> 
> So in the error path kfree(buf) frees the buffer once, and then usb_free_urb(urb)
> frees the same buffer a second time through urb_destroy(). That looks like a
> double free of the kmalloc'd RX buffer.
> 
> The error path is taken when usb_submit_urb() returns non-zero, e.g. -ENODEV if
> the device is removed while the CAN interface is being brought up (ip link set
> canX up), or -ENOMEM / endpoint errors. A device that disconnects at the wrong
> moment, or otherwise makes the submit fail, would hit it.
> 
> I do not have a PCAN-USB adapter, so I reproduced just the buffer handling on
> 7.1-rc7 under KASAN. A small harness replays the exact sequence above
> (URB_FREE_BUFFER set, then kfree(buf), then usb_free_urb(urb)), and KASAN reports
> the second free.
> 
>   BUG: KASAN: double-free in usb_free_urb.part.0+0x91/0xb0
>   Free of addr ffff8881069ccb80 by task trigger.sh/285
>    kfree+0x113/0x3c0
>    usb_free_urb.part.0+0x91/0xb0          <- second free, via urb_destroy()
>   ...
>   Freed by task 285:
>    kfree+0x137/0x3c0                       <- first free, the explicit kfree(buf)
>   ...
>   The buggy address belongs to the object at ffff8881069ccb80
>    which belongs to the cache kmalloc-64 of size 64
> 
> (The harness allocates a 64-byte buffer, which is why KASAN shows kmalloc-64,
> while the real driver allocates dev->adapter->rx_buffer_size.) The first free is
> the explicit kfree(buf), and the second is usb_free_urb() going through
> urb_destroy() and freeing urb->transfer_buffer because URB_FREE_BUFFER is set.
> 
> The smallest fix I could see is to drop the redundant kfree(buf), since
> usb_free_urb() already releases the buffer. This is what commit 03819abbeb11
> ("net: usb: lan78xx: Fix double free issue with interrupt buffer allocation")
> did for the same pattern.
> 
> 	 		usb_unanchor_urb(urb);
> 	-		kfree(buf);
> 	 		usb_free_urb(urb);
> 	 		break;
> 
> With that one-line change the same harness frees the buffer exactly once and the
> KASAN report is gone.
> 
> It looks like this has been there since the driver was first merged
> (bb4785551f64), so if it is a real bug it would be a stable candidate.
> 
> I would appreciate it if you could let me know whether you agree this is a real
> double free and whether dropping the kfree(buf) is the right fix. I am happy to
> send a proper patch with the reproducer once you confirm.

Thanks for the well written report. I looked at the code, and I can
confirm that usb_free_urb() calls usb_destroy() if no one is using the
urb anymore. And finally usb_destroy() calls

  kfree(urb->transfer_buffer);

leading in the double free.

So, same conclusion as you. You can send a patch. Now that you sent a
report, don't forget to add the Closes tag to your patch:

Closes: https://lore.kernel.org/linux-can/178159320216.2154888.16953451793788581739@maoyixie.com/T/#u

Not sure that you need to include the full reproducer in your patch
message. The BUG: KASAN log is enough. But if you want, you can still
post your reproducer in this thread.


Yours sincerely,
Vincent Mailhol

