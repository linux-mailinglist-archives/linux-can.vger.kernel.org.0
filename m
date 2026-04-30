Return-Path: <linux-can+bounces-7456-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCbHFY8782mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7456-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:22:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF54A1EF1
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73C0B30211BE
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F649466B58;
	Thu, 30 Apr 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BS5Y1Ai/"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C14611EB;
	Thu, 30 Apr 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547280; cv=fail; b=nlZLKjZTtKzeTbPLkyWKz5933+lGIfgguHwzyHC282wC6wW1RYx79L3SGl4CCvRxFmstxkY+1I+LRdP8XpWah8flEc/llmdmBWnjjQ9kArd0jzMhYGee3Hb6WL5KfNELZKngyxJsldu/sZXP1K8QC2jNqU3mNbYHpiuKSHvmDN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547280; c=relaxed/simple;
	bh=W6Ze/Sc61KjKcNTf6UMIsJbg52R0jAhE4wdz6vt0gbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcrydxwFJnNLoDZC8EfQqR3oHiS5zXRE2vxaU2qy1Se1my/em71QO1lmsNx/U4c4DKa9rfrTPEJI6fFmwI/o/D3anuGnf4jk6bCSkCZcTUDHenw2EADxfKDTMEjpJno7L+euFs3Wt9fOlVyZdjfHT/WSjGNlIj3u4MC2S18/mXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BS5Y1Ai/; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIyFbXxqyf3bYdWx+icI2S3mLExqAQQZcyKRuhr8PrIHI2xzLS8rlXJMRZsTjnJ9Fba/+0j7uNJ5AfcQRFHAAZSD3ev1f+NVkfhBsVkACH5rOxXxNah9ChFyT57I/kWF6heKdzY/anNGU6pBiQ36D91rou+yu2WlZyzihFlCrxHrcw3X1SD1qXIFREcGGDLoeTwUU7QD26yXdgg1rRg9cbQIxy72e3JwKlb0eCimNiYF1fM3ZbRxTDMMPGa4gDKEcn1LxYAOwewAC8pocNCEccofpG0bSe86XUWlqRw8kaXlWbl9qRAIMHeO8bzPD/RIvuz4Mh6rZ0q7fgQklfK4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Si6UMc96n2N2DF/XC4cnF9nZvr3A9AlpPHbLG67E9R8=;
 b=fnrtMy5Vpv6XciWbZ9Uk5AKp31YZIvfqeAy9NE5QkG+jL1c7CQlIamir3QY2TCOVfi3/9vF7qSnecJLelYQ7e+Trxo+bYB2t8B9DJ11e6qQCc5lvWVlD4vL8yrFlEXZtUG8n0kCRFQg7iE1T+YbA2/zqwDszmkBbDqvM6YZyA2ETiA8hpXH486kubEWkh849QYuQxlYFtlNDXLi2PIAJZWtmKuRLbb0dyfsi/Zx5qgcdb8RI6K5NkWbTj27iEx361kb6sUa681PBpc0OliU6C8C5MvgWbAL5B5SD2UvDcNDABP6hrr6Kx9PCbzUYSQKL5ZQpJLoCc6yF3cw8gEtfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si6UMc96n2N2DF/XC4cnF9nZvr3A9AlpPHbLG67E9R8=;
 b=BS5Y1Ai//6ZqNt7M/YVk29LITvOeHBwWNiFRrNd3fusAX3BY10B7sQpxVri6Y0/Hi2/ptrRGx0fjMr+Tqn0plkrTZpG/HrZ/S6d0FAe8siDwo+UORz7S+ouGVo0yHTzJ4iFjG5JUTtL6za9F54ZwDoTXoUasLYj0IdVbIWC5QwyYMU9cV/yKSh3MAc1AS7so9sC4w0Nu1DzjtnGKc6SJnYsmdzKDgdwfMxf73fUTwKzwWPcN9eCvVAW7nsBcpK7rbZKfHDih5W7GtcLA2tii8dJdPV4e5D49g2xbbfPm4DUAA78GJnMXUGum5n+6cYqEaHSuQaGwIZbEJ4ALQmbQMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10583.eurprd04.prod.outlook.com (2603:10a6:150:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:42 +0000
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
Subject: [PATCH v7 phy-next 26/27] phy: remove temporary provider compatibility from consumer header
Date: Thu, 30 Apr 2026 14:06:51 +0300
Message-Id: <20260430110652.558622-27-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10583:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f5fde0-ba0f-4971-6717-08dea6a8b343
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 bjDhtYlwTEjLGAG6PD8fzABylAebhnFcZ+11DQ5eWy476jzU7w8Pu57C4FqUfkvLEqhk1ygyV4jWFwHlZFIUQTsXrF1EzuNRHCkgZWQzt/B3kEXgoK6rkylQSKzyoX5LJB1uGojv6/yY7dEswy7krIaure2AJEg+U9n63r9Tm7U44TLbT8Or6GGTDjSkPg2u9DBl5KGR+hLrXcbasbAOmeo4nsVNDdO/FVPsRGRPZRnqrg0qtoGDqzbadVcO6zVohoinb195wTtpNhqF5k7VblzQI7ELe5dmgSHrUeNJ52MW0a7soWiuSjTbKQT4+dmgqjtM4xXC2va2PXXn9xCIgVTSeel8m8BpXY3qhvZyaLLOnOhggl1Qh0EbfhlNHrr/lb+H6kscSA7VJhfE7bbpoFrzVl8QfMVHucWJIRtZRYHKatInJklU9Rt0ZqX2lcIumm67ZuwnoDS0Axz6/XTUQQQaeiKtXPZQL0zug6j2qmtCwHzbBBmEgJWEY6ZjB8kBYwWuXett42GF2fBwa8ZTsFRlCJfbuxr6QeDWbJf87RUajjZjabJcfSlk3ouLJM8FKAcSqouY6RR1o58KeDEy0fs3Y96vAsMD+oQ4/oFDurzP1d1WqsEwUeHkfmB9ZFgvhVFLjCRSSrAc3XRpJ12epa90JcNEjMKclOubikCj8JFY7pKTqCxVLwvbaiQKinsznczaTWXiqlE3d3BLW7MSH6atPIKcZy6CHX8Mfj2BNuo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SFRCRVBraWMrQWxFUWZTU2xBNElELzFsWHdRbVl3R0tlY28zbGg0MzFrbTNX?=
 =?utf-8?B?cHZDOEo4RXUwYlJKbFFndS9MSm9JMGtmbWJuSWlDZHZYTElRSzBoL0I3amdK?=
 =?utf-8?B?WnBPKzZBdEIvcG14NitoZy9tSGJXWlE4NXBBZXNJb0tpUVUwSXdmQmF3Vmxh?=
 =?utf-8?B?bjk4bUs0OWVKdUxnMDF0U2tCcFRXbFpnMjhkTkxqT1NUaHJmdnpYc1BoV1A1?=
 =?utf-8?B?WVMzNVNmTnlSaklNcDI3eTBPeU15YkcxVU1RUEhmY2Q3cXgzZ1dXNDBJOVBi?=
 =?utf-8?B?cDZ4STNPUEFsS1BSbkowY3FtazRtblZlRUg5dUFpcjQwSkIzS3JRK2dFWHFm?=
 =?utf-8?B?ZHU3Z1dYQjZHMzJwRytSU1E4eStkNHZYeVB5Y0lCVDZycTN6eEZIU3BZZjA4?=
 =?utf-8?B?clF6SG1CSGFmSXQ0UXBaVGVQc0cxNEtUZWpubTVKR0VjQWNOQkhQVCtmVTZi?=
 =?utf-8?B?dHU3dHkzcEYvVDVoR0NyOXdLMzJ3RUtTV1A2YzVvYWFiNFNlSGdLQXRYU2JM?=
 =?utf-8?B?Y21xbTV3LzUwRzgzMWlwNnVCODJyUFN6UzZrNkI1c0xKTE1pZ3hBeVBFUW9D?=
 =?utf-8?B?ZWxGNmpYVGkrYVg5dmtMbTFyTE45YnJqbEk4dlRLNEI2KzRZN2dXSnpBZ0Z6?=
 =?utf-8?B?WUdkbHpWUVlucmtSNmFIQ2tuTSt1QThHMTczYjY1UHp0YjMyRW1BZ25zZmk1?=
 =?utf-8?B?MUltUWhweVpLZ3Vxam1jMUJqM2Z1dWNTQ2xCWksvYXJ3UllvSXpKQ1FkbVVI?=
 =?utf-8?B?Y1VvVWFQL3FEY1ZhRWQ1OEZiMlBQbzl6a1BFTTZTelU3RVg1ZjdWT1EwRDRp?=
 =?utf-8?B?Z2RYdGNqOUlIanZPWTBFdmcwMDdseDFUY1NJRTdUOUZoak9MRURRTERJeWNw?=
 =?utf-8?B?VmhlSkVwQU0zdmRCRVg0V2pPREx2QkJrOHkvM25BVUpqODd0dkxUeHdQVzNI?=
 =?utf-8?B?WWdRYXRWbVRtOTFUTFJPYUxPcFZ5NTFQbW1ZN0hZYy9vazBjK0xGdmRHa3BH?=
 =?utf-8?B?Z0Z1QmRld0Ivb29NRVQ4Uy9yRWJRdXgyVE45dHgvZTg2VUszMThxZlFhSTYr?=
 =?utf-8?B?dG4wMFdWOGF6Ny90L1EwdTVQamFoMER3elVWekFKeTFtMU5pakVDcWNYZVdL?=
 =?utf-8?B?bTRGWDZKcnk1L1pYdGs5N0kxVmt0dU9VV1k4UG01ZkpqcmRsRURVd3ZlUjlt?=
 =?utf-8?B?bXJKalVsYjVLNTZEVnJxUHUrOHgvZGliSG9KTFA4YXFEQUxQZEFFMVpzTDRD?=
 =?utf-8?B?WmEzbU12RXVjbnRmNVREK25tbTZYTlM5YWZ1ZWlZY0h6QXJsMDJxa2NXSGZy?=
 =?utf-8?B?em0yWlVTZjhKQTQxS1JMSGl5WmVyWFlibkloajV0VHErR2JQQWhlcGdMdXRG?=
 =?utf-8?B?TTFPNGY1eExLeENWSGRkMUpJaGtTbUdlWmYxZlRrc3orcXhKaWhwbmhsTlhU?=
 =?utf-8?B?K3pncWtscHY0dVpjT3loVUxsYlU5SVVLMDBsekJDTS9PdHd3TURMUzZpNzFD?=
 =?utf-8?B?bjNON0dZbkJSemdHdEZNTGlNL3VLM1cyTllrdTllcUtpWTJ3cVROcng5UFYz?=
 =?utf-8?B?NUFUeTNEOW1VWHE0Uzg3YWhLRnVvMHhWczNVMG1Pb0hMZUpRWHBsbWlmTXJs?=
 =?utf-8?B?bkQ2cUlza0J0ZkgrbHAzUzZ0STU3QzE5b0Z3blRSclVCNnhiV1dRQmhqc1BQ?=
 =?utf-8?B?MjZIbmY4SUhnaHZsSmMwRzB0NW1rakNTMmM5UExKV2ZuNncvZ24xbGtVSk1B?=
 =?utf-8?B?NVA2bHNOWVVzRzhGdXdXdU1NdENFY0JPUTVwa0dhVDFZQWE2eVFQZUIxbkEw?=
 =?utf-8?B?eVNScXJSVnA4M1VIcG90T2R2TXU0d3crZ3IvNlk4OFN1Y1ArNlh4ZEtuMjlD?=
 =?utf-8?B?N1NZMmZNZzNxandrSUpmTFRvRTR0eldpcVUybVEvOWI5LzFHWGtkeGJNMkQ5?=
 =?utf-8?B?ZzNnNlV0STlnb3VzWVZGUVFqa0ZpbDVYL0VMTHRwYlBkeEs4ejJBOEFadWN2?=
 =?utf-8?B?NkdVQ1JPQUJQT0dLUHZuc05oenViTmF2bUdMRnZSS1ZvWGc0QldOOWJQdTJB?=
 =?utf-8?B?QmxxZGFqckwrVnZQaFE1bWhkVGdheXdFZFBXM1Ntczg4UzQ4MWRjb1VoYitP?=
 =?utf-8?B?VzVvNFpPNVZZbUc1MnFrcnRBa2RvcUVpUnBBNFUwNFZuTHF0WW1CT1A0Z3ZJ?=
 =?utf-8?B?QjhieW5XNlJuSjl4U3JvS0hiUE94d2lpYmM5WjdYeVRDdVlURzIzUjdSQno2?=
 =?utf-8?B?M0lna2JDbzZYcHd4eGxsK1RYaEZoSW1lOUQ5ZXM4QjQ0K0dQTlJZd28vRkZs?=
 =?utf-8?B?MWZxMjRNVk5TaENMa3d2dGhmVlRycmpVcFpYVzE1TU56T0g1MGdUQ3VTRXlR?=
 =?utf-8?Q?O2k9QUQTo3urSp9MmsvYAffK9GCzd+ALIrnsl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f5fde0-ba0f-4971-6717-08dea6a8b343
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:42.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Cg3c80wgXqplKxSJmmolV7blTeRNxwjaIsz9Q2dSHRgX1MeYE3tXm5nbpUyTCuQxP8aCc+nXnz6acXnGfeA3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10583
X-Rspamd-Queue-Id: 28FF54A1EF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,bootlin.com,lunn.ch,intel.com,rock-chips.com,google.com,samsung.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,HansenPartnership.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,oracle.com,renesas.com,quicinc.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7456-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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

v2->v7: none
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
2.34.1


