Return-Path: <linux-can+bounces-5728-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480BC8AA44
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 16:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 436EE4E4727
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841173314B8;
	Wed, 26 Nov 2025 15:29:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE5303A20
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170944; cv=none; b=XYl1PaLU9tjQ5NiCF0HO+FNnYuXDVDKGtplMlvieTbzjXHr1aOfkURBalujEjK61sEOPUduKo8Z6rF298iLvr53SwtvwbLcanidjWkRWwwEPPHy31TPBAO9md65BxLd3uV4JbA1+ep+XswK6ckL2H6gBH7l3YeioBvKR+UfY0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170944; c=relaxed/simple;
	bh=27YVx8w9eie3JzsSxvPATQ52ANl2xikBLZ8WSoj76Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlIRScLaj8kNFVIZhtIoNW0REgb5cedcTggFecKL74pbvxp160ERq0rHEYqify3A0wv2Jl/ajayz5aVVstR1PyFmawnNAHov9hJp50eWFoaREWt5iusx7h9bhUN9YNxAEGPEXRbsC8MAw8AhKNQ7k/GD1Ezssl1ZZYlCYyc/hZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHRp-0003Oc-7E; Wed, 26 Nov 2025 16:28:49 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHRn-002dD2-10;
	Wed, 26 Nov 2025 16:28:47 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 04A1A4A8DE5;
	Wed, 26 Nov 2025 15:28:47 +0000 (UTC)
Date: Wed, 26 Nov 2025 16:28:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: ssrane_b23@ee.vjti.ac.in
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Rostislav Lisovy <lisovy@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] net/sched: em_canid: fix uninit-value in
 em_canid_match
Message-ID: <20251126-antique-tuatara-of-memory-5725fb-mkl@pengutronix.de>
References: <20251126085718.50808-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wp43vc5hhm3tyrke"
Content-Disposition: inline
In-Reply-To: <20251126085718.50808-1-ssranevjti@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wp43vc5hhm3tyrke
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] net/sched: em_canid: fix uninit-value in
 em_canid_match
MIME-Version: 1.0

On 26.11.2025 14:27:18, ssrane_b23@ee.vjti.ac.in wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> Use pskb_may_pull() to ensure a complete CAN frame is present in the
> linear data buffer before reading the CAN ID. A simple skb->len check
> is insufficient because it only verifies the total data length but does
> not guarantee the data is present in skb->data (it could be in
> fragments).
>
> pskb_may_pull() both validates the length and pulls fragmented data
> into the linear buffer if necessary, making it safe to directly
> access skb->data.
>
> Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5d8269a1e099279152bc
> Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames acco=
rding to their identifiers")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Applied to linux-can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wp43vc5hhm3tyrke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmknHKsACgkQDHRl3/mQ
kZzHBgf/VuvXZqmQ/2MIKATt84MJGjc3Bh63oGRkZtbD1VJY6Bq3Mx2/LflJLRQw
nVGSGu/Sk3C439qLUpdnIOuW9eNxFg/ghjKhm1mifOQcoDXI/zfodeFjaKuuPnFu
fP/PhSGaCE5cWagS8sQH5ewih4LgJfpOd/QdiyP4+6RVBz+NpnLMUKy4yw3iPN+r
XLqAvjNeIGXZOil8VmND8/yYKAWhpjShcM+4QHpubd+Hjie9ro4h5OUUftZ8g4IQ
TYWg/TY7p9WR7yEjTcY0OBQrhrZD5YpuCmjRM8qNxIQ8bIrnXzTSKDDGVv1C8eAm
jDV4FxOyblknbJBo0q0GjgKrSww4zg==
=l4/N
-----END PGP SIGNATURE-----

--wp43vc5hhm3tyrke--

