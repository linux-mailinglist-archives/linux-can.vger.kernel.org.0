Return-Path: <linux-can+bounces-6482-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIEpJRIggmlIPgMAu9opvQ
	(envelope-from <linux-can+bounces-6482-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 17:19:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5FDBCF4
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 17:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB48A315CDA8
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A63D1CAE;
	Tue,  3 Feb 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qKAWEqHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHCHn4Fv"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534843D1CA0;
	Tue,  3 Feb 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135113; cv=none; b=GiRCj7THaS/aDKjh1nZyBM782VhIyVgJgIteZXrn12zIFVKRmedW+PwgTrPT74M8MMKTun/iGY7syv16JuYCvrgIlwO+fqz4clEnEIVvtClsbRTT5CbPWfQ8x7l/CeJPTTfyof+4vx6t1D+uoVgQWdWFDU0RMN+yMOMdmoqsgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135113; c=relaxed/simple;
	bh=9a6MDBZBr2S7DTcvsZmMvwhafM53LBpFJ/OzmyZ9jzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4N2Hzyx7mKELZJTx29IxWIrgh3p2QiyjDbj2PizUxQJe/MIYw/OlQh6gzXZLjdZEQ765O03PCpEcGFafyhm8bpGwJ5YrkJ8zJtQNvcDcCM0yGxwEbeBhc2Q3QXMOAYgN7xSGtc+EZR2iylLbYjsDCoqP7Te3kP9/sZIke1rRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=qKAWEqHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHCHn4Fv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 548C0EC008E;
	Tue,  3 Feb 2026 11:11:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Feb 2026 11:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770135110; x=1770221510; bh=S8DdY7OHjj
	q7ubDcTpspMFvxxPIy4NvGM1w3tP/IR74=; b=qKAWEqHgEgF3XeY8GPtEyZ7xwV
	NTNMWTYphp6Diolc0wISxvpiKowIU9G2cSFmAl0oewdtfFUnl/ccD2gxr900ze1X
	fnMWAHPsPIdYB96/2v5YW9EYrL7IQUW4wXgVPIdEALiBVwTv33LmZ0BefBTsC7kW
	kXNBbsfq/dvMvOoyCU5Xb2SpXz7040mbvrAYuPXx3+AWOMurIPDneHTsuRd3l0QA
	Tf0jzZEdd1B5zbykggsw6aAiwZzJcC5ohj+ueIQJb0mKkN1Rdla4Lo1b074VYq2z
	l4jpYTYjB4Aacla9P2okZRFzVk4Oz1YVooDWgxhOmQPhDnXL2QVhklUd2WGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770135110; x=1770221510; bh=S8DdY7OHjjq7ubDcTpspMFvxxPIy4NvGM1w
	3tP/IR74=; b=dHCHn4Fv8UUl8m5HwfBsUZbsNj9ZhzNjcrgwmKOr3omviw+dDvg
	Ferm8XdTRRohnx4jV5zGqQm1k1I2HcaTEpXB1C0mY1H5PZjRHvDJPPUwOAw2rFaG
	/8DF5YxRh2xTazJ8yJpGM1DBWdS63B81E3PDuMGybGOdXQ4b7ZrOLMCcYqJmGbL5
	RaGEhq663nLtHawjELkoI3hH1yP/HyRxWNS2P7QUsewiiwpsgXdUy1JhawFGOQO2
	wazvyz/2G7MHsg90RaZKU8MoX0tXMgh7kxmq/RetBhkYf2OWXpphiJqN+6Hgp+U0
	hvvSi70YWq0hM7WCeGkN8A7k5UuqCsYjizA==
X-ME-Sender: <xms:Rh6CacqcbCiZ3bhfjRp--M10Xmg_q3Y0Ty2v5id4A8CgS0bxEX4_-A>
    <xme:Rh6CaU5CIoBj2tJgntsTHS_cnKHvWgphqB3M5lXTWAXROj47_EnGArubbIhv5eqoP
    xJblqwH07bO6jhWYRPi2-F5QwWYvAolERNE3w22mfRAocig>
X-ME-Received: <xmr:Rh6CaTcrVAUkYar6KD6ReAEmQByLDIKbwOdzszkgIkYqk85MA5MdQoiewbUBGZB551e5ECW-B6Ww_OfATJTHSX2SdrGhwOsGqZ3BCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeetueehte
    ekuefhleehkeffffeiffeftedtieegkedviefggfefueffkefgueffnecuffhomhgrihhn
    pehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonhhigi
    druggvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Rh6CaZ4-DfsGWh1HZUdBAiHK4mSxtM68QBkHdwae-Wcz6N8iRkLs9Q>
    <xmx:Rh6CaatxQtCqyugr_ydtE0ghdYSAKAB_ArR4589ZFaYzDpTuRpUjaQ>
    <xmx:Rh6CaZhnW8Q7bZexgi2L6lcrUbqrQv3PwS__56mCynADQG9PWDXUOg>
    <xmx:Rh6CaVoH-H0nw21lQ0C2udsTVpnlcNDn3du2zZr9PMQUOEJlBWrbnw>
    <xmx:Rh6Cae7xe2OeTO1dDX5MLfghkYySUYZlfTGcPc8w1hQJezuv9ArTC2OG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 11:11:49 -0500 (EST)
Date: Tue, 3 Feb 2026 17:11:47 +0100
From: Greg KH <greg@kroah.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 5.15.y] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
Message-ID: <2026020342-eats-clamor-2b83@gregkh>
References: <2026012023-ranged-machinist-edb4@gregkh>
 <20260120132156.746174-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120132156.746174-1-mkl@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6482-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13B5FDBCF4
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 02:21:56PM +0100, Marc Kleine-Budde wrote:
> In gs_can_open(), the URBs for USB-in transfers are allocated, added to the
> parent->rx_submitted anchor and submitted. In the complete callback
> gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
> gs_can_close() the URBs are freed by calling
> usb_kill_anchored_urbs(parent->rx_submitted).
> 
> However, this does not take into account that the USB framework unanchors
> the URB before the complete function is called. This means that once an
> in-URB has been completed, it is no longer anchored and is ultimately not
> released in gs_can_close().
> 
> Fix the memory leak by anchoring the URB in the
> gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.
> 
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> (cherry picked from commit 7352e1d5932a0e777e39fa4b619801191f57e603)
> ---
>  drivers/net/can/usb/gs_usb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ffa2a4d92d01..e36745fd2d3b 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -402,6 +402,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  			  usbcan
>  			  );
>  
> +	usb_anchor_urb(urb, &parent->rx_submitted);
> +

Breaks the build :(

