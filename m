Return-Path: <linux-can+bounces-7337-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMIsFuc00Gnm4gYAu9opvQ
	(envelope-from <linux-can+bounces-7337-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 23:45:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C6E398848
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3E6F301992A
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2026 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE33D566B;
	Fri,  3 Apr 2026 21:44:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075072F39AB
	for <linux-can@vger.kernel.org>; Fri,  3 Apr 2026 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252699; cv=none; b=OGi/yT0+v24JBOnk2+k8JMtlH6iTGN8SjsBeK/n+2Hnc/FmyRRVqLVSUmBO2gJaqeh4MmyQ2oO/cKIcu16PKSAm4V7lpqf06921AtNdQ8GXWMm+f+ldLgYJZ/g2U1duODWjw8gplW7iesIveaL0aiyAkp0RTHQfPe8VLp9mq78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252699; c=relaxed/simple;
	bh=3i7B8/6fElTR5FtHx3cMNBjBv1R9T1P8n0qDC6nPbUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFQeLZwq/yU3oIHCwGLOTCHNNrTtSYHjQ6zFjRttYeToY6yfFIkoDqb40gVux76RSpZSsWzobTodGeBBuwYIaaEpLX0qmlKCfsDw+1lShoEAYH5OnsvYUDlBSb4/JGcI5rjRsfMojcep7Gy54L+sdMiaAD3qrlAz1KqK6m41zSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w8mJj-0005Hf-OY; Fri, 03 Apr 2026 23:44:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w8mJj-003b51-07;
	Fri, 03 Apr 2026 23:44:39 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:1016:1:2db7:52be:76a6:e1b2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6B7CB5154D2;
	Fri, 03 Apr 2026 21:44:38 +0000 (UTC)
Date: Fri, 3 Apr 2026 23:44:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju <biju.das.au@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 0/3] Add support for Renesas CAN-FD Bus-Off recovery mode
 selection
Message-ID: <20260403-camouflaged-original-tortoise-ec0f7b-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlkrumscsqdaz4dc"
Content-Disposition: inline
In-Reply-To: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,bp.renesas.com,renesas.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7337-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.441];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: B7C6E398848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wlkrumscsqdaz4dc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] Add support for Renesas CAN-FD Bus-Off recovery mode
 selection
MIME-Version: 1.0

On 03.04.2026 10:49:57, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The CAN-FD IP supports the below Bus-Off recovery modes:
> 1) ISO11898-1 compliant
> 2) Entry to Channel Halt mode automatically at bus-off entry
> 3) Entry to Channel Halt mode automatically at bus-off end
> 4) Entry to Channel Halt mode (in bus-off state) by program request
>
> Add support for Bus-Off recovery mode selection via the
> renesas,bus-off-recovery-mode device tree property. If the property is
> absent, it defaults to RCANFD_CCTR_BOM_BENTRY (entry to Channel Halt mode
> automatically at bus-off entry) for backward compatibility.

Using DT properties for configuration is not the best way to go. I think
we first have to get the CAN error state handling fixed, before you add
new features.

Can you explain a bit more what the controller does in the different
modes?

In the current driver when the bus off IRQ (RCANFD_CERFL_BOEF) fires,
the driver calls can_bus_off(), which triggers the configured bus off
handling.

What the Linux driver should do is once the HW is in bus off mode,
switch off the HW and let the .do_set_mode(CAN_MODE_START) callback
restart the hardware.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wlkrumscsqdaz4dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCadA0wgAKCRDMOmT6rpmt
0tlMAP0fg5LVQbwvHgTgBB3otEBafQFIPsUzKI3Bib4oJEv5MwEA3KSFxrrc00RA
kicmwNQUhIaK08lecC3jYWW8epUrdgE=
=iBYj
-----END PGP SIGNATURE-----

--wlkrumscsqdaz4dc--

