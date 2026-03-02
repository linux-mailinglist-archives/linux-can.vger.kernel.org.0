Return-Path: <linux-can+bounces-6670-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEuNE8SMpWmoDgYAu9opvQ
	(envelope-from <linux-can+bounces-6670-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:12:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E397B1D98D6
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B77E3016B83
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489BA33F8D6;
	Mon,  2 Mar 2026 13:12:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68843451A6
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457152; cv=none; b=ia9HkwQLmWVzjHFP1VeFXUcP9HtkButCnKcsUnUj7v/3i4rB/p/qvt9vbgFwNyRAEHWaMLQCjErQsa3tB6Ajb0Mka63px1aApMW8pverH6BrtIZjgAPIpgfeI9wFZouuae/5TGxZm0mUZ6sVBAu5FWvVFxu9nUx8jfrPu9jGaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457152; c=relaxed/simple;
	bh=XPMw8YdPVuJHmjVe8ww+tb71ebjFyVl3lbp5+SDeTVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCaM5G+H4IxyMg1Wywymgky+S6mdrVY1uxtfstH/VAeqmc/0PsD+Cqi4FOG803IZfeHO9Vt0m0KMm9d8uLVbRmiSRWObNMTnEahY2bSYFlXhsLYmNTOlC2ptSrgF9AdtmsLm4bsT/9aLeIjFwFy6gr6k5M8+FTZJ3O7HOTqrifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx34T-0001s7-PH; Mon, 02 Mar 2026 14:12:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx34S-003O7Y-0i;
	Mon, 02 Mar 2026 14:12:25 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 566AE4F527C;
	Mon, 02 Mar 2026 13:12:25 +0000 (UTC)
Date: Mon, 2 Mar 2026 14:12:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH] can: ems_usb: ems_usb_read_bulk_callback(): check the
 proper length of a message
Message-ID: <20260302-fine-quaint-mantis-74a090-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <2026022316-answering-strainer-a5db@gregkh>
 <20260302-nebulous-zebu-of-health-688c00-mkl@pengutronix.de>
 <2026030244-escapade-visible-2c37@gregkh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6zbjozug2v7reyh"
Content-Disposition: inline
In-Reply-To: <2026030244-escapade-visible-2c37@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6670-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.832];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,pengutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: E397B1D98D6
X-Rspamd-Action: no action


--x6zbjozug2v7reyh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: ems_usb: ems_usb_read_bulk_callback(): check the
 proper length of a message
MIME-Version: 1.0

On 02.03.2026 07:50:02, Greg Kroah-Hartman wrote:
> On Mon, Mar 02, 2026 at 11:06:34AM +0100, Marc Kleine-Budde wrote:
> > On 23.02.2026 17:51:17, Greg Kroah-Hartman wrote:
> > > When looking at the data in a USB urb, the actual_length is the size =
of
> > > the buffer passed to the driver, not the transfer_buffer_length which=
 is
> > > set by the driver as the max size of the buffer.
> > >
> > > When parsing the messages in ems_usb_read_bulk_callback() properly ch=
eck
> > > the size both at the beginning of parsing the message to make sure it=
 is
> > > big enough for the expected structure, and at the end of the message =
to
> > > make sure we don't overflow past the end of the buffer for the next
> > > message.
> > >
> > > Cc: Vincent Mailhol <mailhol@kernel.org>
> > > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > > Cc: stable <stable@kernel.org>
> > > Assisted-by: gkh_clanker_2000
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Applied to linux-can, with preferred stable format.
>
> What is your "preferred stable format"?

FTR: Greg commented on this in:

| https://lore.kernel.org/all/2026030234-sheet-countless-fd2f@gregkh/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x6zbjozug2v7reyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaWMtgAKCRDMOmT6rpmt
0nuuAPwO4H2K/YP2MOZM8cIM9jqgi78soUrkn4Bl7OItUbpZMgD8DFVGdCBZgGQy
l8G3AlCW7h1b6544hCFf3T66dk8QOAs=
=2yia
-----END PGP SIGNATURE-----

--x6zbjozug2v7reyh--

