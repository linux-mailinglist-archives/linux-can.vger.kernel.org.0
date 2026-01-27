Return-Path: <linux-can+bounces-6317-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNpRETXneGmHtwEAu9opvQ
	(envelope-from <linux-can+bounces-6317-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 17:26:29 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0D197BC3
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 17:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78604317EE4D
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420282FD7B3;
	Tue, 27 Jan 2026 15:34:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A03112BD
	for <linux-can@vger.kernel.org>; Tue, 27 Jan 2026 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528072; cv=none; b=d1jijGgw+RqxBNY1OIeeJnNOHCt0YPGu0hPDrxLSVpmv/2/qJVOG7798UXHHId8kOuPFUVvQiE5TV3xq67kwjdc2L1P4oCyV2MWWqW1YMauUoGa0Wz+4Cgow2it76HfOlTVFiwiAh51naysRX6j8EtzW/0UDiOvRTz123EmUoww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528072; c=relaxed/simple;
	bh=yLmln/q39Z0XLlkkrJp7MNr8e8F/skK3To5PFcjYNeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luwCkh3/A88GekIzZh69KIRszgtQQaLa7lyYc4rDadLhlKLnc73SMhTPkKrWnqip8/jI4IOrHQiEPsFepXzKbRDxKuAzT4l/ITT69EwU/f8FnhODnzFJJ3hm8JFOkZEBIthYfGtrLkAG8krujJwaB8WgkNGr6TzNl0KMZcy/Uys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vkl5I-0008FB-9x; Tue, 27 Jan 2026 16:34:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vkl5I-002luQ-2J;
	Tue, 27 Jan 2026 16:34:28 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B86924D974C;
	Tue, 27 Jan 2026 15:34:27 +0000 (UTC)
Date: Tue, 27 Jan 2026 16:34:27 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v2] dummy_can: fix packet statistics
Message-ID: <20260127-unselfish-resourceful-hummingbird-b8cbe1-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260126104540.21024-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f26yxqbpzuueb3e6"
Content-Disposition: inline
In-Reply-To: <20260126104540.21024-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6317-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F0D197BC3
X-Rspamd-Action: no action


--f26yxqbpzuueb3e6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dummy_can: fix packet statistics
MIME-Version: 1.0

On 26.01.2026 11:45:40, Oliver Hartkopp wrote:
> The former implementation was only counting the tx_packets value but not
> the tx_bytes as the skb was dropped on driver layer.
> By enabling the CAN echo support (IFF_ECHO) in dummy_can_init() the code
> to put and get the echo skb is activated and the tx_bytes are counted
> correctly.

Re-phrased the commit message to make it more imperative:

    can: dummy_can: dummy_can_init(): fix packet statistics

    The former implementation was only counting the tx_packets value but not
    the tx_bytes as the skb was dropped on driver layer.

    Enable CAN echo support (IFF_ECHO) in dummy_can_init(), which activates=
 the
    code for setting and retrieving the echo SKB and counts the tx_bytes
    correctly.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f26yxqbpzuueb3e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml42wAACgkQDHRl3/mQ
kZxheQf/Uzy57bmTDRcXPlkSwPU9H89WYuIpAki8ftjGKzY0QyUOV+99MO53W5m1
a+61y2pQFlcsxueesy3vyQneArvnH7DRQLTkzM2DujsjyV8YD7RIzgzqNad/OPbi
KybLZQME3ZlzSqZyoWdDp/2DGSBhuh1nXfSyJ/NCEnnbc2I1SxmgTD6yrdikaQqI
Y5cJ4Q4ln0xTInQE/tT5awf1aAdkPrxv1rfJBf2meEsHxnV0lRLVQOPjiJIeVctl
3EhLrn8GrHQ3EMx4kVXxeUaZOgOi2OOHBdsZ514ZRDyMNDs7aCPoqrNPBZfa1n+A
QkHcLMpZ4tuehgvt+dp4l37GZZmDYw==
=CXTA
-----END PGP SIGNATURE-----

--f26yxqbpzuueb3e6--

