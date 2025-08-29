Return-Path: <linux-can+bounces-4387-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B279B3B3E2
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FEE171EDE
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 07:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D56267386;
	Fri, 29 Aug 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZBYYAQo2"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E3266580;
	Fri, 29 Aug 2025 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451386; cv=fail; b=kxFKbRer6VVftLCH/57+1mBqFShcVtcaDWMAhluKAHcJX8roMvK7GU7r/HNHHTaJ+yWS24mRgQP+w8h0Wgavl6t5RXow8f1ehoKgs+h/UIhE/pvDk64l3KzEd2PsgMnd/x7v4SN0FwDdvj2C+UrYKirrA1zQ+eqJqTxPQHikwDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451386; c=relaxed/simple;
	bh=/DEKToE9khI/IF64bz3dyJTnpv6u0rxFEBM5LAt0TbY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GzWmoAOr17dUwac2XIRBnfa0E9zn/exDACgCJSZ5RI2MAnorkebjEpNn/G0e5MCev8Eq4O9jszN6qcKUvzkdM1/hNq4otm1DOIDzDAB1iZRpkuJdX2aGPH6ZQ183AvlS+V1qaGF0ekm+bQFCVBUMj8lfDqFry0nIqQAUFOmoUqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZBYYAQo2; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy4lxTYOdgZtnA+R8kAgxbwkgx6o1iaUkukhC0w3jRxEFp4LiEOApEVWVBhxhOeV43plKnt97u1VtQdlt2xixvzSXpHUkMfxfGUZMLytLULKLZAwUq8FQoIVzLzz1qZXKYJfN9pXKH0JXvqKFX1jBlILgH31IxHWoFcBAOsuJ9sl7AVEFmg7lHoMfdgvUeq2HSmad4Tq79jDx1bplU7mR/130qqhD5YwK2CI6hELF6prUTouriAzx1arAuxHjUvvHYy84zmfYY5UHC19d1/1Vzvbb2BehlzIyAfaZA4dDglMLexrJX2B0Br1Ssgjne9vFeEKcq+mOPkOZ9hvQWJYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHCj9HHteqFAp4t4kZFMVgMbZE3pIlCwTeH5w7sEo9o=;
 b=U/KRzWeqS2PdxUYiVOzYthOPfB2djaKFBiqoqzYbwpQ3/HrtP6EcKSKAlH2PxUNeHIoBjhKkdJLuUa3wmmes4FHWbhW+ZbwQMSw8YJ70BayGtGeXQqAINkr9dOHdtu8BSzvP83vZROgq49Y3gsNljU7KF49VVtsCdkmqeOPkTSmleOqv0inF7mMPEIXJvxh2PWxbSNjk5AygQoPgT4e/+EaRhWyOkBb5TPXvPqyQjormOWLZGxw5CJjuyjcv+VDTrmLUkbfrdfUSD0sndMpRdnzJeey/RECFPLdqWRkwyGeRBcmN+REbndjNhLVhzkmIl1yIqnVEB682LBYBmLO7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHCj9HHteqFAp4t4kZFMVgMbZE3pIlCwTeH5w7sEo9o=;
 b=ZBYYAQo25hghdItBwYdnUIaNkU4jVs5WNSVI5Yi2on/qyHWI09p4jro2xSm//T5J9wil97JpD842L+WWNgV4awaGouuJVTtKK9Yxr1Dr9WcEw/3S6Sw3F1PDR4wwQUaqSpVutEkNTBHT0uyXD7Drx5gC4YHCXCvVE6hFvqmi3rORtXUYtjze4QoHU1nKoiit0P/SsU4BMBoh8vMSLduEZKnCPFSeDzgE/uRnGKo53+pX9T4ywuAhfkJUQiZOtizO+zYABhHk/FmUx5gmZyXMvr+xcsl+ycMvjhKS1Dpk5j8IRfcqtX2Rwzh9UtPWG0nduMtfaKPJQVy27PaleLIv4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Fri, 29 Aug
 2025 07:09:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:09:42 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 29 Aug 2025 15:08:59 +0800
Subject: [PATCH v3 4/6] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-can-v3-4-3b2f34094f59@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756451349; l=1482;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/DEKToE9khI/IF64bz3dyJTnpv6u0rxFEBM5LAt0TbY=;
 b=J2oysN18eyZZdAO6GUChBaa2pHy6iUj0zMLhCOaA0D1HuzCZG1q9wQX+kD1zhnc9AcWOZ2HAN
 AFgcN5Isgj/D3wDSR8CLFM95bWsWrnaoyPNevvxqo0tY2bkEX0yUEkK
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: a894a27e-2528-4534-7003-08dde6cb0670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWdDcGQ3ck9BTStSc2FMYitNOWlORlJwMmRab0NiSjdpSm0rUmx1Mm1rOFBi?=
 =?utf-8?B?MzgwQkZRYXM1UjNQUEpLTUU4dFF0ekRma21yQXhVUm52d0ZEWGs1cDNTNm1i?=
 =?utf-8?B?QXpjbDJxRnlHQkhPMm80RjRjSnV2UmJEQjVPSXhyMWZ1aWxXdFc2TG04K0dM?=
 =?utf-8?B?OXIvUjA4SEpQNm5UL05rTndiQzIvWE9NejBBbENxbHkwSzJydmY3WG1YOHlZ?=
 =?utf-8?B?dHc1M0UyRksvQnZUbVBzRE1uV1ZHSXF4aDRKUk4wTXQ3bkR2VXE0VzJ5T3pU?=
 =?utf-8?B?ZmNOR3hveElJRjBQZjJFcEVic2ZOQWdUS1hmenFUU1dtSmhybElWbXo1c0hD?=
 =?utf-8?B?SW9nU0pBYXIxSG1qMGJUQlR1cVMzeEFiZTJYN2hiYUV4eUNWTTRZblJlVU9D?=
 =?utf-8?B?WVRHNkYrak9XM1BrbUNoUTFURUVQMlRCbVlXUE5rLzRUMll2YXVVa2tmVmxT?=
 =?utf-8?B?WTdCaFRVbkI0aUdWN0tkRFNjV1p4NnlxVmN5cUZpSXdCUnlKM1FPOEFzSUw4?=
 =?utf-8?B?L052blMzQmVzT2p0YmtSa1NIcFBaR0NEZXNrbTUxa0hxNStsaGNUeFpscU5K?=
 =?utf-8?B?bTdwN0VhSVdMTDg5YWM0cUxpSXNLNnZXL01BazZWZlhlREtKc29uRUp6NTds?=
 =?utf-8?B?MXVIN2lLUUtwek40NlV2RzZVOHkvV1plN2RyL1V2aGxlNWpScG00U00wZkFZ?=
 =?utf-8?B?cUUrY3pJV2xhbWx0bGE5ZGlGR1lkcmRkZmZiUGRmVGJsMFFXVmI0M2FtcXJl?=
 =?utf-8?B?Vm8zM05JY0ZjdTdZOW1LNW16NzRDU1NnTDdRWFZTZE85U3hWc0g2Z3pOamRI?=
 =?utf-8?B?cStXT2h2NVVrMXB6ZzBuRlJOSE0zZ3FFZmljdlByTms3c1JUa3EyZjJRT2tJ?=
 =?utf-8?B?UlIwMW1OdldRZndtbndJZ2g4RmlHeGFHQ0JBVGZ2dzd6SGZ4YklyeEY4Mmkr?=
 =?utf-8?B?MFRWdzl3RGdhSGpYTEJRTlRKZGVMVVVnTExoNjVqeStwMmZCZ3hLWjl6Mnh4?=
 =?utf-8?B?cSs0UkhpT0xXUitpcVlMY1dLUDIzcXc5bGpudlpZdUdHQlRXamtEOVlTWWRy?=
 =?utf-8?B?VmlLOWF2S05RdEVGZWJiQXZnTVJ1ekJodVJoQkFpeFlZbnhOc3duTVA1OVNC?=
 =?utf-8?B?MEdCazRDNUptbWdGazBFK05HNU8vOStmcERYRk1zSGZmRnh1dHhrcldML1Ir?=
 =?utf-8?B?ZmdpZFlCYXdpUTFyeUthekhOMWxNOGhPa0k4Y0VkNzBRVVIzUEJiUFZXdU44?=
 =?utf-8?B?NFRzbzJMNzN6eEJpMEQwYWUyNkcwcGZKSkVqeGZhOUdBVEhjNUVIM09NbU84?=
 =?utf-8?B?enN2aGxReGFCTXFub2FjdnJINmoyZlgyVjJHR0Y5ZU0rY3FvV3kxdjRDQU5i?=
 =?utf-8?B?TEwxL3FLR1NONGVZRU93TGtUV2pCYzZTcWQ2MVpDNlVGcUNJeGVOZi8rc0s1?=
 =?utf-8?B?RDRIZTczdEp1MnhyVzlXQmdVNGQvdVFubVhRZzR5Q1psV3lzcUdGZDJlSlQx?=
 =?utf-8?B?bzZWRHNsa2ZuMkxWOGc4eXhFbzBabG03ajQyWmh3OStUbHBBNGMyNVJTcDZK?=
 =?utf-8?B?akVaL3ZYTlIvUCtjZjBpNERWL3JpZzRjZkhTVlJNZ0ZydXJHK09HU2RRUy9r?=
 =?utf-8?B?aXN1WE12YjBPenVJbHBhRGNoUFhWL0dQUkpBblNQQ3RnZjJiZFk3Szk3bndl?=
 =?utf-8?B?NmptaDJHRDd3cDZ4akpQcUpjUWozcFNCZnNESmFHQTRMSmhlV3BLdERpeVNi?=
 =?utf-8?B?KzhNTUJSU0Z4aXhSZXpUYzh3NmZnS3JyMWZuZDlvWDdia2hqREdrWmhZRzFn?=
 =?utf-8?B?b3JkRGwxanR4d0NxcWNtRGh5OXBFak11dDdkZTlQclhJMEsxZDRuQUExbmFi?=
 =?utf-8?B?bjJBRk5UZ1Nzd2J4d1UrbFVHVDN4ODJhMDlhZ2x6MXd5TzFOTzdiRmMxVkhE?=
 =?utf-8?B?anJOanlzcncvZy92V3J6b1NvbmFhaXk2cnN2c3JNVkpKdm1rUzJaNm1hNlBP?=
 =?utf-8?Q?PAvbZe0hZdn/08umTu4cTA+bxvX7YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzlWR3M5SGF3UnVOVlFpNGEyRUtDRDlqU1g3QXhqWWhHeGthWjVSelJ0ZGpi?=
 =?utf-8?B?RUtjOHlGNUlxZTc4ZHRKL0xZa3NZd3BKWTN4SlRmbVBxKzB4QUljUDg4SW5q?=
 =?utf-8?B?ZGdwVFU0bVE1dHFxSldyTWVFV3plSmtCYWo5bmpuUnBZWGoyMWZOV3pZeGNU?=
 =?utf-8?B?MzFJSDlkTzJNMEY4VXRTWXZyZzlpS0Q3STBmKzhMUXZUbytZT0VKUXFTcWRG?=
 =?utf-8?B?L0o1cGJDL3FwMWFid29jZ1hIYnZqNmNURFQvVzBuUGJGOElUMEd3N2xJaTRk?=
 =?utf-8?B?RlIxRi82TmFVRFByYjdrQVNWN21tZlVYckNRRjZCdTIxUjlzUk1yTnFDZ3h2?=
 =?utf-8?B?eFIvaFM2K0wxd3BCMUxkZDIyT2J2dEdXckVzM3lZYXRkN3FnSWdrZ1FLZEds?=
 =?utf-8?B?SUFVQ2pBbFJaY2c0ajZHbWhJYTB4a2VoZWhpdnB0Qms4ZCtMQ3RZZGZlTXlF?=
 =?utf-8?B?a0lkaXRKazJKSTRHQndWYlhIRkFhSHFBUDVTcEY5UHpURnUybnAxdXpDVUJI?=
 =?utf-8?B?NWs0bXNZdkgyZWwvay9RaHE0RCsreHFrUHFXUmRoMm9HR2tUd0o5bUw3MDBV?=
 =?utf-8?B?VmhPR2h4RkdnaDBkQUZKUnhvc3Z0ZDVSbVZQOXNXeTZQeHJSdHhtcmVkVVR2?=
 =?utf-8?B?SWRnUi9NTmNyNWZSR1Q4RFI2U1FOOHFoZTZmVnNRWXRhNHBBbjBReHVRU2tU?=
 =?utf-8?B?ZWJQaHFDblB4SFBkNWJsUDNhWklhb3Y2WlpvMFliZGZ0Sm9PTGFUUjhkenVT?=
 =?utf-8?B?SU5FZ3hkYWJncWwvdlpSeWV1S094NjRXL0I4dlA1Q3ExSmE0L1NDM0dQNnlO?=
 =?utf-8?B?emVvMjZJYndBQWpUWDNHQ3oxRkUvSlJtUytTamM1cmtUekxkaCt6S05wSkp4?=
 =?utf-8?B?VlNSeit0QWRZN3JCVDRrL093UnlBV21aaGRHWXRDOEVyRFU3Tk9kUGdBRDJU?=
 =?utf-8?B?bFdiUkNHeWV0Z0poODQ4a1daK2hVY0JxTXloZ3hBSVl1RkhjWWx0SUpzSENv?=
 =?utf-8?B?YUI0ZlRCUTJjc2dHYmJkYXE0OEZBRk02Ulo5T2RoeG5RUW9QRnpQc2M3aXdW?=
 =?utf-8?B?OUV6V2NrTVdhZko3VDlubnhXZE9Zdk1NeVlNc3h3MDNoeU10ZXlHY2swN0Y4?=
 =?utf-8?B?WTdzTGtqZStNcGthRHpQU1ljek15cmJHakFsYWJvSGlCS3VFd2dBQ3lnQVcx?=
 =?utf-8?B?bnZ3VGhSVUZzZ2w1RU1JbkpIMUNTN1hYb0Z6b0E3U1NpUDhPZkhaWGo4bkhB?=
 =?utf-8?B?cnJDeXY4UUN6NkRSQTlvUSt6dVBMd3Q2Y3psQXJzdkJsTmtrSDlGbVlrL2dY?=
 =?utf-8?B?VWhybDRqclFUeE90WDZKZmlEZVd4QlZtT2k1YmhkbnVubCtMMG9CWmV3NkNx?=
 =?utf-8?B?MVRxV25JSlMwVWtLcUZiU1FGTWdYWlVSSjdhR3ZhbWFUWm9BWDFleGdJV0ox?=
 =?utf-8?B?d3NDQmhIVGZhQk55ZkhCSXM3bHpUbTBuMDBleHVVOUhiT2UwUTRDMktnSkJU?=
 =?utf-8?B?NUc0QmwrOUdOcERiS1hmRW02eHZRVy9sTVJLdzREamFsa2FTcTVpMGZIZ1Rl?=
 =?utf-8?B?eDVKcGFkbDNqYUhqdTdia0R0azJHZmFOQjFUVkdMaGFITzVJd3pNREtSRCtM?=
 =?utf-8?B?QjJQRHorRnJjMWRvK1NjbVRFUG5hYkxhYUFJRzJ3THI3OW9vU01xMVFTZWZi?=
 =?utf-8?B?cTlzTzh3Ky9xeDdDVHBEd2xGQnU3N3NqWG5mbklnb0tDaytYeUpTbmE5YThw?=
 =?utf-8?B?bExaYmhlb0NSSEZWV05DNjh5d3F4dld0Sm1PUk5INWNYWXhYZ3NWNUZCTE83?=
 =?utf-8?B?TXo3cXVxalNCa2RhSlRiRTlicEkrSkRsQmppd1ZIeGQ0RU1KbTVhWFpOemNw?=
 =?utf-8?B?SHRuWWFaRFMzNC9mRXdvcHV0V2IveFlZQkQ1R0NSbVJvd3g0WHE2L2ZRYlRS?=
 =?utf-8?B?YmZQNldzVnIyOHFFazNKSGdZelhjNmxGazIxcFlRVkNUR2EzNmt1dDlhVXhB?=
 =?utf-8?B?Tjh4ZFBUT2FpakNFVUdFYUZEY0NQcmxhZTlZajNjTE9IRVFEQnduZHdzVUNx?=
 =?utf-8?B?bHhPbnl5REpkKzNEbFpOY3loRDlXWmNKdWN4cnV0SE5kSUtiODRxS3VMWCtF?=
 =?utf-8?Q?5dIqCEsSRMcEW/qHypR/My+NI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a894a27e-2528-4534-7003-08dde6cb0670
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:09:41.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61E5o0tNTYmBSB+feIvpxMjE0etW+zRo8mgaac3d1SsonVJ9KlG5wmOHL4bRuGlpaADmdSy6p6iBAT3S/vmVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4ab03afdae949c8316f31467d1377..c229b748ca7aba2dc8cabe14d66e3d1dcd704c9a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -106,12 +106,11 @@ reg_audio_switch1: regulator-audio-switch1 {
 		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	flexcan2_phy: can-phy {
+		compatible = "nxp,tja1051", "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_m2_pwr: regulator-m2-pwr {
@@ -317,7 +316,7 @@ &enetc_port1 {
 &flexcan2 {
 	pinctrl-0 = <&pinctrl_flexcan2>;
 	pinctrl-names = "default";
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan2_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


