Return-Path: <linux-can+bounces-7128-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aORtEzhyumnRWQIAu9opvQ
	(envelope-from <linux-can+bounces-7128-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:36:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5E2B92B4
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E52F230C69C9
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E23A963A;
	Wed, 18 Mar 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wAA7gZko"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE143A9622;
	Wed, 18 Mar 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825746; cv=fail; b=ukPDcMOW9bjV/C25qHP7zE8VWldcKleW4jkoXB36jPZ6r6NAewsmXK+5WnqShdzxr0FElyTkKwBmdK3W3pM+u83hq/I/rPQhRflNY+7cAuhwHgg+lPsoJHEnyAj6keP1L734x2sBq32BkFvaa3ymCXLsLFp4M7WUOEqzUpSql+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825746; c=relaxed/simple;
	bh=e194nMSy8+pW8b30BHRHh5TUpzRTaLdFl3JBXffRrhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8Wa6nbQDJ1LVno2T48/q1G3vWBlD686IqFL0Jzgs4TYAJGQjkdSROI/1QL2hd0Z/2hinRxn+xJXYWCDYhKPrJmQ/K1COcHutWtGUhp3/xksflA5Z6F8XLgGjP4YYJBFqkgRhdOAMGUrL1pje8eYXM9tlGYOSP7TE8DpyUF2Y8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wAA7gZko; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2k+XSx7+8kKahn6RPDj1Zs/pO1aMpMBPRstC9Dlb+XuScdTwkETB8UiozNRWU7ba3cja3fTbrONzxwlgF57GVBNUk3rruJ5zADs5msPyAFbF62rOwaiDD3Qj8r4Nu2AglQ+GKzxVK9yenxFLWdBixiXR75RSXIJVm7GeiDR31SxhW6JtiUuRgKrsocupGnxdI1Ng9CnNBHQj7XMLAiWThLhnZ3iGpKYTk5ibEIPqXn4dQ3GVx5ZqpOUgBKwPodz8xIn+h8EJJvaW4Q39RMvyHJxqSsvE7YqAG5TIQCD7ve5r94O2SH3hEy9hTfnj87f3A+ouiKBQ82y2pI2jv20sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdOtOl+CgAK+MIUbOlQYuPuxGkQg2QKej9Dqunt/juI=;
 b=hUW/ipHSTyl49XPgtYehSYTMtfyMeBrHUFsZQeC/xEJZpNDY3QC3cxysIqlILInJYWUk4mY7v+p33FTRDKBBclk/7CamkxrecXYkYhdgH0EZxdFSsEkQjp38PC66+n4BIDmkt0ORnB2huMWIS4NuuAAq9gZR0bilbIu1YYwEbrJ510tvPcHwFrFPE2tb80qFvQi+C4lm8i8M1dI6cZlUuKlkKDrC1GVyS3fF+9gGWU9LqdbEL6+kBXkGtbgqe9iryaUB7z+matcDuZSgbpwGAywbcAAlQLKEh5NDbmBWVRyLjsHoaRIiQI88mjdcHZihigIhjiOa8o49OZZg+o3SFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdOtOl+CgAK+MIUbOlQYuPuxGkQg2QKej9Dqunt/juI=;
 b=wAA7gZkoyxfNwZmu4tW5oqtYiqUUNRcH4tQ/R5pUBzy2QI8TCOVpBQz3l9APv2uNRJjD7t2wcIErHiGsHh1v3MHEi8NZuaniJPtm++Hcaqe48Upu3/BpZ/MDywUBEtnAw5saf6AmcJx48z4UcwnfIOswd0eYjDP4qNf1uhfNUd6hQrzOJdAAJKGv6d+2D9SAvydxJ2QP1iV24CtvgBoFoR5RZoUmo30tS8dbEjE/3Cl73jVrXNz2Ly+UmmW+QcQJR0XkHEzFjTzZmUha57GwfbJ+bbk38lojGbWAtV2P4NDs8Mb2IoD5hXUzJATsHopUOPquI4X8ZVRwuoE8IMiqrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 09:22:20 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:22:19 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH 1/5] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Wed, 18 Mar 2026 10:22:11 +0100
Message-ID: <20260318092215.23505-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::30) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 98be85fb-72b9-4b24-e0d8-08de84cfdac2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aja3ASCdH8GACppY4swZdG6mG8WJfGYKNkN6UvBUcSXMi608jre269G8O6nu31kavL/w3bx0h01k9xpVYdvB41ajsQdktWvKg/5hQQBgMq+Ps0YFI5Pidl8JQLyWsr6/cYyxYbeO55XofsGIqpLRqrV8U+ycbcoMW1d8SHen89/8Ni3vQ3m5G2qbL8hBw4HYxTKOFSjoyy+/KgbnZ/zJN1NlBL3MzyocQnuN/g79LBz+nPqukrcaCxyF8Pf+zJtrjvh6vs+VBIPz3l3sXU65oTpCXlk+yDNaDkK2wttkgRUSLkfV+Exz0ulWKoIjKsy0rXn621G1yp6HmcbT7vkVPOtI1TgnwG/kNZ2nbcSyPL1+zmLqJm79uXkXeRHS5LhtRqEd3/Klgo2H/c8FJwjLWfz6GY6TMWto7zoREGK0PxE/39ewLKGh9719lcTgoj/4ZXoQYG3bRVzkqi2cYclDbw5OxfOUq5YfnQL9dWY5PA5VYwKaaofvTXJ4sfvlrxoMbUiwi2ZqbEHe0kFDAaENX2X0wQWQ/5brmSMxXdQsFRfHAjYuDKVjLGHUsQnw74WRJpiaThKbhrI8pOUwlJc8mItog3FJuWO6fyC1ZMiY55jqBdkl+Ki/+Exz2IBDtKa+J4rwitqVQ+su0xP5Gs+YyuJD5k3usmJJZIfJzM1gZC45Haw/97O9pQLGTlHuQHTsk4aFaKqw0JUI6UX2LRa5A5ucCdpEKUUQv7LsgZDZj4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXNIS0czZ05mWXM4empPcFVFUEdDbVdvcmNCTWpSeDlESklkZXhhRjJDcDdx?=
 =?utf-8?B?QWx6RUdZQnNtMndDMDAvZFBsR3ByQklwbGJWZzBFWG51NWtiUVZya0pVd24z?=
 =?utf-8?B?YiszaFFCR1BLNUZ4UDFBTXA0UndyK0QyY1U5TEg0R0x0d1JJdkM1MHpwcTE5?=
 =?utf-8?B?alo1NEZTd3VtbS9xaGl5QnF1T3p0Q1NaTTNjWHQ3djY1dzE1dm16Nk9CY1h3?=
 =?utf-8?B?Tjk5V3Z4YjRhckN2ZUZFcngxanhWUWZvdG9LYXVuVUo5djBCUHY2b3o0RVgv?=
 =?utf-8?B?M1VpQ2dVdHRiOVFBbEFVcUJmU281a3lHc3BRRzJhSCtvU1lFdzBmcklURThw?=
 =?utf-8?B?emhGYjEyU3lMTnp5S3NWUnVPbkFQNFh5L0xGRDlybjBkMXZQVFRKMGxKWVRF?=
 =?utf-8?B?TVkyM1NTRUtnVGhPN2F2SHNsZVBJc293Q0h2bm54L0RCaGNmbk1kQkdzZEky?=
 =?utf-8?B?NnRoSWxLNXpWVFA2Z1MyVnExeDNqSUxxM0hGRklSaVlXd0ZmMk1NL2pzNW15?=
 =?utf-8?B?Q1pmTi9BZnMxN1huMHVrdkdFWEtGZkNhdGtzK2orQjNreE4zeVVDUmtueVpR?=
 =?utf-8?B?NDhqRG5uMVVUREZFMkdWSlBsOXlaR00vYTVKTlZQY2psQVBBY3BudGxqS3Ez?=
 =?utf-8?B?UlVUb3BJL2h6aytiVGFoT2JhK3lETDM5RGZvaVhQWG5yOEZPamIxSERiNy9H?=
 =?utf-8?B?TWFmaWRLbXNnbGI1R2o2VERFcU1WZU5DYzh5d09wY0FZQlZzQWdtQkFKSGFr?=
 =?utf-8?B?aU1raUxQLzhuYnNvR3padmVFNXZRbTNpRW9wb3ZxVW9QWWYzVzF5Vm00dURU?=
 =?utf-8?B?RUI2aHQ5Nnh0V1MrUzlRWFdST1hrRG9UZmxEczVNZm5Va2draVpFUWtwdnJL?=
 =?utf-8?B?MWlnOUVQWGR2MEM0R2hoYmNSdDJZbjFpa2NNeTc0M2g3YUNKZEFMYnZ6Z28v?=
 =?utf-8?B?MFVlKzF6TmFQblRFWC9pRS9GdGErSnNvM2xEQ1d0RVE0TjBGTWNLTVRPSVRE?=
 =?utf-8?B?WUJUKzFYV2U0eFRKbW5ydkZ5UVVGUEVTZitSeWdaQS9FK3N4N2toQ1g0eTd2?=
 =?utf-8?B?ZkVrZHVHOWt5LzRVUmsrSzNZK095aHpFZ1RSNFJ2c0UzQVVsREk4dFY1QnRW?=
 =?utf-8?B?SVRsVUliWUFtbXNiYlVoZ2lBZlphNHgya0k3dEc2WTRncmI3aTFEeVlTWFkx?=
 =?utf-8?B?bnExanFOeFJuclRKTlZPeklVdFBsNUdibmlLTkZ3WVZqcnhtcUhKUEtvcXR0?=
 =?utf-8?B?Y0EvYVRnL2pGSExVaGxIc3ZYRlRCek5ndkpDSFFMeGE2K3QrZE5IN0l6dlpH?=
 =?utf-8?B?UnZ0V0NON1VGN0UrTHRsYUk2dC81YkwvdXU3enVHM1ZDYzVnVUZrTitkZTFN?=
 =?utf-8?B?RThvRERRL0NjNjNad3lXazZaL2lCcjlsb1pOVjh4K0JvcnlYU3ExcU1FMHB6?=
 =?utf-8?B?b3ZJSFF2eWhKVTZOMVI0eTRpNWhmVlFTWmxHZGpFZlhqYmcrbS80aFZtUnJU?=
 =?utf-8?B?STBFcEQrYTRrN0ZpTVFQeDdIUU0zb1U0bU02TFAvdEFudmExWHFieEtGdElQ?=
 =?utf-8?B?Y1dZNURLMVZDSWhsNzl0SEpWc1pLeklwdkNTREkzdTYyalpMN1FGc0ZpVmFZ?=
 =?utf-8?B?UFZzdHdVaHNyWkdwNDZrMlRDT0llWEF6ZnV0aDdHMEROSzl4OHAvZXo5NzJl?=
 =?utf-8?B?TnpwRkhRMWJvMVFtY1BDU0RHYjlEdFQyV0RZR0NhZ2RjeFFDNUNRcDZRU29T?=
 =?utf-8?B?TkdpOTVHdURnUjl6QTNYOEhNNnRlU1ZpaEIxUDliZDRPZGRpSGlqL2Q3dHVH?=
 =?utf-8?B?am9LVnduWVlud3ptQi9Db0Z5bEZlQjByek5KMVJGdWU0TTBMRGRtSUlnU095?=
 =?utf-8?B?TjdvUi9QSzdoUG90YUt2azlxQU5VR29RRytrNlJ1M09HWm5TbVpoOUJ5anVV?=
 =?utf-8?B?TzVHMU41NHJ3a1pjMWxVekhjYVJqSm8zbnU0dG45eEMxTkY1a2dJeS8xQ2lW?=
 =?utf-8?B?UndOVHc3TTJMSm9XYklYelA4aDlPRTA3MlRsYkJweDRGT1JueU9qTnlEM3p2?=
 =?utf-8?B?bUN5QVVXdXBkUTIvTHRRRnE2dDlWSU9PUlhvS2RiK25sSDBqakREN0dnc0hs?=
 =?utf-8?B?aXV0MUpRd3YxVEFYeU1SOVBaMVlHYXMrbEFEWFJnNmxqaHZ5OGxLK2dYcTZv?=
 =?utf-8?B?YnA3M3FHV0djcGVJSGYvdndmREJYRjBoQW5FS2wwMlp2N2FOczdQd2lCbkEv?=
 =?utf-8?B?Y1ZNN080M3o3QzhTckJOZG5nV3JzRVI3SGdRNXJSME9qT3Q5Q1ZqanZKSkFx?=
 =?utf-8?B?TzJvSGNiSmRmNDUzY09RT0hGVkNqRkdSdTVsdjVvalNFZytOSEZtWTFTY3Zi?=
 =?utf-8?Q?/cJk39tnrruGyUe0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98be85fb-72b9-4b24-e0d8-08de84cfdac2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:22:19.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pknREHgPJfUu2QW5HEFXaPU3mJ0gI3fNgVkOJQbln9vOhq571HEeQ7iBRjxx5tNjOQLYS9Fey1+HVqsZZRIyd7Jn+QUR4KMG83qaQOjMHNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7128-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: BBA5E2B92B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add NXP S32N79 SoC compatible string and interrupt properties.

On S32N79, FlexCAN IP is integrated with two interrupt lines:
one for the mailbox interrupts (0-127) and one for signaling
errors and bus state changes.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f81d56f7c12a..131fae2739fa 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -26,6 +26,7 @@ properties:
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
           - nxp,s32g2-flexcan
+          - nxp,s32n79-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -173,11 +174,38 @@ allOf:
             - const: mb-1
       required:
         - interrupt-names
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32n79-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-127
+            - description: Bus Error interrupt
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: berr
+      required:
+        - interrupt-names
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nxp,s32g2-flexcan
+                - nxp,s32n79-flexcan
+    then:
       properties:
         interrupts:
           maxItems: 1
         interrupt-names: false
+
   - if:
       required:
         - xceiver-supply
-- 
2.43.0


