Return-Path: <linux-can+bounces-6671-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIH0AP6PpWkAEAYAu9opvQ
	(envelope-from <linux-can+bounces-6671-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:26:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BC1D9B78
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB38930528BA
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1A3EBF35;
	Mon,  2 Mar 2026 13:24:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2532AAC4
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457873; cv=none; b=mZH0rRqZeAe31JYBRuT0wiSGBWr1+IjuV92VhYpYt3rOuOF+AQ/I2t4psVhANP4oUWN77mBo1w3eCpRjZf9zt+3An/SEam2hLMUTsaItnLXTB9ei2tT5Bk8Q8eYTB/unmf0CQ8oMWFRrADGo7spFHh6qW2w5BKIWCps0KIlxXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457873; c=relaxed/simple;
	bh=18EBpo8SQYyktsR06lBYxbFBYGzGGtPvL53FnsAC18s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAsP9I7OGrLHNCr+mDpwa0l73+64g5JpDoK9sdreyr+vrW93nDKvQDdtx+CRS0r5Thkj/OP67EVbBF7L5jVy4xwHNlfaG8i+o1jMyZ0f8NR3wuVTCs4L841swulCSPbgPNl6tx12pyxKzhWT4qrkH4otSCBLf3MpSJgL5xv4FYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx3FR-0003AT-V7; Mon, 02 Mar 2026 14:23:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx3FO-003O8m-0M;
	Mon, 02 Mar 2026 14:23:43 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 024734F52A9;
	Mon, 02 Mar 2026 13:23:42 +0000 (UTC)
Date: Mon, 2 Mar 2026 14:23:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-can@vger.kernel.org, virtualization@lists.linux.dev, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <20260302-condor-of-nonconcrete-infinity-d3ddbb-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <aZRB7Reu/D6HvRcb@fedora>
 <20260302-mighty-wondrous-seagull-75085c-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jjf747iukq7iwcfs"
Content-Disposition: inline
In-Reply-To: <20260302-mighty-wondrous-seagull-75085c-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6671-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.845];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 617BC1D9B78
X-Rspamd-Action: no action


--jjf747iukq7iwcfs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
MIME-Version: 1.0

On 02.03.2026 11:30:34, Marc Kleine-Budde wrote:
> > +static int virtio_can_open(struct net_device *ndev)
> > +{
> > +	virtio_can_start(ndev);
> > +
> > +	netif_start_queue(ndev);
> > +
> > +	return 0;
> > +}
>
> Is open_candev() missing? The CAN framework requires drivers to call
> open_candev() in their ndo_open handler. open_candev() validates that
> bittiming has been configured (returns -EINVAL if bitrate is 0), checks
> CAN FD data bitrate requirements, and manages carrier state. Without this
> call, can the device be brought up without configuring bitrate? The driver
> does call close_candev() in virtio_can_close(), showing awareness of the
> CAN lifecycle. Every other CAN driver in the kernel calls open_candev() in
> its open function.

This is true for physical CAN devices, so let's clarify things for
virtio.

As far as I can see, there's no interface to get/set the bit timing/bit
rate from the guest, right?

You can set bittiming.bitrate to CAN_BITRATE_UNKNOWN, remove the
netif_carrier handling from virtio_can_start() and use open_candev().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jjf747iukq7iwcfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaWPXAAKCRDMOmT6rpmt
0j0sAPwNAyAFG5YK/f5xejIGQh7RF86VwBOnSvklT3BlxI/mGAEA1ykl58Tu/t9i
lgQZ62GUmRw45Q4HQRlg+agWhiq+YQE=
=eIYn
-----END PGP SIGNATURE-----

--jjf747iukq7iwcfs--

