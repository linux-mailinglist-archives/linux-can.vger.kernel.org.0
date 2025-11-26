Return-Path: <linux-can+bounces-5672-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E23C89353
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569EC3A27E5
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1748270ED9;
	Wed, 26 Nov 2025 10:14:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E52701B6
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152051; cv=none; b=EPYCy8XLvXCk8EeHe4Uk0hOVKD5CS5fY9uiCcTVgW4u3ie+2Wi4lOxn3qEPQxSRA0Ei8Jp+PQW3zgEMWR1p3m2+omY2VB2jRf/JW69fj1Ze02EOU1ioCNgJMEsPprdd6Q8aH6dQXE9I86XXK0kzGi0vAiSPkfUmAebNARJOJ54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152051; c=relaxed/simple;
	bh=HqZWikfj7wkG+IQoeD0AdDRHrOy5dmHHVt/AQDO3Nag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V35ECotDFR2rRl3f5Gc7N3TrEt+Up7CyRICFIGH1Awco6zvrsxrXuxrgneXbFvQJi+WhOuVZFeUMWLK2FW9PAI20x4OQnd4Qlya00P9467Bx3CFBRuOMX9bUYAa9ffIbaH8smcpPmGRj93tRyo9EtFAByyFSnm/JyNcFVlsEutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCXD-0000EM-NF; Wed, 26 Nov 2025 11:14:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCXD-002aE2-1H;
	Wed, 26 Nov 2025 11:14:03 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 25E614A88C9;
	Wed, 26 Nov 2025 10:14:03 +0000 (UTC)
Date: Wed, 26 Nov 2025 11:14:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [canxl v7 12/17] can: calc_bittiming: get rid of the incorrect
 "nominal" word
Message-ID: <20251126-smoky-masked-salmon-a7880c-mkl@pengutronix.de>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
 <20251125123859.3924-13-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kn67tzx5mvvswdo3"
Content-Disposition: inline
In-Reply-To: <20251125123859.3924-13-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kn67tzx5mvvswdo3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v7 12/17] can: calc_bittiming: get rid of the incorrect
 "nominal" word
MIME-Version: 1.0

On 25.11.2025 13:38:54, Oliver Hartkopp wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
>
> The functions can_update_sample_point() and can_calc_bittiming() are
> generic and meant to be used for both the nominal and the data
> bittiming calculation.
>
> However, those functions use terminologies such as "bitrate nominal"
> or "sample point nominal". This is a leftover from when only Classical
> CAN was supported and now became incorrect.
>
> Remove or replace any occurrences of the word "nominal" with something
> more accurate.

I've replaced "nominal" by "reference" as discussed with Vincent in
https://lore.kernel.org/all/20251112-remarkable-puzzling-fox-3b3202-mkl@pen=
gutronix.de/

I'll send a v8.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kn67tzx5mvvswdo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm0ucACgkQDHRl3/mQ
kZy0vwf+KCMzocBR1AaDY8VQINJXnskpPYdwLHWU5pLSC1fJPdsp6mDhyX15MKtJ
/EjTAc0xn0dIupPAITl2ulGJUPNjK8/RUj3ebYS0xdqo3ZqbJnksQ66QrRuHI4IQ
dv0K230gszmqAlLKfKRvyecrp1ujU+AgW1trTGY0DNkRxvS3AX+iYJFc6MmMue8R
kqct5BPVz2MtemHWunTuqZqssKrwzxhTpL6q60br8qnF0RjCZSu566FFlMBi/Fpx
m+/LFPCNmYwYYNspHX8dwlxsYYoi3kmqWbWc11y+JRzQHgtC4K14suRDnnSJRMNa
92VZ2USzTmrA5BqPtL8ZOAlatNHlwg==
=x5+R
-----END PGP SIGNATURE-----

--kn67tzx5mvvswdo3--

