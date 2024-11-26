Return-Path: <linux-can+bounces-2222-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A929D92C3
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 08:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289532855A8
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40998194AF9;
	Tue, 26 Nov 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s2m1ckoO"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD213BAE3;
	Tue, 26 Nov 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607369; cv=fail; b=sDSM0obTHtHAIZMSm4iROuENVOGyoZDGbPsqqUzBs1zXmw2DfUbA5K7mtaDegkyNy0xV4Eji+G8wBJB1FU0sqhrs2Q4nlODr1ocqIm75nhflrPCOZsCotbSyRPNYkGxfdkSbiVHtcOx4qgzWGvZpUtJaEen8cKwR4aGxH37nwKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607369; c=relaxed/simple;
	bh=uiKLQZWyxlPGYRe96cYx4eQHLongvLLVewp/FUvzC4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKiBroOsa0UrO1aWq3Jzlk0Qq330a9qFPsTn6QjrDWLJzk6GLcS9gpbutK8oZcaDBgAYj6rzHNCcfm8DQMVyjyHiWctkstbxoebDc9O3j9M8XRhLxg2WvKTnUq2/AZqrkQ2uBZnNgtVU+k8T9Q3cLQUtrdw0ms8JpwCKvkW9xgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s2m1ckoO; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJoq/pR3HdG61nGfVSkaNeDUdGudxC23ZUMDyjRMRlOwnjVBaYHkrUooJfZtIuHqxgIAx0XG8sQfTWdrpj8RJ9bcVhw0u8qnaACpLx2tPvRcZ59HECHe3iX8uDfdnXf7xpN0/gyzqfh5/PbxwIEhVQNFw5u1LGYJ5fy4zovI7vrMM3HPewxSqUEmbKCnjCkXefZPqywMsDXqgEf8SqryHrnbWPjUyxHosR0Dy6LaSCNkWDDK4aMocek8or4UbiJqYiafD0vzkaonIF8jBECuaH+uvjdM4OygZVu7Y6fCrLuLnRXqTYLSgYuCPZLbyF8obntEKFRwDS6OvDAw5nOsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3sF/eg+iDs5YTUgX+oj09ICc/vwNXzj0Mikzs15Rgo=;
 b=UJ89P/nB+yaamKFkT+IstDsr+1lYuwmlNhOHJGiMraxQxP7kTDYgvOA9Xk18NPIEaclyYBO5Wx0KLAx9H+9l6Enk3ghom1sxd4n2CVhzFaAeRUL7X18Q4o3RGwu3HDl93NNP123lmb64pxnd+ulDS6GAQIoFOiTdlOEIXtLhhZtjKW2q2OOkwhD1DL3lriWhFdg4rXndTV8iKLXd74t0FscAaAVejcUkNBXtX0o5nDtgHBgPuUK3kc+FwgMU4p/yeqsR5jvRqSOOCdmbfyJfNdZIqxPUdJQhPlxt9bXOrcSNGXw+nuXoe0pk+c2p2xT9BUngjsrhiUrgb9eF86O/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3sF/eg+iDs5YTUgX+oj09ICc/vwNXzj0Mikzs15Rgo=;
 b=s2m1ckoO5McB1Z1V9hyb8raR/ooMxVGsrkWJJaVam1ZwfuGYYnIZBUwtkpov2wAgLeN8NFz7bfkqRgNWgiYlCrz0CoA1bFkY6IopfKAQEcGOqkEJtIBEk5bVAPMz7w0uItFVG/bnB+AxcvVP5P7NluqpEH6wVgwoVaLY2VDnh09OvYb6LdDm8XkSheEjIYNlV1TRZAFDfpgqnsYWLhoS2yioP3/Z/iEerw2PxEox/SPZF5X4kmRb/Q8NxgBqEjK237e+1oIE6Ykq7mTJZIvJmJoabrx9JIIFxWCg657ABL0Be6iDZBdFMGVpZp9VQzgAIgqP4JkU1TYW+4ggoD03dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 07:49:23 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:49:23 +0000
Message-ID: <4a999b99-0641-47d4-bef9-114fe6bee78c@oss.nxp.com>
Date: Tue, 26 Nov 2024 09:47:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Frank Li <Frank.Li@nxp.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
 <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM0PR04MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4112a074-84dc-4007-6422-08dd0deed7ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2JIZGVOS3NpWVdtNGYvWEhTRFlQeVNlUktkQVhNY1RYV2tqU01ERHlrQ1ZL?=
 =?utf-8?B?ZzNaRDcrMkVtQklFMmVEUHMzZjdCL2hHNExOL09TeXBRWDN4YzRTYmlySjdY?=
 =?utf-8?B?NWsza2hldkNNOW5qMjlLc2NuSzlJU2VNekxZV09xR01TMDZiNTEzY3I2WXpU?=
 =?utf-8?B?UitwcjNKWXBvS0N4bnNMQXJzTExwc21wTkk2MGpZOUd0WlorYWJ0bVQxelRx?=
 =?utf-8?B?bWYvZlhxTWlSeTc2Nit1Q2dJWnJIV0NVc1VPYjFuV1FTbnBOZnpYS0xkR0o3?=
 =?utf-8?B?SmJlczJJdUpZRmxjVFBPOE1tUEhjaGo5YktKTG00STdRVnE4L2tEYUplS004?=
 =?utf-8?B?R29KN1E2R0J4c0w4cnhHdkFYL29DK2prY3Mya0NBYk1BOXJDdW1SR0I1NzJQ?=
 =?utf-8?B?WnhnUkJWeG5ocHo5dnV6eG5OWEtreGpVckZNbk5TS3ZtWGFhZGdtVzJEdFhi?=
 =?utf-8?B?bmNBMWlmUit1WXBOTkdRQnQ5VEpKaEhkcmd4U1VFNlpYN1IvSmJBWEJOcW5z?=
 =?utf-8?B?Q1A5MlNSY3ZrTGVFNDByQnM5bWRVSEFkTjdLdjFIOFZlR3ExNjJQeTFwK0JQ?=
 =?utf-8?B?Z0tnQm84aDFlWmU3U3hsc2IyUXlKS2U5dE1vMFNHTktOUFNBM2k0ZHhydzFI?=
 =?utf-8?B?ODExOHBXSHRUTllneVk4Ryt2ZlFoUVFRZFZkWkRtelNacWQ0SW9PcU5NT204?=
 =?utf-8?B?cmkxZ2tHNnFnc2cxbUVEVXZNZ25QOFVrVE9YYnJlWTE0NjdtdlVkMlN0dlVU?=
 =?utf-8?B?NE9aM0xweHZ4U0cwZ3F3TmVvTlAvdTFibmR6OUgrWkViUkNZc21uandORDlF?=
 =?utf-8?B?bkIwc2dtY1FLbGdNRW8wd21tWTJ6SmRZeHU5eVQzcmllQTJyRXA1anp0amxq?=
 =?utf-8?B?L3JPeTVRaEhuM0JHWjZlMnNlVjI2ektJdE0wVUFVdTFwMGlsQUdpeUExN2xL?=
 =?utf-8?B?cDM2SlNLNVNZalUxcXVISmkrb0lvZzhSY3VDU3A4Uklsa05RNzc2aVdNcm54?=
 =?utf-8?B?QmdrTTZHUzFGQ3pVUGlweThLZ0NFajlaajVEcGRHdll1SUFnQUdmYzgrSXJZ?=
 =?utf-8?B?TFJsSVkxWkp3bUNBRngxRWJtcENvbzEyb2h3UnFJcjFlaDh3Ui9UK0lXa2pZ?=
 =?utf-8?B?RW1PNW1PeFI3OFcwaDZodEhDaXBRRVQ3clVjWHZnblZkVW5PN1JyQ09iUGVl?=
 =?utf-8?B?QWtrRGpQcFdlUWtWMkRuTzNxQUJVZ3hTS3N3RUVhQzlHZlUxK20xckNPZ2N4?=
 =?utf-8?B?ZVh2NEdYMmpiRCtEQlNFeTZCMXJUdm41WmJjcDV6Tlp0VW44ckc1M0JoTVV6?=
 =?utf-8?B?eXYyanVFQmtrNE9jb2NuOWcxTGdKQjVHUzljbzdGSlZlMWp2ajN2UEtYdDBC?=
 =?utf-8?B?cURqUUFQOEtQcWJOQVpRRkdzelNBZFRJbFU2aGtxcGoyNllEeHA1NDJ6Vlkr?=
 =?utf-8?B?QlR3d2QxdEdDN2xsdktyaFdBMUZCbGljMHZsc3F1cXdUZjl4NlYyOXdpUW9Q?=
 =?utf-8?B?eXp6UzFKR0NvRmJBVmc0VzRHM3k4UEtHdUZhYWRJU0tBajZEWTQwSFVYbzRh?=
 =?utf-8?B?cTRLcStWeHpGUGI2RHUxeitCUjYxb3haejdqSTVWdkJUN0tPWlhONFZ3cnlU?=
 =?utf-8?B?eFdQL2tOSVM4MDlLdnh1RmNQVXJwNjFIUEpGRGIrUExuTmZWL3dIcHhVNGpz?=
 =?utf-8?B?eDJtdCtyTUJCRDU1T1N1T2NVOU5veE9udzZZZ2FmYldLMTA3QjBtNW8vOWl4?=
 =?utf-8?B?NDRrYnZReHZhb3EwRGExMU5yUy9UbklNcCtLRk9ySjVzOFVkakQ2THBLb0ln?=
 =?utf-8?B?cy84RFJvbG5JaUlVb3Nsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFRxVXE1V05Na3lqRnZsMWFLdG1saktQeEVPd3FYdnlZUEpqd2FIbmZCYjNX?=
 =?utf-8?B?dnViK014dDBMeXlEYmNzNDIzbkc0V1BCRFd1TmZUQ1UyS0Y4ejZVdWRiUHZK?=
 =?utf-8?B?aEdmekhBMG0vTWl3WFRlWnRVRVE1dlJqcmRKMGIveEVXSHVLWFJjcmJMSkdG?=
 =?utf-8?B?OE1vakFlcGUydkpGYjFnUXFNV3dMTmJ3U3hIQy9UVmxjQndFOHQ1ZEJ3Si82?=
 =?utf-8?B?VzZIZXdiVWhVQ3U3NHppWDBHYjFnRHhLbW9NQTRwVUc1c0FzbW1UaVNLRGh1?=
 =?utf-8?B?Z0ExMGVZcWJwTmJ0eWs3V2YwZzhGT25pYXFmUTArRGpGb3RJVE02cjdJNGpa?=
 =?utf-8?B?MlVvL1VzRVJodUJuM1NQWHJuTU9XVjRwQ2NaaVp2Sm9xQTZtWWRGZ0JKODVh?=
 =?utf-8?B?djhMendCejVZWktIUnJTT1pFWCtTYjVBUXVDZEFrYmFySUdibVlIWTBvWElh?=
 =?utf-8?B?NWpMUU1ZYWNyL1I2SUx0N3dwREJrK1NoSGdmbEJpUHJtVHY3YjdtRGM4VGox?=
 =?utf-8?B?bVFkSmRsaEsvZ2R2M1c3L2x6UEE2MWs2aC93RTljRXVJMEZMNlRDYU1kbFFJ?=
 =?utf-8?B?ejBiV240VU1Od25JWDRHbzliUjJ6b2RjZEJSTjh2Rlp1QTBrYTRidk1FYjJs?=
 =?utf-8?B?em93OG5xRnhGTFhNbFJNU1RvMUdrZzJKVEZhU3BkT2Y4WHVzbkYwbVlwVXFr?=
 =?utf-8?B?aGlRZjlvVFRYK0dlT0gzQ2JwTWRNRHUrUVNaTVBzK0w4U0xGNC9YWFVZSXlT?=
 =?utf-8?B?UCsyRzhXNnAwekwwc3pRUEkyaTIzWC9VZU9TVFZjdkJzNEhUeFEzdE5nTVN1?=
 =?utf-8?B?Tlp6Zng3bXBZaDAvRlR2WGxTNHgweUwwK3IxL09qb2NIR1dsZFZlZ1A0Q1ph?=
 =?utf-8?B?WVcvYnhEVTFIWVlaTXFiS2lPcjZLeklCZ0QyYmlnMFBTRXcrcTFSSm56dG00?=
 =?utf-8?B?cDZIUVM0dnhkNzczb3JodVFtYytYdU5kUEdKWTl2V2RBTE10TFgvMk5lY0xR?=
 =?utf-8?B?RVF6QzY2a3VIYStzYjNyQkpQenE4c0Eyeklkc0RITnVsZ2lOKzJqUnJkbEZD?=
 =?utf-8?B?ak5QbFgxZVRBSDBZcndHSjlsTUhaazdWeEl3cURmeHFiakVLeU9QTUJDQjhr?=
 =?utf-8?B?RlphcC9IOUQzVERmQ0FRQzNZdk9mck1ETXBJY0FVcDcveFdJZU5WbnU4ejRH?=
 =?utf-8?B?Q0lveEdKUXFXanBuR25oOTgvY0NUamdUZS9vMUltWEs2T0lCLzRoUTQ1elJi?=
 =?utf-8?B?V3dHdFAzTHFtQStmWFZuUzVCelV5N0kyNVIzdmp1VDVjTG9jMHpjYXExSkY2?=
 =?utf-8?B?UjVYRHVkQVFzR1c3Q2J5QklNL3UvSmRIVzJBTFhtQ3VCbk04WjFBeFM1YlJE?=
 =?utf-8?B?OEVNZEF6ZFUvaE1TRFh6YkNER1N2YUtjY3owVHpTOG9HaU9QM3owTm5JOGd1?=
 =?utf-8?B?Skg5NkJBU2RhZU9ESEtTWHkxVW9EczdSaEpJdktEa3BKSnBYRWJ0S2xIdkp0?=
 =?utf-8?B?U2paUHk0ZVBCNDdOc2JBRVRvaG10TlJLRVdTSWFZU3BIckJINnlrZ3pMZFA3?=
 =?utf-8?B?OE1MZStFVEpkV3hjd1FZMTZYZEo0dlB3d2lSM1ZaVDhxY2xpSml0U01TbWsr?=
 =?utf-8?B?Y2hmZXo3R216VHBDMERKdVh2Z3duTk1YWlkwMm01ZFVsY1BxTXlMUkZlWE91?=
 =?utf-8?B?MzdoUk9STkpYVjdzMVB2Q3JYQnZkcWxLNTZQUEMyRFpJS0dIa3JsUW8vcW14?=
 =?utf-8?B?b0RMQy81UTVFQ2wrOWJ5S1piRnpiL2xodjlBOU1QbXJFbkg3OEtHdnI1anpK?=
 =?utf-8?B?ZldPNVp3YWJlV0ZTWGNET013ODFzckdSQTJBL09aSmxKWXBGekROaHZKK004?=
 =?utf-8?B?dGRRYWhTVWZjNmhoV0JqcXZkQitmZkU5UUE0dUhwdDVUdUthWlhPemI3eEZT?=
 =?utf-8?B?eng0QzZzb3BBQ0Y3dW9qNkJBcVFCdjFMU1IxTWlOR0JoTXhZTkRrNXROMTB0?=
 =?utf-8?B?ZDNldVA0QnB1bjgwZldNaHVPbEUvR2laZzNvdWNFeCttZnZROXN4YnBERWp4?=
 =?utf-8?B?dDVQMm5xTTZQaXNEb0V3MmVLaUw2V05XSHJjbDk0MXlmQlQ1Q1kwZWdEZ0lm?=
 =?utf-8?B?VDhsNEFNSVIwOVpOVEtWK3lVU09ORDNFeEdvczJJMSttbGVQRzJSTE9kZE9X?=
 =?utf-8?Q?rT30C3B1mNaVkDSprukByys=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4112a074-84dc-4007-6422-08dd0deed7ac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:49:23.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl+71VoIGeLgz41pWA7kFLFEi4F54cjqSXImk+IRPqwbYU6Ffzq22h/xnI8X4IOjrYg/fwDY2CKslPFoxblqpLHLFoWP4VS/jZ7NB7tF230=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6802

On 11/26/2024 9:19 AM, Krzysztof Kozlowski wrote:
> On Mon, Nov 25, 2024 at 06:31:00PM +0200, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add S32G2/S32G3 SoCs compatible strings.
>>
>> A particularity for these SoCs is the presence of separate interrupts for
>> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>
>> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
>> same restriction for other SoCs.
>>
>> Also, as part of this commit, move the 'allOf' after the required
>> properties to make the documentation easier to read.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 

Hello Krzysztof,

Thanks for your time in reviewing this patch.

> You made multiple changes afterwards, which invalidated the review. See
> submitting-patches which explain what to do in such case.
> 

I will remove the tag in V3 and add this info in the changelog.

>> ---
>>   .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
>>   1 file changed, 42 insertions(+), 4 deletions(-)
> 
> ...
> 
>>       maxItems: 2
>> @@ -136,6 +143,37 @@ required:
>>     - reg
>>     - interrupts
>>   
>> +allOf:
>> +  - $ref: can-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nxp,s32g2-flexcan
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          items:
>> +            - description:
>> +                Message Buffer interrupt for mailboxes 0-7
> 
> Keep it in one line.

I will update in V3.

> 
>> +            - description:
>> +                Interrupt indicating that the CAN bus went to Buss Off state
> 
> s/Interrupt indicating that//
> Buss Off state status?
> 
>> +            - description:
>> +                Interrupt indicating that errors were detected on the CAN bus
> 
> Error detection?

I will rephrase in V2.

> 
>> +            - description:
>> +                Message Buffer interrupt for mailboxes 8-127 (ored)
>> +        interrupt-names:
>> +          items:
>> +            - const: mb_0-7
> 
> Choose one: either underscores or hyphens. Keep it consistent in your
> bindings.

Makes sense. I will update in V3.

> 
>> +            - const: state
>> +            - const: berr
>> +            - const: mb_8-127
> 
> Choose one: either underscores or hyphens. Keep it consistent in your
> bindings.
> 

I will update in V3.

>> +      required:
>> +        - compatible
>> +        - reg
>> +        - interrupts
>> +        - interrupt-names
> 
> What happened to "else:"? Why all other devices now have up to 4 interrupts?
> 
> Best regards,
> Krzysztof
> 

I will add the 'else' branch back in V3.

Best Regards,
Ciprian



