Return-Path: <linux-can+bounces-7675-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNKdLk/IDWr93AUAu9opvQ
	(envelope-from <linux-can+bounces-7675-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 16:42:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14F58FDC5
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82635322D29F
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058D3EB808;
	Wed, 20 May 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qKOs1rSH"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F13EAC74;
	Wed, 20 May 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286901; cv=none; b=PQoftHDZ+8QuT91T0013rmQYPt42DAPYAtLL6H3da5wLVE+JZDZyuMh1gZVsbTK1+jYSmB54JEpfocteXGbRH0p4a6X+3wbBlc84WOIy+RukvepPRA+BMajjaGSGrSsteJyOlb5iP/66MljSNZ02/YGiIMjcEEOjWHOKJqzCDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286901; c=relaxed/simple;
	bh=GDgiypVIwA/PQvdX7RyrKY/+g5n+NMwhEKvQxfGp7xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bqz6Ept4mHi8WX3+KQs08o/aTDNKTqqDUWD+MrY4CROasMNN97xoDrGAasUfUh36pV92zAYH6moKnnRRsbKpxix8xMkwgpCYjeqfu+g+31OHu2s9nsQwrkS3EJ9O4TVecMEpo1Ac4Obod4LPLSTIu+y5htkF8p8esSBerubbEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qKOs1rSH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=GDgiypVIwA/PQvdX7RyrKY/+g5n+NMwhEKvQxfGp7xE=; b=qKOs1rSHUfFyQjQ2QU90qLmsEG
	E4rO+KqFDvZdMnNVkhT2xM9SqMD/CMUMADckAN8zJzIgHiiRGrfYvDLfVYwvte7zRaDJPjinr9dN7
	W41mCtDYikWfvkdAm1kyTt5Ns2JB93TsQ4vLGQVdLdw8UDj+b5s76SDCSf59Tvpostexn9puA2nth
	1WSXxPyw1cawkSEQwtUp6XpmyN9Z6+X49zn1Jkj0dxFSvWFTrY7Udx+xmwDa/G9o8rsguZyCHlSmu
	oG53XHOV5DRGeBYTKUVFMdMkD5aBSLI4rVQszy9k+eZF8tHtjXWW6HmPSv6IqLIL+WyoyuC5IVfQI
	V1VVfT8w==;
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
 Re: [PATCH v8 phy-next 15/31] drm/rockchip: dw_hdmi: avoid direct dereference
 of phy->dev.of_node
Date: Wed, 20 May 2026 16:21:24 +0200
Message-ID: <3758596.1xdlsreqCQ@phil>
In-Reply-To: <20260505100523.1922388-16-vladimir.oltean@nxp.com>
References:
 <20260505100523.1922388-1-vladimir.oltean@nxp.com>
 <20260505100523.1922388-16-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7675-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sntech.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 3A14F58FDC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vladimir,

Am Dienstag, 5. Mai 2026, 12:05:07 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Vladimir Oltean:
> The dw_hdmi-rockchip driver validates pixel clock rates against the
> HDMI PHY's internal clock provider on certain SoCs like RK3328.
> This is currently achieved by dereferencing hdmi->phy->dev.of_node
> to obtain the provider node, which violates the Generic PHY API's
> encapsulation (the goal is for struct phy to be an opaque pointer
> with a hidden definition, to be interacted with only using API
> functions or NULL pointer checks, for the case where optional variants
> of phy_get() did not find a PHY).
>=20
> Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
> on the "hdmi" PHY index within the controller's DT node. This provides
> a parallel path to the clock provider's OF node without relying on the
> internal structure of the struct phy handle.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Heiko Stueber <heiko@sntech.de>

there is now already more stuff depending on this change [0], and
the change itself also is sort of independent of the whole
phy-series. And somehow this series itself sadly hasn't gotten
much review yet.

So would you be ok with me just picking this one patch for the
drm-misc-tree?


Thanks
Heiko

[0] https://lore.kernel.org/dri-devel/20260518193748.2482823-1-jonas@kwiboo=
=2Ese/



