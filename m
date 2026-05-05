Return-Path: <linux-can+bounces-7520-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG8VAe7H+WlhEAMAu9opvQ
	(envelope-from <linux-can+bounces-7520-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:35:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047E4CB7BA
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFFB830B83CC
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212C48034F;
	Tue,  5 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntLTqdHq"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8347ECDD;
	Tue,  5 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975627; cv=fail; b=JK1ym3lFo6XGkNNWdpd0NZZWJxSZYYO4r0rdbjtX13cesypVlqDWL8lt2CDmX/23HIYh6z08tSqrc5TI9d6E9NnN3QnlSzN29WLqpN0iGQoooN6MHccDabh7JKP8JILYibXIwJtjwvTPN2luyEIxf3MaaLexbNo7BNjI722v0wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975627; c=relaxed/simple;
	bh=8qxdHZt/su7Vu961+ti4FaeYSp5g7FWAuRoYkyyiRIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pnzpaq+V0tf/wqkvLK8MEM5wU40+XdLKoX/b+yvn44xFU1WOne7fGbA5o0hGJk3WRH4602VcisxYq+7xDQb0vOq1cFHeYO/zbu3KNzfnhDBF356hNB7pyM50/OddBZKAmGdgosGhy0ejm06TQptk2s3Hbwi/egDLohRpK+4uiAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ntLTqdHq; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjc/XcX5Xi3gftO/QR3TNFclAPxzJ1Ye0NZrzYIugLLXwiwqCaLtwkOGP92Y68BjNVQ8ROAksrZi3LaOKhbS/PRvNAE9N3BAqE+VoaaTD8Lo6t74z2JDX2RGpItxUIhEiXh4MFtlG97PAowYdNyIDo5Z7LxJiwBNk5Zy9ohPqyCSoXwn4t5catRnHEd/KNCByyOdRQ6CTBJ/vTMYkv7+voo4+gYTVOatJhr8Xf3r+PJsd6Nq/MgCI/on2oVmUeTztKi6hRggqXV4Wb4dT3ebHBCnyQT9eDhyg7tXLUQfd8oJ81ntyC3b6IAUHN2OHijwmspbnexAuM+T2/vUSAuvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woTctB9zfV3kVuKS+4vKRMy5hWrTaNujHFCObkBZAnM=;
 b=O1aIx+YSD85hkbftxeJ8mNSDlxgLInhj87sY0idnGHuKnY4ydCn0m5jqEmb4exzOxZOOZ7NOT5zMhDgyJxzVPKA72zNEavO0ao9jMuJQZKQDHXhLlPkpLV66GQSoUm7exd0h8Rf2hjIdogjQemeIH5C2lrIUBG9mUxAQPGhQxtUfpkpWKVoDhxnJJguQ2ZO/X64jTj2nPjD9o+mrdCixPexLuvJN73+FgqvkfLcL85xdGWvKQntf7L3hs+NmOBCmz4x8e1sD9VFMR7+tkQjLK2EB8wN0BIW1miF24YPx+udGocT60md4QI2u2ACl4sD0/Lp5I8XvC19BVMHN6iNvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woTctB9zfV3kVuKS+4vKRMy5hWrTaNujHFCObkBZAnM=;
 b=ntLTqdHqqiU0CI5mTawIMdaqVuNWcW0iJtivJtqlnsbo5ksDUSG+g6aj6v6YLTv0zFRNCYLbKCP5aG5Ck3ZbP4ZZWpxq2MGU3iYMsFdNG7ib5Qf0A4BhO7f4o1rT0/WhVsRW/aJOQilYh6V93WUzM6ReZVqMchKZldFv0lXqsvpGi98fy3kiPA/Bk/PBUTfetEH/K9da5N45bkDTMNxkTiILMgklD5yFA7OLHOubqkWd2KnoUnkp1C8syPRYCK1TrKay2PVe/sIhcnSjdfTgZymboqmpCiolPtkdCZleop4fbL8wYx2Chhbeo6eVyxx62d7FzTn60AIOmZHZlO6cvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:06:50 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:49 +0000
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
Subject: [PATCH v8 phy-next 30/31] phy: remove temporary provider compatibility from consumer header
Date: Tue,  5 May 2026 13:05:22 +0300
Message-Id: <20260505100523.1922388-31-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::30) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 7692dd3b-4163-40a7-a6d9-08deaa8e05ff
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 bryDzflHbYPLhMaJA93nNc5L4wFM2zA3K/fdiCPgknQStefqfUIHxLndT/mTpokM/Sx634bk6robM4A5HRrxuXIb99KozQXDm1CvVpjMt+n6aK7QWJ7Aao78M4ekKst6JBt0gIEqhOPfLWw6z9YsQfdNEUvwxWTx9wb6yZvr2lW8uSocJU1zj3wW5v8QhwXNFI0D1v5oG4T5VdwRFt6PgnuFHZ6uQz2n1FyOwLsKJIYJYIk/Lebtz5A8Axg43Cb36HRFSrd7ewZ19mV8DXSE3JxNsOf3+u/5fhg8fbruG6E/LOOSUU7biBE6pNaA/E71TaWnE/Q4KjRHVVqFWU+p6gGpLXbQ+U0tJHgSkUBTZO+adpe7z0Bqaja4HjgYI9SaPvgtVCeKnHUzl0Iec/SIcR4I1axb1ojDecQPy7qP+a8njeaXVTicJjoA5iIYEKjK9ePA/LZaMCRCaMpkOm4wxTff6d63I45aX7KRovsmjMHJXb27uwq/hmGxGXTt0l1uo9kU4JkhJybWr7CkWa6s/r74NmMWL1/Dn0uFXgI4QViAU9e0LSIxLkbmmqY4UAsrt6J7fJbLFjCFtOTwCYLyIBUrujSpBrMkR7qbdQshtVhRIhHIli/JgNxdSAfxQutykoCRVV2IFyyMGlj/mduWAHyUD6LLIoT8L5c+IqqGuydV0QEh/bfNOhUtZhgSKHrY
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OEJxdW5IVXE0YlRYcHhERVVRQ1pHK2JIVkNnN2VMcEVkRlR0VkhBRzR1VEtt?=
 =?utf-8?B?bEpNS1haWnBBZXNGc04yVlpLcnhGLzdIOU5RTS80NXhwQTh5c0dxTnd2TURy?=
 =?utf-8?B?eDFualNLQURrV25neitnNmp4UWhmS0doK1hXU2ZHN211ZDh5NHRLaHNOdERF?=
 =?utf-8?B?Q0dBTXFyTzJxUnRMd2dod2NKMHNudkxsODhPNW9jOUlEZk9xb3RQMUVaL2ly?=
 =?utf-8?B?ZTBwbEIxdHVwbmRWTFZMN1pqK0pzT044NDBVaEFHZlE1T2E1K3VnK2txSGNB?=
 =?utf-8?B?cDhza0phdytocHcvR09CUXVtZkJlOFNteVhlSjVkY21oU0dBcTRXcTB1Qmhi?=
 =?utf-8?B?WGJsYVliQkRQUjVrSXZjUE9kTUxvZkNjU1N3aFV6SjRHSVVSOTlQYThVMUs5?=
 =?utf-8?B?VDY0a3FLYlVLakpuNld4bmp6SEhNU0dEWkJ5S2NtRHVOSjV5NStWckY4QjY0?=
 =?utf-8?B?dlM3ZlZ0VE5BdE9TS2xDNVU3WUZZWGM2aFdQTjZoVEVDQlkvQjhWSXhBNEFn?=
 =?utf-8?B?RnhBbXI5eXVEd3h1eXY0eU15VURHSWpoOW9wblltWkJrNkNDNnA4ckpMUmNM?=
 =?utf-8?B?Nkp0NGJLMSs4a0FldTlCL1gxYzYyZUs0WmpDK0NnZGdSallmT3M5L3MweCt2?=
 =?utf-8?B?K3RVUXdCaElkY0JJL2U4OUxwclRYemovdEpNK1FpRDBrRDVnQnF6UkJnN1dC?=
 =?utf-8?B?Q2xPSnhlU21aN29PZHRndmNwVEpGSDVZRXZlNldGY0g2SEFCa2VhQ0h2VDdk?=
 =?utf-8?B?NjdGMHcwSUMwUFI2aHljcTd1MmNTMDRyVWZxc3d5MU5BY2c2VWdLTW1sSWxP?=
 =?utf-8?B?U1laME1zQmpIWjlJd1YvMGVOckRwUDM5UlhLNzdFcGRTSUZRUWVlRkhOaGdJ?=
 =?utf-8?B?UEpkK09ORDBvYUt0TWkyTmlMY0JLanpLWWNNUFAxd2lYWksvcWU0dHl0dEYy?=
 =?utf-8?B?ZEY4b3UreUN6Wnphd2MxNnVybXhxSktwZmVqQWw4eXAzN0NDVXpzSHkyV09I?=
 =?utf-8?B?TjdMa3VQcTV3cndxQ1ZrTkxoU2h4RXZKZktOaE1mSEVGVXZXbVlGMDQvbVdL?=
 =?utf-8?B?b1VDNnMxVWF5SW1zVDV6K1ptanpjWi9zWG5HUzhVajBSU2dmRnRCYTZJSnJK?=
 =?utf-8?B?L1BQcTUxVHRpWVowakpPaE1MMlIyTzJPeUd6TW5XTnhXZG4xb2ZuTERTZUlt?=
 =?utf-8?B?R2R3M3VTWi9IRkxPcTI3RThzUTM4MHlMSUFKUEd5d0Q0SXBLRTNhcDE4OEda?=
 =?utf-8?B?QXVHeW4yK3p3MDlGZ01wWlhDaXJGMi9kRlVNUjNmRUZKSjYzZ0hCVExxd2li?=
 =?utf-8?B?QW92ZHhWUE41S244VXBCSSs1ZWw5b0NHNm5PbU5Ld2dLN21pTE9OZ2pqRmlQ?=
 =?utf-8?B?c2VZL3h3NzBrSkV0NHNUcFdYbjRDSGxqNTJ5QjY5WEJCcFIwK3Y1NHJxRXBi?=
 =?utf-8?B?RWwyYXJ3ZHNKZ0g2NE0wbnJ4clNvODNyd3lCOWZmWkFMUlEweEhqQVNKSElN?=
 =?utf-8?B?SVNEdUtwc2t3a3ArRS9UZUs2YXgvWU9TYmtDMldnSHZJSXg3aGRJRVZXaUtF?=
 =?utf-8?B?M1JkR3dnZzNOVDZvMHdVVVlabG14T3czRXk3V055eVZDbHNnMDViNDJGMlZD?=
 =?utf-8?B?bm16M3VzMTRBVEVGcUNPbUdIc01CVVJUeDFsVHhHTGVCcjNiZlRySngwMTVN?=
 =?utf-8?B?eGNCSWRsNVp1VmRRSExoY3BJMDZBOFFEZHNhVVZ2SFZVWmJKU2JLUHBHdDhO?=
 =?utf-8?B?OVhLRFBieTVrelhWc0RLbjA1OGdxS1owOEpKM1FPLzhKNWFzbEoyaTdOQVhW?=
 =?utf-8?B?VkNQTGVNbm1PZTJ6amRNZENWSUtQVmM0S2ZRenR6Qi9iWjgxVjZZdmJTeTA3?=
 =?utf-8?B?QTVMdzQ4VkpPdllTcUYrSFIyOWRuQ01NOWxRUTdJR014bFJxZmdJMytEaUtH?=
 =?utf-8?B?NVlraWdmWlpnU2ROZWcyVDlFaDhSUm80R1RvOElCVUlpY1FYemo4M0VsdXcy?=
 =?utf-8?B?Y1AwL1pOb2JpSS9ZajZZNEpwc2NVM3ZrNXNPTnVyNW4wcmFDdlRYamxDMTl0?=
 =?utf-8?B?MC9tV29rRzZnaW0veThkdWtla2Y1WlBXVDU3eDNNNU5RUzZnOXZJa0lKamNE?=
 =?utf-8?B?VVh0U092b2xjNUJBeWR2ZEpZSU9FNHFnNC8wNU1Fd1k5Yk9rdysxYTdGd3hK?=
 =?utf-8?B?SVVPZi9aaG1JRk9hOHJvZUdhdUcrNHI1VStmUkVXeEhjMGh3bDBuQzNZaFhP?=
 =?utf-8?B?MEpBT3pzQ0hsQUFmQ29OOFJuVHhTRGF2QTNNVFp5WGdNZUpEeVE1NFU4VUZD?=
 =?utf-8?B?USsvdllMV2Fwd1FrNmVYSGJhTWJMODIyNm1RQlBRc1d1Z0tJamhnZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7692dd3b-4163-40a7-a6d9-08deaa8e05ff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:49.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YhScbFfWWyv6GjLbQ64J+szlYee4XNJBWOlEWeyjVkDHr3+Vqo1RicmSXcM0wkWQDhAO9Bo+0R1RTycJ+YTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
X-Rspamd-Queue-Id: 8047E4CB7BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,bootlin.com,lunn.ch,intel.com,rock-chips.com,google.com,samsung.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,HansenPartnership.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,oracle.com,renesas.com,quicinc.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7520-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[102];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

v2->v8: none
v1->v2: collect tag
---
 include/linux/phy/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index e65865b4acfe..ccf7e83f103a 100644
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
2.34.1


