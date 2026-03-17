Return-Path: <linux-can+bounces-7103-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGHyGcreuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7103-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB552B3A34
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A743C317D58D
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6A43A6F00;
	Tue, 17 Mar 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YJtvOpEh"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4013F6608;
	Tue, 17 Mar 2026 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788731; cv=fail; b=OU09Gh37hVYbYOhROkNv1RC3cixpM1ucfIym+uH3dJ2acLnLvFmlWtKEE58X5ln9Al4VQ1EBAjOMCy6SPlZCvMmrGb5IC9B0kC4+Ng4M6fhzJdQePRkh9/GNxKIcu+jatEuwbhEDDhSJgjif91539zIIcWOOviw9d6f8KnATyEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788731; c=relaxed/simple;
	bh=WrQoaVcZp+rVh7TlPDEvGawZdEhfw9s5PTilgOTL31c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbTa6iZ0W7AY3ItRptmsVoCasLvqz+3JM9t7/DWDFpJSBsv9UXhe41dMsMB8VOCyspK7V/p6h0jTrxUqd7E7Yw7Kgq/vx1yGa6WUIec963AMnVEBGyQAL7rttbw9K2eMlxrcCjB06xy1t3f8fpNI+of6PxPPp5c47YR3uVQepvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YJtvOpEh; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/GnQctZ2Nqp9eQ6XZm6vcHaDeU5CAOFSeimDIRrWi3JFAreLFm7WD5DYOuuTU+ZosxiHHrTaicUPwGkmEAULOVaMBrtbJr4/rkZNYO5tUYvtdEswEb05rL2bYV2IBd+GWsdKTnuRF84kNrJ/uJy3qGHSNPjlUhVAn4McwtNlGN8IUZWGbvDoUfsJ0cHCbtpAjL3n+52jzrRadv7bF/oZjwnXHHmMjgzfErYLrqFfO8xyWH2i+eDouY6G8ZaCX0JcB5jdbaHwJOQJrYD6DYiJrB3cOvOW/0aQqF27Idx0ziechASJWGq/Q1kZ1ipJjkrT9AIj4IZ4q4UKbDcyxmjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxXKpcYQBR72MTHmkOKASUqNwMBJoLjOJWUQcjT2LOY=;
 b=goyCkoLuGkrCrQxkv92tzZ9PFQ/cFt9QOoSxYw251zSUsIVJuuikF5kUJYidcDyPudBf7b0M/wDOPDU8lHoMOgkbjZPOtvUuLFiDw6DPmVyuN+jxSSN8PvA/FDJ34Ih0za/tILKwn9R7wUW7fX+ol/4d2N37r7CMxv1txdTzPN+rI0WuDTBsuxOBAXHVS/pjI1LTwVSEWv3Mz2HRkofKHUfeI7Nh8+5WoKz4nJsAK5+BLJrXhyxW7b6OfvP+i5ThZJ4/yJ3lGXruzK7gJngyK2mG4wK6gX5i/aJGo1EgFGZcwCxiccpfSK93ip39hBdeTmwl7JTT2KTOZ6f4eRHSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxXKpcYQBR72MTHmkOKASUqNwMBJoLjOJWUQcjT2LOY=;
 b=YJtvOpEhAUzagC/4k5KPbJptwI78h4L311bLAckqf/E8CL2vlvCvJvONivhKvly7aQExnCeyZVItfRzsIsK+5gYBohrIvGuUzdY6PQOLJpP/edGdf6fuO6C+0tlaQFCBP0TD/lcfuV/F2gKom2LU++iTUiRZ5aZ9YSZXo8WxO/JYvwOq38FEez4FgUKt+W4W1ATy/5iFDwUQrOdPdei8zv0MmDXqmIjtujIyNdYUggmK1Xfa84hzLPCDEuq0d9m/95/+Lbr92+wyhBDC+VD41la1fAzA14rdLGECZkBlpfR5jjnCWYcsagfs/BIFeJK06Ukf4LoHLKNTxr+hwtyRYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:16 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:14 +0000
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Yixun Lan <dlan@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: [PATCH v4 phy-next 02/24] PCI: Add missing headers transitively included by <linux/phy/phy.h>
Date: Wed, 18 Mar 2026 01:04:38 +0200
Message-ID: <20260317230500.2056077-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::38) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 81840da2-a5fb-4f80-0963-08de8479a591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OF0eleNT5vTvoX4Bq/1mlixOmI0vThv7gd4+a3MzJtJ9KhzqgXQ0p84gdDvzgjEaX8sYAkozHFmDzQTMIUNdzDRTxl0+EUuPKKnBm/FAEzWOV3hX9flmI/9oVKQmNQcRjq2jOZ+zif730yxlE+5YWkW8CG3grOryr+2mCVjlrcHdPzrHMbHfmvtexCLhk3qbdhUxz4GQixIVhFnkbE0GMWBUQMpP79jrsfcDO56EOshW84Z9lY+H4DDiHL66pWsHDnpQiN89nTpIdLYPSZbQYXo15VJrydADJfp+GJn6vWz5/LBNk5pfm9dRzqC+Qev/J2uSkwzL343m1Djyx+Fkz2Q4ZsLVMHdFwKFlZDkUv12SeJBMGBfvAVAtBai6a+jrW468i3+DMKYYFqEkZhcanvkYT3jcZuknIUACW3164ok07KY5fwqedGulQPOtgHuwIu4gWJezCxKN4m+fRYapGfOTbJkBHhQz59rldrVP5IDMfdE5bVYjius4PjN4s6+VQ62BcdauWeejMzQS4quVaKKCIBDw4m0ufiSGsM8NQ5sPU04VLK1Om/fo5plQ01Gs//wCEZ8g2iVDJHcPZVHrni70LxMq8Wo+fsf02BeQngT6VMp3XywpPECMydv5hX51XZsCWmNFg7I6mlTkFB/filpcvk/jn2fNrQ5wFLYtFsA4EoKu9fJ1wuhIZygfKTWT6d4eXxgzXnbjHDkh2Lk9XWaPAhcUHfqBJViBrlyRSSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3Ywb0dBUHdmRkMvTUJsTjlNeFFldHhDYURBdzdnbmlYRTMvbkRSQ09jcGpi?=
 =?utf-8?B?SStGcEFuZCszT0M3MnJvaURZc0RMN1o4elFoZVZFMmVqejhMc1ZjbnRqU0R0?=
 =?utf-8?B?WWFFdlZvOE04TmNCZWJqMk9GSWp5Z0RpWUJNTjV2Z1lheGd1a0txaW1ERy9H?=
 =?utf-8?B?Um9yaGlTLzBiczJQbFlSQThzc1lzV1IrRmRPNEFwL3ZCZTIwcDU4UThJUFJD?=
 =?utf-8?B?OCtsRG5PVUJKeFByOVk3SVMyU2NFQkI1MEJwZ3ZPc01FY3lUQ05IUlplSHIx?=
 =?utf-8?B?aHRmaE55a09jQmNPM2h6U01TeTFzMVptalhGNWwxdkVoK2NoQ3YxZ1ZJbVA0?=
 =?utf-8?B?enZITTl5NzRNeVc0MEVHb1JSckowUzhnRXh5eEpxMlhZV0Npc3ZCVVN1WHFV?=
 =?utf-8?B?VURZSUoxdGdiYUhuS216ZUJydkRId0NweGVvQ0lCSElrY1RnekdITDBFWUth?=
 =?utf-8?B?RXBuVld3ZElSNmdaQjVGdStQK2czbG9LUHJjYUc5QS9OYWhQMUN0T3g3V0Q2?=
 =?utf-8?B?ZFAySFFZSU1Jd2FuYW5yZ3BDcCs2bElTQmxSbVNNOUlKMm1kVE91THFSUS9W?=
 =?utf-8?B?bFB4ZWdkd0hCaWxHVEtOQ1VIZC9lQmtVL1MrZEdHVG9jOG9PVlNURnRFK1g0?=
 =?utf-8?B?SkREU0tWNHovWWtOaVEzdWU4RHdoK0c1Y2l4Mm5UUFNwam1yUlIvWUlkMm1F?=
 =?utf-8?B?SzBsVGVFZm5adThQaHNxU0I0dzRhL25aZzlQbWV6eU0xYVBXRkw4WjJsbUdI?=
 =?utf-8?B?SUQvQ29sRk50UVhTRVV2QTZldW5NSWorNlAwbkZlK1lsQWNjRXlmNk92cWNw?=
 =?utf-8?B?OTluUW9ROWgraUtNdk5UYTZsSDFsWjlKZUpLRUFKNDJCb1pVQnkzaGZ6QkVU?=
 =?utf-8?B?R09RUkVpTElEVXk3MHpLWGJwQ0pOb2hyTnc2Y2Q0d01mUzVSaGl0SWlZRktJ?=
 =?utf-8?B?U2V4bEgrelVRdHEyZFRKSzJkT0taTktXQVhVREZvRExJZFNncjlPeERVUzhR?=
 =?utf-8?B?RDh3bnMyNjlocE05QkZRNzNYZEN1NGtPVVBhUWlMSDhkaXlQbmxRcjkzaEZz?=
 =?utf-8?B?dHdtQXl6bTdaYjZ2MnQ1T3A1TXR4WUltODR5VmMzQlRCVmJ1emZVMTZFY0dl?=
 =?utf-8?B?eXJ0Q1hobmd2YUZNZGp2T203S25PMUt3UlRGeXE3Ulp4eFVzTDRMUGxNMUhN?=
 =?utf-8?B?ZVhhMXZrT1ZWbFBhRXFycEhDdmlldDMvaUhrMUlLMzRDQ3RqVytETzlTSFRh?=
 =?utf-8?B?ekdCdSs0TjFMd21DVEl6VkFMNitzR1d2K21JR2tRNkZqUkpwSWJFSjhOemxm?=
 =?utf-8?B?Nmh3UVR3Tmhzb3kvMVNiY3pxWFlYdmlwY0prVlZLOEx1aWgzalFONGF2Z0NK?=
 =?utf-8?B?cEFJcmtpL2dOOE15UitTL2p5NWdJV0JVSmJaRHBlTFlQMVN6dzYxejFLdFlM?=
 =?utf-8?B?WVFJMWxDZlNMcUROUkV5MThGZU9XdmRjVkxScklxZnFiWGp3SHVMZDZCN1dH?=
 =?utf-8?B?dHRkaS9hd2RsYnlLSmo4QnNaeE9pUGp2SGN1L0NUN3RKcjlHL09zS3cxa2NK?=
 =?utf-8?B?VG8xMlp3Vy9uYWxJV2kwcjJtM0x2QTZ4bXp4MGlHMHQxc3RzeDFYcWszWE9l?=
 =?utf-8?B?S04rWmxjVEk2Mm9uejlmMytvamMxSHA5QzZ1T1Mxcmc2TDRGQ0lNTDBLc3M1?=
 =?utf-8?B?VDRUZXc0WlFkL2d3T3JnTFM2QVpMcDJNZ2sxRzlPbFY4azFUekpNUi9FQ241?=
 =?utf-8?B?UUd6Qmp5RUFjQkdURGFlWHhKcVJOZDBYMVRoYW4vT1l6MzNCL0JLblp4UHhz?=
 =?utf-8?B?MkZaanU1MGFZUWJhMkVIQ0NqT3hFRkRrVCtKMG11cHNCemZNTm8vS3Ava1Fr?=
 =?utf-8?B?VzVqV2NoU2lMOHBhcmVzc2ZYUVpvaGpWb1FTaWVUY1owZm1iek85eHpldnRN?=
 =?utf-8?B?QzFnRkQ1K0tBZCsvTHRpN3RsUkFZbW93ZnQ0SDFYRFJkTitJaWJxM0lQRm9s?=
 =?utf-8?B?eDNKdHpFUytuYTdwZ2Y2bEJiZWdhbzlxVFdLR1hPSUhoS2lheVBsaHhPeHRP?=
 =?utf-8?B?QlF1ZGVhWDF3RUF4d20xQlB4Yk1jREFoU2tTbSs2UWVDVCthRi9TT2R6bzZ0?=
 =?utf-8?B?TXRXYmdjUmxyd3VnTjZWNTFGOGRwaTdJREp4R1MrUngrVEJaRGp2Vkc0dWE0?=
 =?utf-8?B?YUY4MFBROWMzSGhOdmsyMXY1OVNSQ0VsKzFPZVJYSWNGeHBwMkVWa0dMclEx?=
 =?utf-8?B?bFlrZDBUL0VFVWVFbDVMY2toR1RuTkNQVUIwTmFkYjNGUjhuUFd5Mnl3Wmk3?=
 =?utf-8?B?ak1oL3BoQVYxRUExTzhNc2QvR0RUbnVTK3BTQWpwMUZoUTNWWmx2Y0xEQ2U0?=
 =?utf-8?Q?FOzAQ9Bqh/kpBijlyRg1G+dXax/hflIjGmkzM0YRnaM/H?=
X-MS-Exchange-AntiSpam-MessageData-1: GO6GCMvrT9YXw1DMiJCD2CCUA/LtXqDkBwM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81840da2-a5fb-4f80-0963-08de8479a591
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:13.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfsdV1PLjFRVyu2eVnCuZMi+vdKw+BmFj10J6U3t/eWylCZ96cxUzhdqfUFLd12zRDqDOPq8zsSFM7AeIOvV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7103-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,google.com,sntech.de,gmail.com,nvidia.com,rock-chips.com,starfivetech.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,rock-chips.com:email,nvidia.com:email,sntech.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,linaro.org:email]
X-Rspamd-Queue-Id: 0EB552B3A34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tegra as well as a few dwc PCI controller drivers uses PM runtime
operations without including the required <linux/pm_runtime.h> header.

Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
controllers use the regulator consumer API without including
<linux/regulator/consumer.h>.

It seems these function prototypes were indirectly provided by
<linux/phy/phy.h>, mostly by mistake (none of the functions it exports
need it).

Before the PHY header can drop the unnecessary includes, make sure the
PCI controller drivers include what they use.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>

v2->v4: none
v1->v2: collect tag, adjust commit title
---
 drivers/pci/controller/dwc/pci-keystone.c     | 1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 drivers/pci/controller/dwc/pcie-histb.c       | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 1 +
 drivers/pci/controller/pci-tegra.c            | 1 +
 drivers/pci/controller/pcie-rockchip-host.c   | 1 +
 drivers/pci/controller/plda/pcie-starfive.c   | 1 +
 9 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 20fa4dadb82a..642e4c45eefc 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d..e0079ec108ab 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #include "../../pci.h"
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index a52071589377..432a54c5bfce 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/reset.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 18460f01b2c6..e417122da51d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/module.h>
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..dbec159fd458 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -15,7 +15,9 @@
 #include <linux/mod_devicetable.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 06571d806ab3..3378a89580ab 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 512309763d1f..a2c1662b6e81 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -36,6 +36,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..46adb4582fcc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "../pci.h"
 #include "pcie-rockchip.h"
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..22344cca167b 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include "../../pci.h"
 
-- 
2.43.0


