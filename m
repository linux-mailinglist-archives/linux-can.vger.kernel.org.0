Return-Path: <linux-can+bounces-7627-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKaSBZyeBWr4YwIAu9opvQ
	(envelope-from <linux-can+bounces-7627-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 12:06:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A2A54020E
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 12:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFF0130086B3
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247A38B142;
	Thu, 14 May 2026 10:06:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7126C385
	for <linux-can@vger.kernel.org>; Thu, 14 May 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753173; cv=none; b=rK23ynbsUidFEgj2bw1SrykJB9Mmv439RbRKhkF2LLIwHKse9tYHmDURWf7nN3wRrfuRHJ44rutGzb5Mfvb8pUoJHPGgruK8dQh+LREC4Pwmz9P8xiO5VxuGMu7czoRyWoBc59DrJb5z7UeuFrXQ/cUiGH4M7++dpE6auGtvZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753173; c=relaxed/simple;
	bh=hzb/rpTvchz4n++Rxj/M8+alBs7miaN+3wFDitOYegQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbWokBcdFdCXZI6uc9Ugi1/4QhA+3dPkYBlgAEdSTQu3Ko6hSeXrjH+5XCy8Rv7rUOshAKJZCGYAFOMQF9Cnzapjl2VCuCy76la0/+Ber9vJMG4kml4u8MrTsatKmnZj1/Tq1SbZliypKrSF3MjftUbvM/wwMEq1GnqKn3UQu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=fail smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNSx1-0007S9-Sa; Thu, 14 May 2026 12:05:55 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNSwy-000kMx-0L;
	Thu, 14 May 2026 12:05:52 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B94D45363CF;
	Thu, 14 May 2026 10:05:51 +0000 (UTC)
Date: Thu, 14 May 2026 12:05:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anurag Dutta <a-dutta@ti.com>
Cc: u-kumar1@ti.com, vigneshr@ti.com, gehariprasath@ti.com, 
	rcsekar@samsung.com, mailhol.vincent@wanadoo.fr, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, msp@baylibre.com
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
Message-ID: <20260514-tiny-koel-of-order-65ade7-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260514065511.3573223-1-a-dutta@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="updzfu6jqbf2tt6x"
Content-Disposition: inline
In-Reply-To: <20260514065511.3573223-1-a-dutta@ti.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 02A2A54020E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[ti.com,samsung.com,wanadoo.fr,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7627-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--updzfu6jqbf2tt6x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
MIME-Version: 1.0

On 14.05.2026 12:25:11, Anurag Dutta wrote:
> Message transmit order is not guaranteed when dedicated TX buffers
> configured with the same Message ID are submitted simultaneously via
> TXBAR write. This is described in J7 errata i2278 and i2279.
>
> As a workaround, introduce m_can_tx_peripheral_submit() to submit
> buffers one at a time using ffs() to find the next pending buffer.
> The TX complete interrupt(IR_TC) triggers submission of the next
> buffer, ensuring strict FIFO ordering.
>
> Link: https://www.ti.com/lit/pdf/sprz530

This errata is for the "J721S2/TDA4VE/TDA4AL/TDA4VL/AM68A Processor
Silicon Revision 1.0". The code path you modify is only active for the
is_peripheral case.

is_peripheral is only set for the tcan4x5x SPI CAN controller, and not
set for memory mapped M_CAN cores as found on the above mentioned TI
processor:

| $ git grep peripheral\ =3D drivers/net/can/m_can
| drivers/net/can/m_can/m_can_platform.c:149:      mcan_class->is_periphera=
l =3D false;
| drivers/net/can/m_can/tcan4x5x-core.c:460:       mcan_class->is_periphera=
l =3D true;

The latest Bosch m_can documentation doesn't mention this problem,
neither the TCAN4550 docs. Can this be an integration problem of the SoC
on TI's side?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--updzfu6jqbf2tt6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCagWefAAKCRDMOmT6rpmt
0oi2AQDNVRJ+6UHrBF7e3KeiZEmQTfJgSLhbi/bNlnbPpLAvYgD8CzNkA9KGLrJP
XZMZ59ykSbydVLGQgTHeUyMfe0IxXwg=
=Lqkc
-----END PGP SIGNATURE-----

--updzfu6jqbf2tt6x--

