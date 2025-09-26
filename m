Return-Path: <linux-can+bounces-5033-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D971BA2BD7
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B512F1C00311
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 07:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832F298CC7;
	Fri, 26 Sep 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="k6fTTzy4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F0296BC0
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871625; cv=none; b=EZOB/yzL7S5CX93BOyJA6YqMWMtqCriq9do/+/P82/eZctWBZFiY6LHukprCNKf8Hkbw/3gxj1bHccuH3BE7x+9kdfi+Xpl+z3pMxB/Bne99ydROHW4miMrqzzbQKQ9VNECTMB8DkOhn0BcUbEkVxJ3hixuupel5FyuHeBO6KPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871625; c=relaxed/simple;
	bh=knWATooov5Y6xhU92Uo06HK7K72GghDAi0s7+oq1EyQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=rzDJq89efVVMXGADfh/F+t8bujo+VkmV/4XRXQa/y9ZyMYI/u8TrnacnUZfoMU99ln2MUZBWb2RFLfSCiasM4bsBb/httNRNP5I2ENzyp14vm/rkU2P/17vcBHD4cWDDyFPOYrwPlfzusVK/xv/eHpJ1LnmajkFvb2qubLR2LJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=k6fTTzy4; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 78938DF94B2
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 09:26:53 +0200 (CEST)
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 7903F2003C1;
	Fri, 26 Sep 2025 09:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1758871606;
	bh=knWATooov5Y6xhU92Uo06HK7K72GghDAi0s7+oq1EyQ=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=k6fTTzy4jktfEb4SqIAEobGCUuATCrVIuDSkXER75Mb99rxNwCH3szX++h5KwATsD
	 TmsaNXjdFtifQHkqTCH6Q0xvkUFhgF3L6EFgdUTypjZ+ctmuJ+e1U0M5t8kn3kkcY2
	 c45gmI5L4Rww/EBczQWWlaympPpNmH9p9p6EDevkC2aWBu4uq2aMcRTJGCZSCau/VW
	 7n5A1Z2xeHjzcEPY5jW/EGovZzcQvAM8XkKfki74m+RA+EGN32zls9OHy7PqD8iteA
	 UB3brdJS6wv/3xnofgw7og1Qc32GMRBG6TiWxG0yWoLkwG8YM8UTgi2ROE1XBh+ump
	 wjrLMtB2jLelQ==
Date: Fri, 26 Sep 2025 09:26:45 +0200 (CEST)
From: stephane.grosjean@free.fr
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	=?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>
Message-ID: <887285384.434276594.1758871605629.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <20250919-witty-bustard-of-certainty-29de42-mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak_usb: fix shift-out-of-bounds issue for 32-bit
 architectures
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC140 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hello Marc,

The reason is that delta_ts is still declared u32.

The problem came from my patch, where it was already declared as u64.

Sorry for that. I push a v2 asap.


----- Mail original -----=20

De: "Marc Kleine-Budde" <mkl@pengutronix.de>=20
=C3=80: "St=C3=A9phane Grosjean" <stephane.grosjean@free.fr>=20
Cc: "linux-can Mailing List" <linux-can@vger.kernel.org>, "St=C3=A9phane Gr=
osjean" <stephane.grosjean@hms-networks.com>=20
Envoy=C3=A9: Vendredi 19 Septembre 2025 19:18:15=20
Objet: Re: [PATCH] can: peak_usb: fix shift-out-of-bounds issue for 32-bit =
architectures=20

On 18.09.2025 15:23:57, St=C3=A9phane Grosjean wrote:=20
> From: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com>=20
>=20
> Explicitly uses a 64-bit constant when the number of bits used for its=20
> shifting is 32 (which is the case for PC CAN FD interfaces supported by=
=20
> this driver).=20
>=20
> Signed-off-by: St=C3=A9phane Grosjean <stephane.grosjean@hms-networks.com=
>=20

This problem is not limited to 32-bit architectures, so I've removed=20
this from the subject.=20

I don't know why, but the patch didn't apply to net/main, applied=20
manually, but removed the line break.=20

Thanks,=20
Marc=20

--=20
Pengutronix e.K. | Marc Kleine-Budde |=20
Embedded Linux | https://www.pengutronix.de |=20
Vertretung N=C3=BCrnberg | Phone: +49-5121-206917-129 |=20
Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-9 |

