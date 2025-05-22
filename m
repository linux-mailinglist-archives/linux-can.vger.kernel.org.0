Return-Path: <linux-can+bounces-3662-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A626FAC081D
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 11:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8624A3734
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD74176ADE;
	Thu, 22 May 2025 09:02:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4C170A11
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904579; cv=none; b=ev1DMT9mY4ueLoDEjuQNv/LgcfO9mT2n9Hxv6p7bjehaW3DNt6WR/4t1plCHQ/jBWwORwx2/mcEyjqZFJoYxjkz/5jDV20PlHdXdXowkakyYzDJYZX5w7oGIuhsgPgzW3YkrE7rQdVKL4+9rPVe1GCi8ThOTUVMeVaiWsVvx/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904579; c=relaxed/simple;
	bh=pvynabwV+K7UmXm4rdZ3v5WzzhRgmux0KWIbDokGE/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmBLdtcJJVL5kq9qXhwOuWZ3H68H6DKt6adoCP0h9Vrnx9I4L6dAgHViUes62ppgxcMHDlQAe+jJ8vwKUvXOfQ6qxfWrakLckyhlIuH+KKEIIottxmttQcVHv21u5OmE51RKJ4vh62Zp2FuQZPTaEN+Di0RedXsr6mW1c/NVu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1p5-0003f4-CQ; Thu, 22 May 2025 11:02:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1p5-000huU-0F;
	Thu, 22 May 2025 11:02:43 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2264D4175E8;
	Thu, 22 May 2025 09:02:42 +0000 (UTC)
Date: Thu, 22 May 2025 11:02:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: rk3576: add can dts nodes
Message-ID: <20250522-poetic-sloth-of-memory-3c2e33-mkl@pengutronix.de>
References: <20250522063232.2197432-1-zhangqing@rock-chips.com>
 <20250522063232.2197432-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t63acjbvqvulm4br"
Content-Disposition: inline
In-Reply-To: <20250522063232.2197432-4-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--t63acjbvqvulm4br
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: rk3576: add can dts nodes
MIME-Version: 1.0

On 22.05.2025 14:32:32, Elaine Zhang wrote:
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Please upstream the dtsi changes via the rockchip soc tree, once the
yaml changes are in net-next/main.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t63acjbvqvulm4br
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgu6C4ACgkQDHRl3/mQ
kZyRDwf/WT5jFUA6f9sJPzL/R7UCu5fTOaxRuiSdEflm/vzbTA5jgKIwjp1GV2E7
BtTYgX5bKQ5f4jUlt9OYozeFVHpXcuxvGHaCHV8tdIq2jDZI+RXazlNOMouRWgxw
+SKGlXbV5sCVxa5DObzCjvZsgZhaEsXm+vYGuuWZfYVbfnn/oqMcoZrGe+DvdpR3
glDLQA7Ikz6JFh1HwlShFnW3EvB9f7NkRelHm/DGigbLxtx+FEFENtW7/xFmEeML
rMkNT3XcFMq6y6MhtssU78OWaJod6LvAfwR2xcYJY68jACl6oGr8uzVOpZcPnPIn
WtU9JbU0AsDZntgGtlbiTH+uBxLPAA==
=ku/M
-----END PGP SIGNATURE-----

--t63acjbvqvulm4br--

