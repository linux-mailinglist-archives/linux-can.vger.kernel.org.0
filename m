Return-Path: <linux-can+bounces-6292-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IKEFsexc2liyAAAu9opvQ
	(envelope-from <linux-can+bounces-6292-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:37:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00479157
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BCF2301DB9B
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91C128395;
	Fri, 23 Jan 2026 17:37:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F42417F2
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189826; cv=none; b=hNwEoUCIusf5+Jd7u6h+3L2/A7l08i1ge3+tRU1aV8tqqEP/ZEL6sezt06AxyBTHqtf2vPgVl8+TCgffusNZY1n/97eBZzP2v/fp+Anvn+Tixc6taJEYhwe1pcJ+IS6Bi+noDwWH5Yi3LZyHzZeaHGk4B71Lw41+gE6V7TeLP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189826; c=relaxed/simple;
	bh=Q3wIf0LQl9biLNhxIYupO/UtCL5l3IzqIjVqeKh16fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4GfdSjN7NjZn1dUS3M2o2A0t7TsMOWAYFUDvzOJZJsOtCDLzgyx0GYPO3/RZ5mAH0z7eR7Dlad8Op6Ve8fl9/Ln/JWDFugXoDmmipqrK4Yi4TKqivjZSNpbNvudYZob6KIK7tTTNlDUxd01SFzHjEEQJYJ19Idi1I+Rrt2UfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL5i-0000gZ-CC; Fri, 23 Jan 2026 18:37:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL5i-0028Fh-2B;
	Fri, 23 Jan 2026 18:37:02 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 130EA4D715D;
	Fri, 23 Jan 2026 17:37:01 +0000 (UTC)
Date: Fri, 23 Jan 2026 18:36:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	davem@davemloft.net, linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [net,2/7] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor
 URL on usb_submit_urb() error
Message-ID: <20260123-radiant-nice-gecko-6331ac-mkl@pengutronix.de>
References: <20260116200323.366877-3-mkl@pengutronix.de>
 <20260119181904.1209979-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dranchuimqg5imao"
Content-Disposition: inline
In-Reply-To: <20260119181904.1209979-1-kuba@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6292-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: AF00479157
X-Rspamd-Action: no action


--dranchuimqg5imao
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net,2/7] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor
 URL on usb_submit_urb() error
MIME-Version: 1.0

On 19.01.2026 10:19:03, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_u=
rb() error
>
> This patch fixes an infinite loop in gs_can_close() by unanchoring the URB
> when usb_submit_urb() fails after re-anchoring. It also adds an error
> message for non-ENODEV/ESHUTDOWN failures.
>
> Link: https://patch.msgid.link/20260116-can_usb-fix-reanchor-v1-1-9d74e72=
89225@pengutronix.de
>
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index d093babbc320..192338b481f2 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -754,6 +754,10 @@ static void gs_usb_receive_bulk_callback(struct ur=
b *urb)
> >  	usb_anchor_urb(urb, &parent->rx_submitted);
> >
> >  	rc =3D usb_submit_urb(urb, GFP_ATOMIC);
> > +	if (!rc)
> > +		return;
> > +
> > +	usb_unanchor_urb(urb);
> >
> >  	/* USB failure take down all interfaces */
> >  	if (rc =3D=3D -ENODEV) {
>
> [ ... ]
>
> > +	} else if (rc !=3D -ESHUTDOWN && net_ratelimit()) {
> > +		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
> > +			    ERR_PTR(urb->status));
>
> Two issues with this error message:
>
> 1. The message prints urb->status, but shouldn't it print rc instead? The
>    variable rc holds the actual error from usb_submit_urb(), while urb->s=
tatus
>    contains the completion status from the previous callback invocation (=
which
>    would typically be 0 for success since we only reach resubmit_urb on
>    successful URB completion). Other CAN USB drivers like usb_8dev print =
the
>    return value from usb_submit_urb() in similar error paths.
>
> 2. The local variable netdev is uninitialized when gs_usb_receive_bulk_ca=
llback()
>    reaches this code path via the short read case. The function declares =
netdev
>    at the top without initialization, and the short read check at the beg=
inning
>    of the function jumps directly to resubmit_urb without ever assigning =
netdev.
>    If usb_submit_urb() then fails with an error other than -ENODEV or -ES=
HUTDOWN,
>    this code will pass the uninitialized netdev pointer to netdev_info().

Fixed with today's PR: https://lore.kernel.org/all/20260123173241.1026226-1=
-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dranchuimqg5imao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzsbQACgkQDHRl3/mQ
kZwknAgAtO7KldQzCON7eUIK4Cv4XEhBIQPOU3LVx8kJnG10YBgXLTZUB6dQhFJt
rhfayiDhPjCkY9z/CHHLXAWEVfxF1pRqrdmsOQePSKRlWkzdZACJKMORSXn+luss
XNWPi4vQqxjmgIwtzF/SN+qJkqHv8s0ml5PyR1sB1IeUwo6G14WZbu3iHG6YXGlh
m1Vkb0H+nJ4kuwnr+T2p8Y6nOpXq5IrvWq/XGgKOAE6orIx6kREOZQoIHGyg/Obf
8nvdt4Lcf3+VQbo0Xz/neidJEErgRNWLoH9hHErGBlTY5sK6OrpNuox4CJ3e9Ur6
CqWAOfDMGvB1ejuyCnU+TTZZyee+lg==
=U/es
-----END PGP SIGNATURE-----

--dranchuimqg5imao--

