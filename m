Return-Path: <linux-can+bounces-7266-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC5yOD7RxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7266-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:49:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D682F3493F6
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FCF83017A94
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CC371069;
	Fri, 27 Mar 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QZFSYE4E"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8FE315D40;
	Fri, 27 Mar 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637322; cv=fail; b=LpZKX2BD8s2t/KEI5gqLOzGl1282RBF6rPHWNBTz9eVOeB1UMEIAtR+Uoj6yjlaOtj4V3FWq1HOr8wfqj1VoPIbFCql+vDsTh2bKzrvH8szQwkyz1l88l/mWX+VVds0105ngRpxpoQONajFAMtuT8XCHjNRWnYXVGFghXXUq+hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637322; c=relaxed/simple;
	bh=XbSyEbPhbFwLmgEObtCcySeFAsDGJayHqshPQl2xcEw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FkG/EGX4RNJd0ccYZqmWuCi4rk0TjHHSTIBzyuwTNqUtO92kR9p6Ufqr8KJxae7KpfmuZJSmcYBZ1A8O/DZmZgc7LUu16jKj+kOG+NIutZGPoRH1sksjHRGT8cWy4wtFyp+px155ayVoAr0RBiTdtpxT3T3b9MqaQ25DNdYmoG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QZFSYE4E; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrcaGGNdzg9q5QzL+UBBdQacRPAsJecox3grpWSzh1MxP3xgJqTK/kjQ++LaW7V4ApiTCK3GIQxVmnFpvwmNFtnRrk1//0UaYi2Zo70pGmF1C8vz+aK46tifdihW+jkIdzYhkUqqP/nExqcsGDbpAoNjmiFddGNAZqo5jllqFP/kyPhoKNJj9cFTjq37y44DqbRMqUj/H2oIszMR5QyAx2fsKMgd6glF5o7LzGOWEfT2wgraY64gEEk4qggUtN2VQtNOXR/I8C+8F5h9Im1ooukbgMNxMFkXa6o/odIX7mScRbPbk3tqQMuLx/JcuJV84qxLvH3PXKjfkN6RL5F4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlIKIolik68+oOtzl7yKCZaFvbV7ivxg+yVa2n/IZvw=;
 b=APQA8+tU6snELS7aRYYIF6qQXRUqR6kFfHJ6s4pJQivZi8kK9Txldx97vYDkkUpKVoM0eI5hBPf6QkHvLfog7ecXhYopzODRVcohv586n3etr8NjnEvwtJ2QQT+4X/cwHEdEKLVBC2VqRKHWUvdZtDQKLmYs5T6b+sUw+/rhvnriY8iFf/EZSVZYXbzEdHW1Ud6dXAAxXuRjf7wAxLBI5Tk1GsA2OpjL22jPvisodWcCQsFnA8pmoQT5K/8XPZxjBiBdMfH70p5Drci//WcXy6LuM1v6czY02UoCxWxDDGkjQRvHgLjKmYJFGg4jkGNKg54Ftf1+WXnA7zMmM19pcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlIKIolik68+oOtzl7yKCZaFvbV7ivxg+yVa2n/IZvw=;
 b=QZFSYE4EHL1AqQM2kT4gIOamPtXx8KNB+mQ32DBJLbqSRzpgvA45GWrhfLTh/tseUONr8NKkTLrPHjg61TzaPZznuTvijeT4spfYrEjDYy/s1A6fGnnhO844JXferlgGDF695TI4SEeUHHiWp+4ZOk7/DLlK/Lh0/Z3/8241iqeR6UaKMX46rGxyVS8LwutZrwlafHek8s/s0Ya5WjQIK8URCK5N1YqMJsE9BQCgw302Et8bP7xg90c1Wu7DHZUNHpRAL0Ff4wXnne+vDCclSUtt4IweF39WdbqbfItDa+gxY4b3npWuF2+LlNDskRsvqann3kplPK2idVHZPlnzlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:32 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:32 +0000
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
Subject: [PATCH v6 phy-next 00/28] Split Generic PHY consumer and provider
Date: Fri, 27 Mar 2026 20:46:38 +0200
Message-ID: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0090.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::43) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb52ca0-4c09-4a5d-e14b-08de8c3171d2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 SoGlkygr5M2tOU4xBGVTzbkK5m4BinWx8Jd1GCiuz3Y/QuLzJajk1FovukjADp55knbRFWFugJkraG+OinvqJkgAMrl9b7fQlPfl32OQSiQ4KZjK2XX9822m0/qIZrEzM8XbUwbOiTIIyltPwbkpofk9A13xi/dbs18uoPEsXj4XVHzzee1pnZiBKTwD34Qy2ibohaCeKXq35oySfOKGYG7szXUtTl8SvLib/L5WHfxNKCm0oaVQAxo/JSGoWO9TrRndvol9ipvmXKC1QqPTkA+CiYpAzbF4NKU17n2B6mX1vBKnqr8PRgmkoeC9j4stolG4QOb6icnptjNZ/zc0reWyl41pkChMCb7AQadHMm7hDwVJuujqJh9ZfN7pHDZJGqV2yuY5shJePMw8rndeJRTGgPEsfLSLWfs+bIx1WZSaPbx1uDrYZet1jR4baJBJ6smi6PSDfQOYON9qOV5qipj5GbmUHYb77xF0n3L7SOK8Z1xjH/wIHHeHtsq1FonRcxMK4UsQujBxifeP7R2fzOsmVMRixwdTmW6B3eRVYwGvUXPy4utFSgI86Ek3W+5z60bx2Dt+fe4crJWN36ATNfGcofZX9b46jRsHVhu+55pC5UIe/oQ0cffCxa9z4FDWq3t7zRXIF1tW5WDms4UpsLAKxw2xhlKklojJ4pH7bxRsxCFrFFWdn6lREWyYReTYSrBHkv8XnAkGWaMIpEJegBo/HYVIl1bgfbfye2ikpRFdFlgHZD8oDtOUdjdgLUF1
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Zkpuc21lTWJaZlc2OWtDV2o0TnowdGRWemJBd1VQby93ZGs5RldhM2g5QS9q?=
 =?utf-8?B?dmtWMEk3ZGZUTi9NYmpIN3I5MDNRVCtxSlpJaWtYVDhnVmdDdmxoaFBqRkRn?=
 =?utf-8?B?Qkw2ZXM1MUVVdUlyVEx2dU1LT3BpYTJ6NUJLaURtbDBWRGUyWFROeU9PM0pF?=
 =?utf-8?B?eTkzMnNjRzF3QTZJS1l2S1dydDEzZ1d4YXZXdmNaTlNZWmJkcGFHTU10cUZh?=
 =?utf-8?B?QkdUTURLRFBRYldPOG95V2hGZ20wTE9RaTVzODJwc1p5NjhqOW9OOUpvekFm?=
 =?utf-8?B?Nm5NOXZqRDIzM3dEd3YwSlE1Y0RVTFR5UTRpTXFlWHBLSEtBaGVaam52WG0y?=
 =?utf-8?B?Mjlmd3VySWNTVE96U3dXWWNFSzFXeUNENHJCRDF4SU1LcFkwL0tYOHVaZXF6?=
 =?utf-8?B?YjREL1ZtbXFyYUFrMG0ralRnbUZ6WHovNTVYaEd5ODJHenlyRkNwemR3dm9m?=
 =?utf-8?B?NngyeStoQW95d2hsazRGZGp1VEtxSS9HdUpwMlhsYTEybitMQnljZTUzUmFw?=
 =?utf-8?B?ZzByd1ljVkpISEpEekhhMVZ5SThOM2syUEpJL0ZJSE5jZUhrRVVuOXVZZFdq?=
 =?utf-8?B?c1MzSUVKOGY5RjBlQ1JNWXdhVGRIeXltMXE2UHc2eUZJVmNDUUQ5S0JRWHRn?=
 =?utf-8?B?cHZhOE9jamVlSFVhU2F4VTlHUVJ6VWxuSy9rOFplRnpPT3dFRGhxRStDcjJq?=
 =?utf-8?B?aS91d3hRaVFDU0tDZmdKZFBsYWdZY2hOQXZFYTc1V0pkaU1EdWRldVNJa3ht?=
 =?utf-8?B?dThWUUpKTzdOOTViMHFsMlRZcVpmeHlZckZGNy9CWjFPd1lPVGR1L1RBR3kr?=
 =?utf-8?B?Ti9FMHhhQkdrbXNtdmU5dFIxNnZlSGkxU1VkN2FiVGVPYU85QW1tSGc5QTFY?=
 =?utf-8?B?YjkyOE9ycjlEU2FiRVJhRDluV2pIRXRjNkRoQkNNNmxXUWpLMHJVbEh0S2Fa?=
 =?utf-8?B?OFNMREFUYTl1T0h1dXlpdzRXZGEvQUk1UXlrTlFWL2hSOE5wV25GU21uUlp5?=
 =?utf-8?B?Rmo3eXFZRm03bmxDWTFaNldpN0dxbzd2TmtKQkFIRGU0NU1TRGk3M2JvOThy?=
 =?utf-8?B?ZzBUclRudkNPNk0wNmFwbktMSVdyOEF5bTF0ZzlMOUk2UWtJb1ZLM3dta2Z0?=
 =?utf-8?B?RU03SkM0M29HODNwTTV1OHJtRHZSMU96YUNaczhwcGlCSGw3ZWx2eWd6dVpt?=
 =?utf-8?B?djQ1MSs2a3EwMTJCaU1sL0lSZTkycFRveDE3Zmk3dVRaSmFxcDluUnFUWC8z?=
 =?utf-8?B?SFV3aEhlNXdka282cVdLeVY2U2hIUHNGd2UzUUpZRHhzRzZENDJGbWFEQ240?=
 =?utf-8?B?bjZNcEZPNHdZTitzM1ZrOFdoT0dPbXI5Vnh4dFlKTms1aEtMbGVxQlJlalQ4?=
 =?utf-8?B?VkRVTTljNVhvMEphOW02YlUwYTVHSHZ2MDVaSFJkNktaeEt1bmtPd0gyR0xy?=
 =?utf-8?B?ZnE5T2txSTJFQS9rVDE4eGx2RmxnN2lUZ3lwRVk2V284YXhwOG1DRkFkWkVU?=
 =?utf-8?B?S0JPM2x0MXdreWdISWNUTUgzRElTZDlCUzg3WmZzTDZKM0lnem5TTjIzajlY?=
 =?utf-8?B?SSthSkZiNmZiMmoxSTdEL0NBTTArdWt6eHNDczdodWd6dWZ5OTd0dFN3Nlpz?=
 =?utf-8?B?QWgrZFU0em04djVta3NVcGZid1pvSytyQ2ZTcW0yNjFuUmppQTBpMlJHd1U0?=
 =?utf-8?B?WlJVTy92Q0lVaW1PeEFHVkxrU3EwbzVnczEzcUhxeWc2UEpBSUE5djBlZS9V?=
 =?utf-8?B?MG5ScC9FbE5XRU45enNkSERBK1RDVEVRY1FyZWR1cFFES3dqT1pMWENFZGFO?=
 =?utf-8?B?WFd3SW4vb01mK3dGSjlLWDJRREh2ems5QVlvL1RhbkQ4eE9pMkpOLzR4amlT?=
 =?utf-8?B?TlBWRVY3by9hZDdPTERkdmUwTXducFFzL0JxenZLbkZiVVBPWU5hQTZOOWw3?=
 =?utf-8?B?eWFPamtGNUs2WW1zQzE5cDk4cVFTU1J1S1hSN3dJMHFaOGZtaEhSUWxobUVM?=
 =?utf-8?B?UE9YRlo3Q3lFYk5TYUJFQ2FLdE9lOEp2SWpjRDJVcU4zcUUrOFVSM094WWdT?=
 =?utf-8?B?L3E2R0IvVmlJZ1pKMnU0aTNycDB6VTZqMWd1eXIxaFRlOE54UU9HdVI5Vjd5?=
 =?utf-8?B?THJQOTAvK3hPdk1FN3hyaGhxQVNRaTdoZW5KSGNLTlhOb05aZ0xJbHFmcVV5?=
 =?utf-8?B?NXhaZStVU3NObFdiS1hVSjVEMlBLNGR6U2VnZjF4Y3E5WlY0OTZCbzlXbitq?=
 =?utf-8?B?MktTL3ZDeG5Eb1BUbG9oc3JMeGJvdkVPQnk5RnFEbkNzbUVSS2tFZStCUmxo?=
 =?utf-8?B?TzBicEFvZXNKVTBPTWc1bG5RNHcwbWM5emRTSXpJYjRKaVpCTHp4NGNiY3Ni?=
 =?utf-8?Q?GQusFOy8aoRDCGJ97pTwPTlKqWVseJNPbcjQ9y57kkWZL?=
X-MS-Exchange-AntiSpam-MessageData-1: q6hn+IpUcZ4miourcXb6r/uJ+iRNmQkHEnw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb52ca0-4c09-4a5d-e14b-08de8c3171d2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:32.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G40NUsY4sZvtXVVY307qZFwTvH+VEUizE+obP0hb1GL3Rsvidk2E6Gw1NpKvp+a57VoOjaCfW00UvDwQpAADwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linux.dev,bootlin.com,lunn.ch,intel.com,rock-chips.com,google.com,samsung.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,HansenPartnership.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,oss.qualcomm.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,oracle.com,renesas.com,quicinc.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7266-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[101];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D682F3493F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The biggest problem requiring this split is the fact that consumer
drivers poke around in struct phy, accessing fields which shouldn't be
visible to them. Follow the example of mux, gpio, iio, spi offload,
pwrsec, pinctrl and regulator, which each expose separate headers for
consumers and providers.

Some off-list discussions were had with Vinod Koul regarding the 3 PHY
providers outside the drivers/phy/ subsystem. It was agreed that it is
desirable to relocate them to drivers/phy/, rather than to publish
phy-provider.h to include/linux/phy/ for liberal use. Only phy.h and
(new) phy-props.h - consumer-facing headers - stay there.

The hope is that developers get a hint when they need to include the
wrong header to get their job done.

If that fails, patch 28/28 adds a regex in the MAINTAINERS entry that
ensures linux-phy is copied on all Generic PHY patches, for an extra set
of eyes.

The series is formatted on linux-phy/next for build testing, but is
intended to be applied on top of commit
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=4ff5801f45b494ad8251a16ec06c9f303ed3b9a0
which is v7.0-rc1 + 1 patch, and then merged into linux-phy/next.
The idea being that it's better to resolve the merge conflict early.
There are 4 expected conflicts, details in the conflicting patches
(25/28 and 26/28).

Requested merge strategy, I hope this works for everyone:
- Subsystem maintainers ACK their affected portions
- Entire series goes through linux-phy
- linux-phy provides stable tag
- (optionally, but recommended) Said tag is merged back into affected
  subsystem 'next' branches. Those who strongly prefer can handle merge
  conflicts when they send their PR. But this series unexports a lot of
  stuff from <linux/phy/phy.h> which may cause breakage if still used
  later, directly or not, in other subsystems.

Detailed change log in patches, summary below.

v5->v6:
- new patch 11/28 to avoid build breakage in ufs-qcom.c for armv7
- expanded CC list coverage
v4->v5:
- fix additional compilation breakage caught by better build coverage.
  PCI patch 02/27 received an extra change for pcie-spacemit-k1.c,
  patch 10/27 (for ufs-qcom.c) is new, so are 12/27 and 13/27 for Tegra
  USB (host and gadget)
v3->v4:
- fix build breakage in drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c and
  include/linux/phy/tegra/xusb.h added by patch 22/24
v2->v3:
- remove unused variable in PCI after device link removal
- update MAINTAINERS regex pattern to escape forward slashes
- add more people to CC list
- provide conflict resolution
v1->v2:
- split "phy: include PHY provider header" into smaller chunks to work
  around mailing list moderation due to patch size
- improve MAINTAINERS regex pattern
- make all PHY attribute helpers NULL-tolerant. Not just the new
  phy_get_bus_width(), but also retroactively, the existing ones.
- fixed the temporary include path from <linux/phy/phy.h> to
  "phy-provider.h", removed anyway by the end of the series
- logical bug fixes in the PCI controller <-> PHY device link removal
  and Exynos UFS PHY API rework

In case anyone wants to test the series, here it is on top of linux-phy/next:
https://github.com/vladimiroltean/linux/tree/phy-split-consumer-provider-v6

I've also test-applied it on v7.0-rc1 and provided conflict resolution
with net-next and with linux-phy/next:
https://github.com/vladimiroltean/linux/commits/phy-split-consumer-provider-v6-merge/

v5 at:
https://lore.kernel.org/linux-phy/20260319223241.1351137-1-vladimir.oltean@nxp.com/
v4 at:
https://lore.kernel.org/linux-phy/20260317230500.2056077-1-vladimir.oltean@nxp.com/
v3 at:
https://lore.kernel.org/linux-phy/20260309190842.927634-1-vladimir.oltean@nxp.com/
v2 at:
https://lore.kernel.org/linux-phy/20260308114009.2546587-1-vladimir.oltean@nxp.com/
v1 at:
https://lore.kernel.org/linux-phy/20260304175735.2660419-13-vladimir.oltean@nxp.com/

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

Vladimir Oltean (28):
  ata: add <linux/pm_runtime.h> where missing
  PCI: Add missing headers transitively included by <linux/phy/phy.h>
  usb: add missing headers transitively included by <linux/phy/phy.h>
  drm: add <linux/pm_runtime.h> where missing
  phy: add <linux/pm_runtime.h> where missing
  phy: spacemit: include missing <linux/phy/phy.h>
  net: lan969x: include missing <linux/of.h>
  PCI: Remove device links to PHY
  scsi: ufs: exynos: stop poking into struct phy guts
  scsi: ufs: qcom: keep parallel track of PHY power state
  scsi: ufs: qcom: include missing <linux/interrupt.h>
  drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
  usb: host: tegra: avoid direct dereference of phy->dev.of_node
  usb: gadget: tegra-xudc: avoid direct dereference of phy->dev.of_node
  drm/msm/dp: remove debugging prints with internal struct phy state
  phy: move provider API out of public <linux/phy/phy.h>
  phy: make phy_get_mode(), phy_(get|set)_bus_width() NULL tolerant
  phy: introduce phy_get_max_link_rate() helper for consumers
  drm/rockchip: dsi: include PHY provider header
  drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
  media: sunxi: a83-mips-csi2: include PHY provider header
  net: renesas: rswitch: include PHY provider header
  pinctrl: tegra-xusb: include PHY provider header
  power: supply: cpcap-charger: include missing <linux/property.h>
  phy: include PHY provider header (1/2)
  phy: include PHY provider header (2/2)
  phy: remove temporary provider compatibility from consumer header
  MAINTAINERS: add regexes for linux-phy

 MAINTAINERS                                   |  11 +
 drivers/ata/ahci.c                            |   1 +
 drivers/ata/ahci_brcm.c                       |   1 +
 drivers/ata/ahci_ceva.c                       |   1 +
 drivers/ata/ahci_qoriq.c                      |   1 +
 drivers/ata/libahci.c                         |   1 +
 .../drm/bridge/analogix/analogix_dp_core.c    |   1 +
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   |   7 +-
 drivers/gpu/drm/bridge/nwl-dsi.c              |   1 +
 drivers/gpu/drm/bridge/samsung-dsim.c         |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-dp.c       |   2 +-
 drivers/gpu/drm/msm/dp/dp_aux.c               |   1 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c              |  18 -
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |   1 +
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |   1 +
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  25 +-
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c    |   2 +-
 drivers/net/can/at91_can.c                    |   3 +-
 drivers/net/can/flexcan/flexcan-core.c        |   3 +-
 drivers/net/can/m_can/m_can_platform.c        |   3 +-
 drivers/net/can/rcar/rcar_canfd.c             |   3 +-
 .../microchip/sparx5/lan969x/lan969x_rgmii.c  |   1 +
 drivers/net/ethernet/renesas/rswitch_main.c   |   1 +
 .../controller/cadence/pcie-cadence-plat.c    |   4 -
 drivers/pci/controller/cadence/pcie-cadence.c |  16 +-
 drivers/pci/controller/cadence/pcie-cadence.h |   2 -
 drivers/pci/controller/dwc/pci-dra7xx.c       |  16 -
 drivers/pci/controller/dwc/pci-keystone.c     |  32 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   1 +
 drivers/pci/controller/dwc/pcie-histb.c       |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c |   3 +
 drivers/pci/controller/dwc/pcie-tegra194.c    |   1 +
 drivers/pci/controller/pci-tegra.c            |   1 +
 drivers/pci/controller/pcie-rockchip-host.c   |   1 +
 drivers/pci/controller/plda/pcie-starfive.c   |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c         |   3 +-
 drivers/phy/allwinner/phy-sun50i-usb3.c       |   3 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c   |   4 +-
 drivers/phy/allwinner/phy-sun9i-usb.c         |   3 +-
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c |   2 +
 .../amlogic/phy-meson-axg-mipi-pcie-analog.c  |   3 +-
 drivers/phy/amlogic/phy-meson-axg-pcie.c      |   2 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c |   3 +-
 drivers/phy/amlogic/phy-meson-g12a-usb2.c     |   2 +
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    |   3 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c      |   3 +-
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c      |   3 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c        |   3 +-
 drivers/phy/apple/atc.c                       |   3 +-
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c    |   3 +-
 drivers/phy/broadcom/phy-bcm-kona-usb2.c      |   4 +-
 drivers/phy/broadcom/phy-bcm-ns-usb2.c        |   3 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c        |   3 +-
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c       |   3 +-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |   3 +-
 drivers/phy/broadcom/phy-bcm-sr-pcie.c        |   3 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c         |   3 +-
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       |   3 +-
 drivers/phy/broadcom/phy-brcm-sata.c          |   3 +-
 drivers/phy/broadcom/phy-brcm-usb.c           |   2 +-
 drivers/phy/cadence/cdns-dphy-rx.c            |   3 +-
 drivers/phy/cadence/cdns-dphy.c               |   4 +-
 drivers/phy/cadence/phy-cadence-salvo.c       |   3 +-
 drivers/phy/cadence/phy-cadence-sierra.c      |   3 +-
 drivers/phy/cadence/phy-cadence-torrent.c     |   3 +-
 drivers/phy/canaan/phy-k230-usb.c             |   3 +-
 drivers/phy/eswin/phy-eic7700-sata.c          |   3 +-
 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    |   3 +-
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c    |   4 +-
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c    |   3 +-
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c   |   6 +-
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   |   3 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c      |   3 +-
 drivers/phy/hisilicon/phy-hi3660-usb3.c       |   3 +-
 drivers/phy/hisilicon/phy-hi3670-pcie.c       |   3 +-
 drivers/phy/hisilicon/phy-hi3670-usb3.c       |   3 +-
 drivers/phy/hisilicon/phy-hi6220-usb.c        |   3 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c    |   4 +-
 drivers/phy/hisilicon/phy-histb-combphy.c     |   3 +-
 drivers/phy/hisilicon/phy-hix5hd2-sata.c      |   3 +-
 drivers/phy/ingenic/phy-ingenic-usb.c         |   3 +-
 drivers/phy/intel/phy-intel-keembay-emmc.c    |   3 +-
 drivers/phy/intel/phy-intel-keembay-usb.c     |   3 +-
 drivers/phy/intel/phy-intel-lgm-combo.c       |   4 +-
 drivers/phy/intel/phy-intel-lgm-emmc.c        |   3 +-
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c      |   3 +-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c   |   4 +-
 drivers/phy/marvell/phy-armada375-usb2.c      |   3 +-
 drivers/phy/marvell/phy-armada38x-comphy.c    |   3 +-
 drivers/phy/marvell/phy-berlin-sata.c         |   3 +-
 drivers/phy/marvell/phy-berlin-usb.c          |   3 +-
 drivers/phy/marvell/phy-mmp3-hsic.c           |   3 +-
 drivers/phy/marvell/phy-mmp3-usb.c            |   3 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c  |   3 +-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c    |   3 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c  |   3 +-
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c    |   3 +-
 drivers/phy/marvell/phy-mvebu-sata.c          |   3 +-
 drivers/phy/marvell/phy-pxa-28nm-hsic.c       |   3 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c       |   3 +-
 drivers/phy/marvell/phy-pxa-usb.c             |   3 +-
 drivers/phy/mediatek/phy-mtk-dp.c             |   3 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c    |   1 -
 drivers/phy/mediatek/phy-mtk-hdmi.h           |   3 +-
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c   |   2 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h       |   3 +-
 drivers/phy/mediatek/phy-mtk-pcie.c           |   2 +-
 drivers/phy/mediatek/phy-mtk-tphy.c           |   2 +-
 drivers/phy/mediatek/phy-mtk-ufs.c            |   2 +-
 drivers/phy/mediatek/phy-mtk-xfi-tphy.c       |   2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c          |   2 +-
 drivers/phy/microchip/lan966x_serdes.c        |   4 +-
 drivers/phy/microchip/sparx5_serdes.c         |   2 +-
 drivers/phy/motorola/phy-cpcap-usb.c          |   3 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c   |   5 +-
 drivers/phy/mscc/phy-ocelot-serdes.c          |   3 +-
 drivers/phy/nuvoton/phy-ma35d1-usb2.c         |   3 +-
 drivers/phy/phy-airoha-pcie.c                 |   2 +-
 drivers/phy/phy-can-transceiver.c             |   3 +-
 drivers/phy/phy-core-mipi-dphy.c              |   4 +-
 drivers/phy/phy-core.c                        |  52 ++
 drivers/phy/phy-google-usb.c                  |   4 +-
 drivers/phy/phy-lpc18xx-usb-otg.c             |   3 +-
 drivers/phy/phy-nxp-ptn3222.c                 |   3 +-
 drivers/phy/phy-pistachio-usb.c               |   4 +-
 drivers/phy/phy-provider.h                    | 256 +++++++++
 drivers/phy/phy-snps-eusb2.c                  |   2 +
 drivers/phy/phy-xgene.c                       |   3 +-
 drivers/phy/qualcomm/phy-ath79-usb.c          |   3 +-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-edp.c           |   3 +-
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |   3 +-
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c   |   3 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c   |   3 +-
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c     |   2 +
 drivers/phy/qualcomm/phy-qcom-m31.c           |   3 +-
 drivers/phy/qualcomm/phy-qcom-pcie2.c         |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     |   4 +-
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |   3 +-
 .../phy/qualcomm/phy-qcom-qmp-usb-legacy.c    |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c      |   4 +-
 drivers/phy/qualcomm/phy-qcom-qusb2.c         |   5 +-
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c     |   3 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c |   4 +-
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c   |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c        |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hsic.c      |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        |   3 +-
 drivers/phy/ralink/phy-mt7621-pci.c           |   3 +-
 drivers/phy/ralink/phy-ralink-usb.c           |   3 +-
 drivers/phy/realtek/phy-rtk-usb2.c            |   3 +-
 drivers/phy/realtek/phy-rtk-usb3.c            |   3 +-
 drivers/phy/renesas/phy-rcar-gen2.c           |   3 +-
 drivers/phy/renesas/phy-rcar-gen3-pcie.c      |   4 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |   3 +-
 drivers/phy/renesas/phy-rcar-gen3-usb3.c      |   3 +-
 drivers/phy/renesas/phy-rzg3e-usb3.c          |   3 +-
 drivers/phy/renesas/r8a779f0-ether-serdes.c   |   4 +-
 drivers/phy/rockchip/phy-rockchip-dp.c        |   3 +-
 drivers/phy/rockchip/phy-rockchip-dphy-rx0.c  |   3 +-
 drivers/phy/rockchip/phy-rockchip-emmc.c      |   3 +-
 .../phy/rockchip/phy-rockchip-inno-csidphy.c  |   3 +-
 .../phy/rockchip/phy-rockchip-inno-dsidphy.c  |   4 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c |   2 +
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   3 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   3 +-
 drivers/phy/rockchip/phy-rockchip-pcie.c      |   2 +-
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c |   3 +-
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c |   2 +
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    |   3 +-
 drivers/phy/rockchip/phy-rockchip-typec.c     |   5 +-
 drivers/phy/rockchip/phy-rockchip-usb.c       |   3 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c     |   2 +
 drivers/phy/samsung/phy-exynos-dp-video.c     |   3 +-
 drivers/phy/samsung/phy-exynos-mipi-video.c   |   3 +-
 drivers/phy/samsung/phy-exynos-pcie.c         |   3 +-
 drivers/phy/samsung/phy-exynos4210-usb2.c     |   3 +-
 drivers/phy/samsung/phy-exynos4x12-usb2.c     |   3 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c      |   2 +
 drivers/phy/samsung/phy-exynos5250-sata.c     |   3 +-
 drivers/phy/samsung/phy-exynos5250-usb2.c     |   3 +-
 drivers/phy/samsung/phy-s5pv210-usb2.c        |   3 +-
 drivers/phy/samsung/phy-samsung-ufs.c         |   2 +-
 drivers/phy/samsung/phy-samsung-ufs.h         |   3 +-
 drivers/phy/samsung/phy-samsung-usb2.c        |   2 +
 drivers/phy/samsung/phy-samsung-usb2.h        |   3 +-
 drivers/phy/socionext/phy-uniphier-ahci.c     |   3 +-
 drivers/phy/socionext/phy-uniphier-pcie.c     |   3 +-
 drivers/phy/socionext/phy-uniphier-usb2.c     |   3 +-
 drivers/phy/socionext/phy-uniphier-usb3hs.c   |   3 +-
 drivers/phy/socionext/phy-uniphier-usb3ss.c   |   3 +-
 drivers/phy/sophgo/phy-cv1800-usb2.c          |   3 +-
 drivers/phy/spacemit/phy-k1-pcie.c            |   4 +-
 drivers/phy/spacemit/phy-k1-usb2.c            |   2 +
 drivers/phy/st/phy-miphy28lp.c                |   4 +-
 drivers/phy/st/phy-spear1310-miphy.c          |   3 +-
 drivers/phy/st/phy-spear1340-miphy.c          |   3 +-
 drivers/phy/st/phy-stih407-usb.c              |   3 +-
 drivers/phy/st/phy-stm32-combophy.c           |   3 +-
 drivers/phy/st/phy-stm32-usbphyc.c            |   2 +
 drivers/phy/starfive/phy-jh7110-dphy-rx.c     |   3 +-
 drivers/phy/starfive/phy-jh7110-dphy-tx.c     |   3 +-
 drivers/phy/starfive/phy-jh7110-pcie.c        |   3 +-
 drivers/phy/starfive/phy-jh7110-usb.c         |   3 +-
 drivers/phy/sunplus/phy-sunplus-usb2.c        |   3 +-
 drivers/phy/tegra/phy-tegra194-p2u.c          |   3 +-
 drivers/phy/tegra/xusb-tegra124.c             |   2 +-
 drivers/phy/tegra/xusb-tegra186.c             |   2 +-
 drivers/phy/tegra/xusb-tegra210.c             |   2 +-
 drivers/phy/tegra/xusb.c                      |   2 +-
 drivers/phy/ti/phy-am654-serdes.c             |   3 +-
 drivers/phy/ti/phy-da8xx-usb.c                |   3 +-
 drivers/phy/ti/phy-dm816x-usb.c               |   3 +-
 drivers/phy/ti/phy-gmii-sel.c                 |   3 +-
 drivers/phy/ti/phy-omap-usb2.c                |   3 +-
 drivers/phy/ti/phy-ti-pipe3.c                 |   3 +-
 drivers/phy/ti/phy-tusb1210.c                 |   1 +
 drivers/phy/ti/phy-twl4030-usb.c              |   3 +-
 drivers/phy/xilinx/phy-zynqmp.c               |   4 +-
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c    |   2 +-
 drivers/power/supply/cpcap-charger.c          |   1 +
 drivers/ufs/host/ufs-exynos.c                 |  24 +-
 drivers/ufs/host/ufs-exynos.h                 |   1 +
 drivers/ufs/host/ufs-qcom.c                   |  16 +-
 drivers/ufs/host/ufs-qcom.h                   |   1 +
 drivers/usb/chipidea/ci_hdrc_imx.c            |   1 +
 drivers/usb/core/hcd.c                        |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c          |   1 +
 drivers/usb/dwc3/gadget.c                     |   1 +
 drivers/usb/gadget/udc/tegra-xudc.c           |  35 +-
 drivers/usb/host/xhci-tegra.c                 |  42 +-
 include/linux/phy/phy-props.h                 |  75 +++
 include/linux/phy/phy-sun4i-usb.h             |   2 +-
 include/linux/phy/phy.h                       | 497 ++++--------------
 include/linux/phy/tegra/xusb.h                |   1 +
 include/linux/phy/ulpi_phy.h                  |   2 +-
 242 files changed, 1003 insertions(+), 739 deletions(-)
 create mode 100644 drivers/phy/phy-provider.h
 create mode 100644 include/linux/phy/phy-props.h

-- 
2.43.0


