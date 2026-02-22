Return-Path: <linux-can+bounces-6605-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCNTGS7/mmlKpQMAu9opvQ
	(envelope-from <linux-can+bounces-6605-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 14:05:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A968D16F1CB
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 14:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FEA63010DA0
	for <lists+linux-can@lfdr.de>; Sun, 22 Feb 2026 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75972586C2;
	Sun, 22 Feb 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT/aGr3j"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3454227BB5;
	Sun, 22 Feb 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765545; cv=none; b=kkadpr/Wse5uoKFXtARw2F0b/0PU3nG+JWbwm0CMQXkHKT/GaIg+aYTbVai0dQXxS2largP+QG8C+WU3ZBN457YKfDypzpQqIfrBvklsjUj5ktMCN0yvgLCZ6xsGDWGisot+OVNblPI0NSmC/z2vVRqvgs83843/M5ffQCWwjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765545; c=relaxed/simple;
	bh=1svqwJU+HEc2mBoOCoJ1f1bC/eF+g1aMSJaQBwG9mzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SovMTFF9xQfoPARkfxZeNx2my1BNzZuP7PUhVPgliqgfLHnMmE8EWtBtArBWeEDyQ803DRxLyDFMCCWQRNNI4eiezd9eThff5QlMYvvJQ6RGfpn4qP1jHUR7z64v8twMagKLUrA4ukLgdCGoOBTYPT06rDLNvtjNl0WLS/mXnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT/aGr3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9CCC116D0;
	Sun, 22 Feb 2026 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771765545;
	bh=1svqwJU+HEc2mBoOCoJ1f1bC/eF+g1aMSJaQBwG9mzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jT/aGr3jQcZBHekvISumDGWgp5qlHogc9x4W24TwG4agEE+ANPzO4WccMiXTkdjEo
	 nchYi+iX9vkwkCwOTrAvlznj0vwox3FKG6Bv8g/NN1ji/DnIyxXA73R1/krhwU+dOm
	 Qn3yRO4gf7VuZK08KP+iIPg7A9ZbbxC/e41l8wxRstW7tp6L/xWsArDCFihug7qm7Z
	 VPShFndEpOucFB5Ejgtwo5LZTJOkYFEw152b3bkqjs3Nu/OmTki0Cd+/E7CbUNtzDw
	 EQy3q/ZpCnQWijmn31utvGedjQAJHzG7nNEPAD5ZQd7nIAJASwBzTTDHw2QxsFGnNE
	 QlRxAPewJ5PtQ==
Message-ID: <f487df33-03f9-43ae-961b-a8a3a7d6cd24@kernel.org>
Date: Sun, 22 Feb 2026 14:05:39 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: esd_usb: add endpoint type validation
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: socketcan@esd.eu, "David S . Miller" <davem@davemloft.net>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Jungclaus <frank.jungclaus@esd.eu>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260213203927.599163-1-n7l8m4@u.northwestern.edu>
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
In-Reply-To: <20260213203927.599163-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6605-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,northwestern.edu:email]
X-Rspamd-Queue-Id: A968D16F1CB
X-Rspamd-Action: no action

On 13/02/2026 at 21:39, Ziyi Guo wrote:
> esd_usb_probe() constructs bulk pipes for two endpoints without
> verifying their transfer types:
> 
>   - usb_rcvbulkpipe(dev->udev, 1) for RX (version reply, async RX data)
>   - usb_sndbulkpipe(dev->udev, 2) for TX (version query, CAN frames)
> 
> A malformed USB device can present these endpoints with transfer types
> that differ from what the driver assumes, triggering the WARNING in
> usb_submit_urb().
> 
> Use usb_find_common_endpoints() to discover and validate the first
> bulk IN and bulk OUT endpoints at probe time, before any allocation.
> Found pipes are saved to struct esd_usb and code uses them directly
> instead of making pipes in place.
> 
> Similar to
> - commit 136bed0bfd3b ("can: mcba_usb: properly check endpoint type")
>   which established the usb_find_common_endpoints() + stored pipes
>   pattern for CAN USB drivers.
> 
> Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
> Suggested-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>

Thanks for this v2.

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>



Yours sincerely,
Vincent Mailhol


