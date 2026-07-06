Return-Path: <linux-can+bounces-8005-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cttsK9NVS2qGPgEAu9opvQ
	(envelope-from <linux-can+bounces-8005-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 09:14:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB070D67F
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 09:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=X8B3Qgs3;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8005-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8005-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC6603037C01
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B8F48AE1B;
	Mon,  6 Jul 2026 06:49:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE43BE627;
	Mon,  6 Jul 2026 06:49:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320591; cv=none; b=BrSd8FZrjqkrltqu/7A1sPa/ruV1G/FcYTm+OCg6x4Nq6vAlaIJLfo9eFHam0+uCHrR2KePylMGN0O/pJwWhahCLg3bCncApNq4hOIQQQJosSa4tqOInhzxfnuXk5iLNDRM380C8DKz9k7ObIyGKWVKt+4lqShfSFM2ziq4f7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320591; c=relaxed/simple;
	bh=3ZbYgyG7jFT7lj5ShRbMBH/iDvRIoA0F97RZxMptZQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/ZNiQ0G7QEdta3YERXuBpFWWCNDYYgG3naMIBYZkBA2Wl7aeCCcIauwx5zkgax2xfcqdx4kH4rOCpQh9okMFr/wCabJT9slnimMhtsY0bFJeJYrsoPZgoWi2WQ8D0Jte0y7hKXOB2aEhPnsvRhqmv546V3c/2fegIvUlJ5UkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8B3Qgs3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26F81F00A3A;
	Mon,  6 Jul 2026 06:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783320584;
	bh=yoQW0ip4pf8WcdK1NCQOxgm3gdLgYSS3HqHm1zapnA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X8B3Qgs3a6RqmlBMS5xVo1UC6MzCpTlsFqr1wic1Em8aTmW1UA7dWWBtmaATHz0Fl
	 RvQ+2KpNdhVMVb3t+iD5irkbKe1PuOjm4f3fckJUv62rj49L6c0VaGe1Q/0u37ukry
	 igJqsZ20NBKlWUHH/Yoka+FWiFFYFE3u55gO+TJY=
Date: Mon, 6 Jul 2026 08:48:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] can: usb: etas_es58x: Fix RX buffer leak on URB
 resubmit failure
Message-ID: <2026070621-clothing-crevice-ecbc@gregkh>
References: <20260706014601.415445-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706014601.415445-1-lgs201920130244@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-8005-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5EB070D67F

On Mon, Jul 06, 2026 at 09:46:01AM +0800, Guangshuo Li wrote:
> es58x_read_bulk_callback() resubmits the RX URB after processing a
> received packet. If the resubmit succeeds, the URB remains anchored and
> will be handled by the normal RX path or by teardown.
> 
> However, if usb_submit_urb() fails, the callback unanchors the URB and
> then returns directly. This skips the existing free_urb path, so the
> coherent transfer buffer allocated with usb_alloc_coherent() is not
> released.
> 
> Reuse the existing free_urb path after a resubmit failure so that the RX
> coherent buffer is freed before leaving the callback.
> 
> Fixes: 5eaad4f76826 ("can: usb: etas_es58x: correctly anchor the urb in the read bulk callback")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> v3:
>   - Regenerate the patch against the correct base so it removes the
>   original return statement instead of the v1-added goto.
>   - Add the missing changelog. No functional change intended.
> 
> v2:
>   - Remove the redundant goto and let the error path fall through to
>     free_urb, as suggested by Vincent Mailhol.
>   - Add Vincent's Reviewed-by tag
> 
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index b259f6109808..e1724ae79c5a 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -1476,7 +1476,6 @@ static void es58x_read_bulk_callback(struct urb *urb)
>  		dev_err_ratelimited(dev,
>  				    "Failed resubmitting read bulk urb: %pe\n",
>  				    ERR_PTR(ret));
> -	return;
>  
>   free_urb:
>  	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

