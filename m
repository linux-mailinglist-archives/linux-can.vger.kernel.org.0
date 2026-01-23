Return-Path: <linux-can+bounces-6286-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP97A7SGc2krxAAAu9opvQ
	(envelope-from <linux-can+bounces-6286-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:33:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E14771D6
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BC41302428E
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEDC29DB99;
	Fri, 23 Jan 2026 14:30:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB228D8ED
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178632; cv=none; b=RqLGf3243M8ITZ4iK6io4G3WRmF2NkFIXjcvs2QVJ/0ICPcS4zll6a7Io+x2DVCF5OvJoXiWtqGzhLI61wtS41T67FOoP2ThmcfkbWKoPY2ly00Glb7cy3gGySXQH6LqVuK/SBdqcQpczaVSDWoHGbBsaV5QotZql+HWRPFjrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178632; c=relaxed/simple;
	bh=dbzocdrkEcAzLkfaFHQy6lFESFnae3oGeKED4QiJ09I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3FoocYIoa/ke3HRZaFBQmR+LG2Lv98wYkUwnaWuAy7s8azLAy6MLnnA7FCR43DzdNUCdp0Rheea91UwDgLwhx8rdxp39TqdtZ1zoLEWBezHLP1+cwoMygNqojGsPr3IauAwFG1s0rKLgUAeS6UyMkhhRFCHKXpaGy+NAXtW0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjIB5-0004lD-SU; Fri, 23 Jan 2026 15:30:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjIB6-0026kg-15;
	Fri, 23 Jan 2026 15:30:23 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 54FD24D6FA6;
	Fri, 23 Jan 2026 14:30:23 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:30:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 00/15] can: grcan: Enhance driver with CANFD Support
 and Improvemens
Message-ID: <20260123-evasive-chirpy-bug-6ac9d8-mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5tojfe3cjkncy5m2"
Content-Disposition: inline
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6286-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91E14771D6
X-Rspamd-Action: no action


--5tojfe3cjkncy5m2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/15] can: grcan: Enhance driver with CANFD Support
 and Improvemens
MIME-Version: 1.0

On 22.01.2026 13:10:23, Arun Muthusamy wrote:
> This patch series updates the GRCAN driver to support the GRCANFD core
> from the GRLIB IP core library.
>
> In addition to GRCANFD support, the updates include enhancements for
> compatibility with NOEL-V (RISC-V) systems, such as matching drivers
> using the 'compatible' identifier and adding support for reading clock
> frequency via the common clock framework where available. The series
> also includes improvements like functions for configuring
> nominal bit-timing and optimizations for DMA operations.
>
> This series also updates the driver documentation and bindings.
> The old text binding is converted to YAML, a new vendor prefix
> is added to reflect the updated ownership and an entry for the
> driver is added to the MAINTAINERS file.

The order of patches is strange.

In #12 you claim to support CAN-FD, but actual support is added in
#13...15.

The kernel should be functional on every commit. Please change the order
of patches, that CAN-FD support can only be enabled if the driver really
supports it.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5tojfe3cjkncy5m2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzhfsACgkQDHRl3/mQ
kZwHTwf/YdeYMJLjdsmXYZd6wFWvx3Fd2gD6DV8c8F+3DPqnznOW3iheWWjaUdjZ
WHxxEUV0gRWM1OpZndj/Hm4SYV2mLNO7uplU7ZnWx4Jwfm5R/IUV+s71rpCD2GPx
OifGT2YEvgsVnNXpIQZItLExscnk6mgWbaf3GKGJgI0pB/lFE4vP9rJxoQ+eHymH
xTfjzMiU90oMArzSVhp7eEZyUPz3OEPP5WY2oJQGUNAsHYIhjEg6ARmqwl92cqwj
4fokeZydZQq8wHOkYs4LGCWxuPl5VyeYr4y02oGdCK7Yesg6bRp/QL7VZWe90yzT
DKwYA0JFpR6vUfDk1pQ06DKqWffvJg==
=riWi
-----END PGP SIGNATURE-----

--5tojfe3cjkncy5m2--

