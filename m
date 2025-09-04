Return-Path: <linux-can+bounces-4464-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C00B435E1
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA271BC87EB
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8582C1786;
	Thu,  4 Sep 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXVZS571"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843083596D;
	Thu,  4 Sep 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975031; cv=fail; b=liwMZO03iQV4rxRXEDNVDqUzVQAuWMQbum7P6JkS10RLYNTCtPNQaCGogqOLbLQl5virgg2pv281CgE05OEDqf2ga+FfqbD0oGsyVolg92xOXZM9wJghPaqk8uINDZ9Xfw87X2Uyn/PaSA834SNvM/NVsHQuVKL7Ld65ZngHqG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975031; c=relaxed/simple;
	bh=Fv8ilU00fQvQ9QHgHajkp+2G/P4EO0415Eva1Op3nVQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=W1eRLRdnr/6srncOEufnSMoqAxS5sNNSEdtWNII23oh8MUjnVwRreJ4u1/RDfde/UfGdqDK2w3yyGUux9iudf/frXqacS0JqmG2jtRwUqLRwN/g95m+mPaQu1psRfssPOe7mhvGgqnxF4bVr0p+/2U6feqyYp1S+JY9aHJGyR9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bXVZS571; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THpDgs2MM+kWVmgVOtzGAQ0iKg11Wto4kkwBWQ5e7OkVw+vmBEupAs9OX35T4RggnXVzdzz5Kv75My3/RSwIAtN2qIh7eSoCqC/gKUba5B8Zz+PeXbv9euGNjxAKppdiT94DTocrzWK4ozBGWADHH/FbqRBY/fov7SN1LDgsHfKAuzWTCq8X5EAFP2uwrtCEh1AR3JnOTO5HdpWi/E9zLOJ19cFD480dVepDkcCuMtj8u6dzX5sbRLV332rPZj3yDmRVImsRWJCZaFnZUaqtlZHFM6LUXa2jpJCuMDsbSJRGlKGPB8Z/cxyzbgAMQ85G7fw4i2EeH5A+d+FjcGueBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHRgqQ4RwBk3Y/7900Un3j879V4i0GpznjvFDXphtmw=;
 b=eQN01j3fTeajnOYsm1kTQ3KCfe9gfPdZHcm59t+baIV+oz+yRj4C1fGHaOWC6UbLNsN8iCvR9qFZIDcU4/039QedUQOC8hwIzUVoa2XrCP2x5vwY/b5Ha8WlxY3nVKpRXNTp/D0CfHK+4eI9jEXQ7HKCtuVYiprdfDbkE4kGfHQdXzxO7bO3e7xDSke8SzXeyHmHlsxcYqDXpfsTb3RQXxh6tfj5LyqEzBdlu5UysdjQI+sQT62Vjc91MqpaVS/KQrpc6mwMg+a5Pe0mtPvW++Reb+wb38mFUHqJtIn3Y0xuzE4U9A71RBymvUfAHhQq99XGQ3IIIJiSf0N2H3czJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHRgqQ4RwBk3Y/7900Un3j879V4i0GpznjvFDXphtmw=;
 b=bXVZS571XBPV/8hcuRb6FGNjgR3BbLqS1/pfl1F5OsFUd71XzF7uAgCZA16U8NQms0TIfeGhpLyzoz3ma/SiqYA5Coc0qhAEikJQlDEQp8QHd/HrgC2cJNVYVxSQYr5oU8thzptq81lXAo6KkVHZ/TTqFb25Do2lnyL8yoN5ssAuVa73p56bVwx+I/F603PMcrTTXt7XU0tHAsimfLhBMoeU1LhHTLWoRcnIDTrxkgrebC7XZX3FgAf/seRpORrmzDjHS8vM2dXmHlLUAuzjoz83C5yW1MFCM6SB9XZgaLDrXd86Q0PWPASntQjmit/i//J6PbDoIB48zchgrQE2Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10507.eurprd04.prod.outlook.com (2603:10a6:102:41a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:06 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v5 0/9] phy: phy-can-transceiver: Support TJA1048/TJA1051
Date: Thu, 04 Sep 2025 16:36:43 +0800
Message-Id: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJtPuWgC/1XPTW7DIBAF4KtErEsF81OHrnqPKgsYDw2L2pFdW
 aki3704jhp7+dD7HnAzow5FR/N+uJlBpzKWvquBXw5GzrH7Ulvamg04YHcEbyV2Vo4Ikig7BDS
 1eRk0l+t95fNU87mMP/3wex+d/HK695O3zibiGL1nadr00V0vr9J/L2OPJjyb4hrOjYPYavxvL
 vdMsN3mVcAi6M1ryJLE017gVoRVYBWYICO5QJnDXtBTBPd4P1WhBImzguSge8FbgavgKtrMDSh
 G8Jsfn+Z5/gPLUeQOhgEAAA==
X-Change-ID: 20250821-can-c832cb4f0323
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=3126;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Fv8ilU00fQvQ9QHgHajkp+2G/P4EO0415Eva1Op3nVQ=;
 b=/u7OhCUnIpXPFIbna6aDU5xWitIvaKTtyr9ndYQI6AY9hf5IC6xu0jHpDngAL+gNJLKYNbY8F
 nS3IblCRcEwCJrxOwWkbQAi+hq2u7EtYIdLlCiTbsbc1pZtqTrmmd1Z
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA2PR04MB10507:EE_
X-MS-Office365-Filtering-Correlation-Id: a289a82e-fb51-46a8-20b9-08ddeb8e3acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1ZHSnRzS2IzY3lTaXExUUMrb2pMR05BN1lXVThUSkJOZE4zNytpRUE5QlYx?=
 =?utf-8?B?RW9vU3dTbjhvWllmU20wOG5CT2pnR3VRcm9hK0haMDJ0OHdLZ2ViMjZvNDM2?=
 =?utf-8?B?OXErbVYzWEpKRDJiS1hpcWRUNmo1RytqT2FOSjh0OGxha3ljVzdGWVJ5WEd0?=
 =?utf-8?B?cVI4RGE3cmdtOEp1azAzcXV2UFhhZHppMi9oNmtuWWhrSncxeUFleTFBK3lJ?=
 =?utf-8?B?UkhkdDVNR3piRm56YmdTKzFTZVVDUkdsbWswWEtZbC91R29ydncxdU0wL0sr?=
 =?utf-8?B?RVpTTHRHRG9Tb2xjemE5SmFHbWNnQVlwMC91UVhYOHFkYjJ3WFlSbVZCYnNG?=
 =?utf-8?B?a0dOQWZlVGhzcWFsQWxwaE9FVk9NQnNHSC9RNTlJTUFoU01UN0RlcXVYZmV0?=
 =?utf-8?B?Q3VHdlJPSW9IRHRVV2RJYm8vcWY5QUhzYnNWSEQ3aktZdHlrdjZCV252RnZi?=
 =?utf-8?B?bW1oVUJiNEsrQzh1MEU1ei93b2Yza0MrM3NLZlE0TTAyM2d1Mk5UOW5hODRt?=
 =?utf-8?B?aDFtWlBxRjVtMmNCd1VvdVZNOEh5cE5iNEh0UG1UdHVpdFdSODhjd0F3VjM3?=
 =?utf-8?B?cTU2ZU40SUlZS2l3ZnMrTUpmblh0eWg4UXlRTW9OZS9uR0YxbEdISktkV3hk?=
 =?utf-8?B?ZW8rYWtpRk1KSkkrZXZ2UHJuSXBJZ3JhYXF0UlExNlNsc3FzZmFwNTZHQzNT?=
 =?utf-8?B?QitRNFN1M3ZQdlpoVVpINVlNZlQwdWF3NFo1VnZMVW1ZaFE3MlhXTjJRSmU0?=
 =?utf-8?B?R2RvVDV2cWkxVTZkUlNwYWZ3ZVpNNkhIa3V1dDlVVnFFN3pRd0J6OGozbDhq?=
 =?utf-8?B?NlgrRWNPZHZ1eUZFcHNXTnFWelB6bjRGcWgwU1ZtWWVtTEJYVzY5N0R1MGpx?=
 =?utf-8?B?YWVSTzZnSHp0U0lwRUxuL3FpQUk1U3FQNVIzelgzcEg2Qy9QK0VBbmNvSnBK?=
 =?utf-8?B?NzMxd2FPRGZnWWJyZC9ndkw1bi9DWlFmSkdIQmozWG9IT1NTbmdrY2g5bURM?=
 =?utf-8?B?dXJydVJQd1pqLzNNT2lWVDVhR0xwR21YN1RpdHp0QjVIMFdrOXBCNEo1RlFw?=
 =?utf-8?B?M2VZVUNZSjJ3SjFjNitQZ2RJME8wUFRUVlhIOThsNnFNNlJVRFBRZFhlc2RQ?=
 =?utf-8?B?dk4wd2ZKN01kMnVMV1hpcG5USHhnMGludGsyZGthK2pFdGFhekpQVCtmSFhX?=
 =?utf-8?B?QU1rSXlsOTJtT3ZVTWN6ejhnaElMUWw3U1BoUm83MG5ZUi95bjNEQlFFak5C?=
 =?utf-8?B?Q2ZTQkF1MjRnTW81dGtNOHQwMi9qU1luUDk2dWVYRTMwN3pEbTJacG5wYVJ0?=
 =?utf-8?B?c3h0aHBmOXRsbWJPZ2VyVUc3THBBcm9NeUdrREZFcjhNdTdIT1dXQVQwdGhx?=
 =?utf-8?B?Y0NFVHFwb2l5NmplZ0pxQW1BSlNBcFgzTTJ0TERXaUZqekxyRWxpcVdKMSt4?=
 =?utf-8?B?cUFMTkFNeStiUWczYk00ZmZpYnlpVnhjcmtpVzFQYzFzZXdqTGhvcHhFem11?=
 =?utf-8?B?MHorSGZaVEMwMlJ1NjYwOUs3SUdkNzN1SjRubSs4enk5UXBzOTdHZnN2S09J?=
 =?utf-8?B?SzRHQVVTZ2UxNTJRRGFLR1htUEZ5TFF6Nk9LK3REY2xzeUhGQUhJdGJ6bWVM?=
 =?utf-8?B?Q01BTVc2ck13bWU0T21xM0plTHBxVC91NEhqdHZ5dE5nVVhPMnA3WGxRUnM0?=
 =?utf-8?B?bHVjS2crVVI3NnUwdXBtNE9lNGN0WmMveWpwVW9rQmVkUGVVL3BJU0NhRGh4?=
 =?utf-8?B?K3lxbGR0dUFmQ3ZRWmltWVZjNGlDTWVwQm4raGtUdU0vVG9EcnM4VWZtRlZW?=
 =?utf-8?B?NU1TMFF2WTI1KzFjVkc1Zy9LUVdBeklhM3hoM213SGZnd2JuSXFSK014Q3BZ?=
 =?utf-8?B?blRJcVFLTVdhUkhPWjI1Q0VTZ0NQZUIrYmZXenpUUVplOUZ3dXRTcWZndEhx?=
 =?utf-8?B?bFN6WWhVeVFiUG9GdmZZdUVvOFFtZ1lTRW1FZHAyaHRmRmlCY2NyekJrUTgy?=
 =?utf-8?B?MkJNdHdTWXpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhkWXJDTEcrSWY2NFlERVZieVBMUTVBVkpCem9xNEZPeVRsRnhvWGV4MXEw?=
 =?utf-8?B?UlV3S2tGa3U2azNCdlVqZVFUWDZOSXczM3dSOU9RWFlRVlZKUnJ4UGhHYTNW?=
 =?utf-8?B?L2tjbnB5U1pFeDNkMnhaVDBSTDNRSlEzQ01XVjhJMFMyemVybTNwTm9ZV2Rx?=
 =?utf-8?B?K2dmbGF4dDhzaVN0ZEtnQ1c2OEIxQS8wWXRsZlVTS1hPWFFia3U0NFU0amhV?=
 =?utf-8?B?VlEyOGZwSFZhMTIxZmNVSkxSbVJGeVVaa3lOV21JdmVOSXE1eityTUh0SWRQ?=
 =?utf-8?B?dS96U0k1eklFMkRMeGpJKy9ZN1BKV2J4QkJVbXJUUU9wRzMxVHJGYndkcmdi?=
 =?utf-8?B?NGZBR0Y1Q1RCcUJYWnRTYi8zZHBTZ2NlNkhDUDVEZGxSOWExNXpxeVlZRW1T?=
 =?utf-8?B?VWxJRkZYSk5MSHVkeCtVNGVMYnBHL0VMR1FIQXBsZTAwa3dKSFZVQ0tUZWVk?=
 =?utf-8?B?eDBPUTl0a0trWVlFQnFhSUx6UnE0Z1YyamdhMm1QcmRGZ29hVjlNRlp4MzU2?=
 =?utf-8?B?emJmY1RYY25LRFlGQkdsaXpsTzIzY2M5K2ZCSnNNTmdqKzBQV2RhV3ZTaFlw?=
 =?utf-8?B?NEtZVmw1UzlOOGlHOE5iU1p1OCtaOEpIT1JZL2M5ZjVTcHorZFVXZmROSzB4?=
 =?utf-8?B?ME5FbjBiNFpXMTVYbG1wQXNpc0h4SFNLb29SWVZkVnpDM0ExaGtkZy8rUlQ1?=
 =?utf-8?B?YjYxSTB5bjhacmM1NW1YaWVVNGlUckFVN1Y1NkZsUjNVUEE3MCtTdFZGZXJq?=
 =?utf-8?B?cWp3S0dLOGRvUEJMQVFmNC9pZWhPZXp6UkJzOTkvV1JrVVEvQ1B1U3dPTU5x?=
 =?utf-8?B?dHRsTTcxUHRvUjcwS2FLN1pydUVKNEJ4YlZyWVdINEE1ei9vd3M3aWF2ODhC?=
 =?utf-8?B?aTl6cCtGTVZ2NmpxdFdacmQxZ1htQ2F5cU05SUVJSlB6djErMnhpdjBneXRO?=
 =?utf-8?B?RXNDc2J0U3U4UmkzZmNjTHhZT1RPbUZRQ1ZZQXFRS2gxTkhyVDRtSlNHSmF3?=
 =?utf-8?B?TTNhMmp6OFUxNFRwalpScExjdFRpU0ZvbUoxY1g5L3lXcFhRb0ZsdThDZTla?=
 =?utf-8?B?ODlaSHM4a3YwVHYxdUE1by9NUDl5Q1BjZDJHRDVjTmhlOXQ3T2MyeFY2WlZz?=
 =?utf-8?B?RkNpUzJRblBsdE1DWXhaWmVrRUlINHE4RFdZV1o4bDg5SkxrY3JCbStucHVs?=
 =?utf-8?B?bkI2Zm9TdDdpcVE2bFZ2a1hkbmF4K0FsYTYyaWJhQUI1SFZaZGtnaUt4RXM3?=
 =?utf-8?B?aVlLVGJnWmhFRDJ1NnVOeTN2QjlmR091SXBLeEQ5K0hJaStGRmN6NVJQeXBu?=
 =?utf-8?B?akVNU3JhdUc1WjFVSEhnOGFQSjZSMXJXNDE3S1FxbEM3Tks4LzFYRHQ2Vjli?=
 =?utf-8?B?Y0xJeWYzWWJyazd3WFZ2a2F2KzY2RmFCNm1lbjlXVnhzeFZ6RkhMdms5ZjZT?=
 =?utf-8?B?Y1RRaUQzLzhSdWZiNzM0RDdIVjRlT2xVdjcyT1NZWmtRc05LMFpCNnJGSGh1?=
 =?utf-8?B?NVNVeEJ5eWNpQXUvTHhhNjVCZis3MXkxT1MzbGVsbW9uNFJoZGphaTJqbFZz?=
 =?utf-8?B?QU9aYW1DeFo2emlmcHlxakc5RWVhWlJlMkVEZFhtMnZFWEtnUlFzakNZUHdm?=
 =?utf-8?B?S1FqUnhxajBOSnArM2RTazYyR3IwTXlEVEdISWlzUFNoaUpYMlVReWRBRU1L?=
 =?utf-8?B?RGdIU1ZFK3cyUXNVWXhpUWJPOWhtRlZEQmk1OUg3OFlpblVYTWJSazNYTERN?=
 =?utf-8?B?WnkxUGdKa0diblowb1d6cXpYNjJ4WDdZc2tBeU0zb3NSSnp1VkFibU1melRW?=
 =?utf-8?B?dnV5OC9TYzluRU9PaHRPWkxuYWk5M3JXbEEydEFxaWhvaC9tcVNWcHVyeHdU?=
 =?utf-8?B?MmFSUWZXZTdUTFBtWmJTb2x6S285cWZLUHRFUndqOFdUVWpycjM1c3Q2Qy9q?=
 =?utf-8?B?eWtIakhUSk0rc2J5ZzhSOTkzdEw4Z1NNc2hPQmcwdVNpWmNlMWEzQ2hiMWRJ?=
 =?utf-8?B?SlhrODBmNUdXcDUySGNJNFpnNmw3enBLUUlrSkhJZjlRSFlVZ1g1dHZBY3Z6?=
 =?utf-8?B?T0liYnhiOFd2aWtwbVludXJKNFVUa3VtVDBidUNXZ28vTFMyS2puQjI5ZlE5?=
 =?utf-8?Q?Gyq/RrL+OGjJcxuPzXoRxQcqh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a289a82e-fb51-46a8-20b9-08ddeb8e3acc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:06.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2HgO3IfH0Ywseng2d7V+rVDOZbQHIE78A1EQ/IbYT72zann3jxPiEl/bITPTljdvBtLqhZBOAE7NWEq6Jdzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10507

TJA1048 is a Dual channel can transceiver with Sleep mode supported.
TJA105{1,7} is a Single Channel can transceiver with Sleep mode supported.

Frank, I dropped your R-b in patch 1, since this patch changes a bit compared
with V4. Thanks for helping reviewing.

To support them:
patch 1: add binding doc
patch 2/3: To support dual channel,
   - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
     has two channels.
   - Introduce can_transceiver_priv as a higher level encapsulation for
     phy, mux_state, num_ch.
   - Alloc a phy for each channel
patch 4,5: Simplify code and check return value of GPIOD API 
patch 6: Add TJA1051,7 support
Others: Update dts to use phys.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v5:
- Update patch 1 dt-bindings for TJA1051 and TJA1057 and allOf entries
  for them, per Conor's comments. Thanks Conor for detailed review on
  the dt-binding patch.
- Add two new patches patch {3,4} to simplify code and check return value of
  gpiod API.
- Add patch 6 because TJA1051 and TJA1057 use their own compatible strings
- Link to v4: https://lore.kernel.org/r/20250901-can-v4-0-e42b5fe2cf9e@nxp.com

Changes in v4:
- Add R-b from Frank for patch 1, 2, 3, 6
- Address the minor comments from Frank regarding min/maxItems, commit
  log
- Link to v3: https://lore.kernel.org/r/20250829-can-v3-0-3b2f34094f59@nxp.com

Changes in v3:
- Patch 1: Add TJA1057, update #phy-cells
- Patch 2,3: Separate patch 2 into two patches per Frank, 1st introduce
  can_transceiver_priv, 2nd support dual chan by adding num_ch
- Patch 6: Change to 5Mbps rate
- Patch 4,5: Add R-b from Frank
- Link to v2: https://lore.kernel.org/r/20250825-can-v2-0-c461e9fcbc14@nxp.com

Changes in v2:
- Update standby-gpios constraints per Conor's comments
- Drop patch 2 which is not needed.
- Link to v1: https://lore.kernel.org/r/20250822-can-v1-0-c075f702adea@nxp.com

---
Peng Fan (9):
      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048
      phy: phy-can-transceiver: Introduce can_transceiver_priv
      phy: phy-can-transceiver: Add dual channel support for TJA1048
      phy: phy-can-transceiver: Drop the gpio desc check
      phy: phy-can-transceiver: Propagate return value of gpiod_set_value_cansleep
      phy: phy-can-transceiver: Add support for TJA105{1,7}
      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  69 +++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  43 ++---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  17 +-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |  13 +-
 drivers/phy/phy-can-transceiver.c                  | 180 ++++++++++++++++-----
 5 files changed, 229 insertions(+), 93 deletions(-)
---
base-commit: 6aea185bfe693f3b373488217c198d2c3daed6eb
change-id: 20250821-can-c832cb4f0323

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


