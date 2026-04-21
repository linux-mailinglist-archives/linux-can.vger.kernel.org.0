Return-Path: <linux-can+bounces-7389-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KFnMIVR52lW6QEAu9opvQ
	(envelope-from <linux-can+bounces-7389-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:29:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B243988A
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 208D83022E25
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9ED3BE14A;
	Tue, 21 Apr 2026 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kKupIbyl"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F723BC695;
	Tue, 21 Apr 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767187; cv=fail; b=qLUf+Jb3zGMKLB8btNnASktk7qf4rYMzsM4CwytCTf0MJhT3Qiq3Hotem64CfqOgJfBx9djITF1SVEHjF9B1621x6XcQ6EpKTAqONqBDVZz7sAUZ4F7QvioFB9IYTp7oEy/wLF7qDs/cpnjsoXE5UXR5YRIgpuynxZX6Xha8JL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767187; c=relaxed/simple;
	bh=NjkkmEQvIhu/ukpc3rYoo+G4FDElFzZoJ0lqkJdSKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbp4SjE3LefvvN1HUQz5qYzlOgh8YeQgaEM4XC4AsvQRp0ds4kaS7S/uSBKZgKR0nYoh7Fh4DMTNqyrdQP8/lXPYQ2TBry26xs7bYqzcs8m45q28ZvG+Ibm1/ChoSbgiuEvQzhI7zBXgtpcS1Mt4JZKyMq3XziEgaik9hNhrg8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kKupIbyl; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adU6gHQbRHvVRFJ9tr+0e9JOqS//JZuIy0bhoR6veGC9Iew2PG01efGRQvuY6zdh0irzfWoQT81wOTN4IbDJdLR8xFi1y9sveeteSqVGaRxhBq1OJrMOMGjoN+nBEnPZFFgmz4QF2rEiXyEzt/5mI0m34+eI+Yd2Qz4JZnTSBXOCa9yhOmE6Dxhg842IJGRq96SMp9nUYZNPggj5ZdavQDoneBSJ9xhx0Se8vc1GEjFPVIbceyaTxqnwpi7hmu+EvqBoWTjoXPfQPzhiIhQWPxzIderYWiBllBcIDisJgMWojOujQ31AnDNHuQbEocu6yjMCn8ZPz2e0h3tP08kKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=D/S7r58CQ+jYMrTF4pwm2U01NFUij5xWHPg8MkEYvjgg7oVJPI2K+3+XNsSUj267YHJaTVDbWrVIJuY1eMnCRUh/k5Z1thbRp4T+VT53FRIleLZucwESHRNRPsNStgmv6lhI0Du5MhASMLD1E5udVTfymzWNYx+ZQTSDaX8e0YE13nssmblaonInEXlJYgp62dgZTEqa8ovNWhYqXuyzjwln3BIt1WqMfjXXlrTivSC9kbNK00c6tGapdeFYv7goiZ0wGxk5ec1VHZSKHXYTWVZJQTN15L7v8ApjuqJVB59rXIqt/eEv/faMF/FlzHKsc9tQ0vB+2DFOjy0JDBjt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=kKupIbylESIx7UtQd6vMOPSBj19sq6NUZpqSID7Gy5UE1Y8VOPvN89QDH1I4djF80dAWKs6+qPtdZtHy1iZeSpVJk5fO8agXJbxCs1mGq0cXMYsQJMW83sGGR+0Iz20JhH2xcpkHI5ASl2w6qsntlYzYfoFsSOCa6vcz4bp25nxNbLsWWLmU4sP85lx2m/6BUArHx7IxrzXyOkh7oCmAqVs1YwnEAunxIyGT32s8D2wswjYgNra04N0XlRuwFMVmi56Ya1Fzsr4Md4jEHvJd0yy0ULLOifvBGBf2XdrpXdPL9f1oU9SW2PPG8I+/nNDKUWBAb6w6spKarT8hO7CE9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:17 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:17 +0000
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
Subject: [PATCH RESEND v4 8/8] arm64: dts: s32n79: enable FlexCAN devices
Date: Tue, 21 Apr 2026 12:26:03 +0200
Message-ID: <20260421102603.4122332-9-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: bc650be7-630d-42e4-2dfc-08de9f906c06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 X/VwV1Ima29bsrHi7s+Ied5/hvnumjzC7i8rmwe18Uo5cZ9ScZu+/i9uDiJZukhVvnrCE5Ddo7V/alEn4eUvzt2ZA2QPq9ljL9F7FEMTXTKFNJ9K0EK0cxDZNLzqJz+YYo+wWN3dw/yk/k1oSOEhTLNqgaFfI8D6vKDqJmxuSd8nG7mkApvmJ7/7EgZOfACBD3T5y2ExEFVc+LGJisUcvLyGFQ5Pn3uGKv1OjzPo3O1jyG6NXR4TB3HRqdHfqL0fk9B/rPH8udEuOyP70Q7Kl3IygrQPkv82GMdoz0v3obiJojNJou7Z2ujsqyqITd9eQJjg67Kq4BSa3dyYfTBAB6JX7keNN3aPRzG5wOQ2Lv68uFrseuXNlb566E5iK2LusoG3U3PiB75nsKOd/4lNlcbwOdp7yN5XGNUlHzJZNquUejpV1IClDl5UzQzCh6BKt81/xJoDfqYu/73yFYNMXYDb+4OLSIdpfnSTElFGbnPGYdif+9qGtcen+EBk+YSi2fO8LKpxwq2YTZYRF4KheYzwrHjyYsFD0xAHvYOdNHQL51sxmIlKshEXe9z4S8nVmDoodebWeKLed0xVzQCU/HASi+1Rjur4U8aBBi0KUx+8PqalgIVBkzlwU6Se7I7UONkWmMMWTgTWCKBjCG1zpPm3E3Coe9HmEA+5/7kiiWV62SkH1+D8Bj/vQ910UMz+0ugfgVxq7GJ3p1MgRyfPuTa/t/4QihfT+S9Hw2fZv3U=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OGp6Q2lFa2VzaWcwdjFWK1VBOGlZNzJrdGRINGJiU2UzREVleDdZeDQyRlly?=
 =?utf-8?B?MXRrK2RuWXhQbFUrMm45TTRXM0hBYWFYemIza05JeVN6YUpYbXBTb3VRN29V?=
 =?utf-8?B?T0xxM2ZkWHVuenRoZjcrZFBmd0M3SUlwSWg5N3JWZDJUR1JNaTRsNFNjTnNv?=
 =?utf-8?B?WHBFdVpSeEdKaHUzclR0cTJ0aXJjREtyU3BoQXNueHFPK3U0LzNkTHIrd2V5?=
 =?utf-8?B?RHJyNGFwTU5BQTI2cC9Ya3ZZRVhIdVVPNGpRYktJMXJYV0FRSHEvcDRXTGxE?=
 =?utf-8?B?a1kvUGZqdWYxejM5cXpqKzkvK1Q3bWJmWDJKRHZNWEhHQlg2Znozd3hYR2pW?=
 =?utf-8?B?MVNKb3poUFVBZk40Y01XN1Q3b2VhYWgvTExmaFZjejVBeitPT2p4S0ZTbS9k?=
 =?utf-8?B?ZzhtTkhuWmg3dE9hVHpYMCtqTk5pRW5WaHA4VU10RWF5akFrZ0RQcmZza0tp?=
 =?utf-8?B?azJVcTVwZ1RKUjdPYVgveXpYbjBLcG1OblpEeWRTd0dRVk42aXFoSXU0T3d4?=
 =?utf-8?B?ZGJod1Jud2MzZDRRMDVCdnZrWTNlM0FHWU1lSVR5dGpDMncrNEExV3l0RVhT?=
 =?utf-8?B?T2hMcUNta0dEVlM3djdKS1pMVWNzUGtFSWJNaU1ZLzNmMktNeDNJVnBlQyto?=
 =?utf-8?B?YlVIcVA2SGhRVVpNZTNiWmRDa3ZQbWJydzBVSlRRT0pmSVQ1V3d3SXM3RFY5?=
 =?utf-8?B?Y0lCTG95VlkzRE9nRmpiMDcxQkRSLzhKaEdpbjcyNG95M0FGbDA1M3BGb2kz?=
 =?utf-8?B?Y1FsZk9SSzlrTWVOT3dxa2tlZDdkdjFFa0t1NXZmMEQ1U1hTdTQyS2NvUHg2?=
 =?utf-8?B?NUhrU2NGUGs1TGM2Ry9zemNKV1ZEeGxhVXEwQnVBWkZ2NGl6WUNEY2VxUVdo?=
 =?utf-8?B?czZzVmh2ZmxNalY0eUNzQXlLbmJ3a1NqdE4vayt5T3htb0E0bUVaRkZ4bnRj?=
 =?utf-8?B?aEY2bjRyZW9na3NwVkorYTNuOE1yNUxaanhUYjRlQmlNMWNGSnkxRTJpQTVZ?=
 =?utf-8?B?a1VTeW5kamN6bFcydFdqK3BUSkNhejhTaG4xbk80WUpNSlVIVkJ6Z0dMbW93?=
 =?utf-8?B?T1Y0bWZkQU9lbUZCWFdVYnlqVFVubkJwY1NhYmh2d2RpMnpDclpzaW1rQ3pV?=
 =?utf-8?B?R09kbno1bGptUFhlWFlLdVNXaU5OKzNIdlUvNEZyQ0gzaGQ1N2xON05jTVF4?=
 =?utf-8?B?bWhLUG9uYTlHTnJoVmxpd2hIWFNRdFVMUXJ1bksxMmdWNGwzaGRqZEdtaktS?=
 =?utf-8?B?dEx6eG5SMnN6OFo4WThRYlhkM0JjYlZDTzZLUVVKbFRxcHNvZGUvSnlPalFa?=
 =?utf-8?B?d0RWZTRHSXdURkkvbk5PWTZRY1BnQzh0eU8zdjBuYmR1Y3NUS28rUHNEL0dF?=
 =?utf-8?B?dXhxbXNMR1ZJUmtNb3VweGJGc2l1N0dSaDMyN0hxNlg2NUlzTjlUeXlmUXhP?=
 =?utf-8?B?U3JBYVcwaUppbjhqVXBOOTFNOFFYU1g5NjFEc0RGbWd0WGY2MGZ6OVdYU1BZ?=
 =?utf-8?B?eWM1amlNTEd3Z3RmTTV3eGZ4YmNBYnBmVTJPamJwSldLZUtNZU95a2hRTUxK?=
 =?utf-8?B?My92MU5uVWkzRWFGbjFCK2JUL1lFRXFITmcxSFlMWXR4REJHNkU1aWNMSk82?=
 =?utf-8?B?d1U5Q1B3blJFa3loS1I1U09RQys1UzBwSFhLb2d0cHVaVWtpYmZVS3lVV1NF?=
 =?utf-8?B?cEJZM0pFS0FRMHJueXAxTmdHRXlyN3pURlZ5c3B3Zmd4Tmh0Umx3aU9wd1JR?=
 =?utf-8?B?TTlRcnlONFB0VUdndW1Idm1BSCttM0YvV3d5dW16VzlmUmFaR1R5R3E0Wmhq?=
 =?utf-8?B?N0NRMzhlYmNqM25Hd2pMVmkzbktjYjVOQ1NMdWRndlQvODJxZU40T1pTYmpG?=
 =?utf-8?B?YWMyeXVSRTJDZWMyVXBML3NyOFMzNThmM0RFNjFsK3hDQ1JuQ25Lc3Q0cjE4?=
 =?utf-8?B?UncvZWlHQmFic254c0UzeFdjTTlRa2FrdDJYUm5xd280MXFSUXJsbHd4R0Nr?=
 =?utf-8?B?SC9FMWdUeHowVzk5T0ZJOVo5dlM3TW9la3RYZnlZSGF6bXJ6VEVZWEhYWTNN?=
 =?utf-8?B?aUJPMnhPeUk1U1pQL0djV3ZiU0Ridkl3REN3RkI0S3BsNm9BOWJDSFVhbzNu?=
 =?utf-8?B?SXpUMlNEUUQ5ZTNQczEyUkZnQzlWWUl1bjFCWFo3VXdxM24yYk9NbWZOYVFI?=
 =?utf-8?B?Y1dwTmtFZUFzQnl4SU93cldTeWsxWUZYeGR2amxxY2UwcDFBNnJqc1FzSlQ4?=
 =?utf-8?B?U1R4N1RGWGc5RnFOU3lVMEpqNUh5NGlWMy84eDdPaElGUVNFRVo1NFJ0SW5Z?=
 =?utf-8?B?YWRWdUVOYjgrRnYzL3Y3TVE3WnY4ME5ITzZmZUFUMjBXZENKNkUwZXEzOFBM?=
 =?utf-8?Q?Ad231uKWWMmHMpRQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc650be7-630d-42e4-2dfc-08de9f906c06
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:17.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVIdIqq87A8la46vTrR5uSZLZOO9Y/eFdhbF2Fb6vu3z8oGyLmaVixYASTrC3ip9GbYoXmZyIdzNe2J/bsT/F3RN8NLN9SjwrbtNprmHE4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7389-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.nxp.com:mid,4.196.180.0:email,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: C06B243988A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Enable FlexCAN controller instances (can0 and can1) and the required RCU
irqsteer interrupt controller on S32N79-RDB board.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
index 1feccd61258e..65a595d7535f 100644
--- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -43,10 +43,22 @@ memory@80000000 {
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &irqsteer_coss {
 	status = "okay";
 };
 
+&irqsteer_rcu {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0


