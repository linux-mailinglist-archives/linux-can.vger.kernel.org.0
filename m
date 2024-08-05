Return-Path: <linux-can+bounces-1112-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB300947E52
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 17:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB141F245EA
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC1157468;
	Mon,  5 Aug 2024 15:37:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA46158DD2
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872253; cv=none; b=UPhmlNOg41KHbxMX2Vs0EyKQCQPszakobEKgRiGNMzqs9H+nXIRKxB2A9o6uMAKNnhTjRk2ZEY5YE3FcseUJ+f45P3E49B8tPbIdUXyeCKltgRjsLsyP/YeTOe+ViyO7smMXD0hTVMhsQju7XZecqcAU5L68eH7cSJY3msAQEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872253; c=relaxed/simple;
	bh=RLkhu/zbsklUvvqC0RNoI9w7njEFnfiXbJ3nJ4t5Vgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD1/jWHRa6m14RMuczBkn/3b7oIhi3zzMfWQMwP2rxLdOngZ17ZN411HywAuvf0iG7y4CmWMf1TRSkpg8DOEcX3GLN7n46bUhONr8V/ikLnw1D/24YzuJri6FSLaeJjnjCqVQZRPykcOUun/N44RPsLq5OSxiu8SFN+5uITMWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazm5-0002MQ-SF; Mon, 05 Aug 2024 17:37:29 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazm5-004kGC-36; Mon, 05 Aug 2024 17:37:29 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C3A6931736C;
	Mon, 05 Aug 2024 15:37:28 +0000 (UTC)
Date: Mon, 5 Aug 2024 17:37:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH] can: kvaser_pciefd: Use a single write when releasing RX
 buffers
Message-ID: <20240805-mindful-unbiased-lobster-384ed9-mkl@pengutronix.de>
References: <20240711135451.2736466-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dcx6ehpcwyx3xuyf"
Content-Disposition: inline
In-Reply-To: <20240711135451.2736466-1-martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dcx6ehpcwyx3xuyf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.07.2024 15:54:51, Martin Jocic wrote:
> We should return from the ISR as fast as possible in order
> not to mask a new interrupt.

Do you mean really mean "mask" new interrupts or "ACK" new interrupts?

I'm not familiar with the hardware, but in several other IP cores the
driver first ACKs then IRQs then does the work. Is this an option here,
too?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dcx6ehpcwyx3xuyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaw8bUACgkQKDiiPnot
vG8HNggAnqOgtcvQWsbesY1k5awD20zAjogk14KXX6hB+5hJEufqYiWGGlKRxdUB
7B6TA+bRAKbIoq9kUMsfzzAWb/5vgwM5hpTNHh8SpML40UIt3Mvf6ca70M9cL5ku
xndXfCEKREnDstLW0yrtl8cxCKVkz4mO7B1ieTzfcKKTtuQ3cU6rmW/ibareCcHz
ftQD6QI5QXi5aOjPNzvglWiBEJ/tfGFl0qotinMlZzmU3uhhpFzWUPYQIO1btLyZ
Ifsl5Zq4O9C2LFlZmqPBAbj3Sn1adCSLZ/lv7MX8l0mo5QV8dt5b9KGucM5eShb7
ThraAnq/C//cYIkJGhA1EebWeLtbzw==
=N1ch
-----END PGP SIGNATURE-----

--dcx6ehpcwyx3xuyf--

