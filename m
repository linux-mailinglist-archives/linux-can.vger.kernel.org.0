Return-Path: <linux-can+bounces-8204-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fv1fCwKNT2oEjgIAu9opvQ
	(envelope-from <linux-can+bounces-8204-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 13:58:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F9730BE0
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 13:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8204-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8204-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4F27302F68A
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 11:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51158238D27;
	Thu,  9 Jul 2026 11:58:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51241CB3B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 11:58:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598334; cv=none; b=A9ee+pjZ8r0wDPK1LHhUXXj0OWIkGpT7osnXxrEK3T/GMPBTPSeiLOoNVrxfbeujH4w7pp+J+fGG8aFJX0ULrj60v6v6KmgIGUmWpOmiU0609cMNWlyLyTpPds+Gex2dMynk7fdgy2n19j7o6/L/pYJC7C6rIhgwocF2bJ0iZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598334; c=relaxed/simple;
	bh=4lqpOm91OEmpHMkfcC8bpKJ/cdsE7UdSXkNd6ctPx2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvjLdAFO6k52fSKohI47IR61KJMWD7KvtNQ1NpX6wQutBp7OS02pejQJQwvTwDhyIpJi8rXNFwyVLuHkzw14U6DT4hrN1MNNREiyxEQ0+fdqKU4PRhHHn2Y6KYFfI75paz+BAe6Z9MrpV+zz9TtFw97kpNRLmRs4geB8XTQ5MO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 25DFC20276A;
	Thu, 09 Jul 2026 13:58:47 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1whnOx-000uU9-0B;
	Thu, 09 Jul 2026 13:58:47 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C6788564096;
	Thu, 09 Jul 2026 11:58:46 +0000 (UTC)
Date: Thu, 9 Jul 2026 13:58:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Ginger <ginger.jzllee@gmail.com>
Subject: Re: [PATCH v10 02/10] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Message-ID: <20260709-funny-bustard-of-genius-e31cc6-mkl@pengutronix.de>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
 <20260709-bcm_fixes-v10-2-57fff38e34ce@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mc2xtpaqelixx7d3"
Content-Disposition: inline
In-Reply-To: <20260709-bcm_fixes-v10-2-57fff38e34ce@hartkopp.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,hartkopp.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-8204-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:devnull+socketcan.hartkopp.net@kernel.org,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:ginger.jzllee@gmail.com,m:devnull@kernel.org,m:gingerjzllee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pengutronix.de:from_mime,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A16F9730BE0


--mc2xtpaqelixx7d3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 02/10] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
MIME-Version: 1.0

On 09.07.2026 12:24:16, Oliver Hartkopp via B4 Relay wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>
> bcm_sendmsg() reads bo->ifindex and checks bo->bound before taking
> lock_sock(), while bcm_notify(), bcm_connect() and bcm_release() all
> mutate both fields under that same lock. Because the lockless reads
> and the locked writes are unordered with respect to each other, a
> racing bcm_notify() (device unregister) or bcm_connect() (concurrent
> bind on another thread sharing the socket) can make bcm_sendmsg()
> observe an inconsistent combination, e.g. a stale bound=3D1 together
> with the now-cleared ifindex=3D0, silently turning a socket bound to a
> specific CAN interface into one that also matches "any" interface.
>
> Keep the lockless bo->bound check purely as a fast-path reject, and
> move the ifindex read (and a bo->bound re-check) into the locked
> section, where every writer already serializes. This removes the
> possibility of observing the two fields torn against each other,
> rather than trying to fix it with more READ_ONCE()/WRITE_ONCE() pairs
> on two independently updated fields. Annotate the now-purely-lockless
> bo->bound accesses consistently across all its write sites.
>
> Also fix bcm_rx_setup() silently returning success when the target
> device disappears concurrently instead of reporting -ENODEV, so a
> broken RX op is no longer left registered as if it had succeeded.
>
> Reported-by: Ginger <ginger.jzllee@gmail.com>
> Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP=
9x_pV3At4g=3Dh1kVEtyhA@mail.gmail.com/
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Can you give me the Fixes: tag?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mc2xtpaqelixx7d3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCak+M9AAKCRDMOmT6rpmt
0t/UAP9FFRnywR2//kzhMOSB1Xxia0eFWjMlxW74qMqKsdpnhwEAihPHsUVAY8i0
Rpr58iywvSaAK7l0ATgNzQSdeXrCeAs=
=Yn+r
-----END PGP SIGNATURE-----

--mc2xtpaqelixx7d3--

