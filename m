Return-Path: <linux-can+bounces-7776-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LSbgAvokKGoW/AIAu9opvQ
	(envelope-from <linux-can+bounces-7776-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:36:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41F661324
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:36:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=iC2Mema0;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7776-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7776-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43030303755A
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB12341068;
	Tue,  9 Jun 2026 14:30:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DB342173;
	Tue,  9 Jun 2026 14:30:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015404; cv=fail; b=Lwq0sFdL/jKoxJ100EE/8dM6L3ifX8dkiN3zxLuuEwgRkRxWVffPeYgn5aHMOuiaRxw8KpaxweijikO49WhGlGFrEcVXtnJ/0e6z8ISZ42qW6ZeUQnJzElzqZBajfiutsP7i44v5PNLl8ba2TsQYupHsLWx8fk3cdG4IQcb3s54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015404; c=relaxed/simple;
	bh=vWCs66j4h6TAKcsY5gLTrIB3ghqYZhbnPAeNSSZPouA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vByqUBknTah4G6d757zH2OYsGEmKHXFkSV76xNi5AC5cskXA/kaZ+t3yX/lYz9RhgC6xb4SZxk3B9rTzWSJ/9DQ05hFO8mhsR7n4OCGbLvnO429slb+FyYu9hkJKqCAJ37GP8h23W/xC6KWlIhOeT9Aw9E8J80PvjeLSWIlQmKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iC2Mema0; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCLXT43XSrvfZGBf9MAFaKFxZJXekFO6ms4hjWZWY9OLF9mX4Qagy4PkWeGhSSPze/VuJ35ILTi4a1pYjjHhDHnYaEg1J6QWaGJwPl/6YyEkCqfAaj2keBVs1ucF9fTXsUgG5mWYWQsGffZuVs9lvRleYeHzizcRbaFc5NJ83sW2hGEZbw+WPpabMCPwP6/imjLmiOIcva7VA7h1ZoQpSNZhmtMqcNmaIEb4N8vfuZQTaUJXVPHPRQktOSo/mRh9HFh++OcaAY+9/60Nt2VtG2HDgr0WnYGoPNHejnqy0eR2lDUaD2QEWKtDYxY8TKHVkkIoQfk2taObdIKC0sSjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EbNlYr3oyEqN/5vtOgIP1W8H7uVQA88fpsANQ2oo3w=;
 b=BptzlPPTJXwVPuFUxoh5UHan0cEcdQ/xwMI4rEBOBnbm/AxJneBChXsakbK9tPsPUj/k4lmXXvPaR4nfxcyDvAvOq1qu0dpQ6f83iUKhCnaZn+wfBjxJ1aZgvOzhDXUU6I+VqvWhX0m1M3y4SDeh+KP/6N+864vLVMleqMCpKmaozGRyFS/eZqHmVlXftgqKIjiVytMJxju2fT9tnLsJplqKVSiIT86G4dUzJ1slehqjxXQ4wZjQc5G2PcMdTslHGrvA0jguydiv+hA3UqIZw+i7n57fuo7FByNtLoLw7tJ2VzenoLxx41ksLfKQqitQNLCYv77k5okL2cH7XUcmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EbNlYr3oyEqN/5vtOgIP1W8H7uVQA88fpsANQ2oo3w=;
 b=iC2Mema0iXRu0lLRFLT9g1FDwx/G+b0bhYqOmzCQiGHDXruJh2NzbPWkSUKBLXvgUrktmeARSys2Y+iaAEEOmcW+1YB/PGB5ZNn24QLTTy0oBD89Cs42xnRk61Lxhs12topjdM7ssew9njf8ZOVJOcrAQTkD8mm6h76N3H6zLqdRKZbd2KJwsAqQ8TEG8G9chAgQRpqTc6u7Iwnt+Mn6qVvj//H5D2ygPMRWosSblnMnwG82Mz7jFbzSZTZhrXlTWU2mq9veQSWoyTzfJod3VtjWUKSYyr8pbUS9UEwF4w3R4pIL3oJ82IrB32jJxmpgNN9DabGr7HBItIZaaR/DJw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:29:57 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:29:57 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v5 0/8] can: flexcan: Add NXP S32N79 SoC support
Date: Tue,  9 Jun 2026 16:29:46 +0200
Message-ID: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: a784fc93-0c33-4adc-4ed1-08dec63394c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
 Y1X+9SORqXvvblu9Vs1Op79WLE1e19RNvr2YYeePm3FByCc7GwecCxo1dWL/yzTFgUl1nNnA3zi5U75LRuIg95WdU6EdbeY7s+Wrf5ueyObx4cKNFDa1SVT4kohtfCA+2sJABbiQIWtr19ooTHsQ4bGZ0MhRC3ulG/+qykpOXUCbqq3Sm/ECw8yUCwkd7qRzcqOJdWs0AypvdYMHZRo6Bj0b+cCzKTsJZ9nTimEeHcLDaq0hTISAysOokCk+Fumhg38g0XXWdzTR+dTH95uniQAfTA6l3Lg6Cfhli9ZmRSnVCMTRN81KwCcihmLneq5xp/ABIylPtSYCsZ1jfgPekfhXHDl6ry5QgvrKVYfR3HmSy36gldHsD6bR0OFfZf1sICjiEMwWqmkfUNzXH+ESrpWlxUh11GlrbKPjgX6GETOoZnE4sMnxCS/aIN3n3U+88BViwJB/Cqfi6C3X9hLJb/1T1xL1+tZP4G1zh9srSHllggOdFQi+7Tx+Y/sIV3pmSxZ2rgmbID3c2cKFBQbdH2DXi6HmIOpubDOJdmhrtpzvhEYWfYGa649PIvnyTdrvXVR4dOZ/5Q0XJ8YOT54oVEm1/LZVqAgtbHnEIjpuMEO+MZhCuo3tBVam8gjZbRO6X65pMsuVjcour2I2j/TtcCoyAWlYnBdVb8Q44KL+ZFDrAqvpn0CcfPnEtNZRB81m
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NTZ6ajk3ajJJeFhMNXIwb0lxZnFxZ3N0WmdycXZTNGxSaldsbjZYa2EvN013?=
 =?utf-8?B?Q0Mra21waGxva2g0RmpYSlp6TFYwVWpnME92RXpJVHBrMXpCUHVPMlRoTUMw?=
 =?utf-8?B?WERPSzVmZjhGMFl3TVlqaHh3MndHN2xmSXZ5dHJ6RER1WDFDT2hEQlNCTERZ?=
 =?utf-8?B?WDA3RWpuVFJpVVhkOXJXSTVlSHkzczVJckJiS0JkWTdUcjY0dkRBSG1zS2RS?=
 =?utf-8?B?NHo1SUUwUjdnYnNKUDFSeEFEZTJ1MDVJalI0L2ltWVljNHJ1RG52L2dIaWJI?=
 =?utf-8?B?MVp6aGdQYWlmcExtOWY3QWt2V0tScnZwREdueHcyeVJxOUZDcVU5SFREY0Nr?=
 =?utf-8?B?b1hxR3BIQzE4bkhNd0pwenlFRFpOMjd3bEQvM2VpVnZQM2QxUlo5ZHdyNkll?=
 =?utf-8?B?S1VFWE9nblBRRWJlc0Z0a2x4NmdwV2tJNWlxcVRXamJzTG9NTm5DOEtpdlhn?=
 =?utf-8?B?MmNraSt3WjIxc3dNWTlwY09XUlFOblFWVFV5Vy9saDlYVGNYYTFNSFY0eUEx?=
 =?utf-8?B?UUpWc1ZIN21sVXp5ZVpaTEVGS2xKc3ZmZ2pSbTVFR2pUb2h2bXpKeEN5VTdV?=
 =?utf-8?B?M0tpQ1R5aU9CN0VYcEI2YkdHdzlHUW9peGpMZUp5ZmNtcEdiOWZUVXVPTjZV?=
 =?utf-8?B?dkxJQWVRSHFkUlZ4VUI2UE9Qd1hGMS95SjhqZ2QxanhmcG1mbmRRdkpPMmpa?=
 =?utf-8?B?SVVxTnV0d1BRbVlWdjg0RGFiWHM3ZFFPclR3bUllQk04TW1WaXkwbW04V2Rh?=
 =?utf-8?B?ZWdWVnVZVHhmMmRSYVp1Umk5VU8yclBkS3JzamkxSE8xUkFUbmRBcEtTemNR?=
 =?utf-8?B?T05GMk5mNEhqWUx0ak1ZNmVjUkQ1UWhXQWlmaFk0MHJPMGxGeXlydmtiTTRj?=
 =?utf-8?B?b1VaK0RxYU5FcXcvcGVrWXB4eUhaeWN5cUVjb1NHMGxTN3B0RlVoYzh5UENa?=
 =?utf-8?B?enF5WnNocE1OMnZKV016Sy84d2w1U29CVWtKOXl6MVFqckFsSk0wUEhrSzc3?=
 =?utf-8?B?SkQzRUNDM3hSNS9ad0h1eG5aTmNmUUdHSFpndUVydzl6UEJWU2dFNDVSMXht?=
 =?utf-8?B?MGFIT25GZmc3eUdydHNLcG9pZFMzMWJPaGdGQWRJNlFxMjVIV2JTbkVnSkk5?=
 =?utf-8?B?dGZINzZjcEg0b0g3ODFmR1hTU3VZUzZGUzRTd0NDL0s5dldRV3FJbEJiNmdJ?=
 =?utf-8?B?K0JWYnV3QWlTZk5xRHRaUHQxQm1ndHlaMWVYcTUvVkxvQmVHTzJpdC9XNGFk?=
 =?utf-8?B?QTE1dFBXQTNtdVZ2UHVPM3NvNEwrV3ZJV1BjVllpbWlwb01CemkyeDE3OXJa?=
 =?utf-8?B?aTRjcy9HNUZDbmpQQ2N4a1YwUzhSSkN5Y0dienlPSEdGRnR2WC9VWG9MdHRh?=
 =?utf-8?B?K21CTmlIMVRaZWpDYTdvL1Rid3psU2IzemlvdU9HNzFjZ29iZ3BwK0ZpK3hw?=
 =?utf-8?B?N2x0OEdSYUxCLzZheUFEK2ZyU0JSN3Vrb09zanl6TFZXUFAzbzlwR0lTWTJJ?=
 =?utf-8?B?MVA0Rk10SThuSTcxR0w1bmpUVkVkYWxSREZPd2pmaXQwcjkyNUFUVzh2TEVI?=
 =?utf-8?B?SExsTXY3dldlTk9BSHR5QlFXRXBvWXY3OStXRHVSa2FyQ0N0SWk2cUxJM1lX?=
 =?utf-8?B?Q3piU0pQakNuNFJCbmtMdGVYRjQ2NXhOMjBVNE03cmdrVjVMdURoY0JRNHlS?=
 =?utf-8?B?cUNsc1FSc2l5clp4a0ZWM1JHVzlEbUtRalVWeFVSNWdyclNJbDZKYXljekI0?=
 =?utf-8?B?S01OSERUd1FnY3BWcTBmRWJjUzBka2YybVQ5QUpBTlV2bEt1NjZuZUFJeWU0?=
 =?utf-8?B?ZUVlRFp3QjdoSS9KaDdoajdGbDAxSmNoejJxVkJSSjNRM3lGK1kwY05qeGcx?=
 =?utf-8?B?Mys5Z29YczhFTVpuTzc1dUJDZmNMK0laRTk2Q21zU01UTDd2YVRVNUxreDZS?=
 =?utf-8?B?cGlQYjNSeEVhaWMrdWJVVE5nZUpFN3llM3dET0N6VnVoNnc5K083QjNWZTBC?=
 =?utf-8?B?Mmp4WmJFVWRoYWNJa3g4ZTlUdUZpbG1Md1NUdjF6SGRhR3RnMHJkK3dmcmVp?=
 =?utf-8?B?RWF6SHRmN0tMT3hmeW8rbDRBWFphSUxPMmtCdng0MHpmRnBkd2l5QXZHQ0Fw?=
 =?utf-8?B?ZlJvYWZtZTRBSEpTdzBLNk9valJHeUUyck5pb2lWZ0crMVpta25Jczdoc085?=
 =?utf-8?B?aThGMktQbUx4UVRTZ3MveU1TTHJIWmtxVGRQcmR1a2c4NTRpelFFMXhqRHV0?=
 =?utf-8?B?cXZnblpwRXZqL3BpekNHcVdNcDhjVUNYY0ZDOXF5bGJTV1NTd2FaeUNSSzFj?=
 =?utf-8?B?WEc4WFp3TXNmeXlxcUxYQnd4L1FnZEdqWjVBSkFudTN4dFVsQlAyMXNOYnhW?=
 =?utf-8?Q?2/8rv/Dq2Ly8PeB8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a784fc93-0c33-4adc-4ed1-08dec63394c1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:29:57.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBRq+apUCMpXNlPK1Wq+ympf5VCHeguJwXFJE9e/S1v9/zasBLklOlK9NfSHImFsNVK9DKni6djOLqHQbqVUp8+uQYuiVQT2Mhk0sJA+8e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7776-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D41F661324

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patch series adds FlexCAN support for the NXP S32N79 SoC.

The S32N79 is an automotive-grade processor from NXP with multiple
FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
other SoCs in the interrupt routing - it uses two separate interrupt
lines:
  - one interrupt for mailboxes 0-127
  - one interrupt for bus error detection and device state changes

The CAN controllers are connected through an irqsteer interrupt
controller in the RCU (Resource Control Unit) domain.

This series:
  1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
  2. Adds dt-bindings documentation for S32N79 FlexCAN
  3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
     configuration
  4. Adds S32N79 device data and compatible string to the driver
  5. Adds FlexCAN device tree nodes for S32N79 SoC
  6. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

v5 -> v4
- Simplified splitting rx/tx masks per mailbox IRQ line

v4 -> v3
- flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
  (not just dev->irq) during IMASK register writes
- Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
  each handler on S32G2 only processes its own MB range
- Added received Acked-by tag on DT bindings patch

v3 -> v2
- Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
  flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
  processing when multiple IRQ lines run concurrently (new patch).
- Added flexcan_irq_esr() handler composing state + berr for S32N79
- Ordered quirks used by s32n devtype data by value.

v2 -> v1
- Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
describe the actual hardware feature
- Appended new quirk at the end
- Switched from platform_get_irq to platform_get_irq_byname usage
- Updated interrupt description in dt-bindings

Ciprian Marian Costea (8):
  can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
  can: flexcan: disable all IRQ lines in
    flexcan_chip_interrupts_enable()
  can: flexcan: split rx/tx masks per mailbox IRQ line
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support
  arm64: dts: s32n79: add FlexCAN nodes
  arm64: dts: s32n79: enable FlexCAN devices

 .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
 drivers/net/can/flexcan/flexcan-core.c        | 227 +++++++++++++++---
 drivers/net/can/flexcan/flexcan.h             |   2 +
 5 files changed, 292 insertions(+), 29 deletions(-)

-- 
2.43.0


