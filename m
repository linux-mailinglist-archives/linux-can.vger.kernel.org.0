Return-Path: <linux-can+bounces-7756-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ABGfHsmfIGq05wAAu9opvQ
	(envelope-from <linux-can+bounces-7756-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 23:42:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE71563B6E0
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 23:42:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7756-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7756-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=collabora.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C349307DFA3
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6414A2E24;
	Wed,  3 Jun 2026 21:39:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD14A2E07;
	Wed,  3 Jun 2026 21:39:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522774; cv=none; b=C5Ibx7KZSdSjPrRdNDwHEYUpk7E3YDWijoRddn4CwtGE1G6ZdW+9bs/sOO/nCg0Qe199ip/GL4pNZfS7uLutvDoRzPgztUHMLTPGbMBuHtC4c5eKCROdwgacJMIkJD9zDBeyLyq1MFjvcIHmRBzhQaceBxixEtsIsLDTC65LPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522774; c=relaxed/simple;
	bh=4ixFSV/12Id5tf/md9aSMpcT24U/Cz8Zv3drM0rLg14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SFQB5u1wrQ6bk0OIbhMPSA427JzkCvRvmRzFA6kMc5oOBL7fPw63LEIsHjjTeDWb23rEfGliLS0hcJzKF110BIlEaQxb0tgFCQgH396gRGw8w7gvZCKKTFuTuqnwDKCssF03ccmH5bk5ANFlnwoCn6YQ/2EVmNa89GYwHM6Dc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3131F0089B;
	Wed,  3 Jun 2026 21:39:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7F4B0181D83; Wed, 03 Jun 2026 23:39:29 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-phy@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
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
 UNGLinuxDriver@microchip.com, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Can Guo <quic_cang@quicinc.com>, Chanho Park <chanho61.park@samsung.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Daniel Machon <daniel.machon@microchip.com>, 
 David Airlie <airlied@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Dmitry Baryshkov <lumag@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 JC Kuo <jckuo@nvidia.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Joe Perches <joe@perches.com>, 
 Johan Hovold <johan+linaro@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kevin Xie <kevin.xie@starfivetech.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Michael Dege <michael.dege@renesas.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Niklas Cassel <cassel@kernel.org>, Nitin Rawat <quic_nitirawa@quicinc.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Peter Chen <peter.chen@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Samuel Holland <samuel@sholland.org>, Sandy Huang <hjc@rock-chips.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Sean Paul <sean@poorly.run>, 
 Sebastian Reichel <sre@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simona Vetter <simona@ffwll.ch>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Vincent Mailhol <mailhol@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
 Yixun Lan <dlan@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Subject: Re: (subset) [PATCH v8 phy-next 00/31] Split Generic PHY consumer
 and provider API
Message-Id: <178052276949.2678508.3221123153750103034.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 23:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linux.dev,bootlin.com,samsung.com,lunn.ch,intel.com,rock-chips.com,acm.org,google.com,quicinc.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,HansenPartnership.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,oss.qualcomm.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,oracle.com,renesas.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	FORGED_RECIPIENTS(0.00)[m:linux-phy@lists.infradead.org,m:vladimir.oltean@nxp.com,m:vkoul@kernel.org,m:neil.armstrong@linaro.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-arm-kernel@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-ide@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-samsung-soc@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:linux-tegra@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:spacemit@lists.linux.dev,m:UNGLinuxDriver@microchip.com,m:abhinav.kumar@linux.dev,m:alexandre.belloni@bootlin.com,m:alim.akhtar@samsung.com,m:andre.draszik@linaro.org,m:andrew+netdev@lunn.ch,m:andrzej.hajda@intel.com,m:andy.yan@rock-chips.com,m:bvanassche@acm.org,m:bh
 elgaas@google.com,m:quic_cang@quicinc.com,m:chanho61.park@samsung.com,m:wens@kernel.org,m:claudiu.beznea@tuxon.dev,m:dlemoal@kernel.org,m:daniel.machon@microchip.com,m:airlied@gmail.com,m:davem@davemloft.net,m:lumag@kernel.org,m:edumazet@google.com,m:festevam@gmail.com,m:Frank.Li@nxp.com,m:geert+renesas@glider.be,m:gregkh@linuxfoundation.org,m:heiko@sntech.de,m:inki.dae@samsung.com,m:jagan@amarulasolutions.com,m:kuba@kernel.org,m:James.Bottomley@HansenPartnership.com,m:jckuo@nvidia.com,m:jernej.skrabec@gmail.com,m:jesszhan0024@gmail.com,m:joe@perches.com,m:johan+linaro@kernel.org,m:jonas@kwiboo.se,m:jonathanh@nvidia.com,m:kevin.xie@starfivetech.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:kwilczynski@kernel.org,m:Laurent.pinchart@ideasonboard.com,m:linusw@kernel.org,m:lpieralisi@kernel.org,m:maarten.lankhorst@linux.intel.com,m:magnus.damm@gmail.com,m:mani@kernel.org,m:mkl@pengutronix.de,m:m.szyprowski@samsung.com,m:marijn.suijten@somainline.org,m:msp@baylibre.com,m:martin.petersen@o
 racle.com,m:mathias.nyman@intel.com,m:mchehab@kernel.org,m:mripard@kernel.org,m:michael.dege@renesas.com,m:nicolas.ferre@microchip.com,m:cassel@kernel.org,m:quic_nitirawa@quicinc.com,m:pabeni@redhat.com,m:kernel@pengutronix.de,m:peter.chen@kernel.org,m:peter.griffin@linaro.org,m:robin.clark@oss.qualcomm.com,m:rfoss@kernel.org,m:robh@kernel.org,m:rmk+kernel@armlinux.org.uk,m:samuel@sholland.org,m:hjc@rock-chips.com,m:s.hauer@pengutronix.de,m:sean@poorly.run,m:sre@kernel.org,m:shawn.guo@linaro.org,m:shawn.lin@rock-chips.com,m:simona@ffwll.ch,m:Steen.Hegelund@microchip.com,m:thierry.reding@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7756-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[sebastian.reichel@collabora.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[106];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:from_mime,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE71563B6E0


On Tue, 05 May 2026 13:04:52 +0300, Vladimir Oltean wrote:
> The biggest problem requiring this split is the fact that consumer
> drivers poke around in struct phy, accessing fields which shouldn't be
> visible to them. Follow the example of mux, gpio, iio, spi offload,
> pwrsec, pinctrl and regulator, which each expose separate headers for
> consumers and providers.
> 
> Some off-list discussions were had with Vinod Koul regarding the 3 PHY
> providers outside the drivers/phy/ subsystem. It was agreed that it is
> desirable to relocate them to drivers/phy/, rather than to publish
> phy-provider.h to include/linux/phy/ for liberal use. Only phy.h and
> (new) phy-props.h - consumer-facing headers - stay there.
> 
> [...]

Applied, thanks!

[26/31] power: supply: cpcap-charger: include missing <linux/property.h>
        commit: a9e36028b688d693d8aefbf84a9899f31a20fcf0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


