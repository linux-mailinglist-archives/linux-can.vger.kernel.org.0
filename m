Return-Path: <linux-can+bounces-7024-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GeSCv+Qrmk7GQIAu9opvQ
	(envelope-from <linux-can+bounces-7024-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 10:21:03 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36F2360EA
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C274304652A
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF59378D68;
	Mon,  9 Mar 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d4bw/dK6"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C213783B9
	for <linux-can@vger.kernel.org>; Mon,  9 Mar 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047945; cv=none; b=CU8i+M+MfwTwwOdDyqwK+yXSaQEwxHP6R4ryCV8pkznlomLm7zk9JSDAAAbSR4O5CD93DYlzF4Enr0nMnt2Uhe4KUURPdAvJH4VpUVdMVGVSjxaRzMHhG8NDC5SFnWtbJKmGOKad4B2Iqcsbo3dGWsyWBGu/GglIIBssnyAr8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047945; c=relaxed/simple;
	bh=CncL9gUcdJL6wlW5tkcGvRzvFuDGtQP6+c+HDcnsN/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bdWBg7L698UU1c+DB631vyL0gK4cuW9lfvLWeUAZWaVvoOc3ISqO8KKGBeow3DVNkLkXuqORy/mI0CpAHSiCexka4T4X7X03Csj+yRF/47V/cuiuitPfr3YzB6cOnsLISN01y0jMjBc67VmYPc0YIEmjcWs73aSByzpG5kF2OM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d4bw/dK6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so4924159f8f.1
        for <linux-can@vger.kernel.org>; Mon, 09 Mar 2026 02:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773047940; x=1773652740; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNiLR6YNrMRtTldTWTQRiLTdnMm5k8O8M4DvpvHP74I=;
        b=d4bw/dK6zVqZDdZTt12+IDmKf/RFmlRClqU3NCeMemKHCYqMLQGLcBHuqQc2BcWOeD
         MXOLsFYj6TQwgG9d1ew4SkOgDEe3IxZWa8agXhd6YzzlHAvxlPV7zRMucd8EK5v6aeJX
         euk/7xwAo8P7CEl3x9SHefS77U8Yxi0nmtZNqbpt2kkmWh1GnCE/QKraHW/3x9H3z+eu
         Hgh8UVKxo75IMc3SnJVjy3eWFqYuMZouwGJ3APuDh1aMYpa7dmq2cnpGcTxaxURf3yju
         ms2CccJlDvP945saycvwiiUZr1WiiL7+9v2UEYTcmobp9tF3vIAtjiGYalZ6Cr3d5R/U
         YqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773047940; x=1773652740;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNiLR6YNrMRtTldTWTQRiLTdnMm5k8O8M4DvpvHP74I=;
        b=cdKF4Xa2NKFXEOQ1M4VHHKgBrJ/4QCT3eIBR6hdFBoOMmE0nW8ChEFc6yj1Va24rqh
         vLkndeLYR5vF63uYFitM9q+0aVDvacC7vRCTllycHlAysjNUZPdjuUQYZ+DovRtXrN0e
         oL9D4uquajZaVDdR+M7MZRnagsJmDhflZ9SCXy3fC25UM9rsQ3PVL7IhO1Uj9Bao3m7M
         FFc1sDj6QpyrgoK0Eqa1QvTEsqVdTWt6SI7mSH1sp6jRJdCNgNqys4QlhHiQC8/tJvtv
         CaPm2jKfIisZY12APWrZEIGGcd3Rs8Va70WfS1UMmioF3x5RrhbSEo3eTGWzyAikE/73
         4QKg==
X-Forwarded-Encrypted: i=1; AJvYcCW1r/8Sa7nluLBkowm3tUGIy03KUO+WWhimmgyzbTkdLQNLlgPCdMa3GqJmORWmEXNRDfJxwQCdU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAeChZPj6pZRXlEAM5dIP0+HYM7stlrLn/5JGPVsCaYv04I6I
	/ZXIL5SJSEqm5QVKFzR0UFXU+SZ96By3KLoWjd5M9lNpkxjCFPg1i9Azig09iwLEYkex9wDIQa7
	ejfKxjIY=
X-Gm-Gg: ATEYQzyq6XO9ovEBrSFU9AyPqZMisx8JXkK/GZ5ECykUDiAUvzJ0oTsDDiZZIegc9qC
	/aNLxO7NAyCnLiUs1v3ZaQg2+nQi8b08yXusxLSCrfRxUYJ/RlHhCKvvZxivTTJyGmAcv0ON6d9
	XGwSBwM3GpQRF1bPJunhbLEAXUaGmGj5ME+SaZ69cfgnxG8XUMOdyNnLE7UKFHnZqFQwOVvUrDC
	7SYxeKLEXn16wtTDqFsmllB2ONWSr/MhRyep4MKMCMOQUO1KRb6LmAzonz+pKqTA05cbgLreFMZ
	bJCcvQ8TcEEoG3a7aquFXDy5g2izvh7tdNzykszKcOHpa1iy17lH0SY8bjpLjICA0vLEmjS+noo
	StYWrq5McTuqrsbNen61qitACpmwioEDFbw0jWvRTyQ0sGUM7uJ0ygJ1GnmUJEWke03ev1EYVGQ
	cQIyRFwdWjAEA39Ng=
X-Received: by 2002:a05:6000:603:b0:439:909f:c5a3 with SMTP id ffacd0b85a97d-439da3277d9mr17145973f8f.4.1773047939930;
        Mon, 09 Mar 2026 02:18:59 -0700 (PDT)
Received: from localhost ([195.52.25.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dada9116sm23029936f8f.14.2026.03.09.02.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=840703edd9f3f1e1e79a02bb78a8d4f69f696b0531524c2c45c8075436e0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 09 Mar 2026 10:18:50 +0100
Message-Id: <DGY51AQLSNAD.3LE77TJER4LGF@baylibre.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-can@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-ide@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
 <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <netdev@vger.kernel.org>, <spacemit@lists.linux.dev>,
 <UNGLinuxDriver@microchip.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Marc Kleine-Budde" <mkl@pengutronix.de>,
 "Vincent Mailhol" <mailhol@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Markus Schneider-Pargmann" <msp@baylibre.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Magnus Damm"
 <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 phy-next 14/24] phy: introduce
 phy_get_max_link_rate() helper for consumers
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: <vladimir.oltean@nxp.com>, <linux-phy@lists.infradead.org>
X-Mailer: aerc 0.21.0
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
 <20260308114009.2546587-15-vladimir.oltean@nxp.com>
In-Reply-To: <20260308114009.2546587-15-vladimir.oltean@nxp.com>
X-Rspamd-Queue-Id: 9C36F2360EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7024-lists,linux-can=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,rock-chips.com,pengutronix.de,bootlin.com,tuxon.dev,baylibre.com,glider.be];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

--840703edd9f3f1e1e79a02bb78a8d4f69f696b0531524c2c45c8075436e0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun Mar 8, 2026 at 12:39 PM CET, vladimir.oltean wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> In CAN drivers, the transceiver is acquired through devm_phy_optional_get=
()
> and NULL is given by the API as a non-error case, so the PHY API should
> also tolerate NULL coming back to it. This means we can further simplify
> the call sites that test for the NULL quality of the transceiver.

Thanks for adding this.

>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Markus Schneider-Pargmann <msp@baylibre.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Magnus Damm <magnus.damm@gmail.com>
>
> v1->v2: make phy_get_bus_width() NULL-tolerant to simplify CAN callers
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c             | 2 +-
>  drivers/net/can/at91_can.c                          | 3 +--
>  drivers/net/can/flexcan/flexcan-core.c              | 3 +--
>  drivers/net/can/m_can/m_can_platform.c              | 3 +--

For m_can:
Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

>  drivers/net/can/rcar/rcar_canfd.c                   | 3 +--
>  drivers/phy/phy-core.c                              | 9 +++++++++
>  include/linux/phy/phy.h                             | 6 ++++++
>  8 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index a8b6ae58cb0a..ed7ed82ddb64 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1300,7 +1300,7 @@ static u32 cdns_mhdp_get_training_interval_us(struc=
t cdns_mhdp_device *mhdp,
> =20
>  static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
>  {
> -	unsigned int link_rate;
> +	u32 link_rate;
> =20
>  	/* Get source capabilities based on PHY attributes */
> =20
> @@ -1308,7 +1308,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mh=
dp_device *mhdp)
>  	if (!mhdp->host.lanes_cnt)
>  		mhdp->host.lanes_cnt =3D 4;
> =20
> -	link_rate =3D mhdp->phy->attrs.max_link_rate;
> +	link_rate =3D phy_get_max_link_rate(mhdp->phy);
>  	if (!link_rate)
>  		link_rate =3D drm_dp_bw_code_to_link_rate(DP_LINK_BW_8_1);
>  	else
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 4ab6922dd79c..79c72ee8e263 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -536,7 +536,7 @@ static int dw_dp_link_parse(struct dw_dp *dp, struct =
drm_connector *connector)
> =20
>  	link->revision =3D link->dpcd[DP_DPCD_REV];
>  	link->rate =3D min_t(u32, min(dp->plat_data.max_link_rate,
> -				    dp->phy->attrs.max_link_rate * 100),
> +				    phy_get_max_link_rate(dp->phy) * 100),
>  			   drm_dp_max_link_rate(link->dpcd));
>  	link->lanes =3D min_t(u8, phy_get_bus_width(dp->phy),
>  			    drm_dp_max_lane_count(link->dpcd));
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index 58da323f14d7..7749da0a58f6 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -1125,8 +1125,7 @@ static int at91_can_probe(struct platform_device *p=
dev)
> =20
>  	can_rx_offload_add_timestamp(dev, &priv->offload);
> =20
> -	if (transceiver)
> -		priv->can.bitrate_max =3D transceiver->attrs.max_link_rate;
> +	priv->can.bitrate_max =3D phy_get_max_link_rate(transceiver);
> =20
>  	if (at91_is_sam9263(priv))
>  		dev->sysfs_groups[0] =3D &at91_sysfs_attr_group;
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503f..093e48b8da58 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2210,8 +2210,7 @@ static int flexcan_probe(struct platform_device *pd=
ev)
>  	priv->reg_xceiver =3D reg_xceiver;
>  	priv->transceiver =3D transceiver;
> =20
> -	if (transceiver)
> -		priv->can.bitrate_max =3D transceiver->attrs.max_link_rate;
> +	priv->can.bitrate_max =3D phy_get_max_link_rate(transceiver);
> =20
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>  		priv->irq_boff =3D platform_get_irq(pdev, 1);
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_c=
an/m_can_platform.c
> index 56da411878af..2a0f163a683a 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -131,8 +131,7 @@ static int m_can_plat_probe(struct platform_device *p=
dev)
>  		goto probe_fail;
>  	}
> =20
> -	if (transceiver)
> -		mcan_class->can.bitrate_max =3D transceiver->attrs.max_link_rate;
> +	mcan_class->can.bitrate_max =3D phy_get_max_link_rate(transceiver);
> =20
>  	priv->base =3D addr;
>  	priv->mram_base =3D mram_addr;
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index eaf8cac78038..9062db48d477 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1884,8 +1884,7 @@ static int rcar_canfd_channel_probe(struct rcar_can=
fd_global *gpriv, u32 ch,
>  	priv->transceiver =3D transceiver;
>  	priv->channel =3D ch;
>  	priv->gpriv =3D gpriv;
> -	if (transceiver)
> -		priv->can.bitrate_max =3D transceiver->attrs.max_link_rate;
> +	priv->can.bitrate_max =3D phy_get_max_link_rate(transceiver);
>  	priv->can.clock.freq =3D fcan_freq;
>  	dev_info(dev, "can_clk rate is %u\n", priv->can.clock.freq);
> =20
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 0d0be494cfd7..737a760d97d1 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -647,6 +647,15 @@ void phy_set_bus_width(struct phy *phy, int bus_widt=
h)
>  }
>  EXPORT_SYMBOL_GPL(phy_set_bus_width);
> =20
> +u32 phy_get_max_link_rate(struct phy *phy)
> +{
> +	if (!phy)
> +		return 0;
> +
> +	return phy->attrs.max_link_rate;
> +}
> +EXPORT_SYMBOL_GPL(phy_get_max_link_rate);
> +
>  /**
>   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
>   * @np: device_node for which to get the phy
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index a7e2432ca1ae..34b656084caf 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
>  int phy_notify_state(struct phy *phy, union phy_notify state);
>  int phy_get_bus_width(struct phy *phy);
>  void phy_set_bus_width(struct phy *phy, int bus_width);
> +u32 phy_get_max_link_rate(struct phy *phy);
>  #else
>  static inline struct phy *phy_get(struct device *dev, const char *string=
)
>  {
> @@ -256,6 +257,11 @@ static inline int phy_get_bus_width(struct phy *phy)
>  static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  {
>  }
> +
> +static inline u32 phy_get_max_link_rate(struct phy *phy)
> +{
> +	return 0;
> +}
>  #endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
> =20
>  #endif /* __PHY_CONSUMER_H */


--840703edd9f3f1e1e79a02bb78a8d4f69f696b0531524c2c45c8075436e0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaa6QehsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlO3
cwEAzFZFZ21Yi1E3bmSFVrYlzos6oRC2RIJXE4meDDVCTjUA/2INMu045NS1yRGm
V6PI/m62S0rUjMso1TupNVful6QE
=gdIq
-----END PGP SIGNATURE-----

--840703edd9f3f1e1e79a02bb78a8d4f69f696b0531524c2c45c8075436e0--

