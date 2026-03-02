Return-Path: <linux-can+bounces-6663-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAypJr1npWkeAAYAu9opvQ
	(envelope-from <linux-can+bounces-6663-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:34:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136471D69A9
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55BB43022966
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA647396D2E;
	Mon,  2 Mar 2026 10:24:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AD39B95E
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447068; cv=none; b=M6oHKKuYd9ZI07Yqw+LDPZyyyn5O5PIH/LQqQmTZx8kupcBbqvNPom7PgRBV9JX6yubg8URSErVu4SmMcz4HX2XeR/w3NmgCjHq+TdRSAeAFxOgitjKZTnRLfTN9Kv0eyQFZvE9F8K7MYQTiQjcgDH7F70gZc34H5hMynDgBH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447068; c=relaxed/simple;
	bh=x/JPmKMpl9B76cHoeYrYmU9vcZQiUMxDoJ1jEnJhn+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKWgWDlM8LZDx/hUXehiEsX9efnIcCsitzW2T5IPulwF8a1CLvNSUywkN8YQGMf7EFHJBN7gDWn8ivrIDd781TbbearHoWbaDDaFgfDGZuFQ0BNoHEbno8apA2lLKdecmd+C04vx6e/m0bmEE0Bvxb4IjHDLNQV7TLlSj0zgLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Rk-0003LN-I6; Mon, 02 Mar 2026 11:24:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0Ri-003MZu-2o;
	Mon, 02 Mar 2026 11:24:16 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BD6624F5071;
	Mon, 02 Mar 2026 10:24:15 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:24:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: net: can: nxp,sja1000: add reference
 to mc-peripheral-props.yaml
Message-ID: <20260302-didactic-neon-ara-91dabe-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260212163000.1195586-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xheu2vifpjpnbcm"
Content-Disposition: inline
In-Reply-To: <20260212163000.1195586-1-Frank.Li@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-6663-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.4:email];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 136471D69A9
X-Rspamd-Action: no action


--3xheu2vifpjpnbcm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/1] dt-bindings: net: can: nxp,sja1000: add reference
 to mc-peripheral-props.yaml
MIME-Version: 1.0

On 12.02.2026 11:30:00, Frank Li wrote:
> Add a reference to mc-peripheral-props.yaml to allow vendor-specific
> properties for memory access timings.
>
> Fix below CHECK_DTBS warings:
> arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dtb: can@4,0 (nxp,sja1=
000): Unevaluated properties are not allowed ('fsl,weim-cs-timing' was unex=
pected)
>         from schema $id: http://devicetree.org/schemas/net/can/nxp,sja100=
0.yaml
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3xheu2vifpjpnbcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaVlTQAKCRDMOmT6rpmt
0hV8AQDLbjBMOU3liC2+KNR/C1BDNT2Yf0FVuMUud3z5t4H+FgEAtLu6taoyRf/I
vHxV2hgCJE4w5SqT3nANcwejnBwvBAQ=
=7CYj
-----END PGP SIGNATURE-----

--3xheu2vifpjpnbcm--

