Return-Path: <linux-can+bounces-7293-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKHEDHDUxml7PAUAu9opvQ
	(envelope-from <linux-can+bounces-7293-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:03:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC559349B01
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B194D30D6FB6
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ABA426D0E;
	Fri, 27 Mar 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cl0Vz1uM"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8F42668F;
	Fri, 27 Mar 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637384; cv=fail; b=UsIGBmflb6/HWiT7tLuS2rMX0SnrontqGm9NMHOZl9wgUz6zKX2RrES+wnnHuLoIKkvUK+EQrVdOPU0CLEwSfuUpHg3GtgSlSiX6uV/DDV7NexCPzKt2YSHwi8dn5RDwpirKHdtWTxY8JsFs6xdTojzoaMDJ3ciSDfrArfHh5Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637384; c=relaxed/simple;
	bh=z8ZVWmyRXVX3qbRm1ktF3JjqF1DelKavVujbTaSq1mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOgZH0L3/QIZxGGC7A+DGKEgkLQFLwhd5BEG9v4GoKRqup2TwEmXX6H++HjTyDeeCnMc15XyNbOK+sie3Xf/Ul7QFtzLzzCao9uKC3cwZzN9Uh/MpIlor3jwdGfufo/fjsBMH1PSGTmVhA+z71NmYkQRPPBlbGxk84BFOgwME5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cl0Vz1uM; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ldfyqdx2WbcvX71DKQC6DW6XY9onfKO9+CxvKhi/2hu096lteXRABaz5ATL+2KmRyWiFZXoATt7530FyLt7FppYl0PH15t8JTkepY6b5u+75hp3knpz0TuptRuXjsy5WJORUyeQNlIKdsKlIIBwW93KT8MgLtUHlj5AE77G0sSYP5YlvWrXsP0B8j4GDVIynskPySAnv9F+x7/429i7GkTVdzV4QDxJL06PMpG3yHEpn+mNneHRLTrX4Z28dIFTJLvQcQmpwUWpYHISBa/LGlSjJ0veLjjsdbVjeF9d618bW9O5XkdAtdq8ZltmZWFZ2GyCJD54r+JFYNbi45jta/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kx2PNVmBmuTf5xQdzjTme21ZIKSQ+6QgjCYigrgnZ8=;
 b=Pqp2cfHODmd8t/xVJESWA9jcxl4FSGFF2yFYczyABMhRQ6SD+GPIZD8DYxkGhqCOOyav9LUtlOlygOaCmaBm8Te2Zw7wj73TC05X/C/YBiLt3tJRaGV2NWafE9TNr27yjiBFFdPhSW7rRr2zFnvadKYWz0k9hjDQ3kqkeh08AozoIXZkYopBA8HvLV7uAMDK9godpvIOgzkkZCnuJeV1tBUCZXhh6QGDRKxBWHj9bFYdLbkuU2KQlrpGgP3yeScocuOii37TV02OayAHs1TQBW0Zwo0QTVpZFR/L3NQBgo34t1z1E6BRkLjF68xAnmL9gQ0l2knpR/BmTJEifG8V0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kx2PNVmBmuTf5xQdzjTme21ZIKSQ+6QgjCYigrgnZ8=;
 b=Cl0Vz1uM/r/0GAPm9k3mASKf4Gjbdpr4+oJ9uRkNt7Gj2VY46moYwD0BPXl1rPDU66tMIGVy4WUUWYw/BBxyjGw+X/eG76TeeUS0DVvJIusNbXHoQW6RpP25QeBfKaAIlfr/doORzXVvluxth1m5wzdmZGGtUlASNE50TsR3bykVQ7vOXm77/fHq5RBWqOh0nBRh/7a+3y0mSt20Si6z2IlOmb93y20tzCjoD/fudETLzyFeaeRTHE1+i9Vzn+hfxsUUgKXRRvYR7kwM6mrrgJe2iXU8oG+1YvgegD1BWufmgx8+T5jcLuYwjE96GBNVNmeBFPyStLTsO1qGWtQz0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:33 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Damien Le Moal <dlemoal@kernel.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	JC Kuo <jckuo@nvidia.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Joe Perches <joe@perches.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
	Maxime Ripard <mripard@kernel.org>,
	Michael Dege <michael.dege@renesas.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Cassel <cassel@kernel.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peter Chen <peter.chen@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Samuel Holland <samuel@sholland.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Paul <sean@poorly.run>,
	Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v6 phy-next 27/28] phy: remove temporary provider compatibility from consumer header
Date: Fri, 27 Mar 2026 20:47:05 +0200
Message-ID: <20260327184706.1600329-28-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:803:104::35) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8a5006-3bff-496e-c7ff-08de8c3195ea
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 KuOvgrmi+ToHJsCKybuTeyONEVJoTM+99Xb15cW8QNrQfD1WU7RoyYPsvR5TRXfHXcvGl/W44Y090VRBKG2gtas+XXdqMtEOHIS4bl3HBcxS+FzYQmP9dXShnic0axn3BvRgrZQLPrTkF4N2uVDCfAmPs9AZglqbJ7P1fYMjZGWVtYpyil01iDrZUaSNILHV3ZmnpgnSGEqA4dO9kJHNZ75miSquB9P1JZoM5cql0KzQU8fRQbl6/l8OMt3FyvyB3YXsQNNpjb7kU9nTvGvfef63yNaXLNKJZB7AUAfGqRmk0F9lHz4zu5BN514bO6nbeYbvi7IpZJCkXIpnvIDxMcxy1LyjPAhzx5/7p3JGIkjhaAmF68s/gn4VkA3qEJzW6gmV+ARO6fHzHjZTQ5pPzzua1Fx72y69E0TN+jD5Q9p3wTFqyjZdbXZ2jSY8mVN85Ca+9QY/kOphFOgWtA+h1RSi8vz8zES96hikbbob8h3CbuSyvjijkNqWL1FyLHx056ocFhBGFu8PZc/1aTiNfFon5an8mpCc/z7Dh9WpSf2NHln8dvMwt+IOgW5ehYNnhcVSajSYkoB3eEKfdZTx1pnQQN3EmE9f7nZ1UnXP5+iul5VnmHob+v+yAJAxp6rLWk0pmzIlDCTk+Jxq0CQIfwMarF5u1RYLpHcbOEYyw667djP9zKoC6J4SAhNyg3mWiCCipixQ4L0NOsx/rdU6YxrkMY4qIWMn9y9SSt3r4so=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M0VTZlVBZTRwcDhVeldCdG9xd1JkUkZSQ1BvcitBOVBhVFdBYTlZdWhucVp0?=
 =?utf-8?B?elJVNkVDTVVBMVNJYkUvTDQ5WW1VZGhWWjRQcWpLYWt6VTNWV01EU2xYV28r?=
 =?utf-8?B?VVVJRFVrellNbmRRam9QQlV3NGxaelNIZ245cXpCT3FGaFVBcktVcXZ2eHdZ?=
 =?utf-8?B?L2VwbnR4UU1yaU9odWhCWEM2SWtEWDNCcUo2Wlh5VWR2SWxCdVZiSXo5akNK?=
 =?utf-8?B?RkJhTlJvWVlsTXFJNXVrdEtFOGk5cEQvNXRrMzFuamhvcHBGRTVOTW91Nldo?=
 =?utf-8?B?NlVJY20rV01GZU9nSDZXSnNLNWZLeVhMZ3RkR3ZrWE1CaElOREwwaDE5R2Nq?=
 =?utf-8?B?K3R1eVRYS3MxY0VIRkN0Sk1DMVUrZ2p3ZFY0NjAvbzFORjNQYlh0eVVvanR5?=
 =?utf-8?B?TGZYSEVaZ0srUkYweW5CR2xzeUdFWE5sTkNTaUJLcENxVW9ZWkc4Uk1BU3l1?=
 =?utf-8?B?Y3crMEQyTURwdExBQ3JoZUNyZ3BxVjdoMnFtRW5GZFFINVUvcEFVWG1Danh6?=
 =?utf-8?B?MVd0eDZMSmliSDhFVkRCQkVIVFdPaVdWR3lBRDJvZm0xYS85enpOSnZQbXRO?=
 =?utf-8?B?NHUvRVZxWXJhbG4yMDV4OC9ucU0rL3JtK1F0STcxZEpWMGtzenpoeUZKYmhG?=
 =?utf-8?B?cTF3VWVZQUFBb0dmdHZzSDM2bjZpRTJicUdKRTRQVU43bUl3c2ovazBpZmdw?=
 =?utf-8?B?N1AyMGdLc1ZvQU9BU0h2dVNZTU5LcXNzQWpUcDJOT2VydysvS25FMHBkOHRu?=
 =?utf-8?B?OG1MWUZra1dnTVdBTkkxeUxCcXkyUGYwZnU3QVZhdUxzUHhPbXowWDZCWGRr?=
 =?utf-8?B?NzA2L1o1eVZBdXNlc0VsbEw3cTcwb3VRN2JJVUQyVDJrb3luZnJicnJkdjVY?=
 =?utf-8?B?N1ZRRDhkbWxLdmJsSEQ2RXBWQ2NhVVZVMkxiOXB1enNQWGNKUThLQ1ZQWGtN?=
 =?utf-8?B?Wk5SeGZ1czQ1NUtZTlVpTCtHT2NmcGJRdC9VNERmbVBwQmNYRFB1UmMyL09y?=
 =?utf-8?B?czIxQ0FrWjdiZlNObGdBRkJsMmV1dmJaU3cwcEJsU1hPSzV1cUs5ME9sTDJw?=
 =?utf-8?B?M2VUNFRYTTdRc2FIM21VQngzT2VYZ3dEazVzWTBEbVpLbmxiL001OVJCN2ZO?=
 =?utf-8?B?Ky8vc0pZV1lLY2NXOW5rYXlGVzdSbHNGRmlxSEdTWTdMRWkydWRmS0RFR0lS?=
 =?utf-8?B?MHBXN0hzdjlYUGprYTV6akJvRUVqb3VmaHdxeXJkY0JVcU1zd29lRG9DTWdM?=
 =?utf-8?B?aUdVVGhVclpwR2c2bktsVDlUNmc4elZ2bUcveURVdVJ5MEl6UWtYcWJrZlZv?=
 =?utf-8?B?RnRzZTlrRDVhdFlzc0hzSTQ0ZTk3U3dsNno5UThFS210Zkttd0VyVjNWb1pm?=
 =?utf-8?B?Y2tHaXpkSEdVZEJsSFFUYUUxN3Y1WWpsdlpvMjdnMkhVVnFEdFhTaEZoT0hx?=
 =?utf-8?B?M1NiSHJCeCsrRHJBUWYwZ2QxTDQrNnNuN24xM1lGdDVsWVEwOGpPZmJ2VVpD?=
 =?utf-8?B?WGVHMHNxSnI2aEpjVThCMnFIbWNBVms3SGNvNWwyNGxpOWlHQ2U1OTQzNGli?=
 =?utf-8?B?ckhBSFppcEhabW53S254ZVVkZ2l3ZFVHTlJiNDV1R2dUUDdSN2RNdndoUlpw?=
 =?utf-8?B?Mk1FQ2xwVXphTDB0WGV2WGJSTDFlcENiVEkva1RvRVhWeHZtU29NTU5ldzFD?=
 =?utf-8?B?THlOZEIrazBpc3V6N0xvQjNvZVcwMWNvdTI5UnNBQ211WUtxZ2tMdnZzSGFy?=
 =?utf-8?B?QmRpeklkeExjaFptRzc4NUtFa0w3a3Ava1g5dVoyOUs3Y1NqRkozSVVJK2g3?=
 =?utf-8?B?VWRmWXloR3ZYTFY4NVRhekdUYUVWMlAvSnZzL3J3M3ZmK1VFY1ZqMzdBRytw?=
 =?utf-8?B?Zm84ZExhcFd5Vmxlenl5dkZnWFhpMnlSL3plZjduVGVlWVRGR1NES25RWjJx?=
 =?utf-8?B?MXpQMUFkVlRMVlVnaVBLMTh1U3gwUXBNM1JKcnBXM0Frc1h1bXVTMzdLbFVC?=
 =?utf-8?B?THZkZlpNUmF0eUFmbGU0Q0xoM0ZJMk1va1pPMSs4NUFaY3JlMG9TY2p5MUpX?=
 =?utf-8?B?WE16WnVYUURUOU9USlQ3aitTZEFxc2RBQ0gxbE95eFdHTTBQZDBkZFp4c3VK?=
 =?utf-8?B?QjhkRklFSGxCU0NtcGZXZ0ZiVFFpSWNuY2hLclA3UTNCdjU3SWQ1SXpnV3lM?=
 =?utf-8?B?ZVRHa0oySDZETmZ0c0hxSmVZSFR0eEZJdzZoUVIyRWVvNVQ3dUlGRCs3RXlw?=
 =?utf-8?B?Rk1ybmdlUUpqWjhhNjlDMnJLWWNnd2dJbjVERFlNUGtLT0FuUnl0WE9GUCt4?=
 =?utf-8?B?aGF6bVAxSUNMWjREQXd4UnM2bndkN0V1V1hMdDB3KzczTnpaVm83WEJjc1hQ?=
 =?utf-8?Q?9b8YEBpQCdZsDZIme4g4hJ5jEgJbt8VB1pi7zFeS6+cAC?=
X-MS-Exchange-AntiSpam-MessageData-1: w02HcxvM2p694GRQ0PqzfUjaC5v82EhS+UU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8a5006-3bff-496e-c7ff-08de8c3195ea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:33.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEcFdBvCDT4eSDj5mgStcJK4C4IWaBURMO587kBftUEPeYIFWSEB/KI5nsUlNAIybgXs/BzTs+dn2IO5JscVNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,bootlin.com,lunn.ch,intel.com,rock-chips.com,google.com,samsung.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,HansenPartnership.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,oracle.com,renesas.com,quicinc.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7293-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[102];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC559349B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all consumers have been updated to no longer dereference fields
inside struct phy, we can hide its definition altogether from public view.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: David Airlie <airlied@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: JC Kuo <jckuo@nvidia.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Dege <michael.dege@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Paul <sean@poorly.run>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

v5->v6:
- expand CC list to inform maintainers of touched drivers that the API
  is becoming unavailable
v2->v5: none
v1->v2: collect tag
---
 include/linux/phy/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 34b656084caf..0fdcefaa3f55 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -12,8 +12,6 @@
 
 #include <linux/phy/phy-props.h>
 
-#include "../../../drivers/phy/phy-provider.h"
-
 struct device;
 struct device_node;
 struct phy;
-- 
2.43.0


