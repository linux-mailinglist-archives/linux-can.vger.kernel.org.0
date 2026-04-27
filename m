Return-Path: <linux-can+bounces-7414-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOlLAHSg72kcDgEAu9opvQ
	(envelope-from <linux-can+bounces-7414-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 19:44:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9D477DAB
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89E1D30480C0
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A630DEB2;
	Mon, 27 Apr 2026 17:41:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B62363095
	for <linux-can@vger.kernel.org>; Mon, 27 Apr 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311672; cv=none; b=XA9uTHkNt1/RoIvs56KngC5NTYxRjJ7o5xHjtz4+Xu+BZ2TfqV0qst9pKCN3o1Oun4lHRD/k2hYgOvdmI19BDpNuxx6400wJDMMrXSiKrUyEYW4ch8liCKqey28SGfz9h6gGdWcS1B/eLyFQguBUNSC0MSPgn+44FQqToq0M/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311672; c=relaxed/simple;
	bh=933cuzfbmyx9xvXGQ5nHFXsD8WOUC25N0p6PQ6LXjpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNx8xd5PeKyPyeyJND38sM9mTouZj5e2OPBHgaf5JpkfgQQ91M1vqCK2PgZD9V9XmwBZUQiQhzoerFidYVuFvfwcqTMSOmlIbf6f0bUUmiw4lacOWUdkeFUn922Yo2T2lCJefOePkI+P4SpX34ahze+YQsHUuyeuVmj5th97Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wHPxD-0001AV-Cm; Mon, 27 Apr 2026 19:41:07 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wHPxC-007Wqa-36;
	Mon, 27 Apr 2026 19:41:07 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B404E5254FA;
	Mon, 27 Apr 2026 17:41:06 +0000 (UTC)
Date: Mon, 27 Apr 2026 19:41:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Lee Jones <lee@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260427-zealous-booby-from-avalon-c9753c-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
 <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
 <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
 <20260427124058.GA8212@google.com>
 <dd5315a7-87e9-4754-9e88-34c0623aca99@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsspviozsezamwxu"
Content-Disposition: inline
In-Reply-To: <dd5315a7-87e9-4754-9e88-34c0623aca99@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 6BA9D477DAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7414-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email]


--zsspviozsezamwxu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
MIME-Version: 1.0

On 27.04.2026 19:15:29, Oliver Hartkopp wrote:
> > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >
> > I'm a little confused by the SoB.  Does this mean you've applied it?
> >
>
> No. Marc will apply the patch.
>
> My SoB is probably not needed in this context.

ACK

> But Marc was sometimes asking
> for it when I commented and discussed patches in the past.

The rule is: if you post a patch, your S-o-b has to be the last S-o-b in
the line.

> I also thought Marc would add the Fixes tag on his own.

If you add it in the thread, b-4 will pick it up automatically and this
less work for me :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zsspviozsezamwxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCae+frAAKCRDMOmT6rpmt
0mzkAP9CfXprs/AA3ox79e7jRndEUK/QeTQONRvYSCGPTrOh3wD/QiV+uwLcKgaA
X0dA4bQtos8OAurj6ScGM7R01UEaSgk=
=G88I
-----END PGP SIGNATURE-----

--zsspviozsezamwxu--

