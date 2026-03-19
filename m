Return-Path: <linux-can+bounces-7141-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFUvDrDHu2leoQIAu9opvQ
	(envelope-from <linux-can+bounces-7141-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:53:52 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF32C918A
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12F230672E9
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26233BA23D;
	Thu, 19 Mar 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ivZxVDsY"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3537B3ED;
	Thu, 19 Mar 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913241; cv=fail; b=TnVzpjLYQrfI2TsdgsnpaVEDPWbckxTecS0sCREw2HR66cBfkSf44BNcaOGo3USP9D3YlQPLxgXso6y4g5gjxyL7vUFS6nXTTMdFtUvLwCPuFvJUoVFdHmzlGJrTiJkqU7RL5Ms/NO0N+5rtgy94ktkHicdSHloRk9end9plIKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913241; c=relaxed/simple;
	bh=zWuzjWcG8UGl7mWEl//Tj7f9nR39D23vg7rL/hJYRZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=An1bdl0e0lqFW4vXoXc+yPIsoXeTEpdNPOt5qpOvZ+g62QxNicsusavzBtshed4BSU25unR8xPJ+l+yijHi9/SwM/x61T3xugzKc3REbS6P+kO6pfMnb6tvyi9eLdLTmYWT/QM3QDniP/7uIZJfSoa8RHyODdOSEWU1lOtqq424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ivZxVDsY; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bD9fNSXJmGx1kQCh+6beXeISf3GGOd8gkCL3Xpl3Z2W41Yvt3ug+7gXaKMkH9gRmsxJqeBBSjKMweIgmjnoKTr4EZAbvPq3UFwlUpVhcbro8Fuk1D1E+t57h6CqATszwYqkmia+H4Iq+xaCVTCXRNhPRd4/lcIwyF7wrWZXHcs7AxgFJIfeOtmjG33khbUuKiCsP8AVVOwXGhfvZArjRgMWs3r7M/7jrgHdWzA62IGj0iDEELtDHlsUmn095EwGKnwqJyXwrj4PJAJi/WKJsRL6R03Ry+5u7hZCJ5nJmOW6KRoSJi+JTfM1zcGcl6lvWaEGzA2yWM3wl3lw9o6D+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUBYVEmwDeXebcKRmjhKJHAiUFgwxPKg1vdjRnjDe1Q=;
 b=hZjLF5AzAszDGrFDVs+eNQTs3hWwJ8rSGMasNRo86RPMdQ7+JyO45rEKVqLvIKLYNOP2RLMxhlzE/tsgDbYmUj6bltCvB68VGOYWAWix+2xi2GsjwbDuExzX3TtmhL8wAByNDyUUZIPzSU9Nq3s7pDxEB82IsiIPYul2FhUj9hKqFnsQ1uORhQrj8JjxH7Oqbz4ggLljOdhg3VmYgG1wIgHSHyxve5az+dY9PdCHY2mC7ymmQVWDmmv3NTIv7MU9Ea+x5vBNR1ZN5+FdzqXIrV+3195GA97u8DUhRpYNoS2tJvBHgbEiKocnqOtUNKt6Z/Zs0IAmn1Lr9xbaN3e0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUBYVEmwDeXebcKRmjhKJHAiUFgwxPKg1vdjRnjDe1Q=;
 b=ivZxVDsYRQuTsCPOFmcWwRgk8agBHfPwx+5fl0tPFV+XLkuJoLrGJoAaw1BGKKbmgb+tSlgFr6A9Ekc5ZIaxAHXfjOd6UBQeKxI9L8JKyIXre4/ax0HBBNGrWOeMbLVg0A8gjpYGD2tDgWsiuGv9OKUIcOeMtqEX6h1Tizip7/IQ+holmTu5TBadvnQ9T+GPCCI8APOUfdicvXAMsp6u2FgPjO/QHN22f3+H8SUg7Fh+J3R6aOegnCorNUnbF2KXntaKQna3gMkaMgd6DdwN6A6ZF47ntqmGq4DPpR3vEXMbZ9lDTr15PBGooh7t899ZaoLX/UXEGCAvUO8N9tClLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:40:31 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:40:33 +0000
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
Subject: [PATCH v2 0/5] can: flexcan: Add NXP S32N79 SoC support
Date: Thu, 19 Mar 2026 10:40:27 +0100
Message-ID: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c80f2a5-7246-4295-74a3-08de859b9145
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mjN0wTMkZuXdz81khJvETEEkW9KTTNo5XzRQ6m9QanmxDmsq7IVkXegksYFAAymCWCVlDvyuenAuRB2o2O/r/rjmGsEVqGyQBC9ubwKCwmw8x9Co4WNZ3y6QzSVRF6JchevJ5l+4tkoEw1h25QynZLhxh5yygpGD0VQetC89YbnDs+vrvUcOI0Df7TwyZiid7O00TziJBAWLPjaWcP7fvMcLor3QtQ1XAofS05Xb4H4B9fBYXsgt06hfi7C74nU//7ZxfVJHiuwHsn9sVIDiuZs1kq2Ggu8q6NRw/7CJFc46tGYt5MsodQaC2gWNnNm7KGXjIFh0AsLSyk87Wlj9VVCn/bioP5nABPUONtN1FiXJ51UBl0GzMQbaXcBL2K05FcWpkwsdvdjWYGMvAtbxLdnXLpdR1kASnirf3nXow8azRNb5KZtVNUZcWYZd2oE9egsCjY5O7dxe3h/IRYnvfRCiH7BYhNuUAygIsB1/T5BReRZXxPa4wafrdin4sfL6CyN8SyjAYlK1sYU/X5HP7fl8mT6tZZ8/lU2GNwwlMeObXv43sZzUePMy0ijVi8+QULKuQxwzD1ITeWrEuaSy2Mvpur6/fgmSUsUkXl4WotqoCOyp4nidgcLPjxSeHuD+lLzzE39vrS7gyqyUNepccDKv1ww++zXVW9P0ChtmBTNPhK9xtqzmtHqJ1RQfBIQ3lLsZRn9s15YQNZSjGfMr1MLN6M3JUGN7rXPShQeL0XA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGhWVUpETk9rS3kxZDNjN1NVaWJYZzVGQWRjMEExckNES1RNcVVWQzZzUjRC?=
 =?utf-8?B?V3lYK2ZsTXVaMFFKNittVmd6YllCOFE1clRqTTlqT05kekZLYk56OUYwSzI1?=
 =?utf-8?B?Q0NYZXhoekU4aHNtVHBmdE5HSUpubFp0NDNIRGdRWG44OXVBVlNYY1BqQ29O?=
 =?utf-8?B?V1NORTIyNXZnQUwzY3Y2RzhHbzdHWW80YlpYVDJ6bkQzSndSNGxWZEk1dXNt?=
 =?utf-8?B?ZjM0a3lyV3ZwczU2bU9GditCN1EvRkVIdjFWNkIySHpWQVhpMWpQYU9SZWdz?=
 =?utf-8?B?Q29kcEFFV1ZIdjJDWGhzRXlUa3IwaENqenVvVU5KNnV1RkNUZHRiUUlFc3Mr?=
 =?utf-8?B?VG9rR0FtcVhVa0czUWlZMFNLME8wc212R0M4dlZvZlhGcm05RWxaQkxndGdt?=
 =?utf-8?B?NVRERDRCK3dvbm5DWTdkdjAxQjh1WXVZaUxGbU53SFRlejdMYlNZRGo3d0lt?=
 =?utf-8?B?ODRRdkJJVUFEUlh1UjF5MGtWeVlOeVkxMEh0eUR0a3NZUHJxcGloemcrTnFr?=
 =?utf-8?B?cXZ6Ung2dnJlbU1qeXhQSk80a2ZwUkFTUm9LVE85d2R1UUs0T05MTFNSYUFF?=
 =?utf-8?B?RmYvZEtTWGpHRDBxZkJ0RTF6TEw2Tyt6a3FCNmw4d2ZPMWpaNHBjaG1MUHhH?=
 =?utf-8?B?NXdidzM0aTduWkxjUmppNkNERnpubzFyNStmYzI2OVplN0ltUUR2aXdiMTN0?=
 =?utf-8?B?aEdLMDQrbnlVa1kvSS95dFplRkxPVlpxNmM4SWhmMkJwbDVOTlVuWjlqcHJN?=
 =?utf-8?B?SFJFWS9yWExLbE0yampOeDNtMzdyaXlCa1pxalVjY1hWaDE5TXlOa0VHSFF1?=
 =?utf-8?B?RGZ3NzBnQURiaFM5em1hTG1TSkJ4ZFlKQnpnSHVlZm5nOVRSaytZaDZRM0xm?=
 =?utf-8?B?UE50SDFFdUNmQWplZjZmOU9qZFdxK0syUjBlcGVJdzY3OWFiTDBxTklaY2cr?=
 =?utf-8?B?NVhDZHdDdmo5WUF6VjdkRDVVbjhWRkNBV0xQZ3JKekFraEhqUnNlSXcwckxT?=
 =?utf-8?B?dzJFL0Q1b091YzZyNSs0Szd2UmgvSHplS3Y5ZFhxSENWeFRGRU01Tm1qdVNV?=
 =?utf-8?B?SGw0VWt3amxWMTdrUUdjYjI0VVBVVTlCZXpJa3crVE9tWGhyNmtYWWNIdjYw?=
 =?utf-8?B?U2RZc2JKR3ZOOFpmQVRyRWdMUzRFSnEzSmIrRFFEc3NRZUFYSHorUUs2c1lG?=
 =?utf-8?B?NDdQR0JiZGhCMU16MW9EcFI0bXlnbkdYSTdRemxQYTdIK2h6TklWUjk0VUNH?=
 =?utf-8?B?dEJleTd2NkxVSGE5NXhKT2h2OGw2eUxpbUxpWGZlR3BKMldrQ1ZrR1lScUht?=
 =?utf-8?B?bmo1cmJieXpGZmVxSGlTb0VScXd2QWlBRUdZV2psZVBzbkc2V2FVeVhlaG8r?=
 =?utf-8?B?RUJwc2hWSytyZTdxd0x0dHh2T0xQRldndVJETExFTUtoYUUxZUJlb1F3eEdo?=
 =?utf-8?B?RHhjUzRSVjgxS2M4OTB0S3ptaHpLWkNibXN1OTRzdkd5TitVZ0t5QlhvWjFx?=
 =?utf-8?B?djI4VVowRE0yNXU5SThFV3BnS0pXVjlxRVJhcDJIa3hYMlJVekJtZVRacEZK?=
 =?utf-8?B?a2xNMlhhdGR1UmNMOE12VXo2c0dJNUFTZHErWXZBVElMZ0NhWWFKcWppbEcx?=
 =?utf-8?B?Z085dUl4N1g1UGpwL0Q1WHQwcU50eXJ4YkovL2lxUmFxdlhYMkszSnhiVmhI?=
 =?utf-8?B?bjBnK3dDcDkzKytZZHA5QkIrMjZvUlNwWnF6SVE2cmM0RFZqZ1ArTkZ3RnRT?=
 =?utf-8?B?cWs2QmM4cWZTSXVXdXdCaGFtY1NSYitSdlNUcGdCVmZCa0VGRWNMYWFZd0Zi?=
 =?utf-8?B?TXVFKzVnZWY4S2oxbzc2cnZXU3VzY3FKUkU2MER5eWRpSjM5OUxPR3BuQnpi?=
 =?utf-8?B?UFhnS0EzOWFrOTdYRlMwb09wSVNEeEUwODlpUzRyeWh0SWswUjV6bEdqRXl3?=
 =?utf-8?B?enIyQlZya1ZoZkhGSVlZeGFMWC8wUEFBTHplUW8xUGtheHpzYXc5QXA2TnZC?=
 =?utf-8?B?SzFkb0JCa0c3OFhvcjZBclRDT2l6LzNrNStHenQrVHRIUWZkR3U1dDRtWEdn?=
 =?utf-8?B?eStXVVpBa2dkUGMyK1FXMmo4RUZYbEtIWGdSdC9mNXNNaUhWRVF0UnVFQjhY?=
 =?utf-8?B?S3dic1dlVXhWMzlZNjhFNGdWRWNGSkxIMVFKRXE4Y2RCUWgyZzNINkF0MVVt?=
 =?utf-8?B?YVZZQjFWRFJOb05LU3k2Ym5IZGZDVnB4RTVBU3Q2L3RxZTIxSGh6M0Q4MzA2?=
 =?utf-8?B?Qms0b3RlbkNSbGhUWjl5S0dBUVRrbWk3amdCSEJhZzdWQWkvaTg0dVIwR0tP?=
 =?utf-8?B?L3NIMVlVM1ZocCtYWVBRTE1xejlHekNidjExZVlCcjZUZ0s0WmJFczlKWnpN?=
 =?utf-8?Q?db8Iycf4oArcTl5Q=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c80f2a5-7246-4295-74a3-08de859b9145
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:40:33.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6iW/xcvHyabmYDUjhgd/YL1hQMeDIc3ABPK5cc3RtXa2Y6/USrPhVLO/t/QrqkBo6iUpyXxtG6cTV208B8xcFzjsw3XIBEJnlj+2jdtwYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7141-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACDF32C918A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
  1. Adds dt-bindings documentation for S32N79 FlexCAN
  2. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
     configuration
  3. Adds S32N79 device data and compatible string to the driver
  4. Adds FlexCAN device tree nodes for S32N79 SoC
  5. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

v2 -> v1
- Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
describe the actual hardware feature
- Appended new quirk at the end
- Switched from platform_get_irq to platform_get_irq_byname usage
- Updated interrupt description in dt-bindings

Ciprian Marian Costea (5):
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support
  arm64: dts: s32n79: add FlexCAN nodes
  arm64: dts: s32n79: enable FlexCAN devices

 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++-
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  | 12 +++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi     | 50 +++++++++++++++++++
 drivers/net/can/flexcan/flexcan-core.c        | 31 ++++++++++--
 drivers/net/can/flexcan/flexcan.h             |  2 +
 5 files changed, 121 insertions(+), 4 deletions(-)

-- 
2.43.0


