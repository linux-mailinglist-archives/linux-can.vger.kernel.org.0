Return-Path: <linux-can+bounces-7060-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBMPBbbVr2kfcgIAu9opvQ
	(envelope-from <linux-can+bounces-7060-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 09:26:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC3A2474EB
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 09:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67BC3064D9D
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 08:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941E3EFD3C;
	Tue, 10 Mar 2026 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JuC/yhxD"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D13B8D6B;
	Tue, 10 Mar 2026 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131100; cv=none; b=XpJvxGBoIUnUylry7mynfLhUo5YFehiWv2z6dmzq1hEab2YxbbY4b8C97RRQr8daNQtm3gvljH8x69Gm94BscTVGgES/4EGMuouu1LE5gfkhq+1XQ3mzgCuo7lyJ9xgtglbJg1DcMvJrsJEPfbs44FSr72EdsUJ1nsMnDqX7DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131100; c=relaxed/simple;
	bh=XRYHG+1OFO9B3BzHm+YXgweT4NhjII3UvBtiXddp6VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGb3OegcJxbwICanihnWiL/HDrBg0uTIOyjecOXd47iLlptCnlGxoFDFlGtOo+q54VtLXW05Txa8L+24sJLJYKbSQpB9tsQl73xJGznplLe3Sk1yWkykN79gFh5xvG39hBqUDEJfW7H0Ajktw2/Trk4utb0AfYHdn23SfLuedRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JuC/yhxD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=2W8R6JKoSWBQ/NVWe1VH8DTpdfOcfJODkzczD104anE=; b=JuC/yhxDoPy5BzKCllx+4lcx/F
	aT/7U8Uk8l3EzePnMXUbbxXawsxzRHryg8fghP2VOHv5kHVBckllNBimOOiJ0d8LfnHjtGmniMUoP
	q+tI4zY5GQIiNsEUe+qxnask3JoIfvvZdpBRFnoZGdldxQgpw2opTa6+/x5nJBA//K40leHf2j3eZ
	QL1kjydLamseRW0i8hF8yC9BA+ISD2o9MPNpUsGC0DfntkB9k4h7pa/Fd+8ADCPiSf0DDEzQCBI5M
	9HJQrDTSAcTC9UmZ18rrV1bkPrtisS78iMGtNExAIokgAvG70PlOoOoPpo/Lna+ZPaU1pgFFTLn9P
	iDkZROYQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-phy@lists.infradead.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject:
 Re: [PATCH v3 phy-next 10/24] drm/rockchip: dw_hdmi: avoid direct dereference
 of phy->dev.of_node
Date: Tue, 10 Mar 2026 09:24:43 +0100
Message-ID: <2218670.OBFZWjSADL@phil>
In-Reply-To: <20260309190842.927634-11-vladimir.oltean@nxp.com>
References:
 <20260309190842.927634-1-vladimir.oltean@nxp.com>
 <20260309190842.927634-11-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: ADC3A2474EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7060-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,ffwll.ch:email,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rock-chips.com:email,sntech.de:dkim,sntech.de:email]
X-Rspamd-Action: no action

Am Montag, 9. M=C3=A4rz 2026, 20:08:28 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Vladimir Oltean:
> The dw_hdmi-rockchip driver validates pixel clock rates against the
> HDMI PHY's internal clock provider on certain SoCs like RK3328.
> This is currently achieved by dereferencing hdmi->phy->dev.of_node
> to obtain the provider node, which violates the Generic PHY API's
> encapsulation (the goal is for struct phy to be an opaque pointer).
>=20
> Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
> on the "hdmi" PHY index within the controller's DT node. This provides
> a parallel path to the clock provider's OF node without relying on the
> internal structure of the struct phy handle.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St=C3=BCbner" <heiko@sntech.de>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
>=20
> v1->v3: none
> ---

[...]

> @@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev=
, struct device *master,
>  		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
>  	}
> =20
> -	if (hdmi->phy) {

nit: a comment would be nice here. I.e. hdmi->phy being an opaque pointer
so checking hdmi->phy !=3D NULL is not possible.

With that being a "goal", I assume that information is not widely spread
so this would prevent the next developer trying to change it back to
"if (hdmi->phy)" while that handling change trickles down.


apart from that:

Reviewed-by: Heiko Stueber <heiko@sntech.de>




