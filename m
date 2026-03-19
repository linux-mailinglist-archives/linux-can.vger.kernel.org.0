Return-Path: <linux-can+bounces-7155-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCJINq0LvGkArgIAu9opvQ
	(envelope-from <linux-can+bounces-7155-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:43:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2942CD167
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7196730A9A8D
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E03D47B0;
	Thu, 19 Mar 2026 14:43:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EF303A01
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931387; cv=none; b=M0hpLoIZbS9NAjXfwI4/tL1qLbkclNO2pk5wsd/ZNGL78i5KJoLTx0bxg4iUxbzfMoRIWUD8Ws4mkLPJQQb2OEAXbGODLgs2XnSdIaUvYJAURwYpflh5IsCgDsu4CiojZMOKBdFSYN6LYE9PP4nbpnVgHnn0a54M5frkjRjM/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931387; c=relaxed/simple;
	bh=Z6v+tojabDv9reJRrro6SYzGGsf5y9wNxSkAqWhGQVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXgDv5y2vRavJwYb5Vd3UCPK7QiQg9sxqw0gLlJvjlep54qSORwf+Rhkk/y35WCpTZjQnGsrpIFDPRTUwhl7/3q3AziotvOrx/u7i35e1v739LNBTs52EyF//31gtqSyOWUi7jauvLMT9htJgvhBv5U0mKfluz8nUqi4zFj53Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3EaB-0000ga-PD; Thu, 19 Mar 2026 15:42:43 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3EaB-0015no-0w;
	Thu, 19 Mar 2026 15:42:43 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DC6AB5085C9;
	Thu, 19 Mar 2026 14:42:42 +0000 (UTC)
Date: Thu, 19 Mar 2026 15:42:42 +0100
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
Subject: Re: [PATCH v2 0/5] can: flexcan: Add NXP S32N79 SoC support
Message-ID: <20260319-asparagus-taipan-of-sufficiency-fcf4de-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
 <20260319-orca-of-legal-science-88e67d-mkl@pengutronix.de>
 <742c748b-8096-49a3-b1a4-3a8507f6f55d@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2iosansca2ri4jm"
Content-Disposition: inline
In-Reply-To: <742c748b-8096-49a3-b1a4-3a8507f6f55d@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7155-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.186];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A2942CD167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--x2iosansca2ri4jm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/5] can: flexcan: Add NXP S32N79 SoC support
MIME-Version: 1.0

On 19.03.2026 16:14:46, Ciprian Marian Costea wrote:
> > Please also have a look at the AI review:
> >
> > https://sashiko.dev/#/patchset/20260318092215.23505-1-ciprianmarian.cos=
tea%40oss.nxp.com
> >
> > Especially on patch#3.
> >
> > I think we should split the main IRQ handler into 3 parts, message buff,
> > bus error and state change.

> Thanks for pointing to the AI review.
>
> It raises two concerns:
>
> 1. Duplicate event processing (can be addressed by splitting the handler
> as you've suggested).
>
> This is a pre-existing issue affecting S32G2 (NR_IRQ_3 with 4 IRQ lines
> to the same handler) and MCF5441X (3 IRQ lines on the same handler).
> I'll include this as a preparatory patch in the next version of the serie=
s.

Thanks. Until the S32G2 was added multiple IRQ handlers was a niche
problem. But now it's relevant.

> 2. Concurrent skb_irq_queue access (pre-existing, separate scope)
>
> The __skb_queue_add_sort() calls on offload->skb_irq_queue are lockless.
> When the mb and esr handlers run concurrently on different CPUs, both
> can manipulate the list simultaneously.
> This is a valid concern, but it's also pre-existing.
>
> The fix requires changes in CAN core's rx-offload.c rather than in
> flexcan, so I think it would be better handled in a separate series.
>
> Would you agree ?

ACK

One option is to make struct can_rx_offload::skb_irq_queue per CPU.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x2iosansca2ri4jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabwLYAAKCRDMOmT6rpmt
0nL/AP4hauOOQHt8J4Raz4k3XL6AkFpJksPkVshPoYgYCYYbHwEA/m2fRk+vD+FQ
N4xipgWJpMlSE+VrRksDVTDxb+1Acw4=
=/RY/
-----END PGP SIGNATURE-----

--x2iosansca2ri4jm--

