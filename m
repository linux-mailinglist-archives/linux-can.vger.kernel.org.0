Return-Path: <linux-can+bounces-7063-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB8XKKDhr2nkdAIAu9opvQ
	(envelope-from <linux-can+bounces-7063-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 10:17:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF4248247
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3810E310EF4F
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638143E4A3;
	Tue, 10 Mar 2026 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2P8w16KW"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2A43CEED;
	Tue, 10 Mar 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133703; cv=none; b=Gp0g6QAKNC+q4R71GJDY4Bwh+N0dw3YEcAGoF1JEDQqm+Ru7049zgtgRjTUUfxwfy7KOiZMOXF3ITMXwYd/QmaFY/UbofRC9O0jobsKttz6y7GhU4itPlUaT0ABEXmnZDENjtj26yv2JseLVm3Qv8n1w5yu49G0MvQJoT2CmAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133703; c=relaxed/simple;
	bh=kvP+A80lUtHD0JXSxM0RjhmHdTQdCORerkk2CLjcP+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAjTwIkRyvEbocybuLg3AQmxVbCkE7XvgDWfzoGFde/ROmAczQ5SUbllpyy2u4DyJoQW32W5W22I5yypCZAlF5jeLlvEsvxxX1MMdHvE2BZgMkFJQZoiSG1bWC5v09yNIqfNiOmcGAoXcgBC+CeJ0VTL10vmr2II3Gr5Kn2D5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2P8w16KW; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=x+sKkqEen+FTZVcatdq7BWmJBRObIwAqW8MBSeFsbCg=; b=2P8w16KW4mcJ4VoQcD9GwW+Aaw
	LPnWPTjV+iBSgpGU8VvlZBgivFQ41jbbUv9xPLTe0UGiC2O/TtxW9n87YjtaKXtEvok+d9X3m90n3
	88MyVWdnk4KdCug4lCgmQ65VmF5YA3tIEvuVR5jNAJV+kyyiI3aJ/12D7cJW361aI64t62QfKt+G8
	DpRgtf8aKTCqaf2K91HStN6cfzfIMJzfn16r4ZEdGteuKTcM5375CxPjFb+Zcjq9TyhP53oWNANrb
	QG5VUTphEsm3do+5av7k096Uzt/+LkiRWIWXHy5//oKgMhx3VYbZAmsubGNimoJORazjXzWfE9QP0
	iOm5zq+A==;
From: Heiko Stuebner <heiko@sntech.de>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject:
 Re: [PATCH v3 phy-next 10/24] drm/rockchip: dw_hdmi: avoid direct dereference
 of phy->dev.of_node
Date: Tue, 10 Mar 2026 10:08:07 +0100
Message-ID: <2772778.X9hSmTKtgW@phil>
In-Reply-To: <20260310083752.ms6u4qpy3snl4h6w@skbuf>
References:
 <20260309190842.927634-1-vladimir.oltean@nxp.com> <2218670.OBFZWjSADL@phil>
 <20260310083752.ms6u4qpy3snl4h6w@skbuf>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 1ACF4248247
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7063-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sntech.de:dkim,sntech.de:email,rock-chips.com:email,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ffwll.ch:email,suse.de:email]
X-Rspamd-Action: no action

Am Dienstag, 10. M=C3=A4rz 2026, 09:37:52 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Vladimir Oltean:
> On Tue, Mar 10, 2026 at 09:24:43AM +0100, Heiko Stuebner wrote:
> > Am Montag, 9. M=C3=A4rz 2026, 20:08:28 Mitteleurop=C3=A4ische Normalzei=
t schrieb Vladimir Oltean:
> > > The dw_hdmi-rockchip driver validates pixel clock rates against the
> > > HDMI PHY's internal clock provider on certain SoCs like RK3328.
> > > This is currently achieved by dereferencing hdmi->phy->dev.of_node
> > > to obtain the provider node, which violates the Generic PHY API's
> > > encapsulation (the goal is for struct phy to be an opaque pointer).
> > >=20
> > > Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
> > > on the "hdmi" PHY index within the controller's DT node. This provides
> > > a parallel path to the clock provider's OF node without relying on the
> > > internal structure of the struct phy handle.
> > >=20
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > ---
> > > Cc: Sandy Huang <hjc@rock-chips.com>
> > > Cc: "Heiko St=C3=BCbner" <heiko@sntech.de>
> > > Cc: Andy Yan <andy.yan@rock-chips.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > >=20
> > > v1->v3: none
> > > ---
> >=20
> > [...]
> >=20
> > > @@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device =
*dev, struct device *master,
> > >  		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
> > >  	}
> > > =20
> > > -	if (hdmi->phy) {
> >=20
> > nit: a comment would be nice here. I.e. hdmi->phy being an opaque point=
er
> > so checking hdmi->phy !=3D NULL is not possible.
> >=20
> > With that being a "goal", I assume that information is not widely spread
> > so this would prevent the next developer trying to change it back to
> > "if (hdmi->phy)" while that handling change trickles down.
>=20
> Testing the NULL quality of "struct phy *phy" is still possible and legal.
> It means that you called an "optional" variant of phy_get(), and there
> was no PHY.

ok, I'll keep that in mind :-)


Heiko



