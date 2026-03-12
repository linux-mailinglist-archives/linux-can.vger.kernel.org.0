Return-Path: <linux-can+bounces-7076-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDhVJcBwsmmuMgAAu9opvQ
	(envelope-from <linux-can+bounces-7076-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 08:52:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9326E7D7
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87AE130451D8
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D253B47ED;
	Thu, 12 Mar 2026 07:51:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BF3AC0D0
	for <linux-can@vger.kernel.org>; Thu, 12 Mar 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301912; cv=none; b=HjSgMt1kIHw52vy2RGs/aH86RXtPzObHi29TvVKTi+aBFQLzAXUPnexvs4ezfJu2rvH5HiOAjJuBrnc23hDV6OzO94AC1AMhIAl+T2hEWoWgtiV83jGVzzCOVbEb/CQirlHXpe7KkOhB2tRDkXNG621bwNxh8etAFiCRKwpM5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301912; c=relaxed/simple;
	bh=O0W4dyeZXINL1xMPgfaiUp8T/xt+gRpsnXCZ1iL32IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8FP16H8JgRIrrs2gl3su8x/SChcGhQq/hSqLV8OuPeeMbtH3xFs1htvyvSAUUyu1G9tIEst8YmT9sXf/WxhNuWEejBSYHnzEuIgUQEoLDNG9Uuy+KRITpubApiJ6Z9NvpMvBz5hAckjW2wxR9tfg4XFeWJ4kHjUk29mCZjERYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0apM-0000j6-G5; Thu, 12 Mar 2026 08:51:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0apK-004zEN-11;
	Thu, 12 Mar 2026 08:51:27 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4A4814FF6DF;
	Thu, 12 Mar 2026 07:51:27 +0000 (UTC)
Date: Thu, 12 Mar 2026 08:51:26 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
Message-ID: <20260312-fragrant-blond-velociraptor-bf449f-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <n6affntgff5wy4xmm255v5h2ejpepicpz2cybcuvsxmry5td6u@jucskv7zrzvv>
 <5cdfe5a5-3c78-45a2-886c-768b224ad776@oss.qualcomm.com>
 <wbx2qrkhpsntggzqkzkpi4sa6qv3buhkjbwmjoa7zgw2oc4b7u@qugyhcxb6qrh>
 <316fa702-6cd8-4842-aecf-c176a5a53e2e@oss.qualcomm.com>
 <qvuokwiqllm6zmlzj3pfvziylrr5krjya5rnf3ojeycdoutlro@fl5qukh4vorm>
 <5486697e-d02e-4b12-9a60-99d0de343515@oss.qualcomm.com>
 <2ho25tzct6t7gsuyufyg7m4a2ikmblhukb4uddwc7p35wd6yne@heippz3lh4kj>
 <465ab63f-3d0c-46f7-a08e-cdc5fc26b600@oss.qualcomm.com>
 <73nfsa3r3isf2shizemroctjpleya4wnnel634g7b5qyvvmze5@vre6wrdxxpet>
 <0bf0a64c-0f05-49ea-b7a2-e1b1345a3d7f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sukssa3pp322mpwk"
Content-Disposition: inline
In-Reply-To: <0bf0a64c-0f05-49ea-b7a2-e1b1345a3d7f@oss.qualcomm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7076-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 57B9326E7D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--sukssa3pp322mpwk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
MIME-Version: 1.0

On 12.03.2026 12:04:47, Viken Dadhaniya wrote:
> I measured the standby pin voltage with only XSTBYEN=3D1 set
> (TRIS0 left at reset default of 1 =3D input): the pin is HIGH
> (~3.3V), meaning the transceiver remains in standby.
>
> The root cause is that after reset TRIS0=3D1 (input direction),
> so the pin is not driven. XSTBYEN=3D1 alone has no effect while
> the pin is configured as input.
>
> Clearing TRIS0=3D0 (output) atomically with XSTBYEN=3D1 fixes this:
>
>   regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
>                      MCP251XFD_REG_IOCON_XSTBYEN |
>                      MCP251XFD_REG_IOCON_TRIS0   |
>                      MCP251XFD_REG_IOCON_LAT0,
>                      MCP251XFD_REG_IOCON_XSTBYEN);
>
> After the above change: pin is LOW (~0V), IOCON =3D 0x03020042,
> transceiver active, CAN communication works. Verified on RB3
> Gen2 with PCAN-USB FD.
>
> Should I send a patch implementing this, gated on a DT property
> such as "microchip,xstbyen"?

Sounds good, make it so.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sukssa3pp322mpwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabJwfAAKCRDMOmT6rpmt
0i+VAQD/pM/3ElXgQQT6o0izqhNruQmbv9GQ2oAKqT8CSu6uHwD/dlMVovtUZD8A
tingrin1tghEh/0VWtmoLpd/EOwCsgw=
=er+K
-----END PGP SIGNATURE-----

--sukssa3pp322mpwk--

