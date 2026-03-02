Return-Path: <linux-can+bounces-6667-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N+CAFWJpWmWDQYAu9opvQ
	(envelope-from <linux-can+bounces-6667-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:57:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0731D94BC
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A823086F26
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6C3ACF16;
	Mon,  2 Mar 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LscGD1zW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4573161BA;
	Mon,  2 Mar 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455836; cv=none; b=HvQd8gDo8a6NVDUiICks40oCKDKtTuLTpUAsTeuZRtja0IbgWxLjYeRZ8WP0wDy0FIV1yVaf4gcEBsksditDr/KBV/JzfvsQjcTXbONFi5MB6cFdWcJR1aHzikZWO903P1rlU2zYeyOXxJGXno4qT7UQs1LE9x1nUN37nxt4eQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455836; c=relaxed/simple;
	bh=DWp6FJVnAjPYvrbd7BtIqrt1Z2RnG99hZoQvyDO5j2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTVOiLmZC8hSjSpj74NisIJAkSwtUfx0nmpU/4z5cVpbMON5aFU+n6hbSTSJ2LXLYjG/fzs31Uq+jjydCxW8a7+zte21WaREQAtk0mAjyH2iNCbz2kRgOCWB4rjfEN3XjBRUwc8I6s8szgAL6XOqD+gb3yaQofRIUZEvNySmoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LscGD1zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E7C19423;
	Mon,  2 Mar 2026 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772455836;
	bh=DWp6FJVnAjPYvrbd7BtIqrt1Z2RnG99hZoQvyDO5j2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LscGD1zWvDBtdp24eyAJEXiVNHzdmzt+QE5Mt3EeNTQVP/faW2ixk47Z0ShVDgffY
	 mt6mRyXvssxgOXf70tt+vaiqwx69OCAQeYQYuBgJDDkiOS1/DRlKvxa+8Z4zwCkvdg
	 Ji0EWgP2r1wzouOqI3SctNvTSEc+3IzXpSr5asS0=
Date: Mon, 2 Mar 2026 07:50:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH 1/3] can: usb: f81604: handle short interrupt urb
 messages properly
Message-ID: <2026030218-goal-sandal-9a47@gregkh>
References: <2026022331-opal-evaluator-a928@gregkh>
 <20260302-steadfast-pony-of-glee-eef582-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-steadfast-pony-of-glee-eef582-mkl@pengutronix.de>
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
	TAGGED_FROM(0.00)[bounces-6667-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.449];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,fintek.com.tw:email]
X-Rspamd-Queue-Id: 3E0731D94BC
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:08:21AM +0100, Marc Kleine-Budde wrote:
> On 23.02.2026 13:10:30, Greg Kroah-Hartman wrote:
> > If an interrupt urb is recieved that is not the correct length, properly
>                             ^^
> > detect it and don't attempt to treat the data as valid.
> >
> > Cc: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Vincent Mailhol <mailhol@kernel.org>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Applied whole series to linux-can, with typo fix and preferred stable
> format.

Thanks!

