Return-Path: <linux-can+bounces-7509-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBWRLcrE+Wk7DwMAu9opvQ
	(envelope-from <linux-can+bounces-7509-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:22:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A34CB04F
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1B9430F4932
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742D43DA23;
	Tue,  5 May 2026 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OG3jyvfd"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E27428846;
	Tue,  5 May 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975592; cv=fail; b=iujSkPbfMLO5yWKTgWp81+sh/eQxyq0OVzogT7+51rviFIMdPlfiy3FFCwU3JcDY1rneOa0IRfH9a6DKY9RGsuyo6UAz6owQJ011NwXsrdM0MFl33uZbhhOZgz7Ca2dlOZQbAW+oDVCu+uVVh9TsRF+Xz9gWseJr9KNSZ0Zv8pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975592; c=relaxed/simple;
	bh=ssoLJwXMVCCaey6nND1NrUKYB3W5nISp3TJv3d4T32Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dj+/Ww0V3PIaNArEL31S1VjIJvQUoyfXLQF4kW7s4JTCivBZAtD0Bm80MtYuBYgTzN05boBm7PDkWIEOSheK9+YfHT7YRM3rhWi9wzpPi4CKMbtxDDM3ljeQCrTyeg+d3IFqVUr7hSX9rKQmTzlkxXbDFKhc7aW8v6dQitYWzz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OG3jyvfd; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIAxF/blG0BplICwCv/wDnSad7dqgLi6XWLUCQP0qfgRMI3513L18L/F7SHlNADSG3eX+r8IZUFTiyMC9Bmxxmyob2Yd9zjNJ1lBIMqjlnG4W+1Fc6hpPBVI3/FiEawqB5UHDNHTlgUZmRa5DChjMW1RR/Lk/zDHXap1Hj2903EAgR7wTBJlzuXHxebe70XCPKCifZPV0PTkMeTWG2EDScxkqAR35V+NkUpDEFE3kQpWFfuqnwbqOUrqkwYq5qTozPWrCoPnyOQUhhrDObLet66+7BunP45o6jm/S7ckOry2ay2bKF7LKY0k3lMVdk78CxHTJw6mBr+DXisFFZPcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPCX8Ehc9aC3teMG9eWtZ/6bq4ZpL3yTg9jEYFg3QOs=;
 b=ero7ri1hyC0lPi1K2LxF4zgmWqoWaIDb1tIBtJy77QYQMHDnAwRZpy72p4Thn/FahL9ADZISuv+PZcbNXDP3qZuvm2e+94mFL6TZmHW1VceBqGcK669wAGjS4HS+6loVmuYfa43v8X8CUy1J4W3wJZv/fs/7LYbXK0JkTIhWVQxRFYI1FhuPSk/BNu29tm6wr+oPRpLjcvJzsEzBPq15goCZfgRR/uRJHa3CBQ7JdEo0sSJ08e573F1Lrxo6sF6S3IOp3YMJycsNjPzjh8jJFQp3yh8Q2TY8ky7dOw3df9+oljQXrg8wZUbqLcsv0KwhIcMnRuKGooxbR6RXtkDr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPCX8Ehc9aC3teMG9eWtZ/6bq4ZpL3yTg9jEYFg3QOs=;
 b=OG3jyvfdsljNzuOuWzg0lvvGi6jytS7AMOeu8hev6pczT7od4Qo8WQ/I5QVbZJuQQrFiaAc/n6kR2WXJ1SkKerlRf1ufpM0hM8C9m+DaxYPagC8KtrmHaTweVk+5/nPbW7DZjQ3f3pcZ6/ISQ87f2H2iKcInlk3pjNbivSQLjwO1pvTRgPDEhhEhOYBiShjKvNBdVVNwPCu1K/kvZLx6KBtDsp/4JFXOZun76drMbyNJli6ukWcfh/CgpGsvIvLs3TXHGKNRKHIm3ZoVg48TgxImXSYsj3PnZ1UOFUQ4qkiWJ2SiFlgkXnqo14BpGKLuBLEAwVPc9LUmjmA9h0Bo3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:16 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:16 +0000
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
Subject: [PATCH v8 phy-next 18/31] phy: move provider API out of public <linux/phy/phy.h>
Date: Tue,  5 May 2026 13:05:10 +0300
Message-Id: <20260505100523.1922388-19-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d95bd3a-b986-478e-d3d3-08deaa8df1f8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|18092099006|22082099003|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
 qm7w2Gm3wKFqonKuwG+uNRwOGCzDxi9achuzfirP19WxOBvZB0P2HsZpVBelqds7itXpP4qby8ag00XUVN+o3nTny6tVb4H9BiHSXOyO5mhEbcK3wju4mPtZK8hCV5ZbPjeNuTjq+63wvb64gGgRylDTdAi4yAxMyeLs14YF3l8/q0JeUgsZbznet2xKpbsDN6O2dUgljaI/dzyeSDSuniZidihpCkwQnLeasRu+z1DCECog8wBnOUBdPU+zVD93kRLd3E1AIrVN4c0TCXrScAzub0RRxj3JxOi5yObpPMz5G3pVRcjIhpeoDOt1Y7hKCUOwVWPRLhmZagaRPWYlYYZrSeG3UcdDhW6P9l8ry4M9nBs1ANCS3cTcQhl3hlVNUjfNdRrH4czBQUmFOrVVtpGzRTkDhyuS86yAjjLTnPAdYG6Bx0MgB2LMYC/fZhGDK96M3ImQbWGZ2MlRHGEijeZOSiYMzMTDlXTZB5ORGhywrq9fM/sUCSJAoxZWxNH59jm67g+88YR/Z3O/3/SvS4apCiQVo08X32wKSFAMDr5tkFd3BSuIfi5UK5eYiCCxbgpL+zWAuFkAYDnPtW+Zu+2Heqd3WiyVKpzJK59bK7LoO+n7llHTpc+dMKvakCRohsyC3IcLrfWR+wt7b2ipZw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(18092099006)(22082099003)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MVBuZDZQc3NNOHFyR0J2bVlUV0gvUTdLZVhhdGNJaWwyVUFNVG1mL3p1QnNL?=
 =?utf-8?B?THdkVlFodjN1M3V3cnNKb3E2NGN4U2NkcEowZ0FyT0UzUWFrb1FwbDk0cXE3?=
 =?utf-8?B?b1NIVDg0V2g2b08wMytSOFgrTnoxM2dod0YzNnFFT1lKVE02Tm9yTmRia2pq?=
 =?utf-8?B?V3F4cTRnZjBncHBkdzZ0YmdyMk9jWjc3TTZEVWdQQldGQTdFN0ZpL0xyYUhv?=
 =?utf-8?B?Nno3QWkwclFCTm11UVBrRlM2anQ1TldZcTFGZDduLzdEaXZhbk9FOUxVUXpw?=
 =?utf-8?B?YnBybWliWW5qWHpndHVwL0ZZK1ZWc0RRWkV4M3AwUklGQzVmTXZWUHlmdjc3?=
 =?utf-8?B?VEZFWFM2dHBwa0FtUitMZTdLeUZxK0hUNkdrbUVBa0p1T1FHdkpkenZZWTZU?=
 =?utf-8?B?VVkzemZRWjg4a0UrclJnOHdjb1dRSDFRSUlnUVRpQ3pMMlpqOVFRTEF2YzNW?=
 =?utf-8?B?VDlmTDJnK0JwbENHekRQQXo5aTNMaURXaEExNnEraVIwSDArZzlNQzRxYnA2?=
 =?utf-8?B?elBUVFdhU3l0T3ZqMVltM0hGRFJHU2ZwbjBEUUlHOWZsbkExSHdFRHpHWHZL?=
 =?utf-8?B?UnN6cytZV2ZIbVRETXVlSzMvTko2bUVMRWVFY2oxZ2U5aTdpa3FSUXU0QjVS?=
 =?utf-8?B?NTFiV08wSFVFT0hsRHJ5RXpiQ1U1TlEzaC9qblEyK3VheE5VYzdSNktxR0V6?=
 =?utf-8?B?ei9MVHNUcnR1UURCeEhxb3llMkZScW5aeTRNTWZkSVBxTUR2ZmFIL2RXTUg0?=
 =?utf-8?B?RkJFM1dtRjhSQjMrTXNOaUZOVEVOTnMrT1paRytlSlZWUXlCMkxnWlJGZjN5?=
 =?utf-8?B?Kzh5ZGVlMktKd3NBeEk5RFZPTTJLRnowR2RHNlY5VVhTQU9BU2tQeGQ1K0FX?=
 =?utf-8?B?REwybU5ZVytOWW16SHZXY3NCR3ExREtGTzlPcWhVMGFUQzYxQWN6dnNPRDBR?=
 =?utf-8?B?ckhCSlFhNzRxYUlId0k5dDdYVXBpaHEyL1JoSjdvNlJGcHB6TGtGWDE1OEVs?=
 =?utf-8?B?dHdFWW9mS1F5RzBaUFQyaDRDdHFJQy9lQ2lhVWRtVUx3RFVsU0RETmtvVFVz?=
 =?utf-8?B?Q0tVK1BvSklhMUxhRnhhK01YM3F6a2hZbVBtVjZsNUJIZTNqZjNQZFVBNWhk?=
 =?utf-8?B?cjZLU3lETTVQNWxzOWsvWVJ2YWxqbkZ4OWZwYzdoSzh3cUlmZ2pJRlF2c2Ja?=
 =?utf-8?B?bjhPY3VMa0tYM01LOTlmSzE5bkZDbWRLQlZqOWFnVnhyclZPdmI3blZXN3cx?=
 =?utf-8?B?OXN6aE9hMXJoQTZrNExheElMU0hFb1hvSEtGTVJjdmdZZ0hxeVVHR01TZlBt?=
 =?utf-8?B?ZENnZWhvMkdNOXloQ2srT0hPVWRZN0p0M1BMdjlCK3dmeGdJMGtGcjUwa3c5?=
 =?utf-8?B?MlpldjBaVmcyMTNQQzVtNEk1bDRtZjNjUXZxTlNQTnpyQmxhUmo5L3pUYldk?=
 =?utf-8?B?YlF3dURvWFNkWHNXSWVGYytqbEtWbkZ1aUpCQUNNbysyTTFHR0x6M3FJdTZY?=
 =?utf-8?B?ME1IL0cwZDY2L1JTRk1JOE4rQTVEd0ZkRmdrcGs3dEQ0TlJOVFFCU0JWbFBz?=
 =?utf-8?B?SStqTWxYVnA0ZHFQUlE4TlprMnFZUUgwQ2EycUVCbFpod1dpamtzRzVvS0Vo?=
 =?utf-8?B?MzlNeVRzd2FTMjVTOVlESnhmYlJlRHZBNy9UTWwwWDg0QXNUczVTdEdKeGZi?=
 =?utf-8?B?eG1uYU1NTjhIOTg4aVNXMW9kVVV4WnEvb3RrNTdadmFlNFhuZCtZQnBGSTdv?=
 =?utf-8?B?T2JkeSs3YWNMalRpY2ZnN1NPcFc3d2s3RUJOajVId0diYnJ1NUNVL0Y5YlAy?=
 =?utf-8?B?UzlXZ3dwK3FOR1BiemhLSGlFaEprVTk1dHNVOFNnc1FOUndOWVRuNUR5N1BI?=
 =?utf-8?B?UHY1MEpwckVPRHNCWjViOEppU3FYM1graENOZDQxZFQrbjFSZ3k1MmlZMzhR?=
 =?utf-8?B?RWd4Y3NJbERNdG1UT3BBQWhCZ3doWTdWcEFwUWxGblppM2tGc1BuOTlzKy9l?=
 =?utf-8?B?d1VNcnBLRHlJSTVScUVjYlp2cEJoeXVWd25MU1ZJU2lpaDRwbXRzMjd6dTEw?=
 =?utf-8?B?Z240MFFxSWFKTitUZ3lJcHhPUjRJdGlXNnlyZUl3MTJ0MGFZM01OVFRCQ1Ev?=
 =?utf-8?B?dU1KWUV3NU1nbHR6ZnNVSnVtNjJ6cnpQZlhuMFBqYllZcUhRWGRLZEFmS0VN?=
 =?utf-8?B?T1F4UElsOFNHSi9yMkhJUjZQUDVtRWhlRjl5aFR2TzJMUEl0V0NKV2ZMMjNz?=
 =?utf-8?B?NytsSjgySk9CSXdWd0tlSU9zNGd5elp1M3V1QkkveGN6U1NVRjBCeGNMeDUw?=
 =?utf-8?B?TnFDREZzVHpuNkh3YUNhVlFsenBnQzV0d24ySTdWNmVBSEhSbmltdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95bd3a-b986-478e-d3d3-08deaa8df1f8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:16.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQMRsIkU56HDP8AAc22dhY6qY2pRzMUQLJvBFYWzJRx9erdj696OBTwkMP6myBHGzqffOyrGeQ16sbHHH2dWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 518A34CB04F
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
	TAGGED_FROM(0.00)[bounces-7509-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[102];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The major goal is to hide the contents of struct phy from consumer
drivers.

The idea with "phy-props.h" is that both consumers and providers make
use of some data types. So both headers include "phy-props.h".

Some slight points of contention.

1. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
   We do have 3 PHY providers outside of drivers/phy/:

   drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
   drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
   drivers/pinctrl/tegra/pinctrl-tegra-xusb.c

   but the practice is not encouraged, and with time, these should be
   moved to the subsystem. This is not something that I can do now.

2. We can no longer tolerate static inline helpers. Allowing these would
   make it impossible to hide the struct phy definition from consumers.
   I've made phy_get_mode(), phy_get_bus_width() exported symbols in
   drivers/phy/phy-core.c.

3. This is not a change without side effects. In the transition we are
   no longer providing <linux/pm_runtime.h> at all, and
   <linux/regulator/consumer.h> to PHY consumer drivers. However, the
   in-tree dependencies should all have been resolved. Also, the
   movement of phy-provider.h to drivers/phy/ is at least "interesting"
   for out of tree PHY provider drivers (this header is not deployed by
   make headers_install). However, it seems to be what Vinod is looking
   to see.

For temporary compatibility, keep including the provider header. This
will be removed when abuses are all gotten rid of.

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

v7->v8:
- phy_set_bus_width() is now considered a provider function; the new
  consumer function is phy_request_bus_width()
v2->v7: none
v1->v2:
- collect tag
- fix path to phy-provider.h
- update commit message with the 4th point of contention
---
 drivers/phy/phy-core.c        |  28 ++
 drivers/phy/phy-provider.h    | 263 ++++++++++++++++++
 include/linux/phy/phy-props.h |  75 +++++
 include/linux/phy/phy.h       | 504 ++++++----------------------------
 4 files changed, 457 insertions(+), 413 deletions(-)
 create mode 100644 drivers/phy/phy-provider.h
 create mode 100644 include/linux/phy/phy-props.h

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 634ac07fd1f3..fe933629286b 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -20,6 +20,22 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
+#define	to_phy(a)	(container_of((a), struct phy, dev))
+
+/**
+ * struct phy_lookup - PHY association in list of phys managed by the phy driver
+ * @node: list node
+ * @dev_id: the device of the association
+ * @con_id: connection ID string on device
+ * @phy: the phy of the association
+ */
+struct phy_lookup {
+	struct list_head node;
+	const char *dev_id;
+	const char *con_id;
+	struct phy *phy;
+};
+
 static void phy_release(struct device *dev);
 static const struct class phy_class = {
 	.name = "phy",
@@ -606,6 +622,18 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+enum phy_mode phy_get_mode(struct phy *phy)
+{
+	return phy->attrs.mode;
+}
+EXPORT_SYMBOL_GPL(phy_get_mode);
+
+int phy_get_bus_width(struct phy *phy)
+{
+	return phy->attrs.bus_width;
+}
+EXPORT_SYMBOL_GPL(phy_get_bus_width);
+
 /**
  * phy_request_bus_width() - request PHY to change its bus width
  * @phy: the phy returned by phy_get()
diff --git a/drivers/phy/phy-provider.h b/drivers/phy/phy-provider.h
new file mode 100644
index 000000000000..c76dd8cf5f32
--- /dev/null
+++ b/drivers/phy/phy-provider.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-provider.h -- Generic PHY provider API
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+#ifndef __PHY_PROVIDER_H
+#define __PHY_PROVIDER_H
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/phy/phy-props.h>
+
+struct phy;
+
+/**
+ * struct phy_ops - set of function pointers for performing phy operations
+ * @init: operation to be performed for initializing phy
+ * @exit: operation to be performed while exiting
+ * @power_on: powering on the phy
+ * @power_off: powering off the phy
+ * @set_mode: set the mode of the phy
+ * @set_media: set the media type of the phy (optional)
+ * @set_speed: set the speed of the phy (optional)
+ * @reset: resetting the phy
+ * @calibrate: calibrate the phy
+ * @notify_phystate: notify and configure the phy for a particular state
+ * @request_bus_width: request a different bus width for the phy
+ * @release: ops to be performed while the consumer relinquishes the PHY
+ * @owner: the module owner containing the ops
+ */
+struct phy_ops {
+	int	(*init)(struct phy *phy);
+	int	(*exit)(struct phy *phy);
+	int	(*power_on)(struct phy *phy);
+	int	(*power_off)(struct phy *phy);
+	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
+	int	(*set_media)(struct phy *phy, enum phy_media media);
+	int	(*set_speed)(struct phy *phy, int speed);
+
+	/**
+	 * @configure:
+	 *
+	 * Optional.
+	 *
+	 * Used to change the PHY parameters. phy_init() must have
+	 * been called on the phy.
+	 *
+	 * Returns: 0 if successful, an negative error code otherwise
+	 */
+	int	(*configure)(struct phy *phy, union phy_configure_opts *opts);
+
+	/**
+	 * @validate:
+	 *
+	 * Optional.
+	 *
+	 * Used to check that the current set of parameters can be
+	 * handled by the phy. Implementations are free to tune the
+	 * parameters passed as arguments if needed by some
+	 * implementation detail or constraints. It must not change
+	 * any actual configuration of the PHY, so calling it as many
+	 * times as deemed fit by the consumer must have no side
+	 * effect.
+	 *
+	 * Returns: 0 if the configuration can be applied, an negative
+	 * error code otherwise
+	 */
+	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
+			    union phy_configure_opts *opts);
+	int	(*reset)(struct phy *phy);
+	int	(*calibrate)(struct phy *phy);
+
+	/* notify phy connect status change */
+	int	(*connect)(struct phy *phy, int port);
+	int	(*disconnect)(struct phy *phy, int port);
+
+	int	(*notify_phystate)(struct phy *phy, union phy_notify state);
+	int	(*request_bus_width)(struct phy *phy, int bus_width);
+	void	(*release)(struct phy *phy);
+	struct module *owner;
+};
+
+/**
+ * struct phy_attrs - represents phy attributes
+ * @bus_width: Data path width implemented by PHY
+ * @max_link_rate: Maximum link rate supported by PHY (units to be decided by producer and consumer)
+ * @mode: PHY mode
+ */
+struct phy_attrs {
+	u32			bus_width;
+	u32			max_link_rate;
+	enum phy_mode		mode;
+};
+
+/**
+ * struct phy - represents the phy device
+ * @dev: phy device
+ * @id: id of the phy device
+ * @ops: function pointers for performing phy operations
+ * @mutex: mutex to protect phy_ops
+ * @lockdep_key: lockdep information for this mutex
+ * @init_count: used to protect when the PHY is used by multiple consumers
+ * @power_count: used to protect when the PHY is used by multiple consumers
+ * @attrs: used to specify PHY specific attributes
+ * @pwr: power regulator associated with the phy
+ * @debugfs: debugfs directory
+ */
+struct phy {
+	struct device		dev;
+	int			id;
+	const struct phy_ops	*ops;
+	struct mutex		mutex;
+	struct lock_class_key	lockdep_key;
+	int			init_count;
+	int			power_count;
+	struct phy_attrs	attrs;
+	struct regulator	*pwr;
+	struct dentry		*debugfs;
+};
+
+/**
+ * struct phy_provider - represents the phy provider
+ * @dev: phy provider device
+ * @children: can be used to override the default (dev->of_node) child node
+ * @owner: the module owner having of_xlate
+ * @list: to maintain a linked list of PHY providers
+ * @of_xlate: function pointer to obtain phy instance from phy pointer
+ */
+struct phy_provider {
+	struct device		*dev;
+	struct device_node	*children;
+	struct module		*owner;
+	struct list_head	list;
+	struct phy *(*of_xlate)(struct device *dev,
+				const struct of_phandle_args *args);
+};
+
+#define	of_phy_provider_register(dev, xlate)	\
+	__of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
+
+#define	devm_of_phy_provider_register(dev, xlate)	\
+	__devm_of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
+
+#define of_phy_provider_register_full(dev, children, xlate) \
+	__of_phy_provider_register(dev, children, THIS_MODULE, xlate)
+
+#define devm_of_phy_provider_register_full(dev, children, xlate) \
+	__devm_of_phy_provider_register(dev, children, THIS_MODULE, xlate)
+
+static inline void phy_set_drvdata(struct phy *phy, void *data)
+{
+	dev_set_drvdata(&phy->dev, data);
+}
+
+static inline void *phy_get_drvdata(struct phy *phy)
+{
+	return dev_get_drvdata(&phy->dev);
+}
+
+static inline void phy_set_bus_width(struct phy *phy, int bus_width)
+{
+	phy->attrs.bus_width = bus_width;
+}
+
+#if IS_ENABLED(CONFIG_GENERIC_PHY)
+struct phy *phy_create(struct device *dev, struct device_node *node,
+		       const struct phy_ops *ops);
+struct phy *devm_phy_create(struct device *dev, struct device_node *node,
+			    const struct phy_ops *ops);
+void phy_destroy(struct phy *phy);
+void devm_phy_destroy(struct device *dev, struct phy *phy);
+
+struct phy_provider *
+__of_phy_provider_register(struct device *dev, struct device_node *children,
+			   struct module *owner,
+			   struct phy *(*of_xlate)(struct device *dev,
+						   const struct of_phandle_args *args));
+struct phy_provider *
+__devm_of_phy_provider_register(struct device *dev, struct device_node *children,
+				struct module *owner,
+				struct phy *(*of_xlate)(struct device *dev,
+							const struct of_phandle_args *args));
+void of_phy_provider_unregister(struct phy_provider *phy_provider);
+void devm_of_phy_provider_unregister(struct device *dev,
+				     struct phy_provider *phy_provider);
+int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
+void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
+struct phy *of_phy_simple_xlate(struct device *dev,
+				const struct of_phandle_args *args);
+#else
+static inline struct phy *phy_create(struct device *dev,
+				     struct device_node *node,
+				     const struct phy_ops *ops)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct phy *devm_phy_create(struct device *dev,
+					  struct device_node *node,
+					  const struct phy_ops *ops)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void phy_destroy(struct phy *phy)
+{
+}
+
+static inline void devm_phy_destroy(struct device *dev, struct phy *phy)
+{
+}
+
+static inline struct phy_provider *
+__of_phy_provider_register(struct device *dev, struct device_node *children,
+			   struct module *owner,
+			   struct phy *(*of_xlate)(struct device *dev,
+						   const struct of_phandle_args *args))
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct phy_provider *
+__devm_of_phy_provider_register(struct device *dev, struct device_node *children,
+				struct module *owner,
+				struct phy *(*of_xlate)(struct device *dev,
+							const struct of_phandle_args *args))
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void of_phy_provider_unregister(struct phy_provider *phy_provider)
+{
+}
+
+static inline void devm_of_phy_provider_unregister(struct device *dev,
+						   struct phy_provider *phy_provider)
+{
+}
+
+static inline int phy_create_lookup(struct phy *phy, const char *con_id,
+				    const char *dev_id)
+{
+	return 0;
+}
+
+static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
+				     const char *dev_id)
+{
+}
+
+static inline struct phy *of_phy_simple_xlate(struct device *dev,
+					      const struct of_phandle_args *args)
+{
+	return ERR_PTR(-ENOSYS);
+}
+#endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
+
+#endif /* __PHY_PROVIDER_H */
diff --git a/include/linux/phy/phy-props.h b/include/linux/phy/phy-props.h
new file mode 100644
index 000000000000..11f36738165f
--- /dev/null
+++ b/include/linux/phy/phy-props.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-provider.h -- Generic PHY properties
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+#ifndef __PHY_PROPS_H
+#define __PHY_PROPS_H
+
+#include <linux/phy/phy-dp.h>
+#include <linux/phy/phy-hdmi.h>
+#include <linux/phy/phy-lvds.h>
+#include <linux/phy/phy-mipi-dphy.h>
+
+enum phy_mode {
+	PHY_MODE_INVALID,
+	PHY_MODE_USB_HOST,
+	PHY_MODE_USB_HOST_LS,
+	PHY_MODE_USB_HOST_FS,
+	PHY_MODE_USB_HOST_HS,
+	PHY_MODE_USB_HOST_SS,
+	PHY_MODE_USB_DEVICE,
+	PHY_MODE_USB_DEVICE_LS,
+	PHY_MODE_USB_DEVICE_FS,
+	PHY_MODE_USB_DEVICE_HS,
+	PHY_MODE_USB_DEVICE_SS,
+	PHY_MODE_USB_OTG,
+	PHY_MODE_UFS_HS_A,
+	PHY_MODE_UFS_HS_B,
+	PHY_MODE_PCIE,
+	PHY_MODE_ETHERNET,
+	PHY_MODE_MIPI_DPHY,
+	PHY_MODE_SATA,
+	PHY_MODE_LVDS,
+	PHY_MODE_DP,
+	PHY_MODE_HDMI,
+};
+
+enum phy_media {
+	PHY_MEDIA_DEFAULT,
+	PHY_MEDIA_SR,
+	PHY_MEDIA_DAC,
+};
+
+enum phy_ufs_state {
+	PHY_UFS_HIBERN8_ENTER,
+	PHY_UFS_HIBERN8_EXIT,
+};
+
+union phy_notify {
+	enum phy_ufs_state ufs_state;
+};
+
+/**
+ * union phy_configure_opts - Opaque generic phy configuration
+ *
+ * @mipi_dphy:	Configuration set applicable for phys supporting
+ *		the MIPI_DPHY phy mode.
+ * @dp:		Configuration set applicable for phys supporting
+ *		the DisplayPort protocol.
+ * @lvds:	Configuration set applicable for phys supporting
+ *		the LVDS phy mode.
+ * @hdmi:	Configuration set applicable for phys supporting
+ *		the HDMI phy mode.
+ */
+union phy_configure_opts {
+	struct phy_configure_opts_mipi_dphy	mipi_dphy;
+	struct phy_configure_opts_dp		dp;
+	struct phy_configure_opts_lvds		lvds;
+	struct phy_configure_opts_hdmi		hdmi;
+};
+
+#endif /* __PHY_PROPS_H */
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 01af84f97608..d716e5e0584c 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -1,248 +1,38 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * phy.h -- generic phy header file
+ * phy.h -- Generic PHY consumer API
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
  *
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-#ifndef __DRIVERS_PHY_H
-#define __DRIVERS_PHY_H
+#ifndef __PHY_CONSUMER_H
+#define __PHY_CONSUMER_H
 
-#include <linux/err.h>
-#include <linux/of.h>
-#include <linux/device.h>
-#include <linux/pm_runtime.h>
-#include <linux/regulator/consumer.h>
+#include <linux/phy/phy-props.h>
 
-#include <linux/phy/phy-dp.h>
-#include <linux/phy/phy-hdmi.h>
-#include <linux/phy/phy-lvds.h>
-#include <linux/phy/phy-mipi-dphy.h>
+#include "../../../drivers/phy/phy-provider.h"
 
+struct device;
+struct device_node;
 struct phy;
 
-enum phy_mode {
-	PHY_MODE_INVALID,
-	PHY_MODE_USB_HOST,
-	PHY_MODE_USB_HOST_LS,
-	PHY_MODE_USB_HOST_FS,
-	PHY_MODE_USB_HOST_HS,
-	PHY_MODE_USB_HOST_SS,
-	PHY_MODE_USB_DEVICE,
-	PHY_MODE_USB_DEVICE_LS,
-	PHY_MODE_USB_DEVICE_FS,
-	PHY_MODE_USB_DEVICE_HS,
-	PHY_MODE_USB_DEVICE_SS,
-	PHY_MODE_USB_OTG,
-	PHY_MODE_UFS_HS_A,
-	PHY_MODE_UFS_HS_B,
-	PHY_MODE_PCIE,
-	PHY_MODE_ETHERNET,
-	PHY_MODE_MIPI_DPHY,
-	PHY_MODE_SATA,
-	PHY_MODE_LVDS,
-	PHY_MODE_DP,
-	PHY_MODE_HDMI,
-};
-
-enum phy_media {
-	PHY_MEDIA_DEFAULT,
-	PHY_MEDIA_SR,
-	PHY_MEDIA_DAC,
-};
-
-enum phy_ufs_state {
-	PHY_UFS_HIBERN8_ENTER,
-	PHY_UFS_HIBERN8_EXIT,
-};
-
-union phy_notify {
-	enum phy_ufs_state ufs_state;
-};
-
-/**
- * union phy_configure_opts - Opaque generic phy configuration
- *
- * @mipi_dphy:	Configuration set applicable for phys supporting
- *		the MIPI_DPHY phy mode.
- * @dp:		Configuration set applicable for phys supporting
- *		the DisplayPort protocol.
- * @lvds:	Configuration set applicable for phys supporting
- *		the LVDS phy mode.
- * @hdmi:	Configuration set applicable for phys supporting
- *		the HDMI phy mode.
- */
-union phy_configure_opts {
-	struct phy_configure_opts_mipi_dphy	mipi_dphy;
-	struct phy_configure_opts_dp		dp;
-	struct phy_configure_opts_lvds		lvds;
-	struct phy_configure_opts_hdmi		hdmi;
-};
-
-/**
- * struct phy_ops - set of function pointers for performing phy operations
- * @init: operation to be performed for initializing phy
- * @exit: operation to be performed while exiting
- * @power_on: powering on the phy
- * @power_off: powering off the phy
- * @set_mode: set the mode of the phy
- * @set_media: set the media type of the phy (optional)
- * @set_speed: set the speed of the phy (optional)
- * @reset: resetting the phy
- * @calibrate: calibrate the phy
- * @notify_phystate: notify and configure the phy for a particular state
- * @request_bus_width: request a different bus width for the phy
- * @release: ops to be performed while the consumer relinquishes the PHY
- * @owner: the module owner containing the ops
- */
-struct phy_ops {
-	int	(*init)(struct phy *phy);
-	int	(*exit)(struct phy *phy);
-	int	(*power_on)(struct phy *phy);
-	int	(*power_off)(struct phy *phy);
-	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
-	int	(*set_media)(struct phy *phy, enum phy_media media);
-	int	(*set_speed)(struct phy *phy, int speed);
-
-	/**
-	 * @configure:
-	 *
-	 * Optional.
-	 *
-	 * Used to change the PHY parameters. phy_init() must have
-	 * been called on the phy.
-	 *
-	 * Returns: 0 if successful, an negative error code otherwise
-	 */
-	int	(*configure)(struct phy *phy, union phy_configure_opts *opts);
-
-	/**
-	 * @validate:
-	 *
-	 * Optional.
-	 *
-	 * Used to check that the current set of parameters can be
-	 * handled by the phy. Implementations are free to tune the
-	 * parameters passed as arguments if needed by some
-	 * implementation detail or constraints. It must not change
-	 * any actual configuration of the PHY, so calling it as many
-	 * times as deemed fit by the consumer must have no side
-	 * effect.
-	 *
-	 * Returns: 0 if the configuration can be applied, an negative
-	 * error code otherwise
-	 */
-	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
-			    union phy_configure_opts *opts);
-	int	(*reset)(struct phy *phy);
-	int	(*calibrate)(struct phy *phy);
-
-	/* notify phy connect status change */
-	int	(*connect)(struct phy *phy, int port);
-	int	(*disconnect)(struct phy *phy, int port);
-
-	int	(*notify_phystate)(struct phy *phy, union phy_notify state);
-	int	(*request_bus_width)(struct phy *phy, int bus_width);
-	void	(*release)(struct phy *phy);
-	struct module *owner;
-};
-
-/**
- * struct phy_attrs - represents phy attributes
- * @bus_width: Data path width implemented by PHY
- * @max_link_rate: Maximum link rate supported by PHY (units to be decided by producer and consumer)
- * @mode: PHY mode
- */
-struct phy_attrs {
-	u32			bus_width;
-	u32			max_link_rate;
-	enum phy_mode		mode;
-};
-
-/**
- * struct phy - represents the phy device
- * @dev: phy device
- * @id: id of the phy device
- * @ops: function pointers for performing phy operations
- * @mutex: mutex to protect phy_ops
- * @lockdep_key: lockdep information for this mutex
- * @init_count: used to protect when the PHY is used by multiple consumers
- * @power_count: used to protect when the PHY is used by multiple consumers
- * @attrs: used to specify PHY specific attributes
- * @pwr: power regulator associated with the phy
- * @debugfs: debugfs directory
- */
-struct phy {
-	struct device		dev;
-	int			id;
-	const struct phy_ops	*ops;
-	struct mutex		mutex;
-	struct lock_class_key	lockdep_key;
-	int			init_count;
-	int			power_count;
-	struct phy_attrs	attrs;
-	struct regulator	*pwr;
-	struct dentry		*debugfs;
-};
-
-/**
- * struct phy_provider - represents the phy provider
- * @dev: phy provider device
- * @children: can be used to override the default (dev->of_node) child node
- * @owner: the module owner having of_xlate
- * @list: to maintain a linked list of PHY providers
- * @of_xlate: function pointer to obtain phy instance from phy pointer
- */
-struct phy_provider {
-	struct device		*dev;
-	struct device_node	*children;
-	struct module		*owner;
-	struct list_head	list;
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args);
-};
-
-/**
- * struct phy_lookup - PHY association in list of phys managed by the phy driver
- * @node: list node
- * @dev_id: the device of the association
- * @con_id: connection ID string on device
- * @phy: the phy of the association
- */
-struct phy_lookup {
-	struct list_head node;
-	const char *dev_id;
-	const char *con_id;
-	struct phy *phy;
-};
-
-#define	to_phy(a)	(container_of((a), struct phy, dev))
-
-#define	of_phy_provider_register(dev, xlate)	\
-	__of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
-
-#define	devm_of_phy_provider_register(dev, xlate)	\
-	__devm_of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
-
-#define of_phy_provider_register_full(dev, children, xlate) \
-	__of_phy_provider_register(dev, children, THIS_MODULE, xlate)
-
-#define devm_of_phy_provider_register_full(dev, children, xlate) \
-	__devm_of_phy_provider_register(dev, children, THIS_MODULE, xlate)
-
-static inline void phy_set_drvdata(struct phy *phy, void *data)
-{
-	dev_set_drvdata(&phy->dev, data);
-}
-
-static inline void *phy_get_drvdata(struct phy *phy)
-{
-	return dev_get_drvdata(&phy->dev);
-}
-
 #if IS_ENABLED(CONFIG_GENERIC_PHY)
+struct phy *phy_get(struct device *dev, const char *string);
+struct phy *devm_phy_get(struct device *dev, const char *string);
+struct phy *devm_phy_optional_get(struct device *dev, const char *string);
+struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
+			    const char *con_id);
+struct phy *devm_of_phy_optional_get(struct device *dev, struct device_node *np,
+				     const char *con_id);
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index);
+void of_phy_put(struct phy *phy);
+void phy_put(struct device *dev, struct phy *phy);
+void devm_phy_put(struct device *dev, struct phy *phy);
+struct phy *of_phy_get(struct device_node *np, const char *con_id);
+
 int phy_pm_runtime_get(struct phy *phy);
 int phy_pm_runtime_get_sync(struct phy *phy);
 void phy_pm_runtime_put(struct phy *phy);
@@ -259,60 +49,69 @@ int phy_set_speed(struct phy *phy, int speed);
 int phy_configure(struct phy *phy, union phy_configure_opts *opts);
 int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 		 union phy_configure_opts *opts);
-
-static inline enum phy_mode phy_get_mode(struct phy *phy)
-{
-	return phy->attrs.mode;
-}
+enum phy_mode phy_get_mode(struct phy *phy);
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
 int phy_notify_connect(struct phy *phy, int port);
 int phy_notify_disconnect(struct phy *phy, int port);
 int phy_notify_state(struct phy *phy, union phy_notify state);
-static inline int phy_get_bus_width(struct phy *phy)
+int phy_get_bus_width(struct phy *phy);
+int phy_request_bus_width(struct phy *phy, int bus_width);
+#else
+static inline struct phy *phy_get(struct device *dev, const char *string)
 {
-	return phy->attrs.bus_width;
+	return ERR_PTR(-ENOSYS);
 }
-static inline void phy_set_bus_width(struct phy *phy, int bus_width)
+
+static inline struct phy *devm_phy_get(struct device *dev, const char *string)
 {
-	phy->attrs.bus_width = bus_width;
+	return ERR_PTR(-ENOSYS);
 }
-int phy_request_bus_width(struct phy *phy, int bus_width);
-struct phy *phy_get(struct device *dev, const char *string);
-struct phy *devm_phy_get(struct device *dev, const char *string);
-struct phy *devm_phy_optional_get(struct device *dev, const char *string);
-struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
-			    const char *con_id);
-struct phy *devm_of_phy_optional_get(struct device *dev, struct device_node *np,
-				     const char *con_id);
-struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
-				     int index);
-void of_phy_put(struct phy *phy);
-void phy_put(struct device *dev, struct phy *phy);
-void devm_phy_put(struct device *dev, struct phy *phy);
-struct phy *of_phy_get(struct device_node *np, const char *con_id);
-struct phy *of_phy_simple_xlate(struct device *dev,
-				const struct of_phandle_args *args);
-struct phy *phy_create(struct device *dev, struct device_node *node,
-		       const struct phy_ops *ops);
-struct phy *devm_phy_create(struct device *dev, struct device_node *node,
-			    const struct phy_ops *ops);
-void phy_destroy(struct phy *phy);
-void devm_phy_destroy(struct device *dev, struct phy *phy);
-struct phy_provider *__of_phy_provider_register(struct device *dev,
-	struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args));
-struct phy_provider *__devm_of_phy_provider_register(struct device *dev,
-	struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args));
-void of_phy_provider_unregister(struct phy_provider *phy_provider);
-void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider);
-int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
-void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
-#else
+
+static inline struct phy *devm_phy_optional_get(struct device *dev,
+						const char *string)
+{
+	return NULL;
+}
+
+static inline struct phy *devm_of_phy_get(struct device *dev,
+					  struct device_node *np,
+					  const char *con_id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct phy *devm_of_phy_optional_get(struct device *dev,
+						   struct device_node *np,
+						   const char *con_id)
+{
+	return NULL;
+}
+
+static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
+						   struct device_node *np,
+						   int index)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void of_phy_put(struct phy *phy)
+{
+}
+
+static inline void phy_put(struct device *dev, struct phy *phy)
+{
+}
+
+static inline void devm_phy_put(struct device *dev, struct phy *phy)
+{
+}
+
+static inline struct phy *of_phy_get(struct device_node *np, const char *con_id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline int phy_pm_runtime_get(struct phy *phy)
 {
 	if (!phy)
@@ -391,61 +190,59 @@ static inline int phy_set_speed(struct phy *phy, int speed)
 	return -ENODEV;
 }
 
-static inline enum phy_mode phy_get_mode(struct phy *phy)
-{
-	return PHY_MODE_INVALID;
-}
-
-static inline int phy_reset(struct phy *phy)
+static inline int phy_configure(struct phy *phy,
+				union phy_configure_opts *opts)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_calibrate(struct phy *phy)
+static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
+			       union phy_configure_opts *opts)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_notify_connect(struct phy *phy, int index)
+static inline enum phy_mode phy_get_mode(struct phy *phy)
+{
+	return PHY_MODE_INVALID;
+}
+
+static inline int phy_reset(struct phy *phy)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_notify_disconnect(struct phy *phy, int index)
+static inline int phy_calibrate(struct phy *phy)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_notify_state(struct phy *phy, union phy_notify state)
+static inline int phy_notify_connect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_configure(struct phy *phy,
-				union phy_configure_opts *opts)
+static inline int phy_notify_disconnect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
-
 	return -ENOSYS;
 }
 
-static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
-			       union phy_configure_opts *opts)
+static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 {
 	if (!phy)
 		return 0;
-
 	return -ENOSYS;
 }
 
@@ -454,11 +251,6 @@ static inline int phy_get_bus_width(struct phy *phy)
 	return -ENOSYS;
 }
 
-static inline void phy_set_bus_width(struct phy *phy, int bus_width)
-{
-	return;
-}
-
 static inline int phy_request_bus_width(struct phy *phy, int bus_width)
 {
 	if (!phy)
@@ -466,120 +258,6 @@ static inline int phy_request_bus_width(struct phy *phy, int bus_width)
 
 	return -ENOSYS;
 }
+#endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
 
-static inline struct phy *phy_get(struct device *dev, const char *string)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_phy_get(struct device *dev, const char *string)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_phy_optional_get(struct device *dev,
-						const char *string)
-{
-	return NULL;
-}
-
-static inline struct phy *devm_of_phy_get(struct device *dev,
-					  struct device_node *np,
-					  const char *con_id)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_of_phy_optional_get(struct device *dev,
-						   struct device_node *np,
-						   const char *con_id)
-{
-	return NULL;
-}
-
-static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
-						   struct device_node *np,
-						   int index)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void of_phy_put(struct phy *phy)
-{
-}
-
-static inline void phy_put(struct device *dev, struct phy *phy)
-{
-}
-
-static inline void devm_phy_put(struct device *dev, struct phy *phy)
-{
-}
-
-static inline struct phy *of_phy_get(struct device_node *np, const char *con_id)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *of_phy_simple_xlate(struct device *dev,
-					      const struct of_phandle_args *args)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *phy_create(struct device *dev,
-				     struct device_node *node,
-				     const struct phy_ops *ops)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_phy_create(struct device *dev,
-					  struct device_node *node,
-					  const struct phy_ops *ops)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void phy_destroy(struct phy *phy)
-{
-}
-
-static inline void devm_phy_destroy(struct device *dev, struct phy *phy)
-{
-}
-
-static inline struct phy_provider *__of_phy_provider_register(
-	struct device *dev, struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args))
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy_provider *__devm_of_phy_provider_register(struct device
-	*dev, struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args))
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void of_phy_provider_unregister(struct phy_provider *phy_provider)
-{
-}
-
-static inline void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider)
-{
-}
-static inline int
-phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id)
-{
-	return 0;
-}
-static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
-				     const char *dev_id) { }
-#endif
-
-#endif /* __DRIVERS_PHY_H */
+#endif /* __PHY_CONSUMER_H */
-- 
2.34.1


