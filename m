Return-Path: <linux-can+bounces-4404-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19711B3D725
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 05:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660D8189803B
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 03:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B340222590;
	Mon,  1 Sep 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JutD1CME"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D021CC43;
	Mon,  1 Sep 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696739; cv=fail; b=GlCDOZXDdOMQmHxUcnbFxdDHPLA/EhO/7UBE5iTgMA9mAWckvaBn/j8jzWwG0ZHPdbsLMXaNA2YthDe00egZTvSjKs4eTwYkV+Boq/E33B55vlX5ccLmY687hAmczPmkscheV0jS8fkI9oF7h1PDq51ydJKI7aOfO+GBKGFjIPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696739; c=relaxed/simple;
	bh=FY4pPZ1aDEMyqYllvZTAPBnGkv/MTxPgh/KCOmnd5ew=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=utn1GtP8txZRmDWKoW4ktc2eJ3fv6joEngmkuFaAgGE4Y2e0pc2KtVpreadAhXlGVHJ5Pdvqwbz00ihSNHd47PhjWnM9848GQqRt2HolURUwL+ZTJynbXXKlUKwfCKNA0KjeUi7fsFelrqCNGb20xLCI/aAzFMj660mry0hcd3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JutD1CME; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QX0CI63GNg8K+7MdZ7IxOTL9Yn/gqd+uYG6Q/JMtdeebkqNOoiN0Z7uq1iI0aop2EsxvHdikXFUcU3nF4vC2KHsQOxRsuqAUzNRgbgeYXQMJDymj0pJj1qYemox7OVKZswHrs0LD3FV5Zkw7Yv7h4O7QVwmhfs5Oc6lDLaKuzgvKUyh8FIKk9to+9QDqHxuuiOTgm5lLB7/Y97e/OVxJC5yCA2KR3DIPoqSrMvQVtMyud+DMEHdnFxy22zDXq0gWnDSciQnYjrZwf6YHQ89PIxanJO9Pf8YM5lsNhmzRTZPXTAqKicohrr0A+7fpNuecf83RwwGGDWS4zJpOokoSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoupLKXdR+Z7rmxKgymA6UFa1Dro42TjvfEoLuUf82Y=;
 b=ZMDURWrsx5aGBdYdHvGkbWBpMxOfNADH9rNR09IcbYtJU14WHf850+eMpL0tqsz9LzST/Gs0ZUof7K/NHZ4hTpzeBqezHEY1A1+CYCXBFJz3xXyES9We6csLngA5ULRagyofOIPGnJ4MUEswv6mJxmi4Tj487hUHiW8kiQfTusw0T028jySqnY4F5n5TpM0d8uWpyhwlfINWyoU3oXuElIu4IFRpVj+3xcs96RzOpb09D5F932mbsA1oJgo/n3vL8eC9JbB1omI9vvkqX/a5BZrpvfTLJS48YYwX6QRTqegIAKNVGPTdHYqyq7DsTXUqpEdqDhvwk83ejNuHpcgTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoupLKXdR+Z7rmxKgymA6UFa1Dro42TjvfEoLuUf82Y=;
 b=JutD1CME6NHPHMA+akoe60f8DoOfG2cG9XGBwqjHvdS/IZo7UV4tupPZmht1CrBsKPsiz7srALW/4TwJgTphmzwFx046sA4xogH9EBCuYBtIWzi42XKJ3cy+oS6nIvDrFbTPOnbYDpbO0sRb5Tm8cnCu64y2GYWWiu3DZqZnyE+P649Bw3c2uFc9aC6vdI9Tv+7u5AjVcH1X1/S94oPIvQTGGvZLVwTtfvgA61CwgsjvLACvPKGKbf1RUmiqCthgL6EmAmuLOZozTodfgtsH4+wUYadwyZ8HEQx2M5VsowFHX2Vc/1uc1Ia1t6C4ROZ+Kif6+AIQsk0/af/f9fOMjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:18:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:18:54 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:18:13 +0800
Subject: [PATCH v4 3/6] phy: phy-can-transceiver: Add dual channel support
 for TJA1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-can-v4-3-e42b5fe2cf9e@nxp.com>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
In-Reply-To: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756696708; l=5981;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=FY4pPZ1aDEMyqYllvZTAPBnGkv/MTxPgh/KCOmnd5ew=;
 b=htKf+5UpZXUP9pJ3qpVHmgoH6kCgpTvbYc2rfJHqDa1I3R8Y3vxWOzkum3+fy0cVT0EV/XV/+
 ceLe2S/8bjqBqSI6tia9F53ZWpre535y48Lz9wbHoppoWV/Td8dXkYz
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 31002ea5-9a46-4681-803d-08dde90647a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDM3NWJVUHZiYzJtMUlTRlpHZTlNaWhndmp6d3ZHY3UwdDhxTW5VUys5S1lD?=
 =?utf-8?B?MlRPUUhSRytXZnFUTTA0ZFNYaktucS9GUUJRcDVIUlI3TnJvQmZ5c01peTN2?=
 =?utf-8?B?N0E0ZzFINGpOU01QS0FPWmpNTWpiZ3c3NjhFMGJlblpuZWd3ZzZGOHViV1F5?=
 =?utf-8?B?VU1KWUhDYlZEcnlrbXdzVDJ3OFFYV3hqTG40UWV5QlZneFhaY3dZNHhXTHo0?=
 =?utf-8?B?bFZuYnc2Y0IwVkljVE9PaEJoQTA4eTV6emRSYkEwd3FSakY5M3BJb0dYbHF4?=
 =?utf-8?B?OGlCZFBkMnp2ZURCZ2RLMUF6djFsdWZlN2RibVVrRFZiVVl1UllUalJXRjlw?=
 =?utf-8?B?NDJHRkVXeHJHMGRZTXIxOXp5STBOWEhzTHF2dTlqc3hnN3E0eDZNMHNhb1dD?=
 =?utf-8?B?OHVWaTNJZmtqeWdJWmJOSjRyNkZ3RGY1OEl5N01GQXpTbmhCN3pOc2VTTk9N?=
 =?utf-8?B?b1lpVjRCdTdmUXBvWittOHIrTlZmVzRTYTJMQk95L2k4eTVXWWtCVkZkKzQ5?=
 =?utf-8?B?di8rN0xTY1VOL1E1dGV0dzNDTkJ4emNqZVlQS3cxeVp2NVR1RUMydG04RHhJ?=
 =?utf-8?B?aDJZYmc0Zm5BWFpZNzZORHREUHA0TjhMNmNia2pWRFhWcnU3cFVZbmJHK0px?=
 =?utf-8?B?Zy9NTk9zYXlyTTZrcTFEanBabUJSMkN3Y1RhYk83MVpuYk82OFpYUXBySTNU?=
 =?utf-8?B?ekk4NENuNTQwMTZvLzJHR2w5UmFnc0k1WklIckE1NHp5ZkJiM21mQkZtR0ZM?=
 =?utf-8?B?Q1RxV0NOYkN2d1hyRE5pSTJ3WDc1V2RpMFJkcXYvSmw2djhDQTZMRjd3MEFK?=
 =?utf-8?B?TEYrY3VpVFhsQUZqblp0cjQxM1FOM2JVRVVvY1NwbGM2dUhYbkMrdFpsK3Nm?=
 =?utf-8?B?SzZQRmxzZEI0TS9oSHZWVnNzT0RBckh3NWFaWFdkNVZUdkZ6a0ZZc2Rnc3Zv?=
 =?utf-8?B?enBzTXoxR0QvaVovM1VBRXZFd0lURGxnUG5hbG4xMlRmUmxqZDRKTEJjU0Nw?=
 =?utf-8?B?ejJtWTVhTnN3N096aFlRbjRidHZabHQ3QStFd2s5eWtCYnpYaUx6L2t6dVF2?=
 =?utf-8?B?cHVnclBMdHNEeHc1VlRWS1JBL0tVdUlVWUZWZkNvYkVCVE9WNDFlL3VKZGw4?=
 =?utf-8?B?RitXYnVZRi9OVUQ2TE5Ud0EyVWliaktneS9SQ0xPaU1ZR3Z3azFmZGY0dTVY?=
 =?utf-8?B?ZGlTczhscFdSUnpUaHYwVW9oNlRvbU5jOEYvbTdOdFV1cGZLUjNqTzR3UDBv?=
 =?utf-8?B?WGhqMFBYMmRUNzRMeWtSaEh3SFBkL0NJcDhJVWsxNFZIVmZzTC80YmtOSWxB?=
 =?utf-8?B?QUlneVJTeVhnRzI0SEtGdFovTTRxRmFONmU0dWlreFVMQ1hTaGo2TkFmMGJW?=
 =?utf-8?B?UTV4d0owSFJqYUdMNEJidEpwdkhIbXgwY2s3elovS1U3UjlhQUdDNFVvT1NK?=
 =?utf-8?B?NWF3QjFTd1ZkOThXMUlXaFpkNnhvdGVBd3gwR2lkL1RjZndicTRTeVBXZHBB?=
 =?utf-8?B?Syt1V3FYeDI5VlRzNHE3dlc5OEx4T0lDYXN2VFFCV0VuaXh2QmM1TU1NWmxt?=
 =?utf-8?B?emlZQmFTTTFSNjFnYzMrTWV4Y2JJQkxOUkxlaEJCU1ZzRlcwVXVBcXkzcUkw?=
 =?utf-8?B?YSt1VUd1MkNRZHhFU2JkcHFiNGdFeGJJZTJTRTF6T1h1QTU4N0prM1VpQUJs?=
 =?utf-8?B?d2lTcVB1WXkwYlIyMDhTeVZ6T0ExMUZlWnpzREJxN2RMTXNWNk5maTQwOHRE?=
 =?utf-8?B?Mm00bEdxRDFENTJjVytxOGg1eWpUNlNkLzNSNmRRS01uaG1JYlJzVTdKYVFT?=
 =?utf-8?B?M0U0elRLYjNIZUI2TWNNU25neHJMWFNCeTdVK3RrZ2ExeEYxdlVTdStSZVRh?=
 =?utf-8?B?M2xHdnkvZWM4NFFReUo5b3RiRGtBeTdYWFVESnkvUUhGbDduMWR1Uko0ZlpD?=
 =?utf-8?B?QVhoM2pjQm1Qek5WV1BBQkx1YXdCZjFJMEo5cnNyc0huU0RZN0hHRHJtNG1U?=
 =?utf-8?Q?u9PAkjlu6lrJ/L09AsIFpULN2NxoUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWlNeWg4eXpsbzdYVE9pbVpxS0FiNlRYdmVXYjN2K09KZ3EwUE1uUmt5V09v?=
 =?utf-8?B?MFhpbjY3bW14RzVVS2RPSEYwVU5hSHBna3JpS0xGQ1dGZnN4S25yQjlHV0RK?=
 =?utf-8?B?MmxMMHFiVXBSUG5rMVdRdDM2aTk1STdvTjVmUHphd1hJTWd6ellTMlFuTitK?=
 =?utf-8?B?bnFRdTNjcnlDbStJTjhzVWQySjdzUmNhTkdQT0UwekIraFRMQ3NVTDdxdjBt?=
 =?utf-8?B?SEpkL0c1eVJ4aGJzOVJPY05sUjlVQ3N5OUw3V0NiaVBraTV6em04c1gvUXEx?=
 =?utf-8?B?YllNbHNXSnBMdFN6N1VwU3dsb2piUGVCdzdGYmRJTFNpSnpZaEtqY29pUkdL?=
 =?utf-8?B?eW95cHdOdzRIVEpodTlRV0FETzZqUWZXZkc1dm5JVEZIYjhsMFZ6RmZPVVJH?=
 =?utf-8?B?V3o1WC9jZmdiVEtXMHdLK1o4WDFvYUcrb1ZkUUlVZ3pDN0EzQWQ1d0tOOXhI?=
 =?utf-8?B?UUowMytvRVlBRnFNU2JVK1FjZlBpaVc3Nkw0TS8wR09EZkdnWjN0UHZleDhT?=
 =?utf-8?B?VkpXVVZTSmg0VWd1ejJZRUE4ekxwWmk3K3NtNzhOZG9uaWllN0Z4MmlML3E3?=
 =?utf-8?B?N29nYTNlK21VdTFSUzYxMnh6cjZySWR5ZzlGc2srRW9Kb0xIbnlOTWFQcUZ4?=
 =?utf-8?B?OGdxYS9aZEI3d3JkN1RqSmxRTnR4RXhsZ01GSnpnOXFkOVkyU0JXMFkvMTNq?=
 =?utf-8?B?VGFyUmR6OEZFNm5oaldqSWxJREU4UEZxYnBBaFRmMUk1YjY1R1RjYkxTemUy?=
 =?utf-8?B?TEpZS1pUMURTaXdxRk5JZkNCNWJZWHVyUjk1VFBqd0t3NjVyWVI0cExsS3VG?=
 =?utf-8?B?U3RneEF2SWcyMUJ0Um5JVC9OTUJ0YWNHK0hZVUVhZTNZN2RuUE56TlJEbEJa?=
 =?utf-8?B?dW55ZlBab2cwVHBBSDBudGQwMGxhM1dQNjdiNEpNbG91QnZ5aWJWUXFIZWY5?=
 =?utf-8?B?QWVEMHVTY2toeTVlU3BBcVlXdEdRT3lvanBpdVc1bEYyaDAwM25sUXVLckJ6?=
 =?utf-8?B?OHRXUUJBVjQzOHFMMk50UzRCQUhZVkF4QWlwVUczbDJkRnlPMmtvU0tmaHJl?=
 =?utf-8?B?eTFUWlI3WlpWUjc4UVA4U29taXBwQm9XczZUaU50V0FwcVdXbW1YTUg0Ry9M?=
 =?utf-8?B?cENJaENXcWpCdkRuTjZYQVR5TUcrS013Ym1vc1Bwc2xSU2wxb3VDMG1JRFNt?=
 =?utf-8?B?eHEvNVloS0RRQ2M0TTdEMmxLaWdYeGc1bS8rVlBzUTN0VjdDUVdtbVlPNFRY?=
 =?utf-8?B?SVY1c0p5WUptQ05NcmgyeFMxeU9ERzE0K0tid09FbExkUUlVdndEU1VoOVZq?=
 =?utf-8?B?MHdwVXpqbC9nVk9INmNVcDBmY3hRYzRnSzd1WGk0MG1kelZlY0lMSGdSYzR4?=
 =?utf-8?B?RVM0eDNsZUpoNWFNcDR5WXdMa1ErbWVKTW1keGxEOEtKUlBxRGdaSDBkRENt?=
 =?utf-8?B?RkhsaFpCYWxkbzVMdXVQeVdOY0xlRHBtYTZ0TWpFWlk1UFQxTUhvcitlMllI?=
 =?utf-8?B?ejZ3d29kREVQTnBMN0ZNRGhDcERON2dIZTBTc2pTNTUyeEJPUVl3L3JadFJv?=
 =?utf-8?B?UEZDR0ZmV1h3K0dmRWFSM0x3M2xnd0ZXbHlkbEQwTDVEOGQwVWRnQVYyUTA1?=
 =?utf-8?B?V05saitIOVFuMmNoYXFtditSL0RuWndIZ2NOZTE5RFhyM29vNzNzMld1M3Jk?=
 =?utf-8?B?NEd5NDhXa3B1bTd4QmdqdkxaMDB0enFSdnA3WlZUMldkY3VmMFpqS25saFRO?=
 =?utf-8?B?SEplWjB0ZXRJREwvdlIzWk91ZGJXMWNGVG5FYVdSUFdlKzgvSlQrT1RsdGor?=
 =?utf-8?B?aDV0ZkdSL0VaQlVzaW5TOXpCcWVPZU9CeVdVREozdDBPZUF1d3d0eGlBY1lh?=
 =?utf-8?B?Qk9vb1FPTzdwVVhOOXR5TkI4RDlPTHpYcTFCNGMrZUdQa3A5OXJkc0V5Zzg0?=
 =?utf-8?B?UkwrbTNxeThNRktOZE5Va1JyamhGbVo3UjVEeUh1U3hOVEZxRmdIVnBVMEUr?=
 =?utf-8?B?Zk92S2xENm10WTQzb1RFamZITmVhb0pxQVlJVloyYllpcFVCbllZZ1pVdi9F?=
 =?utf-8?B?a1JweEJlQ3h6aUFpbHAwd1RlQldzaFA0a2RSLzV2MGxrT1pndFNUaTAvMm1W?=
 =?utf-8?Q?H7TkHqnVxQJBf8PetvYwLRYPw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31002ea5-9a46-4681-803d-08dde90647a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:18:54.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/Bmm5bzkMZY5YPr+SJWOTi1aU0Mjqn3typXmNAojEmSasAfmP4c5u8vY/sPowyZ7GLJkYo/77REzM1SfY7ZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

- Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy has two
  channels.
- Alloc a phy for each channel
- Support TJA1048 which is a dual high-speed CAN transceiver with sleep
  mode supported.
- Add can_transceiver_phy_xlate for parsing phy

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 6415c6af0e8414a6cc8d15958a17ee749a3f28e9..f06b1df76ada023f432dce892c3346f45397ab54 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -17,6 +17,7 @@ struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 };
 
 struct can_transceiver_phy {
@@ -29,6 +30,7 @@ struct can_transceiver_phy {
 struct can_transceiver_priv {
 	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
+	int num_ch;
 };
 
 /* Power on function */
@@ -81,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
 };
 
+static const struct can_transceiver_data tja1048_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -90,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "nxp,tja1048",
+		.data = &tja1048_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -108,6 +118,25 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 	return devm_mux_state_get(dev, mux_name);
 }
 
+static struct phy *can_transceiver_phy_xlate(struct device *dev,
+					     const struct of_phandle_args *args)
+{
+	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
+	u32 idx;
+
+	if (priv->num_ch == 1)
+		return priv->can_transceiver_phy[0].generic_phy;
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = args->args[0];
+	if (idx >= priv->num_ch)
+		return ERR_PTR(-EINVAL);
+
+	return priv->can_transceiver_phy[idx].generic_phy;
+}
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -120,7 +149,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err;
+	int num_ch = 1;
+	int err, i;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
@@ -131,7 +161,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
+		num_ch = 2;
+
+	priv->num_ch = num_ch;
+	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
 						 GFP_KERNEL);
 	if (!priv->can_transceiver_phy)
 		return -ENOMEM;
@@ -142,38 +176,43 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	phy = devm_phy_create(dev, dev->of_node,
-			      &can_transceiver_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create can transceiver phy\n");
-		return PTR_ERR(phy);
-	}
-
 	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
 	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
-	phy->attrs.max_link_rate = max_bitrate;
 
-	priv->can_transceiver_phy->generic_phy = phy;
-	priv->can_transceiver_phy->priv = priv;
+	for (i = 0; i < num_ch; i++) {
+		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create can transceiver phy\n");
+			return PTR_ERR(phy);
+		}
 
-	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
-		if (IS_ERR(standby_gpio))
-			return PTR_ERR(standby_gpio);
-		priv->can_transceiver_phy->standby_gpio = standby_gpio;
-	}
+		phy->attrs.max_link_rate = max_bitrate;
 
-	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
-		if (IS_ERR(enable_gpio))
-			return PTR_ERR(enable_gpio);
-		priv->can_transceiver_phy->enable_gpio = enable_gpio;
-	}
+		priv->can_transceiver_phy[i].generic_phy = phy;
+		priv->can_transceiver_phy[i].priv = priv;
 
-	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
+		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
+								     GPIOD_OUT_HIGH);
+			if (IS_ERR(standby_gpio))
+				return PTR_ERR(standby_gpio);
+			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
+		}
+
+		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(enable_gpio))
+				return PTR_ERR(enable_gpio);
+			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
+		}
+
+		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
+				&priv->can_transceiver_phy[i]);
+	}
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }

-- 
2.37.1


