Return-Path: <linux-can+bounces-7029-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODuyAtwar2n2NwIAu9opvQ
	(envelope-from <linux-can+bounces-7029-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:09:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D523F276
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192C8300E388
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970035E937;
	Mon,  9 Mar 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B8hcSySU"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB74CB5B;
	Mon,  9 Mar 2026 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083352; cv=fail; b=i0dBJkiXCEFO7fgwMDNRrVY5/rxQ3yk/0oCKEQUjGjCMMPn3O9GDiy5FSe6/S7rb0s+Uo4k5EnrX+9G2f8U4hosMg8k40c/6S3dV0TBfi592Z/1DsgklQzubEZiHo1sUGiEiLtv4X5hB7pKNNAUKQEiA0lyyQAZMUdn+kHu/Cd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083352; c=relaxed/simple;
	bh=X7/XzpGy3abkHgsSsA6IB4i1QxmevKqfq6o+l7RE03g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U7YWIjxN8Avkg+cPMF211zI0CRiOL+et8FC8thB5j+1lgC0zziuYYSWwjTWpdEpGRDjRKO90KmTeVFFRUQe9I1cIboiuKsmMTq1YZy6W2UwY4DfwA9fUFbZeS9AhF2yJjSBEP/WrluUnEnitOa7/C+T+efCgJav+7VFTnT0zysg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B8hcSySU; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNbTDImIY7NqMJVU+MXwEf6Hc8bkSi2eRgLfH3ygomGYHNO6iPbUZ8qOYd3t85zl8nuCylPE/ar952deWfB/gxiNih0kGy1N+iJreRGtLphsR4sdnDhOxOI3MScU+l5gv/Y1XSzaZp1lQj/7KY16yMHgi5A/F3heEgQpXeNeNZyMmhcMHGXeZ7jjr+ovW/cMGO98BxjO3wtxKgA+3258QjJWD7t/98kosI/NLalUf8RxlLqnsKOGyvtWHIoKMPQ1REFjVLdeqV9ft8dCyzRPQXvQ5joraYSNRkzN0Er7bM07P23oxQMn/6RU4IxUxIRrE4B6HezADjbVV4mK8vNJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqFhRoKuEJh7cZsgILk/T3MDhA4GOK/prA32/q3g/gQ=;
 b=GnpB0pw/YPFXd9adInxlE0TpPjFwc7Kv7Mhvt4jRsJRNZF7N2kahnokFL3jEQD7wMT0FSs6OZS/o5ics5v3zKKnS0h1ANyx+5V6b4j+ZKJ0KbRwfYPIAPMweBbmeg8gqtHnZ0l1HGkRdOz+dpJI5x0XFG4QbYZ5Ss3Cps0AyARI2NvtZZfZKsoUdw20hZGXrvzT7dARghAp9YRsGnGQLjKDVn74zLZRDBHSEEj3dD+DwfE/Cht4fXp5OXQxxp4TjGTdJK0/+7rmS0mqv/RlEtKoNzgcb2ciqqCpmHHP7kmyOWUPGxDNPO6Z2DZ20K7qrn7mD85rkZK5BStrVQPywRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqFhRoKuEJh7cZsgILk/T3MDhA4GOK/prA32/q3g/gQ=;
 b=B8hcSySUemsVNKUSzLuPg8v/55+Sr0SufQPWBfwBUgjJ/BFiK++ll1ncq9LuGL+SHsPULJ+P71LCg2IYvLj5ZXYdgVgJtmAd5054YZ0Ci5TWFmCHqd2vz4lTVIm9yccTiRWn+gQgf2hbJ3299HcIdUKkZ3h1xV4RxD/J4BtWUWyjZQH3M8zxUVYgXOzXiIrT8JT3khgHhZau7TJmrdcxopKATFSGc1KnCEC6hT44akBzJ+gOeFmmFJvSmhrp/TaZXaZnj06XxDjEh1iKXcg0qPLD7u7dThyf2QOMw96613tbkjRGe4uH58RIRquqMXtMRlfCFGQyhQEHW6eZcfkACQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:05 +0000
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
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Joe Perches <joe@perches.com>,
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
Subject: [PATCH v3 phy-next 00/24] Split Generic PHY consumer and provider API
Date: Mon,  9 Mar 2026 21:08:18 +0200
Message-ID: <20260309190842.927634-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: d8db4a24-62e4-4f49-72c9-08de7e0f554d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 XEcgWjBqi6oAw9ADhw/hwylx+r+2Q7iiz83/myXhNFA4LTMwxUpd+4JTrYXlv5Mqf4Mbw7vPobfK60LghGo2iBZSXSJ2xR72X5+EG9GzHoMTJ0MrwjEnfw1Nfn89/bmnodwdWMZgSuxLjXMGDxhxov04Q7Vhc2H7cysYYY271m4yTBMHjZ+HA0ouCyDCNqVdrlaoOSjKVybRUhc3Js3cxYFwsUoSoD1wxSUB2GmtMMKSi2Xzli5jwmCZECSDUotVvVgGqUBIPRyCi5YM2RmtLR+lEICZ3eV7PdvoA29Qq6GZGiZ3YrD9vSwEyZ2UrT8RwokCKoDUCpFuuV3ndtNQkePM+GnaFgDw5luOI7blSD+LaskoMPmytgxviN4sdgA5jj98a/Guilu15YxzHf3v3ZuNKZT8W7JF2hqiaTgDnJkeBI6zkk3LZSnG7AC+NN6DsCINfZnd36qlroaj0nR43GZCkX1D/ARS+6D/YzcZEaCgaJY52n70mlNKaEF7InI0SPmR92sGJgOi6g97lyBce6TUnhMm0XoIQQ5I4XNOrOy4t04MMd/Q6OtOBDoaTVrM0rWv+szu+GMyvbjERTba/qY9lVv3NIGm4BxxowHhpcWC3qRz4N1Nc1qrbuztAFsREU1a0AIxV+s4yRVyqai5g7W7RkSiIfNQsFybc8aMQALnrJRmlxUaUGdZkEUM5nz4
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eldQUm1zVDZyUjRrM05QbHB6THY2SUFOWktmLys3eWNXeDIvRDU3Z1JabStT?=
 =?utf-8?B?ZGN3N3hzQUpudWphaTdReXZYaTM1dHZyRG56MzZKZ1NiWHFONjVNWGs5eEt6?=
 =?utf-8?B?N1FOQXBLR2orVnJqVk81dGNMYlArcTZwS25ob0RhczJCak5MT3hWMVVTUUg1?=
 =?utf-8?B?WmlCc0gxK01LcldxZFAxTlJTdlg3RUlHMS9ldUl5dmhZZ0dYZ3did2MvaGZq?=
 =?utf-8?B?WldVVlovQlRlemlQdDhmOWhtRDYwVVRBUWp4TExLeVV1Qi9KcHdWMVJkRm9R?=
 =?utf-8?B?VzYwbkNML0pZbGVvOVhCZkRFYXpZSnM4V0pDRCtPb3ZlZlQzSC9DMlZCV0JF?=
 =?utf-8?B?WVpWWngzS2kvTFl0Miswb0pBRXVscTBObmtGd3Vwd2g3b1lxWEp5WVhkbUVw?=
 =?utf-8?B?RThFdE9CVkxNbG9vK2I4elhvYnlTOVIrZ1BBRlhLRWNrcXZYbXNNSU1GdFl5?=
 =?utf-8?B?UXpIc2JNNktFMGlVMUMrbUNZMFpLZlVhKzNxL0RBS3VxbEpBeEphZW9uRGpW?=
 =?utf-8?B?cklGREYzamlQV0thbndBbGl4Y2M3NEthYWpyTEV0akJ1eUZLSW1UNytjTkdN?=
 =?utf-8?B?bHk4WEpUNWxzcXZHM3JBdlErSGtQQzFIMkx2NVB3QlBsN3F2bWJrQWVqM3dP?=
 =?utf-8?B?MjlUTDlxbTRWQjR0a0ZQSlg5T1FLQWFtUmU0UHZ6NUhqdzBaek1YSDZOaVVL?=
 =?utf-8?B?N1hKWmc0dUQvejlJTHRKQ3lxM25SUTR5eDBYWlhvWHhKVDdINWQ5VUUxM2c4?=
 =?utf-8?B?eU9QeVovU2M5VUJTcHZDNy92T0JzenA1Q0ozVjh5YXl2Yi96M1VWb0JrZ1lR?=
 =?utf-8?B?YmdnNEZDZThWV2VVL1VXcm5PRFNqczFMdHI0YnNRektNVDloMGZCSldkYnZh?=
 =?utf-8?B?bTUyYitlb1VLa0IzVlZYRmlPL0tENjFRQzlxL29rU1Fua3FaQ2R1SE12YkFU?=
 =?utf-8?B?YUdVdFRLQ3ZYaW91T09nR2VOWmRIRWNmOE9ibXJQaXNTaU9pRWloSkNOajhq?=
 =?utf-8?B?cUQwTFV4V09aTS9Vbnh1QmVRdEF6N2NrMGpSdXkwVzdMaUxoWFdPam5zVnRY?=
 =?utf-8?B?UG5GQy9XOXdaSlpKUERFcXlCUFREdEpHK1R2Ri81NC82UzlyNExGdnNqZG1V?=
 =?utf-8?B?S2hDTjRXUWswbVQ5MllFVkYySElYWEJ0cndLSnhEYzRSdm00YkRKTFJsbmZD?=
 =?utf-8?B?MmFodXRCUk5NeVprdERlK095U1VLd3FEYVFqekZ2VDNwUjBnU3htYi9NazlG?=
 =?utf-8?B?WkVYSHJ5NFdrMTN4THM5bWI2WkxiRUJoQUY1QmhlZnBabzBYU2Zpek1qZzB0?=
 =?utf-8?B?THdXMFgzTDZWQ0lWV0FZNUxUdzNXS3NORkMzcjRhUnp0akdDNkJYd0tDR29k?=
 =?utf-8?B?ZE9NVFlkOFpybGsrQ25oM1BOMjU3Y0E0aU9TSjM4WVBmTmJrbVJoMHRUSERS?=
 =?utf-8?B?ZG9pakVtRmJOQ3RRT00yRlYyMGw1a05wbWQ4d1E0eTNwdHlTWlUwTDJERUQ1?=
 =?utf-8?B?T1VRKzdxS3I0bTNqYzdWd044SDVEWjc0TzdsYklKdFV2TTgveUtTN2xyOGl4?=
 =?utf-8?B?YlRTaE5tL2xvOUVreUlHY09QbmhweTZmLysydGVBVVBtdmJDT3pVNnN3cHA0?=
 =?utf-8?B?enVEZE1DNnZYNFlXSmoxY0xxb3YzVm1mOGNlb2hUVVhnbmR1aTczL0g3dmlB?=
 =?utf-8?B?R1ZjZTlla1NGZVVnQlRJUXZYdnlkZmpFTkFSaERJbVRlNmYyVXJaRnZibEdE?=
 =?utf-8?B?QUNFb1dudy9lTDBJSXlJeTFnclNLc3NWSDRIRTM0RWVRUUFjRUFPaHhBNURO?=
 =?utf-8?B?UHZmVEhxaXBZWUUxeVROVlZCTDlhU0NaMjJlbkVxM1poRk1raVQ1U2VwamJ0?=
 =?utf-8?B?V3pocFlXQUwrWVVVeDYvZ0ZFb3FNZGJ4VW9SenNRZjhKYzdxSVlDOHBsK3Ja?=
 =?utf-8?B?Y0JXN05EK2o2anlNMFovYmZUeWllRzNkRThscEJNSk5TRHVaWDV2N0JBRi9X?=
 =?utf-8?B?MHE1a2kwN3ZlSUlHR0hGYkQySkRDNm5BV09RZ3ZrUHNKM2FBTm5wdlQ1WDJw?=
 =?utf-8?B?UE5KVkd2SmlJN0ZZZUN6bFYxc2diY1MxUFJGQ1JYTU9rcmg3UVZsRXJUMFBC?=
 =?utf-8?B?Ry9mSG05b3dMdHVCdkxBTWxSR2xic0pTM2J2eW1ZM2MybHljejAyclIwdm5O?=
 =?utf-8?B?TUhaQlpHc2ZnMmVKMXlXa09yWlpheXFKVlR3WmYyVHhJUnU3bU5xNHdqbFMr?=
 =?utf-8?B?YW5QelNBN2pscVhsWXEvbXpJc2d4cjMrR2Q0cEJFbXg4UHBza09xU1MxZU1w?=
 =?utf-8?B?eHZVOU9tVmlLQmJ5di9YMmZONnk2dHNZQ2ltaGFhUGhEMGtXSTFtM1Z0R21J?=
 =?utf-8?Q?fPn/XMKu8RhTskNqW4usk5R2iwkANv3rOARNoneUEe3y7?=
X-MS-Exchange-AntiSpam-MessageData-1: 25X3k10J55dIlE6TPhtIwsKPN+CfE6xF8ec=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8db4a24-62e4-4f49-72c9-08de7e0f554d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:05.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mxjD6/cBZmSNNYvle+QI/FI4XTHe8+OQrb7WMkGgQN5jRGmnpvJWqahjcOmetD/K+9d1oEZ3Dqt4xLs+srDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 758D523F276
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linux.dev,bootlin.com,lunn.ch,intel.com,rock-chips.com,google.com,samsung.com,tuxon.dev,gmail.com,davemloft.net,nxp.com,glider.be,linuxfoundation.org,sntech.de,amarulasolutions.com,perches.com,kwiboo.se,nvidia.com,starfivetech.com,oss.qualcomm.com,ideasonboard.com,linux.intel.com,pengutronix.de,somainline.org,baylibre.com,renesas.com,redhat.com,armlinux.org.uk,sholland.org,poorly.run,ffwll.ch,synopsys.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7029-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_GT_50(0.00)[95];
	TAGGED_RCPT(0.00)[linux-can,netdev,renesas,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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

If that fails, patch 24/24 adds a regex in the MAINTAINERS entry that
ensures linux-phy is copied on all Generic PHY patches, for an extra set
of eyes.

The series is formatted on linux-phy/next for build testing, but is
intended to be applied on top of commit
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=4ff5801f45b494ad8251a16ec06c9f303ed3b9a0
which is v7.0-rc1 + 1 patch, and then merged into linux-phy/next.
The idea being that it's better to resolve the merge conflict early.
There are 4 expected conflicts, details in the conflicting patches
(21/24 and 22/24).

Requested merge strategy, I hope this works for everyone:
- Subsystem maintainers ACK their affected portions
- Entire series goes through linux-phy
- linux-phy provides stable tag
- (optionally) Said tag is merged back into affected subsystem 'next'
  branches. Those who prefer can handle merge conflicts when they send
  their PR.

Detailed change log in patches, summary below.

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
https://github.com/vladimiroltean/linux/tree/phy-split-consumer-provider-v3

I've also test-applied it on v7.0-rc1 and provided conflict resolution
with net-next and with linux-phy/next:
https://github.com/vladimiroltean/linux/commits/phy-split-consumer-provider-merge/

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
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Joe Perches <joe@perches.com>
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

Vladimir Oltean (24):
  ata: add <linux/pm_runtime.h> where missing
  PCI: Add missing headers transitively included by <linux/phy/phy.h>
  usb: add missing headers transitively included by <linux/phy/phy.h>
  drm: add <linux/pm_runtime.h> where missing
  phy: add <linux/pm_runtime.h> where missing
  phy: spacemit: include missing <linux/phy/phy.h>
  net: lan969x: include missing <linux/of.h>
  PCI: Remove device links to PHY
  ufs: exynos: stop poking into struct phy guts
  drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
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
 drivers/pci/controller/dwc/pcie-spacemit-k1.c |   2 +
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
 drivers/usb/chipidea/ci_hdrc_imx.c            |   1 +
 drivers/usb/core/hcd.c                        |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c          |   1 +
 drivers/usb/dwc3/gadget.c                     |   1 +
 include/linux/phy/phy-props.h                 |  75 +++
 include/linux/phy/phy-sun4i-usb.h             |   2 +-
 include/linux/phy/phy.h                       | 497 ++++--------------
 include/linux/phy/ulpi_phy.h                  |   2 +-
 237 files changed, 941 insertions(+), 705 deletions(-)
 create mode 100644 drivers/phy/phy-provider.h
 create mode 100644 include/linux/phy/phy-props.h

-- 
2.43.0


