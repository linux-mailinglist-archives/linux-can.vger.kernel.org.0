Return-Path: <linux-can+bounces-7080-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBMlCvu5smmYOwAAu9opvQ
	(envelope-from <linux-can+bounces-7080-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 14:04:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 894082723C7
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 14:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E4B3062F9B
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98937DE8A;
	Thu, 12 Mar 2026 13:01:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A913BE62F
	for <linux-can@vger.kernel.org>; Thu, 12 Mar 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320502; cv=none; b=OcTUgH+NwWS5xLj4ecdtFDjYdMzX+jl4u4Ip8W7KYEfSci0w7eJXrK9yPaJWk0n9a4E5RfQPIxcKsquHMFwHQNqSI8ykpH226ssNdTeo/gAi2Erf2keYtWHEPiGcf2M8yfoIgkC5KIhDyF/m6si91egnro2nKxi6qNT8ssEuEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320502; c=relaxed/simple;
	bh=mHpAgu5Dsnbe3fVk2Pr6O9uk2FcSppo6ZXlCpSIpoLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp8fKYf65WswZeSKYuH/Ud+JUAVqIvSbOljNulV+1EbsKxGItWFg128RXukLWmXR9BuSkerCowAMYGeYecgf4XIkwGJ1F30Mu6zmYef6uKwzZqBgBnS1m4rcoJEnB8RqmGzsxl2IiOAlD+GjtmNI503U1U6QwVj4GqQiYSPO4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0ffH-0002g5-0s; Thu, 12 Mar 2026 14:01:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0ffD-0051ZH-2l;
	Thu, 12 Mar 2026 14:01:21 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DED974FFAA3;
	Thu, 12 Mar 2026 13:01:20 +0000 (UTC)
Date: Thu, 12 Mar 2026 14:01:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?5oKs5rq6?= <2063309626@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Maud Spierings <maudspierings@gocontroll.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Alban Bedel <alban.bedel@lht.dlh.de>, 
	gszhai <gszhai@bjtu.edu.cn>, 25125332 <25125332@bjtu.edu.cn>, 25125283 <25125283@bjtu.edu.cn>, 
	23120469 <23120469@bjtu.edu.cn>, linux-can <linux-can@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] can: mcp251x: add error handling for power enable
 inopen and resume
Message-ID: <20260312-alligator-of-total-contentment-e7349c-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_6A462B2C8A50BA55116D560D2FFE9EED2D09@qq.com>
 <20260312-peridot-galago-of-painting-7d6e1c-mkl@pengutronix.de>
 <tencent_9D40B736A2D06AF745F473AAC55B45561106@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="liohzfrzmouwwelw"
Content-Disposition: inline
In-Reply-To: <tencent_9D40B736A2D06AF745F473AAC55B45561106@qq.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7080-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[qq.com];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 894082723C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--liohzfrzmouwwelw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2] can: mcp251x: add error handling for power enable
 inopen and resume
MIME-Version: 1.0

On 12.03.2026 20:48:43, =E6=82=AC=E6=BA=BA wrote:
> Add missing error handling for mcp251x_power_enable() calls in both
> mcp251x_open() and mcp251x_can_resume() functions.
>
> In mcp251x_open(), if power enable fails, jump to error path to close
> candev without attempting to disable power again.
>
> In mcp251x_can_resume(), properly check return values of power enable
> calls for both power and transceiver regulators. If any fails, return
> the error code to the PM framework and log the failure.
>
> This ensures the driver properly handles power control failures and
> maintains correct device state.
>
> Signed-off-by: Wenyuan Li <2063309626@qq.com>

Please use git send-email as you did with the first patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--liohzfrzmouwwelw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabK5HQAKCRDMOmT6rpmt
0gQZAPwKF7AJ4QoF7+tt73le3ckeVNt0YIfvo+PCQECvoEBffQEApXwKx2KjSIMG
5wS/FrxqC5TbTgTUKjPhNZCwmTQofQM=
=VHsQ
-----END PGP SIGNATURE-----

--liohzfrzmouwwelw--

