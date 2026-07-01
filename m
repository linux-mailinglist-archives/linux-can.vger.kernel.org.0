Return-Path: <linux-can+bounces-7940-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hiTsGM7kRGrY2goAu9opvQ
	(envelope-from <linux-can+bounces-7940-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 11:58:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4526EBCD8
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 11:58:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=CBFCH8L3;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7940-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7940-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7BF33049704
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCA93DEADC;
	Wed,  1 Jul 2026 09:56:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99A3FFAC6;
	Wed,  1 Jul 2026 09:55:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899767; cv=none; b=Y1m3YeXYaxghBrjyxmnSpC6fFx4tWPRYI6+Z7i1x6NdLbdgE6mErXX0b/jnSuLkfP1IKurrAw74t6Bt9LlpUtN44cqZCEu4W/UTTU0tETizJMCOc9FkJIOh7Q16KQ7qKZVpQYliSQ7vDTijep48+WyXNNZfaauTNJWW67pwWZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899767; c=relaxed/simple;
	bh=Y6FebpXTbt55poJocQkLDY6wwdF36SH6ugjS6chVRFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT4k6OFl/uTbrE8OCbRw4osaCsA+66qTzRbVlqRWsVj1OF2kFlzkMfhXNg64GQhNMb0rN5FnKQb8ch9Opj6AWG35PafDdhcrhqKgMIRod0OcrFH05b4BNUcZhVIG3A+C22V82kjTbIIQclhFLaDQDGCN+/SNPG4Wo+vgtTk7xQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=CBFCH8L3; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=YXbWsJdVyrdyTG0h5l7l2loSKTm6mVXPsPtw2ami5dk=; b=CBFCH8L3XGKiP/K1ZN7vVXVeHO
	TYkbcdRb7HG3F74/uf8JkzcO+CYf/pQ8hVd/bQW64Ez2rZ4zxcV4TD0jnnJseomf1envfpC8mnB+Q
	AXx+xHjOmIhyrn9yFTao5hqiJWjmm1v9eFQzdTye49MOlx8QrLadNqQKz4MVVq9UicyCi7m9t222i
	SUAkN9B4gjxbnt2lMrxs+JROzdPZgH7xqe3MBWAMt+K5c4hXSLlrlhoQtMTZaYHbAKEzBypRxVrM4
	X4p3CoGibwpF2ye7JhDmqplKnFc8fTDvLGL3P4wY8T7vuXpwFxPsznPvG3gb2gCl+RTv1YHEL7YtO
	PBd3NovA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 1579567540@qq.com
Cc: Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, luch00 <1579567540@qq.com>
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Date: Wed, 01 Jul 2026 11:55:39 +0200
Message-ID: <2064877.jZfb76A358@diego>
In-Reply-To: <tencent_124D6134EB32480979234201E688087E5408@qq.com>
References:
 <20260701070128.2096267-1-1579567540@qq.com>
 <tencent_124D6134EB32480979234201E688087E5408@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:1579567540@qq.com,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7940-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,vger.kernel.org,qq.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,vger.kernel.org,lists.infradead.org,qq.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sntech.de:dkim,sntech.de:from_mime,qq.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,diego:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD4526EBCD8

Hi,

Am Mittwoch, 1. Juli 2026, 09:01:27 Mitteleurop=C3=A4ische Sommerzeit schri=
eb 1579567540@qq.com:
> From: luch00 <1579567540@qq.com>

please use a real name, not an alias.


> Add support for the RK3588v2 CAN-FD controller by introducing a
> dedicated model ID and OF match entry.
>=20
> The block is closely related to the existing RK3568 variants, but it
> cannot reuse their match data unchanged. In particular, RK3588v2
> encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
> SoC-specific handling.
>=20
> Validation on RK3588v2 also shows that its observed errata profile does
> not fully match rk3568v2/rk3568v3, so keep a dedicated devtype for this
> variant instead of relying on an rk3568 fallback.

=46unnily enough, we seem to have worked on the same topic
at the same time :-)

https://lore.kernel.org/lkml/20260630164336.3444550-1-heiko@sntech.de/

> Signed-off-by: luch00 <1579567540@qq.com>
> ---
>  drivers/net/can/rockchip/rockchip_canfd-core.c | 14 ++++++++++++++
>  drivers/net/can/rockchip/rockchip_canfd-rx.c   |  5 ++++-
>  drivers/net/can/rockchip/rockchip_canfd.h      | 12 +++++++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 29de0c01e..3c2480785 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -50,6 +50,15 @@ static const struct rkcanfd_devtype_data rkcanfd_devty=
pe_data_rk3568v3 =3D {
>  		RKCANFD_QUIRK_CANFD_BROKEN,
>  };
> =20
> +/* Tests on the rk3588v2 reproduce Erratum 5, but not
> + * Erratum 6 or the special CAN-FD frames that trigger Error Interrupts
> + * on rk3568v2/rk3568v3.
> + */

Here I could reproduce erratum 6 though:
https://lore.kernel.org/lkml/20260630164336.3444550-4-heiko@sntech.de/


[...]

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-rx.c
> index 475c0409e..fe64db373 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
> @@ -281,7 +281,10 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *p=
riv)
>  {
>  	const u32 reg =3D rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
> =20
> -	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
> +	if (priv->devtype_data.model =3D=3D RKCANFD_MODEL_RK3588V2)
> +		return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588, reg);
> +
> +	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568, reg);
>  }
> =20
>  int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
> diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/=
rockchip/rockchip_canfd.h
> index 93131c7d7..f6105b904 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd.h
> +++ b/drivers/net/can/rockchip/rockchip_canfd.h
> @@ -214,7 +214,8 @@
>  #define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_ENABLE BIT(0)
> =20
>  #define RKCANFD_REG_RX_FIFO_CTRL 0x118
> -#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT GENMASK(6, 4)
> +#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568 GENMASK(6, 4)
> +#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588 GENMASK(7, 5)

Oh, didn't see this when doing my variant of the support, so cool that you
found this.


Heiko



