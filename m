Return-Path: <linux-can+bounces-5085-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45CBB07C8
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C211946BA7
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94382EF66C;
	Wed,  1 Oct 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="axJOreWO"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FA2EF65C;
	Wed,  1 Oct 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325010; cv=fail; b=J8EFaHNg7sFrIx+Il3tf0S+jnreblsAm+UrqXIy8GFRQVzcGG/F4/1ufKi/iykq9iCeveQDsmIUzInky0lOA8QFsOh74XtfSn3OvkgvOhND5FC3HqHCJM7x42V0IuMzRxhQwYiymsZiOxpv8PEWKkpq4eSfxtghYnNlOCxobEDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325010; c=relaxed/simple;
	bh=HRGa/wx4/RzrTafN77tpIx0ls9EKbEJ0H+aGudMUU/w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MsT0co3Jh2TpCzTLvruMtY1YrlXxjA7ig8b3uHrmaUbRn/1HaIwhh42l/wJJLRtRrTbFo/X5cs2kCG/reO/qMy/YShNv/9TKaIl4LLQfROmEhbObOW/EH/XExOoXjZkMN93mRHotafFAGCmmBuPQAJ19hN1UYO6KCYmVc7AwsFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=axJOreWO; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmjdyWXHC1qirTveBMfiOtcd5OOtg5A8WrGMLaF7GUJ4R/zKT+ZXJGcGkPDXPa6KRDx26dlQhyrEba7My/WXnYuoTqClTZlI3R7M5l+kz3X8ayz0csUL1zUazVd582ecx4+JhNahXRBitczqnTdkyN9YkTlBHHw2uqXhsE+uNvOP/g5Eot5DOyk3OHFcNMZIfH/qTs+6JP4PVgl4dQyzfqZwawPxvaUHcGzOiqPTrguwkIELfdRkcxtuI8UmelioLJyhfBkteW/i9PriO+n5kBIjWkO0Kgu2f8DhecTD4IGE2rT4N66OKGUBeikpxkx+ruQAL7KxIa2c7mE7evB5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kpkh3erQSi/p41e7cV+kgf4oYjUdrARt/Ev1itusdJw=;
 b=myLuhtDSil1GNgHJfDMehTna4yysMZO4IzH1xSk8vIfNuBxPC5/Efx2sVCDL2ah9ckSyXdA1/oCz++mmp7JNlfNEiA+D40oRS30d1GcM2SoI0yqI/yDNjv5EFXiZPj7F19dZpVqsQia6J1ffCnKHJZOKBuZ4VDXTn7Om3XZdcrPvOigHcFXg7cfBWBtJbCFujbgTHuUkZqidUrLy1mJ9oqvGyBRwQ/JW/EBnT5qrwZ+Y/6pf4ym1OgUN3juOz9rP10nZkLYyIoLk0ihhnk+u+2m1FJSTsyXLMedYX42fivheXRJWQ/JuqA/0LJASgRfqscNcSq0QhuAOB1un1Cd62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpkh3erQSi/p41e7cV+kgf4oYjUdrARt/Ev1itusdJw=;
 b=axJOreWOJC6Y6wx6PzNHWnVMfCHRcBj53DDsJUfyeLBJhiasc1S3zbgkYyAxIxJcbqjkSwbWEdcqTvV9QCKk90cqGMd80OC7sObn7qOSJPqkIxGwmiBipCLHKc50mbzSLF+n4zSy53+3JFUb5vEAQsRZOGOPmWA0a1VhluTMSitJYbiFeJSyOQgwyoPY5ghvFJxK7yS+j2VnWCQAR0seyPH7Enegi1+58ynwtY/RZQ5vfp6gM5t8SeZdn9tMADXEK4jgD381zkywuZSiQk+g+FKE96nMayuiLajgD2gk8PTM1JyHraxb5GVzbjjk0D0n8Xno6Ma4PnezQjsrWCqnRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 13:23:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:23 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:36 +0800
Subject: [PATCH v7 5/8] phy: phy-can-transceiver: Add support for
 TJA105{1,7}
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-5-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=3770;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=HRGa/wx4/RzrTafN77tpIx0ls9EKbEJ0H+aGudMUU/w=;
 b=n/NW74d6cHDM5bEJjtbAJ6f0ouFW8MFnyABE4ejByAG4KetwkYLfaIOYZg9LmRo6Q4AwYRPaf
 MweoJduJ9BqDTiIRTkNq74+mitPpg1Iy1Gx/P7GK8j92Tys9QVjvncQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fc6a7d-f928-4b2e-7b50-08de00edb2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c09laWVsOC9HTjdvV2h0RExnQTV3M0RQeThGZC85TTRydW1qQTRMOC8reFdr?=
 =?utf-8?B?cE5vS3U3aDlUK29lTXpNVmZYYWJVeWNPbDMzaHV1UklSSG4zNy9HKzNveXBZ?=
 =?utf-8?B?Qk5HalZ4ZmpETkM4N2hBenlqblFvWGxnRFpQVnJjR29FczVncDlYUUEzZW1t?=
 =?utf-8?B?aFhkQmdLRWkvdEVuTVRFdnRKaHpFTkM2ZzFMcW5FbS9DWVlERENYMGpac2RC?=
 =?utf-8?B?Y2ZOU3lGMUtpSmJrLzA1cTJIQmRtclkvNzB1eElpZk5yMGk0N093Ti9wd21p?=
 =?utf-8?B?K2VQRnB0R29PVVFrUDZJOXlscGI2bHdHT1ZVS0dLZnF2Q3RqVk5TbDNIM1Mz?=
 =?utf-8?B?aE1sd3E1Q0lHelZIZ2lzYlg0QmZiMERRSzZ6R2trdGtNR1JpSmF1eWRVNEYr?=
 =?utf-8?B?eGdIUk1ZajdWanFYS0NXS3Y0STBPWjlvdTVuU0VZTlRRZjBSOEhpWGNmYWla?=
 =?utf-8?B?VW1KY29ML0Y2a2lUSnFPZWRyUDJ3OVhIZ2dpKzRKNTI3WkY4NTVsOTRFbTRi?=
 =?utf-8?B?bnJJdkVZejJ1UG45L3RnYjJGL0E3TWtSenRaS1N1TTlQV2tMOEVtTndpSnh2?=
 =?utf-8?B?a2N2T2pLbFhHZWwvN0JlSUtWTWdhVnFPOTRqcU9NZmtla293ZDBZZmF2VlRC?=
 =?utf-8?B?Mmd0L2lJeFpWMVRDVXlkd1BIdHZyTit5YVQ5YkFFUkVhVkVyaVU2S0NxcU5t?=
 =?utf-8?B?R0N3MTFrcHdLTVJTUjVtRDBoYVN5bVRNeTk3MjllWTh6ODl0SXhLUUlUTnJB?=
 =?utf-8?B?cmFDSEZSblY3RnozbmJpU045aU8xOUEzKzVFSE1oU3hYS0oyZWY0NkIwKzg3?=
 =?utf-8?B?QUZPRXZUYnFCYzFzZEljNE42TUExSnRXOGNuYzBHOTlDNnBRUWhiLy9zYmRE?=
 =?utf-8?B?ZlYzVXBPeWE3ZSs4aTdpWEhod1N2T0p1Z2xuOFFnYnBNeWtQdjhMbWFwcmd4?=
 =?utf-8?B?bHQ2MnRSbzhtL0RYaFZGbm85NFVDMitiK0JZeElmOHdtMFJkWHRJQUpmYnBr?=
 =?utf-8?B?NURiMzdKMVFLN0Q1c1NTSVE0S2piVGhHdWIvei9WODdwWEtVK0trVFBCNXJ4?=
 =?utf-8?B?VytjbTRhQkhTQ3VuN1hCYTdyZG4ycmFBRkExdnYzRFNlemhrMXFQRXZsZGEv?=
 =?utf-8?B?MEgyYTZ0Q21QV0dySm4vMnpTcCt2T0oyQUhPK1drZlVIRTlMWjhNTlZSY3hK?=
 =?utf-8?B?aWc2ZldWR0VUV0VJenBiT2VDNXRuQ2lCVzlsK3ppcU9abXJuVlRtS1VJVHE2?=
 =?utf-8?B?V3E2cjZrUyswQ3dkMWk4VG11b1pRaDl6VzJmWTZobHd2S0lnMXlyY2tBREtM?=
 =?utf-8?B?czYxN1JnY08rRGZaYk5zZktPM0FDM3MvTEFSVzl4WkMzUlJESVBVbzU0dGlT?=
 =?utf-8?B?Z2x6OUhHSHphZ2tJTC9OQWVPWGZtSlRuQngwcVI5SEczNTl1NWtsek5sMTF3?=
 =?utf-8?B?SENOYXhORUo4cWp0NjJyQXhid0JkMHNvakVmdG43OVNlRTIwM0htNWRUV0tP?=
 =?utf-8?B?UDVQS0RtdjNiYkEvdCtadm52eExjYVRSQnRqSnhIRTVWK295eHRkNFZvWDVo?=
 =?utf-8?B?Zk5ya3hWaGs5NVUzdHZiQUhaL0NrWmJuTlB6UFhWUlFWN2NBS1N2RG5SWXQv?=
 =?utf-8?B?bTUwL0ZhQ2t6MlpwK1BMSS9kaU5zNUpmZnM3YTJWUWhJN1BKbHhHVysrZXJN?=
 =?utf-8?B?VkpmWG9tbmU0V2xRbHhzdkRKc1J3SmlKeFhOVUtmbGUyVHBRN2puejF3Lysz?=
 =?utf-8?B?b2hhdFU3RStrc3o4SEs2ZDcyY0xEQWFFdUduVjR1VGkzY2ZpTGtvb25LZko0?=
 =?utf-8?B?UjFCZlhvZlR0N1lyVVpKUGRHWWxzaGVZQjV5VDZMSWZlRzU1bDREUDZXSjZG?=
 =?utf-8?B?KzRwTHlZRjdBWExSd1JnelFRMk96SHphM0dtVFpGK3hkUkxjV3lWMUUxWXZD?=
 =?utf-8?B?SFczWXkvM3FMYW1nSm9ocDB4d2kxMjdoaWFsUzZiOGlqUGNhM0x0ak44Z0dN?=
 =?utf-8?B?WHlvSFJnY09nUm5jT0FqbHlxeHJNK1JuS2ZwWVJmSHBnVTJrMUZUZ2FibWEv?=
 =?utf-8?B?MkJqMmlHbzJiMkpKODJDZnh3VnFHaWhEQnJTUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDVTZkxTTCtKRk9GYjN2U2hpOHprU0xFRnI3cWJsMDRSMGxyN1BtOFQ5V3pZ?=
 =?utf-8?B?RlluNzhXaFpYbkx6VzRaYVluaGlyR1BTU1VWREo3dURCSXk2OTluRUxlL1E3?=
 =?utf-8?B?VHhZNmxEWThsYW5HMVhQVlhpaENuMDN1M1NzRVhrRmNRekZYSlNpNVpzMUx5?=
 =?utf-8?B?TXd0aUdsbGhYY3h2NVdBT29ZeGtObzdNS0hNa0ZuaVNhc0FqSmZwSzJ3dzNX?=
 =?utf-8?B?VjNJNTgvdDRzckdmbHVnR1k0Nlp5YklpZW55YlNISXhmdDdqYWk4MjNKL090?=
 =?utf-8?B?b2tSdkgrd1Bmak5WOHYrR3JUNThVUWg3YkpNTS9GcmwxYXRIbmFhWVdGMzNm?=
 =?utf-8?B?U1JaYzZoMzUrdTRaM1h3TEE1VFVSYm5tSG52dHJjS1pONmI5VmpHd0gybU4v?=
 =?utf-8?B?Vngya0g2Z3U2Ry8wTWlDMVdGWGFKNnZpcHRZNlN6TW5jbE1VRUErUVp6WnhT?=
 =?utf-8?B?ZDVCdHcxS0d6dWpoMEc2RDR5YkVEOWlSUW5hMGx4Sit4b0pXQjJpYkpmM2w0?=
 =?utf-8?B?aDJad1l3OXZad0w5NFV2bW8zNlh1UVg4WXFsd0VsanEvRk1SaFI2R0FMWVdm?=
 =?utf-8?B?aXl6TXZqV1R6Nko4Y2xoeGU0NmtEb3NoYm1FQnBvaUNZcG5OeVl0c1VPZys2?=
 =?utf-8?B?L3hSd0hpbGFNYUpUL3lSQ0UxTCt1eS8zZEJ1TTFnSXovOFQ3TFB4UllKWHlJ?=
 =?utf-8?B?c1lhemlHdWpCdE9tUlhVMlZtR1ZoYnBSUUkrYnc0NFZocXp5OTJ0WjBsYXZO?=
 =?utf-8?B?T05BSUFnbEhyejJKVDFuVVd1cXI4eGd2aFZVVFJ6NzA3ZXBGUUd1UlRtWEl1?=
 =?utf-8?B?WUJ6Uit1RnRhVUtidDZodzhyMVRKaWpNYlNOeXROM3JtV05uMzdxd3FmMGY2?=
 =?utf-8?B?NzRENGUyVVM5TG5wZU1DNnFzUzZwRzNsRzR2N2UwYWNGQ3IvdzVQQnlzbVgy?=
 =?utf-8?B?WUlVeHJ5M0lnWDR1cHJ6TFZwL0RGUG9mNFpwUk9LM0VvcE1uQ3lpejVHUktV?=
 =?utf-8?B?dDdIWDZQaTVUenhxcm9BbnNWMnhtbGJadkxONzZPTWNRWTlwaHhkbVdPZ0lZ?=
 =?utf-8?B?RHdBNG5xMVNrNGNHditxQ21FdVFRVENDNHdPQ2tIZHV3S2tKY0lrVjBES2VO?=
 =?utf-8?B?LzA2UGhEVDRDK0pKYTNaWnluZGo4TmZJa2RGOS8rbHFIc3o0RVQvSTYvVmpV?=
 =?utf-8?B?c05GbGNiS3pGYkZXaTJJajdDWVdSRTcydVRBMi83U1k4bEJNMkRvRUtycjUv?=
 =?utf-8?B?RGZDOWx1dEdzUnFZVnQ4N1MrbmVsM2NqNlpNeTd5Y1ljZnViNkpDa1JWUmFp?=
 =?utf-8?B?WEFqTzJPdk8xYTZOU3hDNTZzNnFaaGFyQ20ydkxTbDk3ZGxwQlVWLzdmZloz?=
 =?utf-8?B?WC95cS9JNTZlbXhRTytlVm9DYSt0Y042NUZuTERqR0c1ZW5uZDJrdE95bXJ0?=
 =?utf-8?B?RDhqd09SbURkTHF4YVphUWc1cWYyY080WEVWR3ErUnJWK2dvVENRQm1xR25E?=
 =?utf-8?B?NkdSMDJlcDFvNUdjNlA4M3ltbUxZaURJUjI2NEtYWWMxVDJKZmcwMnFycVR2?=
 =?utf-8?B?bUkyWVJZQnNiSEhFRFlWQzE0TTVKWmVqYklLNHUyNDFQVGZQczA0eXZNdE5o?=
 =?utf-8?B?NU9oRmFmY25kL0VTb28zbXJ2SHQwZkVIWVU2eDY2U3lSUVMycGtaTEQ1WkVE?=
 =?utf-8?B?UjVmQjZ6NlVwSThQSnhQbUFJVkowK0JwNVhGQnozZTcwbmpZQ1RJaENSdnY5?=
 =?utf-8?B?Y2xiVU9SNXhPdDVWTlY1UHhORzVBTm91RGptTjFIc0t5d3ZkanF1b2hQZ0Z3?=
 =?utf-8?B?Z2VuQytCTWpJa3RBWENkYzNTaTFOMTh2eW9kenNqOTROUEtPZnhDL3Y5R1J1?=
 =?utf-8?B?V1RpZW03c0dEREFadjJVUForcW9nMHE2UkJZNFJ1L2g5b2lwSENOQ1RZb3hW?=
 =?utf-8?B?Umw5cnl1NXhRWEdDZDN5Z1U5aTRlNU1BWExHc1V2VzcvTkUyQitTN2dzZlpX?=
 =?utf-8?B?QU84OWN1ZDJ6ak9zMHcyNGpoMFBrTmRsaUJadldzNU5kckY3UWF0THBsYy9z?=
 =?utf-8?B?ZXJqYWNBenhqeGxPTDR1eWh1ZWlrWmxQL1VFZmlESG43dStSZWszZDY3Wldm?=
 =?utf-8?Q?EMf9Kv/AzoLdZhfcLYDEJ1/sY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fc6a7d-f928-4b2e-7b50-08de00edb2a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:23.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyKWX79CjKo5dCcM7Sf0vCEGEVJDjgoCZIjgLSeZuKdSUiZhYGVwp2cmwgC3AvkBDrVYaaUXMaznFzj7HKjRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

Support TJA105{1,7} which are a single channel high-speed CAN transceiver
with silent mode supported.

phy mode is not implemented as of now. silent settings are kept in
phy_power_on and phy_power_off. After phy mode is supported, the silent
settings could be moved to phy_set_mode.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 89189be9b795a626dff7046c6a60cd4b841f4f0f..330356706ad7bd40901f2cab928f90e1b4dc6c5a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -18,10 +18,12 @@ struct can_transceiver_data {
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
 #define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
+#define CAN_TRANSCEIVER_SILENT_PRESENT	BIT(3)
 };
 
 struct can_transceiver_phy {
 	struct phy *generic_phy;
+	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct can_transceiver_priv *priv;
@@ -47,6 +49,7 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 			return ret;
 		}
 	}
+	gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 0);
 	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
 	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 
@@ -59,6 +62,7 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	struct can_transceiver_priv *priv = can_transceiver_phy->priv;
 
+	gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 1);
 	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
 	if (priv->mux_state)
@@ -85,6 +89,14 @@ static const struct can_transceiver_data tja1048_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
 };
 
+static const struct can_transceiver_data tja1051_drvdata = {
+	.flags = CAN_TRANSCEIVER_SILENT_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
+};
+
+static const struct can_transceiver_data tja1057_drvdata = {
+	.flags = CAN_TRANSCEIVER_SILENT_PRESENT,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -98,6 +110,14 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "nxp,tja1048",
 		.data = &tja1048_drvdata
 	},
+	{
+		.compatible = "nxp,tja1051",
+		.data = &tja1051_drvdata
+	},
+	{
+		.compatible = "nxp,tja1057",
+		.data = &tja1057_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -144,6 +164,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
+	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
@@ -203,7 +224,16 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 			can_transceiver_phy->enable_gpio = enable_gpio;
 		}
 
+		if (drvdata->flags & CAN_TRANSCEIVER_SILENT_PRESENT) {
+			silent_gpio = devm_gpiod_get_index_optional(dev, "silent", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(silent_gpio))
+				return PTR_ERR(silent_gpio);
+			can_transceiver_phy->silent_gpio = silent_gpio;
+		}
+
 		phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);

-- 
2.37.1


