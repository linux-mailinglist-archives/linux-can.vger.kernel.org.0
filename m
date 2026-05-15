Return-Path: <linux-can+bounces-7633-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPksI5oLB2oLrAIAu9opvQ
	(envelope-from <linux-can+bounces-7633-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 14:03:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12C54F036
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 14:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52C43031E8C
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517204779A5;
	Fri, 15 May 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpTCpvQl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8313D1AA6;
	Fri, 15 May 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844858; cv=none; b=LquD4/saXP9CTp4mRc+sB8hkmqf2OErQ+dFK2MqZmN+8F5AksE9nkW/GIzlq24hJ8x6CyitJNOJNfcWjEKMfk31txSk7qGt4CX/nxXPhKQx9MWMLb6eYBSNDk1KeMJfrBmKMyXup0U7Pr9ZLw8f/+fE309SY+2JVZT7YxDoTgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844858; c=relaxed/simple;
	bh=1FDeHDEihOYWGU48h11uUqCbV/FhBSzI+ffcgiaXOgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7IXBBY/SYXN6qsV48/PhI4lcFax+vy4VLEfPe/nL7F1i1lxoXlDcQ6X3iVlTRr5qFY8/mK87HzIShC6OZdktz8dHFvEy7vGyqm5la/db39UxK3JMlW/J3zBLr65efQqXg0KFKi+KTiZCfyy5ieNaAVWpL9hCnpl9WTfzC2cfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpTCpvQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF5BC2BCB0;
	Fri, 15 May 2026 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844857;
	bh=1FDeHDEihOYWGU48h11uUqCbV/FhBSzI+ffcgiaXOgQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DpTCpvQlqbD5S3i/gSC33LGkntaQMWYrwBRML46VlV+ptynwER/RsopTcxebbSlBr
	 37ReXWi/oGCpeqaOmk/+4e9qbd/mqxHMcnm/da/rHBrBbUumeRjQnF6cQ4WaqULyEf
	 MAGCjNLBDkUOX6j9l9An8/tsu3uQXDz58UYjJJcHusRD4Hj81uoT85qXm6ZvQfgYxZ
	 lHDSLpJHmD8Z5vwRpkb5x2G2KatqpXj5GazZxeD3v399F87ObOa90CJtNt0tndS8N9
	 mLJ0znlskv6Mc3d5OzldPV11u7PRw3PEL9sbRTEsI/MLfSWo0g8+l/O8WSMNiVxxrj
	 7jNIBHi9gOvJA==
Message-ID: <e6ad1a37-2c78-44cd-9004-bdadf73b7042@kernel.org>
Date: Fri, 15 May 2026 13:34:14 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: peak_usb: Add bounds check for USB channel index
To: James Gao <jamesgao5@outlook.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, s.grosjean@peak-system.fr,
 linux-kernel@vger.kernel.org
References: <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0A12C54F036
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7633-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On 13/05/2026 at 11:51, James Gao wrote:
> The channel control index ctrl_idx is derived from rx->len which comes
> directly from a device USB payload. The mask 0x0f allows values 0-15,
> but the array size of usb_if->dev[] is only 2. Values 2-15 cause heap
> out-of-bounds read, eventually causing kernel panic in the IRQ context.
> 
> Add bounds checking for ctrl_idx before the array access in both
> pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error().
> 
> Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
> Signed-off-by: James Gao <jamesgao5@outlook.com>
> ---
> 
> Hi Marc,
> 	Thanks for the review for v1. Since this is not a security bug I have
> 	moved the discussion to public mail list. Changes in v2:
> 	- Use ARRAY_SIZE(usb_if->dev) instead of PCAN_USBPRO_CHANNEL_COUNT
> 	- Use -EINVAL instead of -ENOMEM
> 	- Add newline between variable declaration and bounds check
> 	- Wrap commit message
> 
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index 4bfa8d0fbb32..5b1e3501cfb8 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -534,6 +534,10 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
>  				      struct pcan_usb_pro_rxmsg *rx)
>  {
>  	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
> +
> +	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
> +		return -EINVAL;

Please don't tangle declarations and expressions.

	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
	struct peak_usb_device *dev;
	struct net_device *netdev;
	struct can_frame *can_frame;
	struct sk_buff *skb;
	struct skb_shared_hwtstamps *hwts;

	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
		return -EINVAL;

	dev = usb_if->dev[ctrl_idx];
	netdev = dev->netdev;

Aside from that, looks OK.

>  	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
>  	struct net_device *netdev = dev->netdev;
>  	struct can_frame *can_frame;
> @@ -573,6 +577,10 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
>  {
>  	const u16 raw_status = le16_to_cpu(er->status);
>  	const unsigned int ctrl_idx = (er->channel >> 4) & 0x0f;
> +
> +	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
> +		return -EINVAL;

Same comment as above.

>  	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
>  	struct net_device *netdev = dev->netdev;
>  	struct can_frame *can_frame;


Yours sincerely,
Vincent Mailhol


