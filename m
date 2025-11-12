Return-Path: <linux-can+bounces-5347-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08FC512F9
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 243674F4FC2
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DD2FE071;
	Wed, 12 Nov 2025 08:48:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A102FD7BC
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937326; cv=none; b=T8ilFAn3w5Sm2D5jSzAFy3IgTlp1qSgRVX8of3iugaTrIPJR97m/mzyGXVlbE7lleagJkmkzMqV5xtquajEGzxzCOTi4moBGhTQBB8OWBkUjU7ZWv0ReOHR8F4maeFXMk2h8C5X4xW2g2VRPgjQRJAW2GnL/GBVsVzGYmYHKF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937326; c=relaxed/simple;
	bh=GXyxs2fdJAXg+I9zySibsWiBBmpKXy7SGhXsGpF9q1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/Abnl54hGE7meXlavpqkbpHd74VZI6UPVkFYDgZd526UX+FGdENxuYGNb1sezR2Qf72isnK0ke2PXaF1CRG3CP5a2g7r+Rda3+KbYWs/TrwFa475SFHqh5TnHxjddbzLKaBkBPgt6ypVNEnJYOYyBgl+MExFIvP8g7ebhEfKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Wt-0002Un-Qy; Wed, 12 Nov 2025 09:48:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6Wq-0003IY-02;
	Wed, 12 Nov 2025 09:48:36 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C47F549D931;
	Wed, 12 Nov 2025 08:48:35 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:48:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: dario.binacchi@amarulasolutions.com, mailhol@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: bxcan: Fix a typo error for assign
Message-ID: <20251112-adept-hog-of-perspective-06034a-mkl@pengutronix.de>
References: <20251103074009.4708-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aymbmr4omypbjtnz"
Content-Disposition: inline
In-Reply-To: <20251103074009.4708-1-chuguangqing@inspur.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--aymbmr4omypbjtnz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: bxcan: Fix a typo error for assign
MIME-Version: 1.0

On 03.11.2025 15:40:09, Chu Guangqing wrote:
> Fix the spelling error of "assign".
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--aymbmr4omypbjtnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUSeAACgkQDHRl3/mQ
kZxilAf/aeIB0Drgewhhbh0fvV0GejEXmeFteRF93t6F12ckifWhSIhxlGDr47gP
+2eJ3fdOZCeeEqMipN6Wi+JV8vHauhpVfSVNaQb5XDvmA0RRsB6CqoEt/f81oasc
p7kfa0L0rMtmmNbJpqDgDZO8CXvlwf4oXtoj2vmyDS18dskIZJ3axRyTWzuuk+O8
rPz+ndMH/kMbVRfvweVB51h4kk8YPX1BqeGa6bAUeFoEnNm8/wAdcScOqdP/PxLP
ZPzWSVWNK1YQfsYKQ3UXolV38BNE81fTDSV0jpIfHAgD8SmDB0VLIer8VASRnRpS
BabwNG+d2yWAK0unnBwJf806NKar5A==
=hHX/
-----END PGP SIGNATURE-----

--aymbmr4omypbjtnz--

