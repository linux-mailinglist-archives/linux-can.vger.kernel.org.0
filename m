Return-Path: <linux-can+bounces-7231-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GV9Lr+kwWknUQQAu9opvQ
	(envelope-from <linux-can+bounces-7231-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 21:38:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADF2FD5DD
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1F61300B503
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211F3E1CEE;
	Mon, 23 Mar 2026 20:38:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA453E1CE8
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298289; cv=none; b=W89c8B/Mj5iQ2siD+8ihhuZxhyrhgX376JeB0cXh1de86qJLLZYB+02WV1ZZkuokr4sgoI8HKT6r5UU5MuYGz6km2B2qRE1ESchfhve8dtDLHm/DMeG2FLJXo/wCqRUAm3CDx3DZWmVGd2g7ObeKjUuVkEBxH8EEOjzmT+Vb5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298289; c=relaxed/simple;
	bh=Yt7USsk3cuGUzCm1y+OZ6JKq00IJQcMuuHfBv45NCGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7SgN3OZaXxz4B4aphabvlwkpS3JuLgttasS8x/+EZ/p0CKVkagWZeLSIlJCHC6hOmTCJldLSTX6kS2HuesOpZpwQYanMGGByIlqMJi9VMcTz+OZsKkdx47cU85orCkQeMLVrGkhG734vKELfXDrmTddTLR6zIQWzDLBMAstF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4m1e-00032Q-TH; Mon, 23 Mar 2026 21:37:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4m1e-001mnM-0D;
	Mon, 23 Mar 2026 21:37:26 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B4BBC50B02C;
	Mon, 23 Mar 2026 20:37:25 +0000 (UTC)
Date: Mon, 23 Mar 2026 21:37:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mani@kernel.org, 
	thomas.kopp@microchip.com, mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, linusw@kernel.org, 
	brgl@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v3 1/2] dt-bindings: can: mcp251xfd: add
 microchip,xstbyen property
Message-ID: <20260323-artificial-ecstatic-collie-047169-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260321135031.3107408-1-viken.dadhaniya@oss.qualcomm.com>
 <20260321135031.3107408-2-viken.dadhaniya@oss.qualcomm.com>
 <20260323-bonded-ranging-c9f9c4d0aacf@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mj7lxv6n5m3i3nve"
Content-Disposition: inline
In-Reply-To: <20260323-bonded-ranging-c9f9c4d0aacf@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7231-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83ADF2FD5DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--mj7lxv6n5m3i3nve
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] dt-bindings: can: mcp251xfd: add
 microchip,xstbyen property
MIME-Version: 1.0

On 23.03.2026 19:30:00, Conor Dooley wrote:
> > diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251=
xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.ya=
ml
> > index 2d13638ebc6a..28e494262cd9 100644
> > --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> > @@ -44,6 +44,14 @@ properties:
> >        signals a pending RX interrupt.
> >      maxItems: 1
> >
> > +  microchip,xstbyen:
> > +    type: boolean
> > +    description:
> > +      If present, configure the INT0/GPIO0/XSTBY pin as transceiver st=
andby
> > +      control. The pin is driven low when the controller is active and=
 high
> > +      when it enters Sleep mode, allowing automatic standby control of=
 an
> > +      external CAN transceiver connected to this pin.
>
> What I don't understand from this patch is why a property for this is
> required.
> Why can't this mode be implied from the lack of rx-int-gpios or
> interrupts?

The mcp251xfd has 2 GPIO pins. "rx-int-gpios" is for the other pin:
INT1/GPIO1. Also by default I don't want the controller to drive a pin
in a certain direction.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mj7lxv6n5m3i3nve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacGkfQAKCRDMOmT6rpmt
0lw8AP4hL8Ju237y3P6/SPoa8sYRa5wDdt5saifjrXPVIRURYgD+Nk36Nzd9OCQh
mZ9s0Zw8dTT8RbvjyTcZSzMvAG3mMQ8=
=PjbA
-----END PGP SIGNATURE-----

--mj7lxv6n5m3i3nve--

