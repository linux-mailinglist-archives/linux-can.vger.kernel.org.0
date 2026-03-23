Return-Path: <linux-can+bounces-7227-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBR1OCxIwWlGSAQAu9opvQ
	(envelope-from <linux-can+bounces-7227-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:03:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 871942F3B9B
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EF6B3048453
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BF3B47D5;
	Mon, 23 Mar 2026 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="svgWHg3T"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340B3AF647;
	Mon, 23 Mar 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274328; cv=fail; b=pWtE+yJk76NK+HLMTNLzRWClLJVrmTxFo87NY/A+gamQaYLGDF89j26XUtPwSs3FRIKSsFyj2FEoI0ZwKUyIzHlldIOc+kBRiZui/nmVBDW7PDWMJxVGdeG32s/n+W4AEXZbMHJ5Tv/2rrfET7QJlLLVo0jO2GOhzJqI3FNQDXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274328; c=relaxed/simple;
	bh=NjkkmEQvIhu/ukpc3rYoo+G4FDElFzZoJ0lqkJdSKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmZC1d9PN0Mq7cBBdseM1e/yUkp7cwYs6hmDACO6nHe5Wn6YPmL6iXLTYzTZj3lyMgXsPfXY28pVNcNZ2W9BcavOAb7MjVuuiaK3DXCium79veB8rS4PN1KpI/M2GctNmkzZ4pEZBAAabnLDW0mC7VsHsMlfG8dmsjygwJUt884=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=svgWHg3T; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/7i12iorqDhScSfLpV82T70qGWAc1UTbqBnRfKYcfZ7RSkHobFByENQznD74bPr3sQ00H2Elky5mrbUXqNriWVZHn/Yjk/G1MmXdUX8/Wi0xldyDABJ1aKnNAXDywvwdb4ehqhzLK3KmkFZsb0UPlkrakCjNubmWL1jgbW0O7u8hPcddctmwCJjqdL40bTZ92uqrN/cCoQaJw1zabC6IWn3hbUxnBtp6XYpNbqH4+MLaP2amMmCBD+IT4co9FGx+HgGwsh1qJOWPJu0xvRFIGxPWPthklk4OknXKJb3C9zlZp2cm/vfyEKOGj43tUx3R2Cc0+NW+2keVQ7YtUNwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=ZrhmzvP29LcV2jQVYrrgLlgNXsmVBWpna6Iyws9G0avIzob5IcpeH1y5yUANl+dcxetqgarvyo4zoVakfLl/tm8ywF2s6gE8AWNCUh/87niYrV13/fkxmgdRgl8jln6WMWDP/+stRU55kLq3Fxgtgdwww1s5YW4cR2KI0soQUCMCf1GYd36G31pMgh/oMOww2BaflPCEcEfcvcuI1JcwPJai1eOl6PdEOrW8652oxexRUzLl1JXGhGA00sbIq1suLO/txFqvGkqaqVbP+fCuglTf2wpEzYdmo/5VuUmjEMuoEP/WARKwrVQujx99Ut2qYUUQNgA+SSjDbAX13jXCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRQouUAtAoFM2r1Ht6OLIZn6BKh+s2A174EICOx9dcE=;
 b=svgWHg3Te6hNhrEGo/Qil9DZfX1AOvCJ24s3FdCjK5XA6jHKJXLrZZJ1TMiEvh9GkFXPEutKnV1IkZ+j/l+AZsljBa776cRiYrWFtA7SK4NlNXMvKXQl8XjRPuy23AmWcMZp7EwKcw7NQkTb9J27i+bC12RUMW/VmrIf4Y+v4Qg2q3KiJTQ4Vp5c6NRnRstGRptYFaP7avAm+PPV8wM/AOX66QwpG5XeJm1aAMHsxZSEVOug5EAOr+OPfncpSJVp+wzXe5Xc8mcphndxaPzkaINC/YGiZVOK45wfNGBaOEGDSizgAE/AxmyFaTacYheTTe9QoMfhv6+/VtJ6hHFoBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:58:33 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:58:33 +0000
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
Subject: [PATCH v3 6/6] arm64: dts: s32n79: enable FlexCAN devices
Date: Mon, 23 Mar 2026 14:58:27 +0100
Message-ID: <20260323135827.2129371-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0064.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: e625d6d0-bd3d-4746-fcd7-08de88e443fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZfnQybi2dYfwqcdJnioB67OGtmlx5s2Pz3wyS6peBspPrmyIJIqtS+nZ/x070+S11AcCXnybfZCDfGB8poh8YcdfMPKvNVsqC7i8GSqxbyTmCbbYYVVSDlXUmrSAeUbBRBVzwX4qJXS9nN22/sm+wVS4XXcsbVrW+G/q00H+cdjnbn30PoM7RdsVHa4hAwDslKNqJWkC1zg7SIYJILKzT9EK65cVoP3a1KiH7hoDkLfTLjLA/x/fY13EDBx9GxFcTR+EdPkFjRRiMp6pzTH1hlGCJlvfEWdocVU5nLWuboVij7OalZc8YBuybJCcHDMyVr9s5zqDTFz615NjhsmnrnoS9Jp/bpGFJnaVzvCnqXw0vqT1jj2A8O0ov9BL+FRPilbpb11jAdM4dcPyEmfDLv0Pgf2rrPzf/4D+9AhFDLQKhU6ujPXpnMp6Y5IaRNetjrI+9DUJ2BCtChyFeHhK3Kadr6HYYc0HbUFl9Q2q9V5SYmp83cwSz3u7h0dmeJEXoGjqK8/dytIaKRx0yQFZTivlgtflhcLc7mJ5a5mK0UAeqC50wsGNv/5Ir65NO3nkO/HvJi5gX+EeL0a8kHXekczk7xkfoOPdEpSPwvlUUAZ3T3oo7JE6imCA1hAOdEhYxlwYLQF0PGzSKAQyhsn9Up6OZmeUzmAxdrUIzCOtKcqzPeomNpNTGOFskaY41XhhMik6MjGCXw9Iny9A/yZK9nvO+7bWA67jNTK27K/WP7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDd0MFFiRmVvcjZnVkYrTkhRUTBJbVJTcEozb01Wb2FtRG5LdmRHc0hEZ09m?=
 =?utf-8?B?M2xibGFLSFAxWEhnSloxYTJDY1RUVU8yM3pyK2dadHJsbHVNT20yNWV5VEdR?=
 =?utf-8?B?dzBzMldpZjZDTjUxZXp6RUN0dEtqK3pxSCt6bUVsOTVoclB6Nk5lblN6dlBq?=
 =?utf-8?B?RCtzbjVaM0NFZmxlSk1PSTVDajZpckN4dDlNM01GYmFiUDlEV24vVDdvazUv?=
 =?utf-8?B?ZlIzeVB3MmgxajQ0Q3B1V09ZM1FxdHRhS3N5SXdaWllQY0lNR0hkcXc1MU8w?=
 =?utf-8?B?YzdNOXFyWmJTTW1Jc0wyRnpaMFNJZWNTRGZlVjVWOG1HdmFnN2RDRGJtd2Ni?=
 =?utf-8?B?Q3hMRGcwNmdWOFZsMFppNG1uZjNYZHkwZDczd0xmb2txSGFrbWx1OENlWVNQ?=
 =?utf-8?B?QkdaWEtocjZTN2RkckhLQzl1ZGVDMi9RMEtyVEw2R0QvSkZGYTJpWnYxaWRw?=
 =?utf-8?B?eGoxY0YvbTBkVmVuSDkxNmpxSW1wbjRMRVRTbHQ1QVZZOFIvVWhlWFNIQUVx?=
 =?utf-8?B?YTloYmY1WHVWVnV0L1lsNlY0TXNWTHRJeFBhbjlvZjNheDcyZ0E1ZWc0STRH?=
 =?utf-8?B?YU5La2VIR1dtTUUyaENZQ2dhM1BjKysvM0Vod3FuKzMva2p4VlZJMzY5dFhZ?=
 =?utf-8?B?aGZMR2p3NmI2N2tXZEZoK3NqdnFhY2pINGY4WjkvQ3NraklMVkFGWmtzN2tZ?=
 =?utf-8?B?WEd0bVdjcFl5OFVzNVA5WWRpcmtFYkFzdERVSHEzMlpSOFNqNjhQMVlhQUVs?=
 =?utf-8?B?OTcrajFNV0F4TnBCVnlYbmYzaWhwRndlYmNCaHJIUzFXVGUzUXVJWG5XRTJt?=
 =?utf-8?B?aXVBQzRGMWhGSzlzOE1IcVFaTElPd1FwOFdPOTlhVFdpRlpiZjVqcERyLzMr?=
 =?utf-8?B?V3ZPVGpBeVlHdzVKN2E0Sy9OblVmSmFaODIrZEsrdG9tb3hNNjhpNEFKdnFD?=
 =?utf-8?B?MUNiWDBxVnAvZHhCUlhTajIzRkJYdi9UU3o1L2lrMXBueWR0L1dYRm5qazgv?=
 =?utf-8?B?cE9kbU9qbHplTFBOM29adjhjK1h5TkF6bXZFWXBiWnJrUm5QTDRSRlhEMUNl?=
 =?utf-8?B?MzBkSUZCTlN1QTlFZXlpRW52R0NRY3dFTVRYSFUzakdzOTN4bzlLRG03TXg2?=
 =?utf-8?B?ZmI4bnZRMDZOb2xmOXpYRHc2MUVMMG1pbmxuSGtDRERNOEdWTjd2WGRpSG9i?=
 =?utf-8?B?SDkzam4veWlVK2E5bE0xa3BYWFF4anp6VG1jVHlmbDdCdE5nbm9OSGJRdGJk?=
 =?utf-8?B?VWZxL1hrWUhidFI0aGJuSWRhRTZmWDlqNGVSVzBpdkhUVzRib2tqWlhvYUFZ?=
 =?utf-8?B?N0xsU3N3MktlV1hOUDA3bDlUSi9Ydkg0Z1FiaVdIZlNXYWFRNkgxR0R2K0ox?=
 =?utf-8?B?RGR3QTJieUluVkFqRFhvdVFaendxK1VzOWhORGFDSGdKazFCbGRyS3hjb2FR?=
 =?utf-8?B?Z0pGMXlZQXVHVjBOZDM3alVwKzgzK3dKMEFwdEVRNkZGNG5xc3gwSU9iV0Zy?=
 =?utf-8?B?dmZHaVcwQmhTNWU1MlplVnJFeENiV3h4MlJqODQxZWIreUJ5bUJOSEFXTHVm?=
 =?utf-8?B?SStoTTNnSUxWM2cvdXRCb2hDVXQwQ2NPTXBmT0lmMzcxTmhvSDVsTENwQ3pD?=
 =?utf-8?B?cTc4S1lCU2c5QitKLzNDMG01dmlXMGl0TVBFU0cxc0xOdzNRWEhWUlhQSCtW?=
 =?utf-8?B?SUc0STNPVmplelNFM0dmUHYrWS9JTE83STdvaGFJTzUyTHhPSTFISm8wcWVy?=
 =?utf-8?B?c1JuOVIxNVZTeVNReWtCVFYzTzZTWXpUWXBPdEpva2hFcGphNEhyS1ZxZHdY?=
 =?utf-8?B?QXVtL1dKbnNJK0VRa1VGL256blNjSzBzdHU5bE9YL0FNcTUxY1JMUU12d0dv?=
 =?utf-8?B?OHlldVI2MW1KNVRIVm9aTHYxQWsxK2pUNjlaL0xBeGtxY1BHTFhTN0Z2VzRJ?=
 =?utf-8?B?NWRkSUh5ckIzSFNkVHE4YmhFUzBwTFowbXh4dGxKSDV6a0p4b1FVUmU0RFRh?=
 =?utf-8?B?VWtnVkpPdUNndnNPaCtoZVJOSjFMTVpvWWJCN21mZFlxVDhNemRKRmV3WGx6?=
 =?utf-8?B?V3NsYUdKQ1pHaEwzUkxHWHhQR1lUei84RzJWT056WHVIZDBoSDBqVVU3dGYy?=
 =?utf-8?B?RHYrdElObGhvK0gzL0U1Z2IyUlQyM0xINTVzazFsQnpoNW5mZFBtTmlrRU9M?=
 =?utf-8?B?NVpabzNidTQzcitJNU1IdmVSbjl0Z3ZwVEJLVDN1aDRCM2lZQmxwaG5qRmJm?=
 =?utf-8?B?UzlubnBseVlsUVMrNlg5YVNkVGdic3RYWnp0ODdzRHBkdG1FU0wzS1AxUmhx?=
 =?utf-8?B?cDRVKzlxSTdhWHp6a1JYZEtUTmJVRFh1OGwwc096NUplNmo0K3hKWmFOVkRS?=
 =?utf-8?Q?uwDMqqDErTDrbAM8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e625d6d0-bd3d-4746-fcd7-08de88e443fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:58:31.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8AQ74RjvANtz8GzQqDunflO/ObjAdj3e9c0bi6+NZo1t2TXCzhDS9H+lc+tQie0Q4klJFuCguT/rXz/XQn5aEMOzuhJ99623kH1QlMni2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7227-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,4.196.180.0:email]
X-Rspamd-Queue-Id: 871942F3B9B
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


