Return-Path: <linux-can+bounces-6668-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OECUNF+JpWmWDQYAu9opvQ
	(envelope-from <linux-can+bounces-6668-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:58:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B91D94CA
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8A2330A3EAC
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482053ACEED;
	Mon,  2 Mar 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DRUuup/X"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6533B951;
	Mon,  2 Mar 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455870; cv=none; b=HgC2yyrrVSefyfBwtpMztWPpfIvScE3ENszCChuUGcsdhVosYABZ4vDvIKSaCUZo553l6PoAUxopzw6sjmmnoljwjzAK6tUiuR0vWCNEoKTUrbGICWQFuNoeg2r4QMTdr2q9bHunRHdtyhTd/scXDeaTU4cPlReX+Rpks9xQ1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455870; c=relaxed/simple;
	bh=2V7ncjs7ZIIj3qy+QMQ0qfNSeRmhGsWTDBQ8Fwneykc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw4ylJJeZsG9E+7csC7yRSDC+zh+rxq/nqo8+xxBRJN7TwkVJ7gjuBLoneCCa18MwClhJJ3/XoUtXldgT9JLb9kR5WHtS9BMy8DT88119jKy0btPrPNiQCqlzETWY4E+rtiwdusFpbW4SBvAPS7tFM9eV4R6Aili0ULqEEY6Wro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DRUuup/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F32FC19423;
	Mon,  2 Mar 2026 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772455869;
	bh=2V7ncjs7ZIIj3qy+QMQ0qfNSeRmhGsWTDBQ8Fwneykc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRUuup/XKK7Qo0QEdlXK8hzxaLV3JQTi7mAIRbQtLGGNwBNahZY235u28xPh0WyrW
	 Dl7Pk3jYM5xjbgl81bzOhCbcoKY9AeGy7J0tUwrU4C6TvmysMcWkAKBYsHTu2zf8Xs
	 F+8HvNReXyIw7nobICJWpJKt/CLdl8RS30jA2g1Y=
Date: Mon, 2 Mar 2026 07:50:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH] can: usb: etas_es58x: correctly anchor the urb in the
 read bulk callback
Message-ID: <2026030234-sheet-countless-fd2f@gregkh>
References: <2026022320-poser-stiffly-9d84@gregkh>
 <20260302-festive-crane-of-fortitude-d135bc-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-festive-crane-of-fortitude-d135bc-mkl@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6668-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.322];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5B6B91D94CA
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:01:48AM +0100, Marc Kleine-Budde wrote:
> On 23.02.2026 17:39:20, Greg Kroah-Hartman wrote:
> > When submitting an urb, that is using the anchor pattern, it needs to be
> > anchored before submitting it otherwise it could be leaked if
> > usb_kill_anchored_urbs() is called.  This logic is correctly done
> > elsewhere in the driver, except in the read bulk callback so do that
> > here also.
> >
> > Cc: Vincent Mailhol <mailhol@kernel.org>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: stable <stable@kernel.org>
> 
> FYI: checkpatch suggests:
> Invalid email format for stable: 'stable <stable@kernel.org>', prefer 'stable@kernel.org'

Checkpatch is wrong here, either is just fine.

thanks,

greg k-h

