Return-Path: <linux-can+bounces-7245-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNuGAG+WwmkbfQQAu9opvQ
	(envelope-from <linux-can+bounces-7245-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 14:49:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CF309B76
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 14:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0E0930D8C30
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70DD3F8DEF;
	Tue, 24 Mar 2026 13:44:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA52E040D
	for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359874; cv=none; b=n66RmKE+ZDSnreTq9+25g1rCilTjyadmVmwS51bOoEgQcDyprZOMIXq7EVi47YaujctZWFf1p/4PSLnzQEte9NzeGbEaQlXg9XmNWfHkvafsfrwEovkcehgTu2j8zwCB2hPP7Lt1oPNo+TWM579IERBC+uTn0qeLPRCoBMlIRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359874; c=relaxed/simple;
	bh=ODuucfHqNC/TsGgCiBoIbDGOqb0PBXK6r+a/JlhTvOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnOaah64IwdsorxUoePV7OjVAtqMGnYStyg4poS4ZPWcCQSZzggw6xvc48UA1V3/Nxtq7urqNgdpNa4Unez+qUedLX9wiQymZ0DY7kc99FGJP19l37HoyK5TSxVPSjNyb/Qwm0g4x4mbsFVpcg/kp6iApF4GSmp/xjfWMWYxa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w523G-0000hg-I8; Tue, 24 Mar 2026 14:44:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w523G-001uDG-0K;
	Tue, 24 Mar 2026 14:44:10 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BCA0A50BAF9;
	Tue, 24 Mar 2026 13:44:09 +0000 (UTC)
Date: Tue, 24 Mar 2026 14:44:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH v3 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
Message-ID: <20260324-dashing-lush-skink-c194f1-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
 <20260323135827.2129371-2-ciprianmarian.costea@oss.nxp.com>
 <20260324-psychedelic-idealistic-dormouse-95b03c-mkl@pengutronix.de>
 <024316c6-aa33-4561-889c-abd9eeb9d83f@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxywmcxzkmfggb4a"
Content-Disposition: inline
In-Reply-To: <024316c6-aa33-4561-889c-abd9eeb9d83f@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7245-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A2CF309B76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wxywmcxzkmfggb4a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
MIME-Version: 1.0

On 24.03.2026 14:30:50, Ciprian Marian Costea wrote:
> > Can you take care of the S32G2 which has 2 mailbox IRQs, too? Please in
> > a separate patch.
> >
> > My idea was to take the "irq" argument of the IRQ handler and the quirks
> > and figure out if you are the first or second mailbox IRQ handler.
> >
> > Convert these
> >
> > | struct flexcan_priv {
> > | [...]
> > | 	u64 rx_mask;
> > | 	u64 tx_mask;
> > | [...]
> > | }
> >
> > into a struct and put an array of 2 of these structs into "struct
> > flexcan_priv". Use correct mask array depending on IRQ handler.
> >
> > regards,
> > Marc
> >
> > --
> > Pengutronix e.K.                 | Marc Kleine-Budde          |
> > Embedded Linux                   | https://www.pengutronix.de |
> > Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
>
> Thanks for your review.
> I'll add a separate patch implementing per-MB-IRQ mask handling (needed
> by S32G2) in V4. And thanks for the implementation suggestion. I'll take
> it into account.

Maybe you can come up with a improved/better solution.

With the potential concurrent mailbox IRQ handlers on the s32g we have a
problem with the rx-offload infrastructure. After converting it to
per-CPU lists, we still have to merge the lists to the global one.

The current supported use case is a single IRQ handler that adds all
received CAN frames (and CAN error frames) sorted to the skb_irq_queue
list. At the end of the IRQ handler the list is appended to the
skb_queue and NAPI pushes the CAN frames into the networking stack.

This is done to preserve the order of CAN frames, which is crucial for
some CAN protocols.

If we have 2 IRQ handlers adding the per-cpu skb_irq_queue to the
skb_queue might lead to out-of-order reception.

I see 2 options to workaround this:
- Lock the skb_queue and sort each packet into it.
  This makes the lock longer and
  if an IRQ is delayed old packets might already been processed, so
  out-of-order reception is still possible.
- Disable mailboxes 1...8 for the s32g and only use the 2nd IRQ handler.
  This obviously reduces the number of RX mailboxes, this increases the
  change of RX buffer overflows on systems under high load.
  On the other hand the driver can be extended to use the mailboxes
  64...127.

As I don't have a s32g SoC nor a customer using it, I have no time to
implement this. Maybe you or someone from NXP is willing to do this.

> Now, unrelated to the per-MB-IRQ refactor, one thing I noticed during the
> IRQ handlers split: dev->stats counters (e.g. rx_fifo_errors) can
> be incremented concurrently from different IRQ handlers on different CPUs.
>
> That said, these are just diagnostic counters and lost increments
> should be benign. Do you think this warrants any synchronization/locking
> mechanism, or is the current behavior acceptable?

There are better ways to do stats, but IMHO for now we can live with the
problem.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wxywmcxzkmfggb4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacKVJwAKCRDMOmT6rpmt
0ny3AP97AOLxQtsjTBYCxlTxLITZgMUMW/Ggdd7EXYi/BhV5ZAD/R+Ywhkah185h
9ybw30y8qx3GHGBTYUiZJdd3yOVQIww=
=JAYU
-----END PGP SIGNATURE-----

--wxywmcxzkmfggb4a--

