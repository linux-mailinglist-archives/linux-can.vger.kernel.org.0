Return-Path: <linux-can+bounces-6669-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOWKMJqMpWmoDgYAu9opvQ
	(envelope-from <linux-can+bounces-6669-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:11:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5111D9893
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D31B4300C3B8
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A40366DB7;
	Mon,  2 Mar 2026 13:11:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49335AC2A
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457108; cv=none; b=UGtVtXagjYTo9N8EubUhxhjz/q6smguZbw6CrV34DiTs/acKcyGm4Rlu2/I525W1zOgBa2tWQ/ojeCrHmaWUjwu6qE6toOJr6/P54scsX7RHRweDXF57F8T4NMpZZh72OAdHBbEm/AeArbQ7L2eetckEQfWFT9a+XMrebgUEs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457108; c=relaxed/simple;
	bh=jOLS84EF1x0xIZNGM0EsBMWr6toJAI07hRkpZXvkmZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5yzK8z9FdtRWZ/OKauVJqXKNNsYDpEirbVZOX4qX2LnAjAovRIAhN5LHOS3yInyywjDnTnGvHnDK2nheOD+dr0ngbJI3ygDB6/sD0NJtMsb7+8UMTVXrausbtArX7DkI3xSXu5V0u+1RpwwV6tvSORruZABQB3Ihlzra9OUtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx33i-0001nB-5g; Mon, 02 Mar 2026 14:11:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx33g-003O7S-1q;
	Mon, 02 Mar 2026 14:11:37 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 975AE4F5279;
	Mon, 02 Mar 2026 13:11:37 +0000 (UTC)
Date: Mon, 2 Mar 2026 14:11:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: checkpatch: format of stable@k.o address (was: Re: [PATCH] can: usb:
 etas_es58x: correctly anchor the urb in the read bulk callback)
Message-ID: <20260302-brainy-scrupulous-vicugna-164ebc-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <2026022320-poser-stiffly-9d84@gregkh>
 <20260302-festive-crane-of-fortitude-d135bc-mkl@pengutronix.de>
 <2026030234-sheet-countless-fd2f@gregkh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bwcmdampgr4i6cqy"
Content-Disposition: inline
In-Reply-To: <2026030234-sheet-countless-fd2f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-6669-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.337];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url,pengutronix.de:email]
X-Rspamd-Queue-Id: CE5111D9893
X-Rspamd-Action: no action


--bwcmdampgr4i6cqy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: checkpatch: format of stable@k.o address (was: Re: [PATCH] can: usb:
 etas_es58x: correctly anchor the urb in the read bulk callback)
MIME-Version: 1.0

On 02.03.2026 07:50:58, Greg Kroah-Hartman wrote:
> On Mon, Mar 02, 2026 at 11:01:48AM +0100, Marc Kleine-Budde wrote:
> > On 23.02.2026 17:39:20, Greg Kroah-Hartman wrote:
> > > When submitting an urb, that is using the anchor pattern, it needs to=
 be
> > > anchored before submitting it otherwise it could be leaked if
> > > usb_kill_anchored_urbs() is called.  This logic is correctly done
> > > elsewhere in the driver, except in the read bulk callback so do that
> > > here also.
> > >
> > > Cc: Vincent Mailhol <mailhol@kernel.org>
> > > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > > Cc: stable <stable@kernel.org>
> >
> > FYI: checkpatch suggests:
> > Invalid email format for stable: 'stable <stable@kernel.org>', prefer '=
stable@kernel.org'
>
> Checkpatch is wrong here, either is just fine.

That check was introduced by Dwaipayan Ray (Cc'ed) in commit
fccaebf00e60 ("checkpatch: improve email parsing"), a.k.a.
v5.11-rc1~133^2~46.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bwcmdampgr4i6cqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaWMhgAKCRDMOmT6rpmt
0m+kAP9EgJQMTklfa+yGOduPUdFjspyU58nRu918FupeKoO6vAEAhQG8l3QUt0Ht
1F2fNTRqe7c+ps5RfnHKOEn3YB6+wwg=
=1ysC
-----END PGP SIGNATURE-----

--bwcmdampgr4i6cqy--

