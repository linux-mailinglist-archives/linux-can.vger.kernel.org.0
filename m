Return-Path: <linux-can+bounces-3368-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56E4A7E2D0
	for <lists+linux-can@lfdr.de>; Mon,  7 Apr 2025 16:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE94421C89
	for <lists+linux-can@lfdr.de>; Mon,  7 Apr 2025 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442A1DF745;
	Mon,  7 Apr 2025 14:34:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCA1DE3BF
	for <linux-can@vger.kernel.org>; Mon,  7 Apr 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036472; cv=none; b=e2SLP/+Ya0/w8E64Ivp47Ce4OM8Gy1jn1sOR6Y8qBlnfp01v85hzLSMCCRk4Gr2+otjM15eSVAflaZ/LYwhVGchsoziPWsIcTdYfeicslJPmFR1GdBsiPYfBWyT0PCbF1gziZzhzJi361MzPis/gMhQM2lRhobkv9BkY+JTOLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036472; c=relaxed/simple;
	bh=EuwBqjboEj0MNjwZj7hZh4ixSNZkG90tChRP/6suiM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLEqK+Q/ONM+/67WBU8LHqofjYR5GwNrEmNCo7r1S/4Xtfi0aqaNtouF9Cct7j72R+gSXKV45MrU1p5pr4mEExHLxOaEnUIJYJq1Vui5VWwtNROEyJBnVCdBi/KOYw1Mu0BJBWSVq8M9Ex97ATTEOhevR2OO09shyqyOMF4cT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u1nYP-0002ra-Ai; Mon, 07 Apr 2025 16:34:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u1nYO-003mHX-2x;
	Mon, 07 Apr 2025 16:34:24 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 78FF03F20C2;
	Mon, 07 Apr 2025 14:34:24 +0000 (UTC)
Date: Mon, 7 Apr 2025 16:34:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Axel Forsman <axfo@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	stable@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 1/3] can: kvaser_pciefd: Force IRQ edge in case of nested
 IRQ
Message-ID: <20250407-unyielding-panda-of-wealth-5c277e-mkl@pengutronix.de>
References: <20250331072528.137304-1-axfo@kvaser.com>
 <20250331072528.137304-2-axfo@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxznz6cxs6ci2wj2"
Content-Disposition: inline
In-Reply-To: <20250331072528.137304-2-axfo@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--cxznz6cxs6ci2wj2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] can: kvaser_pciefd: Force IRQ edge in case of nested
 IRQ
MIME-Version: 1.0

On 31.03.2025 09:25:26, Axel Forsman wrote:
> Avoid the driver missing IRQs by temporarily masking IRQs in the ISR
> to enforce an edge even if a different IRQ is signalled before handled
> IRQs are cleared.
>=20
> Fixes: 48f827d4f48f ("can: kvaser_pciefd: Move reset of DMA RX buffers to=
 the end of the ISR")
> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Forsman <axfo@kvaser.com>
> Tested-by: Jimmy Assarsson <extja@kvaser.com>
> Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 83 ++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pci=
efd.c
> index fa04a7ced02b..0d1b895509c3 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -1646,24 +1646,28 @@ static int kvaser_pciefd_read_buffer(struct kvase=
r_pciefd *pcie, int dma_buf)
>  	return res;
>  }
> =20
> -static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
> +static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
>  {
> +	__le32 __iomem *srb_cmd_reg =3D KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_P=
CIEFD_SRB_CMD_REG;

Why is this an __le32? The struct kvaser_pciefd::reg_base is __iomem
void *.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cxznz6cxs6ci2wj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfz4m0ACgkQDHRl3/mQ
kZwUWAf+JaG52om75t0+dLe+wRxhRmWeBumrOrK7QLuoBlHEwaTRopw9UXUyT7UY
jeZJTWrXQE6rbTTZGDG6DdjlqKtc57L987ms/wrJ+V6nKeG3bqJHYCfxXaRndjkf
Hz83INpiphngKq8RBLkNiqxc9BFw1G5+1Ou4vz4kag4xzyovwlpsgTrxSuUsVmPs
K7/O7efN+rFldda/n+SqqEA8VE3GHeG1zdSxgY1SASt7GkA2TNZ1GP4ytuF+/3mk
Chyh8qJ8ejCiurHVcCWnRBQpIgtbLM+Vd/nckonm4+bHGbu1Nabb1NAsBI7Z/Wi+
9gGRemyxjxN/jyTGN+SYp3VMOs2jPQ==
=Mhlb
-----END PGP SIGNATURE-----

--cxznz6cxs6ci2wj2--

