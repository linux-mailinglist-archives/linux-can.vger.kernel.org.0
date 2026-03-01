Return-Path: <linux-can+bounces-6653-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNrRITitpGmtowUAu9opvQ
	(envelope-from <linux-can+bounces-6653-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Mar 2026 22:18:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB901D19C1
	for <lists+linux-can@lfdr.de>; Sun, 01 Mar 2026 22:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6BA7300460A
	for <lists+linux-can@lfdr.de>; Sun,  1 Mar 2026 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15E430B9F;
	Sun,  1 Mar 2026 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca72z6Yy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1F430B89;
	Sun,  1 Mar 2026 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772399920; cv=none; b=Dqu7FLfzQTlX+EyRk3xExUiOjqVf4rWu6jnwHlZ3CciOEMOz/m2LBwqm+1rLAN3j/r7zCcXxsUva6ISFB0MJoBKQbHZTSSBcZeHqHIefnAuOf8c+WvK6qkDF0BkC8raDAGXyyx4//r9T1JWYHPds6JRILXCQ7Q/B4bsaMIK/G8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772399920; c=relaxed/simple;
	bh=E3lqFJDzQ9T/4PeH5nrHAvyZ7JMPoAr/UsofvYY2bu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBmwyBO+OjbXhp9lPBFZBRhX+g0/4edMIXQiK0Us5P+q/ircRKRHYRthShu78jXo9LrLtLix2lBjknKuUZjojgiz1D3I5GfjfaHLRmQxOXxur1MJ6ozKYtmSvDy/zMeBlFDvQHlJXhuNrc0Vn/M/RYUyqzI/eVos8p05iOFmlHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca72z6Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C8BC116C6;
	Sun,  1 Mar 2026 21:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772399919;
	bh=E3lqFJDzQ9T/4PeH5nrHAvyZ7JMPoAr/UsofvYY2bu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ca72z6Yyp6Akz9u5SNKg6OwqSrVly7ZCN75UHkaCoDB5XFDfDB/+uEU/pdX5MJLgD
	 7MrvzuqAGvlRUpbi3kZ7Rto58jZjgNejCMeLdxWr8jwD5cFtrFExPIVYVHJJpiFwHv
	 TCJmvprstYfkH7U3zsOzlbngKXPh8LLnzjbmefv/GzUNPS7RasOEv08+ET9bejzJ7Z
	 Y0nv2cowmo7OgQVKpbn6yqZUMBuq3UVmAbkBRAx0OT5cuqhxRSvFRn9vly9o6krRnK
	 /hVXuhaVl4sp6G0UNzzcUgSmEpBybfOPGu23vXjSbWfzXtVxEaOy5ONm3Y3MvzNU/w
	 oWijP4drU6VAw==
Message-ID: <2e05a4d5-b42c-4c3d-812a-8e8ddb94cec1@kernel.org>
Date: Sun, 1 Mar 2026 22:18:35 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: usb: etas_es58x: correctly anchor the urb in the
 read bulk callback
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 stable <stable@kernel.org>, linux-can@vger.kernel.org
References: <2026022320-poser-stiffly-9d84@gregkh>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: fr-FR, en-GB
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <2026022320-poser-stiffly-9d84@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6653-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CB901D19C1
X-Rspamd-Action: no action

On 23/02/2026 at 17:39, Greg Kroah-Hartman wrote:
> When submitting an urb, that is using the anchor pattern, it needs to be
> anchored before submitting it otherwise it could be leaked if
> usb_kill_anchored_urbs() is called.  This logic is correctly done
> elsewhere in the driver, except in the read bulk callback so do that
> here also.

I can explain why this bug went through the cracks. When I wrote this
driver, I was actually wondering whether I had to manually re-anchor the
urbs. I checked the documentation of usb_submit_urb() and
usb_fill_bulk_urb() but there was no mention that the urb will be
unachored by the framework before calling urb->complete(). And so, I
assumed that it would stay anchored. And I ended up just anchoring them
once at creation and then reuse them without paying attention to the
anchor any more.

Now that I see your patch, I had a look at the code source and can see
that indeed __usb_hcd_giveback_urb() will unanchor the urbs.

Anyway, thanks for the fix!

> Cc: Vincent Mailhol <mailhol@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Tested-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


