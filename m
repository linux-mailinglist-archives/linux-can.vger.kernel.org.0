Return-Path: <linux-can+bounces-7169-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN5CJKJ5vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7169-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:33:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746692D3082
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65458301689B
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F4F407566;
	Thu, 19 Mar 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="naJabn6C"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A167402BA6;
	Thu, 19 Mar 2026 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959576; cv=fail; b=T/R4wj9/rvCHPIG+4cAFKQ8xkQ9JADxygdHLIbcJSLu4e8zsr5M6/ODVWV6vCVyjyPESxbe2f1n+Th1d3PRtAyYU6+yAP6ZHYOek+7J90H9ebDsqLMUUTJNPzM2YezcpJopNQQugWWejCOnppyolkVr4T/DwYvUFdm6sCt5pS2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959576; c=relaxed/simple;
	bh=WwzhUMim3dx/UnIN+/qrU2b0JhhIYhtUazaUxEhYGIg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pJ8XkR+nqYmC9i3tdRwWhneIrMzaf1YjW8SSpSxxRPzqIW/gJw3Qr5QWEq3iTTfgmicBFfaGOfefJF6bU3QHybdzp3f5Hv9Dyt84vfq9YYLuaSOZvBCnSC3YLFAlVkW+rVJ575Uxcrpv2akOQwUrOlYCbWKZzvJxetZTChRAKRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=naJabn6C; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+4y+jlnZiJbrPq1uGBtzBHFbrgiomWUIzuHJ2y/J+bdjxgMG5LsHmrSz4GHt42SB13HWxpPxb96gpNa3Fd8F9UQ7B616ARPPMk+yO0ZRk9RPDorWxA2G0uchIpmJ/xxQptDt32ZhxlX8LizLTlbjvbN/sXUFp1YYUVluR33FLa0h30o4URq3owNvc7/ijV3RkxTqoyHrbYrfYMBwYTBxXzejCNdFDh3okYevMyleNafxnb2BtzSar24QjF7ALpEEJAJOu6C2hw2uziQm/YAQ2ywgsHEYZGr7KLc1KFuDrd2PGSYhYvfAH6hJbHK6/C4opM8hfqMAO4yzPJ7X65FcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KUh28j13blQ2LrfFK0ASncGGRnvBRaxrnslTSgJHjk=;
 b=TUIWLVseaVhk50UWLYnIx4IbAmtNmOmVp04gpfXshDAph+vin3kh9Rco0/1dBmnyzHpPup5nWAX9CIj2EPZ6tJGgJ26a5TTXo8kv239RICr/u3Be1MlY9VvjvJoF+QOU0UfS7Spz/AAG3MYyjV883c3BUh9YS7i2eH8pH36yK4CeXs+l3EhnN0izQgNQ4IOhS6BhK/TEgRo0cZJteR/UjQehwjxeSImh8F5V1OzYnWKP7tf6BMm+pvj2cN0fo5vPU7SwmoA6KRVD9Uxh/usSyUODNxK02RpFJLHtKV77TqPr9KICP1W5hv8NvW8fqMXoFb8KaY/PbKEGIqgVU8yEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KUh28j13blQ2LrfFK0ASncGGRnvBRaxrnslTSgJHjk=;
 b=naJabn6C0Cx0F/ktsniQKZgQnr9PaZc/lBbbpIzvgfXztUwicKf1csEqP5EXBetiARn1JJFTfkpNQWcxzDch9UGWwsbPGd0eM9zEiUekjMGaxL2OCad/9PjGkFhdHA6uzT2ggQcdro1iu4xEfNzr7ZTDCs8IjcEoM+Lb04r/capj7szVJKUzpBi7YIEL81BZzJPnoSZMlrNIqr7KrcdNMtBMjBm2p3K8ZEmZQeY68m+pRJncWkTycjJJ+bo6QuHfr3COONJ927CWXa2KXZrvNNJ3hFWSZ1HzE/roQlAoz6+p2+zTyB8NNG/X2NPGs1PY0wrRkaU8gt5wtCldoq7rWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:37 +0000
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
	Mathias Nyman <mathias.nyman@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Dege <michael.dege@renesas.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Cassel <cassel@kernel.org>,
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
Subject: [PATCH v5 phy-next 00/27] Split Generic PHY consumer and provider API
Date: Fri, 20 Mar 2026 00:32:14 +0200
Message-ID: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: b299a9c7-ba92-4e7a-f615-08de86076c82
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 pOx8kkKU8MaGVcRQAYffCjh9jmGtpVJtF/0j/8t5pEIQtrkn13usfPP9JVTkoCauK93n/Tw1mw6u7gBFmc+Q7i8QyjsaGUgoJONJ0W2hOWCq5lB7Ct4YOqLMAZrs2LCPY967P9c4gkD5I2XbVL0uFRrYTtvSy6qanRsxp+27L9G4FxV4Q02k2SNVq2CxiLLPc9wg4X0Z0Ld6f/9QGZgFAer0Y+DvXENtZl5C9u7n4t9Gb6WMwR8J7i48dRznfrSULe2rwSu+ZF8ioUNrf32AAyCmHfOeA/5kMoCms8ATbPZ6YYoITEFyYEWvh+3pxqNBUAC651ehkysJNiujA+GVb6VS5XqFyrGdfThH4VkO7locoj/+WLfumAjBYFiPcW9gQHjxAclCRCKcb+99YPmIjke0tTluK81IFkasdergWlkTLhCToslKuwVPJ3KR28o/QDdgVt9n85uvml43yfa9x1RbIwoUqc5pPLQv3XoX5iu9EWnmne5k0X/urnteYNwRdTj3xn7vp1xtPfCLsHdhr7q+f7L3aezD5d81wxWVR7dHRGKQacGIoVrm6VEgZD9TcuqiQm6rx0oTF1ZvU5k2PH2bcNzdG6uxZmEBGCrWHN1BjryaSyyeu9fnNSVrDk43FD35k7G741WTL8dU8rlG/vjgiC+QkyRwkJTv4TDEQrPHjvL00wZcYPHpCmPeZAJq
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TUc0bTNLNVhVUTZ4QXJuaTh2cjhjQ1AyM2RwcS9KWE8vQUdHL3NadXJzUWgz?=
 =?utf-8?B?TmliOFdoRGlxU3BGbytIZlRpQVhrZW01NlVGc0lXczE0aTdldmFIdyttYWhQ?=
 =?utf-8?B?WXRGRzNneTFYNGd4VzRkVWw3eEN0UEJ5cXFoVEJBNmdDeUJrRjArWkh4MHJM?=
 =?utf-8?B?Q09pUFFNTDFyRXQwaDduM2ZJSEtsM2F5ME9QWWk4RXdoandBVERQSkVqUTlq?=
 =?utf-8?B?YnB6S0NlQkYvSDBXNXVDNUpPbVZkRktLdDJuUElldjZ5cEpLRUpUaUd5SVRx?=
 =?utf-8?B?TkFmQlpvLzZYYyt4U3pwaDljbWF2NnJxSWtxY0NhY2ViNkVrdDNCSy9VNDIv?=
 =?utf-8?B?OVZCWEsvTHhrOGVjUW9rWGRDZk5MVDlhL2VmdDY1MUw1ZW00K1J4LzF1UzIv?=
 =?utf-8?B?K0kzOHZNc2hEMFJMUVY2aExpV2o1QlhmMHp3ZGxNdjByWWsvQk0vbGFoRTB4?=
 =?utf-8?B?RUtUUDN1UzFXUDJCSVdvZ1VPdU5zNU0xYzVXNVNLWU04RTh5V1M0bzI4ZGQv?=
 =?utf-8?B?dmhlQ1dOY3RCY2ZLYUR3bktOejRsMkUvU2V4ZWtUUlU3d0NHZlQyL004YXJo?=
 =?utf-8?B?WEZNWk9pMTdVTFFSZU8yS1VGd3RNUzhyM2g0ZmpvcjRidlluRUtPcFZoUE5M?=
 =?utf-8?B?SkNpcjhEc290S0laQjNldW1qR0NlTGRab1d3cXhrckYvam5TYWh1N2UzZndh?=
 =?utf-8?B?blIxZlZYUVdQR2xkNldkK25pbnI1T3VRczZGVHZxY0NrYi9NL0RCVGZNWTRr?=
 =?utf-8?B?ZS9aemc3V0x1Wmg4TDJYK3htS2VqSXpuWGJSOUdJbnBCSTN4WUVWV3JxOEFE?=
 =?utf-8?B?VlhMU25ESk9yd0tZRU81ZkQ4OUZUakRJeHk4a1RWMUlVdjQ0dXAxbVlvd1Fn?=
 =?utf-8?B?VXBKZzYyaUVYUGhBNStPOEh4alBVbHdwa3I4anRuZndMTHBxWU90cTRGcFRx?=
 =?utf-8?B?a3c1V0pzaHdqeGNPaUNibjBZSTJ2alVZOEtucEU2UVFkUHF4ek9qTDBoQm9Y?=
 =?utf-8?B?aW5remJUVkcwTUpOMFRHVlZ5VzI2YXNFZ3dzMEJoRUE0aVEvaFJ1SHNHSWFu?=
 =?utf-8?B?YVBzNTJPQU52Q2dBa0l3QmxmdjVoeVovUWNOUklxU0syZ2d4N2J5ZUNZOFI3?=
 =?utf-8?B?WU9maC9rNnc0ems4aUZ3eGxLTzFhVWlzKzJHUUtMTXRCeXNxRUo4WWdubHo5?=
 =?utf-8?B?dDZJcWVudjNsRkoxMU52SDdHQjFlM29ldU1mU3pqUGQ3R3ZHZHpIeEVyS0pC?=
 =?utf-8?B?L212NkhkU3ltNk1FZTB4Q3BDRHFiYkx2a0dFVFEvL0hpUW5idGRITXIzVUZR?=
 =?utf-8?B?c0ZERytFRUszNnR0ckxERDNzZXZxTTVLR0VvZ3BNUVNCUTdTVkRyYmdnTHFP?=
 =?utf-8?B?aEdpV0ltbmhNSDdodUhMMDZtY2R4MWFFSEFoM3FEWldBcUtod0h3ZkMzMDhu?=
 =?utf-8?B?aWtyK0xuNVVLL1EvWmdWR0crQS93am5DT0xCNGxzSFFFOFpHbThtcFBpcTBB?=
 =?utf-8?B?dDBkcE5IRHVYa2c3aHRnYUxTT2M1UktrRTdMRmdHOG5QSVRDZ09VazFOaktS?=
 =?utf-8?B?Ylp1U2Q1K3JmZVpCbnZlQ1J6UWZCTFBJYkkzalJMOEFrWlROeklUdUZBWnBE?=
 =?utf-8?B?cExUbko0SDF6QTc1L1haS2wzZEpxRGxJT1pHSWxzU1l1b3IycjFXWnk2Ynha?=
 =?utf-8?B?REEwNEIrRERaaVgxMG14azVjU1lwcGgzRzlEbkxnbDRFUmE1WEZ6MFhuV1or?=
 =?utf-8?B?VTF4bTY5ZUxyTWFlZ2M4VzFZSFpsNytidmVGNlVqdm9pNlcvMjZ4THFKTzIr?=
 =?utf-8?B?aXZYMzdJR200bXh2Y2VqL2dHcWJ3Q3ZwSnNaNGhLbEhTSE0rcnFMUGNzcHRV?=
 =?utf-8?B?SkNpMFoweG9iZk9CL3VqNHlXSDJEQXpNN1cwbkozTlFWUTJWbDRTQVhxaDhK?=
 =?utf-8?B?VWgxVnJNbUY1YmZ3NVlBTHJ4RlMzQnhSMHJ4eFRhYnhtSVVUTlMzUU56T0Na?=
 =?utf-8?B?K0hlWHpBRFI3TlNGTmhYZytHNUE2bjRJWGtSL1RHdzRhRlptaFBXY1o0WUJU?=
 =?utf-8?B?Tll3MWZrQ1FKU25yeWpURnVpeHVXUUxuRGk4TjY0YjgzRjNML2IvNDg4dW5X?=
 =?utf-8?B?MVZWWUkwbjJseUpOR1l3L2JDdWlpZi9wdEVocUJReUE3R2c0VjJDdUk0T0ZE?=
 =?utf-8?B?VTExVmpFR1M5NHpIb1RiZEEzbnA4UkVNSVhSM1B3TW0yTTBlRFAxYnNGTXBG?=
 =?utf-8?B?ejhDdEZkUW5jM1RRbERmQXdZZk0xeDVqM1gways4ZE93Z3k5ZlJVb2Zxcis2?=
 =?utf-8?B?UGk5Zmd1U0h3cjJ3eFYvQ3ZGUWlMMzVSM0RCb2N1L3ZCVTRGOTR0QnVBNGw2?=
 =?utf-8?Q?yIe3AbUIom0RXud/I8HxkzVpu/f/Jn1spYxU0Uqt4cOu/?=
X-MS-Exchange-AntiSpam-MessageData-1: H+DxvMRlMbgs+Ut9FJ52hVwMIyLn4TDESZg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b299a9c7-ba92-4e7a-f615-08de86076c82
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:37.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FklR1p3XuJG9MTSFx7C7GRCuASzXF1CEIs+erX2TV1bKZDRY4n4/VqsI7TcItGuq4FjScaIoiXGZrNkNSv/MaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linux.dev,bootlin.com,lunn.ch,intel.com,rock-chips.com,google.com,samsung.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,nvidia.com,perches.com,kwiboo.se,starfivetech.com,oss.qualcomm.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,renesas.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7169-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[98];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,linaro,kernel];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 746692D3082
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

If that fails, patch 27/27 adds a regex in the MAINTAINERS entry that
ensures linux-phy is copied on all Generic PHY patches, for an extra set
of eyes.

The series is formatted on linux-phy/next for build testing, but is
intended to be applied on top of commit
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=4ff5801f45b494ad8251a16ec06c9f303ed3b9a0
which is v7.0-rc1 + 1 patch, and then merged into linux-phy/next.
The idea being that it's better to resolve the merge conflict early.
There are 4 expected conflicts, details in the conflicting patches
(24/27 and 25/27).

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
https://github.com/vladimiroltean/linux/tree/phy-split-consumer-provider-v5

I've also test-applied it on v7.0-rc1 and provided conflict resolution
with net-next and with linux-phy/next:
https://github.com/vladimiroltean/linux/commits/phy-split-consumer-provider-v5-merge/

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
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Dege <michael.dege@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Niklas Cassel <cassel@kernel.org>
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

Vladimir Oltean (27):
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
 drivers/ufs/host/ufs-qcom.c                   |   9 +-
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
 242 files changed, 1001 insertions(+), 734 deletions(-)
 create mode 100644 drivers/phy/phy-provider.h
 create mode 100644 include/linux/phy/phy-props.h

-- 
2.43.0


