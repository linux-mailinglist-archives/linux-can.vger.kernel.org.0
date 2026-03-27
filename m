Return-Path: <linux-can+bounces-7282-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELyDKJjTxmlzPAUAu9opvQ
	(envelope-from <linux-can+bounces-7282-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:59:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C7349900
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C9E3307D9AC
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE943A7F74;
	Fri, 27 Mar 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VQF/CMYP"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C743A6418;
	Fri, 27 Mar 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637357; cv=fail; b=JFRxy8AntNygie4oB09WEMnHfdd22zYnxnRHcNYwnPhnILTHvRGNNHLVjXEDgDWsKDQsGvO39UEeNSrr/QyY7CpkGqTDahlZGOOoIS6Xan34Gty0Z4qwQS3Jb/5BWu0gUS/oZuxRTZXiRTJfA4EFV4O6Y3xxZZWv2Y9YyhClgJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637357; c=relaxed/simple;
	bh=fgtC5NlrTJvPFKtgRJ9BWfZeiqZ80RAIN0O+LigVRgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+p2xRRCTrJlh7dgtLOtPtwt8zEom9htrVj1/y6AWV0vXBlMuAA4bnLn2dPFG15/3o5lcHElt3xmsovBaK1M3+ZWkbfjH7boi1EUZ/Q/l6wsBFla2ANzO0Fi/AjtCkn/cmO6XqVVNp2F4rYjg7i2llGYgUCJdMu/HYIBHA8VNvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VQF/CMYP; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAetS5MGH8i7GeMSrOtCj9vRL92Y37ATFVc4Xd44iLJJ+xgtLQomMvLfnKrFxof9NRGyS+qzj3GdcFXMKJ3HQZ5TKrCrhbAPfCJzZPwv2YU5TtcCc7wD8RRL3wKJH8lFK2+UxKURDve2ndR1f1NMUNZMD0/TYlkIBHv/80rhfYibfDE2vpaNoeLcSOCouN9crgfVkEP9JVC0aSQOeO8tY5v9aEQPSayjxp4zoyAQsNKrIhowbHJWXDnocUN7IFPbRng3XIXBwpVVlJ6IMH0q+CC/Dq7YK1kc2M4pOrcdLX2IkRMCA91NOeipukj7BjsM6PpdPtFbzzU54lUdj43QUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4omQoUIAkwi7qvWK8SFUrFNMdz0VCDLujfrSPPBAPV4=;
 b=XVl1dGBtPrlgupl/tdtTDmSxImiSmmTUHLN51YCx1DAFD+CisnkFIL4nn0kPo6zp5P7nluDrQOP0SONuvzoFKc+wdrtGNwrCEIE6SJcgIoPiL3563jaPXvdt8SXak7gi7CvgcJKwIMk+fjABOTN+h2hPQkLgpHMOyijFyBr0ZE4X2YQ3TepiMMCSixmqLA2zKZSIMiovInXYjR6em4izyDKtm/ToE30zkO2w9ADnvysSqbxcrxNZmx7N7nFoOV0ZooXrTdEtUodd7sLaSolis76EzGZIMjHZijkZbXrszXn/n8ppPyc4MH0T9rJClXnQs9mWyd2W5R1fq/LNCmtNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4omQoUIAkwi7qvWK8SFUrFNMdz0VCDLujfrSPPBAPV4=;
 b=VQF/CMYPggx7IGAtENvTmu9TkY488Xo0fbuYUPuN5nK8YDamuiKFce/rdVvktqLqhNmq5mqAMeUaS35mU0UFjN+l2N8JbRUQ74EFloUchLzm/hCW1YP1iPeycWm+CnbAiVvvFyzgQHqA1Oh6ubRz9AAP1Xhrtprio2Wp/wd+tvUf6FGXTfTxmbFT1Y2s3zCJeW74HytuO9/u+ZE1zPNJG08At1648MDEs+8O2Qhk1Td9HqaOmb88Ff/mVXRvXJ80+URh7AtoZR5AwElUbONf+PWlry90ry1ulhGLUQ10YkMnxZzIfjRvl8KQw9bzg3yx3qD7kd6P+qr5IzQHB/M11w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:07 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:07 +0000
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
Subject: [PATCH v6 phy-next 16/28] phy: move provider API out of public <linux/phy/phy.h>
Date: Fri, 27 Mar 2026 20:46:54 +0200
Message-ID: <20260327184706.1600329-17-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0004.eurprd08.prod.outlook.com
 (2603:10a6:803:104::17) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4891af-1f86-446d-bd6b-08de8c31868c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|13003099007|56012099003|18092099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 xO6SmsIg8MDEWj2pNNroJsRlGO2OkqD88ewcN9PLxKjjqlOtwCi6ssg31l+GwapQTqb7ffnRJsmseazv4oUUZGcw1rNiiY1vba26LH6Rynb6Df2KyCzCZJ3hR0ZcFPwsBgCsrNdQNz4Z4X+Rn6zbQ1GEl6woNWARAlMow5S2nYUSnGwV1YMin3DDZlEZmE+rFunyNZhJJ+XmQxe//dDVode5YT3CiXRF+ZhZMn8QGZ7CSKweYLNPlVXrVHXjRsrRdmzxPoVXpva4GNwk0W2/pCr7FSS77RtiQgXQq5WAtiBMnQHuweEGM4ZjSAPYNxbpS+Df5oHkTi2XX+aQe8C96E4EgziHVnnIjX3AsGx7WDRlYZ3LkKnuOOmICaERJHIm27AclvPYof6uBjkuysnEBJwDlVWaHY/K2R9syhWlO0jSKgxgbWktqbqz8CLtQlSd13/P3h5Yyd1tmYzfJKVhx2O/b3uE8AlmH1Crxgowje4AR3Ks0rDpg2lAAy8PuEc5mddRXewWZZDBe2koW0DGI2WHrmA7wUMJ1ah1dzWiWFpwTdJqYloataRVDvM4hjGpxYksV2hF8gPHJCLOcLNGrEpDENEAOAwgV6JcGGneXtUeszWb40MuSfg4L1VnwALi9Coa+3BNb+HDPrR2YzVVbE1kqcLmTtwdm+irRZnh7KkrAVloJrqMBPCqugMNrN7M
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(13003099007)(56012099003)(18092099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eGVTZDMyYkYrajNkMEg5dFZ6eWNDY1ZlWkxSRGM1TVJnRHQySTRRN0RBUkNF?=
 =?utf-8?B?MW5tTHRwbUVDa1hyU3JzNGdUTEhhWmtqYzFqeHVXZHQ3azMwb3gyTDk2bnJV?=
 =?utf-8?B?ZUEyLzA2Q0xtRUpJTnV4WmFSTWVham5CVWxDZDBqblI1bUVWYjhVTlJRL1pj?=
 =?utf-8?B?MS9wM283amNhT2RLUU1ONjVhTDdGcGFQNnVabUlTV3FIREFVM0p5L0M4Z0hH?=
 =?utf-8?B?TW8vTExUN0QxZDJjb3B0NkdUeVoxUS9EQ2NvTGx2TERUbWRudG9Bdk00cHlt?=
 =?utf-8?B?RHBGWDVmTURwa0VvZW1ueUNGRFFLcnRsQ09EZzhZeXFoZXpqWDlIWXI0b1VU?=
 =?utf-8?B?VlZPUU44NWJ5WDdiM0V6Vm11NUJZSXJyM2UwdEJYOWhMcUtOc1FLc2lIMFB3?=
 =?utf-8?B?bU9iQ2ZCNkRBaHczdGZ2b21VTDRLMDhqeWFnY3lvQkNmdStXMVBuUlRzeTFD?=
 =?utf-8?B?WWk3Mnp3aGFkVTlXTjlxRmhkTUVyVnNucHZmcHJIRHVodzZ1dlRWUUE1ajlI?=
 =?utf-8?B?UXZuS0dlT2dUZTJKanNOSWt5VFdYTW1NanA1TmdzclhGYmhKbmxjdUZDUnRI?=
 =?utf-8?B?LzVTdE9YcGlhN29oNkhKNUJDd3pXYVh5SVJaa2xVNWxsOWFzVGI0YWRWMXpx?=
 =?utf-8?B?bmVlYVJieCtLMzkyd0t2SXBnRzRXdDhvUWZLVU04bDhYOU4rQ0xFdFhaYnl1?=
 =?utf-8?B?dElBd1lCSEdFd3ZsRm9VQ1ozcTRsT2RhbStYdXVlTHNpWHVyUmxXclk0eUZ1?=
 =?utf-8?B?d0VvN2FicGU3VTJIUUVwazJOYTgzblhCdE8xdlVvdTkycXU3amsxaE9ZV2gr?=
 =?utf-8?B?czZNbHE3ZW40NTU3aWljQUl5ejI5SWdyV1FSQ1ZLYU5GL2w0ZkNwVVJDTy84?=
 =?utf-8?B?UFJqUmlmWW91OVJ0alRYKzlKOGxycFRvQVB6bC9SREFIbGpDR3VhRnl6alF3?=
 =?utf-8?B?UlhzQ3M1dmlTbWZCcGRZdHEvdytnTlN0dFdZUmhZWGl1R1ZQL3luY3ZiZE5H?=
 =?utf-8?B?YktubFFmUGV1MTFpeTluZE43R2JwU1QxY0UxaDVyN0t1cVZSaXUxeVJHTEhT?=
 =?utf-8?B?OGJhMmdoamNyOHBhak4rL21zQmxEdGwwMG1oT1FEWHRPeG8rSWJ4OUE3UlRF?=
 =?utf-8?B?MXVqRC80Q0tKdGhzdW94Mmk0YkthZnFOM2RMZUdHK2gvNUVidzk4bnhTc1NX?=
 =?utf-8?B?OFF6eE95Rm5SOHZwb2lJanduVW1xSFJ4Wjc2WUxxejhqNkhibVJCNlp2YWh4?=
 =?utf-8?B?NjZIOU1Fam54OHVkQ09JSFhtQ1RidTR0R1BFWCtiazEvaXFEcS9YMVRUZE1z?=
 =?utf-8?B?RytrbmZITnFYWTAvdHpQNGpJWENqekgwS3VSNVZrdjBoVlhuSk91bFRTeFpq?=
 =?utf-8?B?TDRyN0hoN0Jic2FIVmYxRkRGSDBTOGNQaWxDbndiMEM1N1pTcUxYRU05WEl0?=
 =?utf-8?B?NllOd2crRDVKUEZ3N3U1SUZ1Z3FkWmF5SU5PRVh5VUxQSzRYWDYvY04xZ05R?=
 =?utf-8?B?Zk9JWk8xQ1lTVURUcjJVNk9MZ21iUlNGWWQvOHRIUEg1LzNkNmU3YjlFU2wr?=
 =?utf-8?B?aVJPNG9rSFZoOWM5a1I5SmNUMTdMMWdBY3NjWXJtN3BlMDU2bFdYVHBCSUdG?=
 =?utf-8?B?bW9FQ3o5VldFMDNlQ2RvcEV3dUZkd2pDY3N5NGQ1ZTVJc2x3WExQelpkSWpi?=
 =?utf-8?B?NUNUL1Byd2t1OUs0OHdyL1VpRXpiQ1ZBRkJDdkRsNTdWK0dmVkt2bUZTUkpy?=
 =?utf-8?B?cE91Sk01T0ZNdGZPQnBzc1l1V1lPUnBtbzZtWUtXMTZPL3hoREF3MDhaZDdX?=
 =?utf-8?B?V2hXcjlWSHlQRHNBRzhuWWc0OUF5cmNYSzE3U0xvaVQzQVNuS0RBRjlPeHlQ?=
 =?utf-8?B?SW55UWR2anJISjBTNUhCcE1SdC9SSG9JWWtaR2JpbzArZ0lpRzlrMy9Gd1F0?=
 =?utf-8?B?NHlkZFRlTXBkbUpMSkVZL1J3Sm1WSEZnUThzdEltWWdxbGpVdnhBU3FOWUgw?=
 =?utf-8?B?bWx4NkxhSU1qdXpUUE5VcGZGZU5yV2Q2RDJONUFhTWhYMStsSm1CZmxSczVJ?=
 =?utf-8?B?MmpLUEZpZ241d0szaTB1OVQyQXBjdWV3MVVYWTJ5WEdaVzdKQTQ1YW93bkZM?=
 =?utf-8?B?ZEM4MHY0aTRpWDIzRzJBMXRvV29EbGxFd2g2ZEFqdTFQNHBvRVJZTVJhZmxM?=
 =?utf-8?B?ZlNWTGozdm81bjAxU2l3ekZlc29HYU9pREJEOUczaUg1M0V6SFpvd0I5UE92?=
 =?utf-8?B?YUZWTDE5eUtrZGdiOGxBNlJ1bjR6UjNlaUpzVElTQWJJRzBqTUE2Q3lsQ2ho?=
 =?utf-8?B?bCttbGNzZzRjb1FJMzFrVVhvUzdUUW9mbGlEMlFKOEltN1JyZStjTmYvbEFD?=
 =?utf-8?Q?12dU1TOqVQ6owTZAqKJbcyeP3Id4Tiqha6PJEsdnUUdVQ?=
X-MS-Exchange-AntiSpam-MessageData-1: ElkcvNj1+8cKhit/hP7+5fAzw1ggsEYoQPI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4891af-1f86-446d-bd6b-08de8c31868c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:07.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtbqHVhXj2Nd2mN0DTsMLLRQIhY0TvaebVnbTBJb9PlJTbL9tFxBFEFpi+JdYXhuiVQjJ2ERK9dvpCgfknKhQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
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
	TAGGED_FROM(0.00)[bounces-7282-lists,linux-can=lfdr.de];
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
X-Rspamd-Queue-Id: 3D1C7349900
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The major goal is to hide the contents of struct phy from consumer
drivers.

The idea with "phy-props.h" is that both consumers and providers make
use of some data types. So both headers include "phy-props.h".

Some slight points of contention.

1. phy_set_bus_width(): Vinod explains that despite the current caller
   situation (9 providers, 1 consumer), it is a consumer API function.

   The use case is that the controller (for example UFS) may have
   limitations and should set the expected lanes to be used and width on
   those lanes. A number of Generic PHYs can support multiple lanes and
   multiple width so this is way for controller telling I am using this
   configuration.

2. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
   We do have 3 PHY providers outside of drivers/phy/:

   drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
   drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
   drivers/pinctrl/tegra/pinctrl-tegra-xusb.c

   but the practice is not encouraged, and with time, these should be
   moved to the subsystem. This is not something that I can do now.

3. We can no longer tolerate static inline helpers. Allowing these would
   make it impossible to hide the struct phy definition from consumers.
   I've made phy_get_mode(), phy_get_bus_width(), phy_set_bus_width()
   exported symbols in drivers/phy/phy-core.c.

4. This is not a change without side effects. In the transition we are
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

v5->v6:
- expand CC list to inform maintainers of touched drivers that the API
  is becoming unavailable
v2->v5: none
v1->v2:
- collect tag
- fix path to phy-provider.h
- update commit message with the 4th point of contention
---
 drivers/phy/phy-core.c        |  34 +++
 drivers/phy/phy-provider.h    | 256 +++++++++++++++++
 include/linux/phy/phy-props.h |  75 +++++
 include/linux/phy/phy.h       | 497 +++++++---------------------------
 4 files changed, 456 insertions(+), 406 deletions(-)
 create mode 100644 drivers/phy/phy-provider.h
 create mode 100644 include/linux/phy/phy-props.h

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53..a1aff00fba7c 100644
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
@@ -606,6 +622,24 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
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
+void phy_set_bus_width(struct phy *phy, int bus_width)
+{
+	phy->attrs.bus_width = bus_width;
+}
+EXPORT_SYMBOL_GPL(phy_set_bus_width);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/drivers/phy/phy-provider.h b/drivers/phy/phy-provider.h
new file mode 100644
index 000000000000..0637278a2d8d
--- /dev/null
+++ b/drivers/phy/phy-provider.h
@@ -0,0 +1,256 @@
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
index ea47975e288a..f208edd25afe 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -1,246 +1,38 @@
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
@@ -257,59 +49,69 @@ int phy_set_speed(struct phy *phy, int speed);
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
+void phy_set_bus_width(struct phy *phy, int bus_width);
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
@@ -388,61 +190,59 @@ static inline int phy_set_speed(struct phy *phy, int speed)
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
 
@@ -453,122 +253,7 @@ static inline int phy_get_bus_width(struct phy *phy)
 
 static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
-	return;
-}
-
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
 }
-static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
-				     const char *dev_id) { }
-#endif
+#endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
 
-#endif /* __DRIVERS_PHY_H */
+#endif /* __PHY_CONSUMER_H */
-- 
2.43.0


