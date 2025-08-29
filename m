Return-Path: <linux-can+bounces-4385-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B0B3B3DB
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1633BC4C4
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2F262FC7;
	Fri, 29 Aug 2025 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kfO1fr/8"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB8264A86;
	Fri, 29 Aug 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451374; cv=fail; b=Omjk2NDN6j+S+PGTLqsy+ytc/54gw/nMnts1SnaGRjZ6LnxiirpLLJphxohNcRBLSqccYDFEYKfMKzN8E0kbZ9NliSO2XncQFkhABDugVRSpbkBxNIfHCe3XzjEpgkJC9qzJLHJ5aNFOXutlL781mg/ehZl8Aw1F7tnzTVKF60g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451374; c=relaxed/simple;
	bh=o4iLsANqJYzFyoa80ejSRA0IiUkyjg8Sk4tBjUtpqaw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mLv4nkQ7TkF/MVoqeLxqwaRvPS381ZnSMryCG9p+oDGcCvSxuiNE75rDI7fNpa2ET6YHI61vxK6mhhbxtSW0uFukfSGeRi4ib6dJ35XJtz/lF6RMfAuM7ZU9TSbcE7fV5OG7C3TX8huZ74cJtRdA9LKNC2Ck4HPpcYfYf3Lko0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kfO1fr/8; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPIzxMVevyULsua403DMbiHPaUJIVmKDMJUoRGXM3qrOAiLxF3tF5na8AoOanq0fxxTCTYILtHkNY9cN3IT5+4itqJ5OyE+hRSfQx1Ky9pc+WR86PAaVItX0HW9bfVw9ps6oBI+bTEA5pKEPQz9OOH6hlC8gqw6dLEJ07NZGwY06Hcj9vXovcKzoH3zCMA1m2RDnD0UVNC4zkVCAj9qukljle4YoujHwIh6jNaJfLqwbryZwQ7MqahssULZkcvVX+EH81gPGXfznbrHvpiYdG7+aF61ZSTLsUe/asBzNLwEVoMxcS41oOQhCHceEavALZMUiubrhbarWDwF8rSVE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsRF9JzM2FIHMpsvgG3IFbJpEqyyK+RjuKgXsq6eMJM=;
 b=H6HomPTaQsJ7qYojE5FmHbHhjqbA33ZM2wHPvQJ5Z3ysxr+FiaJwwCsldSZgbTwK0mH1kmjiUdWxcnKkUD+rtincRF68ZFWRbht1nOSd4K9rJA/qSphuc+fUJHEIBUkKIh7fqdlL7ARzJM3TUD/mY2Yobfsf9npsgl91++a0VOlBY2pqnAznwzTf4fHOQjWZFV6d4vnp5BrvGuCMJauK6qpAE+1avaRaMnlGHVCpN5KXR+G0+yRUWz9Bg2wOn9N7IBY96rjovkBmihLIabMMFP+dyTrPTZSg2CaZ04HhvJYTMxVDmJjyadnb9A29BA4XeIc7bG2bfkZA8BX7ZT2Kng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsRF9JzM2FIHMpsvgG3IFbJpEqyyK+RjuKgXsq6eMJM=;
 b=kfO1fr/8CAtvX1VgiCkmH5ONUl2+In6WVJUMUIUAt/G6AIqap8K2D/Q8M0aPHZ8hBcrKbeZusU/Mc2581A82p2R8a599EDskaK0v5Uj1abDs+mY8hkGDR0nkoXKkN7Qy/VB5SD76v4LqAFTqBq8Q7K+gSd4sQyOwIKbYjgZf4OamQsQX9P1bzvh/QSHiA8R4PRe5SS5RSfDXLDFBD51VEbEExyDLm/RM/TYwf+od/gOv0uDwVnWSthuqHeclIvTKHEBktySDunkYcWoTKR452QN0KdBAVvzBpO8PU6U1j19MGRgn+HaWzgneHVgtgtTkTCeuHkKLSeSOS1BXk7fLGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7752.eurprd04.prod.outlook.com (2603:10a6:20b:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 07:09:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:09:29 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 29 Aug 2025 15:08:57 +0800
Subject: [PATCH v3 2/6] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-can-v3-2-3b2f34094f59@nxp.com>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
In-Reply-To: <20250829-can-v3-0-3b2f34094f59@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756451349; l=4424;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=o4iLsANqJYzFyoa80ejSRA0IiUkyjg8Sk4tBjUtpqaw=;
 b=CooEZlfVTZmTlip0XxptGBWC/AqRABrD0NDE8akk0nP6J3sShZc9YPimSujaqG9arGg/kfunM
 TxhgCU3sFh7DQ+CZePqbz9Hj98HjpdV8yXd4eFvrDhWghxizJtpFgaE
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: d5446904-d0ee-4a12-b224-08dde6cafeec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UExPZTRpRVcrNTl6eHF4OU5OcDBUbHY1cHBCTU5xV2xKdWxtQ0Fra09PcEF4?=
 =?utf-8?B?ZW5ob015T0tnOE1jU3ZNNzBzelRPejdodzgrQVdhNWVSK05VVkcxWURaL3Ri?=
 =?utf-8?B?SWQ5UzZaREM4R2ZnbHFUMU5CZzhoOC8zZWtGdlpueDdDS3ZHUE5VQ1V0TkF2?=
 =?utf-8?B?RU1EME93T1BicDRuaFhEUHFTdkUrR1FXZk1kZGlTeDZhS3dpS05HRWY5cnM5?=
 =?utf-8?B?bC95UVVZZEJ1Yzd1Zzl3YlpWdW1zRkdpN3lLTXcrREJEU01TUU9FZkpZVmhx?=
 =?utf-8?B?c1Vmc1BUUDN1Z1VZRDNwU1pSTW44T2gyejAvZjg5dTVScUxGK0ZhWEVMdXFN?=
 =?utf-8?B?TW1GejlPMnhqbjZZOXNkYyswMW9VbEFMRWdldTRXcStpd1dIdTQ4b3g5SWFi?=
 =?utf-8?B?cXdHRGxlN3Z5WnRwdXc1YnlkVTRtTUVnV0FXZHZOV3BQVnpKWnFzUU5QTHVW?=
 =?utf-8?B?cFMrSHUzMHgyVVNoV0lIMEdYV2dIbUpWSS92NXYzbFFNS2hubXdSWnlGK3J1?=
 =?utf-8?B?VEh5SzVQaVRnYzNzV2lGTmtXMkR6N0Z6ejJpdDdYZjhURUF3Ri9sN1JKLzg0?=
 =?utf-8?B?bmdwaXEwQVpvWUFOMFZwVDF2dVpPdXpWVE5aSjZEdXpJWXJSNVMyc1gxaHlO?=
 =?utf-8?B?NklNMjJhMnV6c1dvQmdpUWJyMHJnM0h1bVYyWWIvcVF4dmhRdjFHNGw5NEFk?=
 =?utf-8?B?WXl5OHNTN2J3dXdGSWpnOGZyQWk2Y1QrbWxRdCtrc1ZJTGg3VEx3RUJSZnlz?=
 =?utf-8?B?ampEd1ppdm9mVFk1VXBSclMvbEcrMU1qamlSTUp0SmxPOFpucUlnbWRpNlo5?=
 =?utf-8?B?Vk5oNy9icWcyQzdTMTI5eVV2L2I3Uy9XVUFCZGc5cFVjdEtzZnp4UC9KWUlT?=
 =?utf-8?B?RG90OGVKVWEzUnlOTkZYb21iOGRVeGlCNzdMSWc0TkZEVVpqWXJtLzVSNEpC?=
 =?utf-8?B?QW9BR2RTVWdvSmhxay9Pb3dUZTNJUVdwVDlnbWhxbHJQYmFoR2tOYUtzQzRk?=
 =?utf-8?B?RTdnOEladTFlSUFhR2ovNjZqMHZldS9RU1lxRE1LSGlhV3duUXFmMFlaUUVz?=
 =?utf-8?B?MU56S3ZRckJrNDlOQmdOUklDbUUweTl1ZkRuV3hCc3FIY2dwaWUzS2k4aUts?=
 =?utf-8?B?RHBDaUptbzdta21pT202bjV3RkIyYlM1bmd4R2FjRC92M3FhaVgxQWhzWTJi?=
 =?utf-8?B?RjVlczd3OXBzeEo2QzZxU1pjUFhCUlBYVExLUXhXN1Fsb1l0VGJGKzNhQWtp?=
 =?utf-8?B?bUEraDE1K2JPWkgyb0VEWWVBWDh4ZlE0OHRLT2ltTU1xUG9oditadm5hUDQ2?=
 =?utf-8?B?Z2lwY3cxQ0Zud0ZaRDZWYVRFRUNxcUFoWXFFaktXTTk0aWlIUzMxbktlOUdl?=
 =?utf-8?B?QTNQb2lPeW5OZnBmbWQrNUs5M1JHend2RS9qdjJ3QmUxVmFQdXFGd2RzTTlH?=
 =?utf-8?B?UWlEWmdRcFBHNTFXekI5VmpNOTFNSVNOK2kzQjlCdjgwNWtydDVSWDUvODV5?=
 =?utf-8?B?RW1vSnZ0bnEzeEdyUVdpL3ZzMDBVQjhBcGQwN054V2JKNGNBMUNwQTBxOGtI?=
 =?utf-8?B?em84bE5LWWRldm5JSm1hY0craFZHbHBaUVRROEZ1K0VFVVArbnpia09DZnZS?=
 =?utf-8?B?QU54Zm5Fb1dtTHRicHBDSXIvZXlPSTJieHZrbTF3aEdYZGl5SUM1ajNoU3Jy?=
 =?utf-8?B?MzFVUGRNYTdqeFVjQjQ2VjVUdWF4ZzU1YlpTaS9SK3gzcmxqYTk0YW8vOHFB?=
 =?utf-8?B?cE1zRnB0dHhjOWs0VXozV2NCcS9RcGxBZEZ4ZnhFeXBETUN6aGZxRER4UjhN?=
 =?utf-8?B?M2s1cG5PQ3BNYnhHQld1N2pJeXByb1VCdGFPZVpzSVhVdWluV0FvNlhDVjZC?=
 =?utf-8?B?MG5iNlZkakxOK2FVd2dHRUNKbktRM0tMeFJzMnhDZ2xGSXRoeGxkdDVxd0JD?=
 =?utf-8?B?c2NkTlV4azNrMVNJcnprbWhxNEtCdlNXOFRGUnNDSE5ib0hxUHJPS3NDWkdh?=
 =?utf-8?Q?6nW0hPmSdejlcF9DOwXrj8KblSNhz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdwZXdwd1Y0bTZlZnYxMU9nWkozSDdaNVJETHlxMzRyMk51Mml1RHNxbThT?=
 =?utf-8?B?T0llb250Y1Q4REcyQzJ1MGUrL2w2WUZQNnlHaGtBaVBuODF4QS96Y1RjRzVF?=
 =?utf-8?B?cVkwalM2RS9BTHUva0xIYUpUSlNDS0FFVzB5Q3VYNzUxWVRwWmlmKzFCMHEr?=
 =?utf-8?B?UHQ1MU5LUVIvcm5uM0xHc0k4TlZnclgrWXpCTzZSMkRvYnV6eWxjYzdrY2hW?=
 =?utf-8?B?YWd2OXJXMTdKK0NqbGpvWVo4YXJlZFRON3FlWGt1NDU5eEtlbXpoTnFEZmJX?=
 =?utf-8?B?bEM2bU9Jb3hBWml5ZERQY0FBeGxQakJ4VHo3cWNIcHk5ZlM1c1Z4eWxjdUd1?=
 =?utf-8?B?SUFleUFCQ0lKTHM1SkN4bFhmWU9zK3lkdHZwdUpTQ0JhMnBUSGNJczAwTlVt?=
 =?utf-8?B?TllHa3dOcThnK1ZzNWdnQ3NzbmExYzFxVko4OGcwdTN1RFdzbWFRZ0FJT2Nm?=
 =?utf-8?B?YjJMZ0owdXd5K1pWQVpYNWxuNXdROU92eUZ3cldzNmM2SzMxOFJ0MmRBRGxt?=
 =?utf-8?B?bGRYWXpwWFcvclRWREVHYzdsUlZFaWFUcmhVNnpkK1Uxb2RWejVZb0g0SEJX?=
 =?utf-8?B?QUlhUjRUYjRVajBJRkVkSThSSDNXdlJSYyt1SHhSM3YxWWovVmQxSVRRRDVa?=
 =?utf-8?B?MU1BcHZNMnJrSDU1V3BIWDhwNGJTNG5Idk5NOGFvVGhsakpyWFlhVEh0V0Q4?=
 =?utf-8?B?TXFqa3Z5M0RiSDRDKzZwQWVTemtueXJHU2VRRzBKUUV1czBZZGI4dmFGWUQ3?=
 =?utf-8?B?andvaWw4OVNiL1YxZENuRDRBRVRvTUZOL2JLZDY5bldQZlBnZWViNFB6Ly9S?=
 =?utf-8?B?WXhJb01KZ1RBREEvb1I4RGdZK01QaTlWQkNsSk01VHJmcmQwSU1tdS93aGRi?=
 =?utf-8?B?WkJKSnMwdEt4Y0JpaTZoZkNic29aZ0ljb3NjZnUvT0FOcXQzL1MzanM0Tjlt?=
 =?utf-8?B?Rzk4ODQ0MTRYNWwxcEVHNlRGNnNEbDJMRTBScEtWQWMyUGo1QVkvdlpkS3Ny?=
 =?utf-8?B?KzZRb0cwV3hVWmI0RDVDQ0ZWNWQ5OG1WL25adnpBSTViaWFpclFxcnY3dDFZ?=
 =?utf-8?B?eXlZMjhRMGluYzBtVk1RaG5idlZsRUlmeFQvZGpZM0pBbnBpRWVSN3htOWJq?=
 =?utf-8?B?eHJ0Tk9GYnFnNnduT3R5aEJpQWo1NDVPYU1nNC9pY2oyalNrSlRNODU3R0tq?=
 =?utf-8?B?QkMyNCtLdlRxdUdVV2p6WnQzNzl6dW1jdFIvT01UeVo0OFJBVXptUDBwWEZQ?=
 =?utf-8?B?c2hNWnNmM2R5Q0tLcm10V0Q1TDdzTnZrVG5WaG51OGgrY2VXdmVDUk9uT2Zm?=
 =?utf-8?B?SnpIMEEvQndTdi9IWFNTdmRyWlhXQW50OFZsSysxaEtlbE5vN1ZuV0NSWjBi?=
 =?utf-8?B?RFliTHllYUE5NUJVSjdpS0JEUUlEeWlHZDZMY2s2OGg2L0RFdHVDZVlmZ1Ax?=
 =?utf-8?B?TjlmTlZzNGQ1a2xPSkVnbURZaWhsUGZwQkhXQ0hLc0w3VzB3S0lKKzhiejdB?=
 =?utf-8?B?UHZKVWNMVnRZNW5RcnphYnkrTHNsMHZLYmFGOWZOcjhJU2JSWkt1NnhSQ3Bo?=
 =?utf-8?B?QlQ2WkI2Z0FnbEc2eDFSdUozS0srdzcxOXIzTVZpUldFMzcwaGVnK2ZtcytB?=
 =?utf-8?B?S1RPSVZ3ekorYzRIc1loYXE1MjVrRHJFenM1S2Z4MENTck0wam5lMlJTdWpp?=
 =?utf-8?B?MnBKREVuT3djTEdMR0NpLzRlYjAwaFlXbktQblEvdHJ6TDMrTktWZXRuaXE4?=
 =?utf-8?B?UnN5a0lNc2hVYmxhWnFkZkxXZFlFNUwwQTE5UG12K3p2clZQRHZSQTFkdCtN?=
 =?utf-8?B?WWJ5MlhnbGt4MWlKSysvaFBTVHNETGU1NG0rQVFPaUFOTG1FVmdUUEZiYUNO?=
 =?utf-8?B?ZklpWDZaNnlWQlhFL0N5bElQci9nZmtxQyswSXhLNUZERmNnUmo5Z1gyUk8v?=
 =?utf-8?B?d3hpWHBVcVpBcmVZdUdHNTZENXdzMTMyd2Z1ZGN5NTJHZjZTSC9BZERiRnI3?=
 =?utf-8?B?UGVmL3dDT05VWFpuUHlVdW9zTjVKZTlDdFBRK1BBalZsRHV5L2tFdWdXSDhz?=
 =?utf-8?B?NVZvT2x1dW4rTE9hT0NjYlRBbnFiSEFJVUdMc1d0MFZ0c1VQZEZ4ZTE5Q250?=
 =?utf-8?Q?2OAWClNvXu2B/BXxctTa1kCID?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5446904-d0ee-4a12-b224-08dde6cafeec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:09:29.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzRmKPfWUcT+2P4wDWky0LJ7MOIt08U9J6ng4oxJUiEUey4MCH865fXf5zTcpUgxaMkDnpQiP544ZRFErXbO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7752

To prepare for dual-channel phy support, introduce can_transceiver_priv as
a higher level encapsulation for phy and mux_state.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f59caff4b3d4c267feca4220bf1547b6fad08f95..6415c6af0e8414a6cc8d15958a17ee749a3f28e9 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -23,6 +23,11 @@ struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
+struct can_transceiver_priv {
+	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
 };
 
@@ -32,8 +37,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
-	if (can_transceiver_phy->mux_state) {
-		ret = mux_state_select(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->priv->mux_state);
 		if (ret) {
 			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
 			return ret;
@@ -56,8 +61,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
-	if (can_transceiver_phy->mux_state)
-		mux_state_deselect(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state)
+		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
 	return 0;
 }
@@ -107,7 +112,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	struct can_transceiver_phy *can_transceiver_phy;
+	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
@@ -117,18 +122,25 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	u32 max_bitrate = 0;
 	int err;
 
-	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
-	if (!can_transceiver_phy)
-		return -ENOMEM;
-
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+						 GFP_KERNEL);
+	if (!priv->can_transceiver_phy)
+		return -ENOMEM;
+
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 
-	can_transceiver_phy->mux_state = mux_state;
+	priv->mux_state = mux_state;
 
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
@@ -142,23 +154,24 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
 	phy->attrs.max_link_rate = max_bitrate;
 
-	can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->generic_phy = phy;
+	priv->can_transceiver_phy->priv = priv;
 
 	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
 		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
 		if (IS_ERR(standby_gpio))
 			return PTR_ERR(standby_gpio);
-		can_transceiver_phy->standby_gpio = standby_gpio;
+		priv->can_transceiver_phy->standby_gpio = standby_gpio;
 	}
 
 	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
 		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 		if (IS_ERR(enable_gpio))
 			return PTR_ERR(enable_gpio);
-		can_transceiver_phy->enable_gpio = enable_gpio;
+		priv->can_transceiver_phy->enable_gpio = enable_gpio;
 	}
 
-	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 

-- 
2.37.1


