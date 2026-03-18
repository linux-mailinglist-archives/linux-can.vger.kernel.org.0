Return-Path: <linux-can+bounces-7129-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM4aOSRyumnRWQIAu9opvQ
	(envelope-from <linux-can+bounces-7129-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:36:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63602B92AB
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89B3E30D9491
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1A3AB284;
	Wed, 18 Mar 2026 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TQosxXmk"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D83A9D82;
	Wed, 18 Mar 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825749; cv=fail; b=s0ja5lqmwv46PgTfR7+HIJNFC1/Tc4uIzqGOvB4CWGmKG5X+2+Hq/yOv8PKHB1OyoUUw0OlHGB4n6mH2GRdEmPMzOZeLxvVi5U926JBAtXrdv9/KC4hyt/C/j4UFoNSNWIKEdleiklahcso3AaWGvK8Dpvkr2mObvqrKYIy3pS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825749; c=relaxed/simple;
	bh=Yizd+lERofkd/Ov+Ej8ZYikk3MyUC1NkK0Bb+zBzSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hOwmqhLrUGUeuQupTC/shL4zkt21/4FM2B35YZj5qq94bvOtBh79gv3QcNGMZ+dH7n/YlHtZrvVFlVDKvYb2xfkowgoRRect7p+3INrPTzEQmRG+/Mp/CFB/bawtMY75hOnW6nFDUhFg6s3pFILeh8S944eJMg++/b45JDhI1sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TQosxXmk; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9wTECyOikJrdXBc9VMfDtUXHD0A+nDHFQMInGWPUKAbMstbf2jQ2TfYGRVwtDpHwzOKM3du7KU6HyTD1vQYvoejW531ns2JFtxQOp+YRMpPxJpURktrqGf8oSU2QACmGXfvK1J+aS7+vwmvDWFolfGb2cNumsBnVs52+AujWlD4+ITWskBx50niWlx6aAucUiSU+vDrf1f5aobFl1HpLffHA3fucdwez+WYxlcab0bfPajfq6Vo1oyiKOyFJQmT/F4G2OQyqAxhQUbGqytzQmoRl2+/jeVEglZNnDXUh//ionq5m655HDpFnPGh3wE3joSkV3Wj0Mwij4A9r8f3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GVYV9KyzN1SAqdsEvucOlVGq0Q4fRFunqEFo/ZRMu0=;
 b=VaOdWdEcNxatD/a64RE8c24ELak+rvZJi+3/HBerzfUo3O5mNkwxmBt47nKGH/aQwV0AC43SOe6QWGayHvaP4xq5wVYUr3l8V00KvzFt+218SfAs4YpVQsfawzpABvOZYgoRoBFrlsOyIV2EFYWplUMk/AXXpyhj7Ai3yAD/sJd9YnVFOd79hzLi6M4rMifvkm8Q8Uh7S/0+ELK37oVE1ttRcgIj0KyC55kyT7bm/vTUdZggJ01gOREaglOsaLviPZaF11J9PxkUimmE98wqPUOJQ004Pn7/Ru/UxC4Ypkft9zLCyLJz1N2GVt1liMMSAStStXDs0c+Eev1UlsCA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GVYV9KyzN1SAqdsEvucOlVGq0Q4fRFunqEFo/ZRMu0=;
 b=TQosxXmkf52IERd5lLfzJsL/65Gpg7pvTITNP6MchMwdcpsvjnaK9w442t6AMKafLQnfO951GYGO3dJ1LlwYvCS0JlrlGo4l0nJN1QTTy0Jbz0wbWH3Ko4dVgG1jzm8eNXsOZz1+COtmP52HSrX7KD18C8fRoaRyXQ9LvUvdY2Moprya9pLz32iDjT1OGln3hJIRXBT2/FRQTadL80R3tWxv7Qz76kRObr1B+ofsL9ODPFut4kdD5BUohuHkwznw0UDvJDlzMEs+YqSZ8mJFmXc+0Seegt2RSalyUYlJZPoDcX6aCWxDrZi3+t4F07YZ6bjXT7SQUKHMHR1th6a2hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 09:22:21 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:22:21 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH 2/5] can: flexcan: add FLEXCAN_QUIRK_NR_IRQ_2 quirk for two interrupt lines
Date: Wed, 18 Mar 2026 10:22:12 +0100
Message-ID: <20260318092215.23505-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 624d4c7d-56c6-4813-3cd6-08de84cfdb9e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	79bnKXUQsBkQYcbIqO3QLMR8yk6XTj1pMyUlCdGNRf5x+jT+kM0brl7BdHB0wb1UjyGkyNMMP2UltS24TIyJhtssAfuIXoM7ioMyg3JX+XKZr4N+ZSs1WWWn7MJTh5c49Zh9QI7qtcoOpohi0pcgfhH8pXtgF+rrhsLqe10Qty62miGcAHd7bO6hKemOz5W8ipyyBDpOWnM/YG42SXgN0uO4DxxBS+v8Jl3mP/j81fG40uxtOkaVSP8+u1tra3CoHGOIfL6iRFNWxs+MvJh363T7ok4uz9u6/eZzSDfZ9dmiAjk7BUwcdJAXMYsVM6Ycfbyflmp4RSCxsLImLXnrtJruwmCL3mk2XJAevApbSO3jB5b5yjmZMc6SpMFgSpCN8L/qC1f8mSNdLPcZPHR3CTZaGYtjXUX5jFWxly31PAuAqs48/Z/W1AMIcDgO2HyrmQVRJw+/Rkx1mosSkegf1EEJRqFlLI7KWeCoTS0ei8SmwpeZBRaJi+251WbVg9azz/xuQYI/r7gN8ir3oKnsmQGBVNTOY0nXREn8CcFZdCGs8DmRRWQBRDfCKsFbB/g4SJHTdmWxnwUZqaRHifTQi55xiuvI6RgtWMwsbYYlOzYJB3oh6ZKsVBBg4oRzBEkeiJPyCMw5R7qhUP0zS5L5VyXz0miico6OzD47LG87PAsb4A2j1dYTonoKrDPspuG4z3Z22GxcTu8Oef1wwbPFkLSlU9V58J+b9K/kG2wMj3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpGbUVWcUNUREJwbHcrMW9qK2FRNDFBQmQwK2FJU0F4MXRJeHhQMU00RzlO?=
 =?utf-8?B?Sys1OUpaWUJyQldxZ1FDYmZraDNoMWNJTThWY0E3SHA3VFlzdU9WallyS1h6?=
 =?utf-8?B?MlpZWUpqOThldWdsdW5ZZnJwRWNrZVJpNHo1eTVVQytUelVXMkJIZndDY3Yr?=
 =?utf-8?B?YmhtR2tOUGVVTXBjWldYaHpaRE5BMjc3YnZzREtMOVZubjFaOWFjT0ZidVhD?=
 =?utf-8?B?dnU5RC8vM1ltQUJRNVVhY1NkNUFxU045OXhaVDM1TFhUckpsQWIvYWhoMjU2?=
 =?utf-8?B?SDdGVmtkUzJueDFWQXBZS1I0dERtcEwxRDZocE9VbHB2anRGWGVoTHdnVmhs?=
 =?utf-8?B?V0taTnFGVWdYUWw1KzVWYkNKangrU2RCR3BNT0ZPUXZTUlpUVXVsNXRrd05s?=
 =?utf-8?B?Nndja3ZmMFg0QzhFU1o0WGx6Zzc5bU54MXdHc0RGRklRQ2QwKytrazNoai9o?=
 =?utf-8?B?TzV2dWZIb1NDNXFUQ1FpZmlDV2NBQko5UFpIa3JBSW1GUC9ucnhWYys0RDdl?=
 =?utf-8?B?U2hlYXRlb2Z4aXRzWUJnY2FTeGoydXc0bjBLd3dYZ2E4ejJCQ0h0QWU3Uk0z?=
 =?utf-8?B?dHVCWHgvVmRpZEI4akMrVjNQaDZWYjBsZFdpOXZndE10S1lGQ0loV0NOa2E5?=
 =?utf-8?B?STBjYVlMcU8zWlo4dzJ0Rjh0TU1rYU91ZERJMkxvcUwrcndyM2gyM3RuejhL?=
 =?utf-8?B?eWRJVURBay85ME90UzhaQ2xsN09pdHZqN3RnU1E4OW1Tdy9HWDAvRDU3cTJo?=
 =?utf-8?B?L0JlUlVPVUNZanJlZEl3QnhLRnNVUFRWU1didUIySHpWdXJ5cUYrNisveFA1?=
 =?utf-8?B?S2hTVVVGdUpuREFFdHBPdU53eCtRMG1ueUp4NDNEZXoxdFZ6a0lrWE1VSXV3?=
 =?utf-8?B?ZzBwcUk1blpkRXlxVWtlVlF2c3NGM3J0My9ZdW1FckxjMUp1RTUzTS9RaWZW?=
 =?utf-8?B?bDhKUnRPcExyRlU2bFBRRjFSTENqK0VmNDhKVWhLUkpzU1ZhQUIxKzRYZWpv?=
 =?utf-8?B?TEk5OFVjU091MTZRT2J5QXR6ZThCOUVKeXV6bnZ2RnlTcXJhNmhDSXU3K0Vr?=
 =?utf-8?B?N3VlU1duSWlHdGt0M2YrNjM1ZnV5MjFTaXZYTWd2UG1iUld4VXdDYmp3VUNm?=
 =?utf-8?B?Q2I3ckdNOTc0RC9oamtYRzd6U0prRE1XbTBQdWJuaC9KaFFYRnN3ZVh6eVlq?=
 =?utf-8?B?Ly95MHFYUXJsSWxrdzJ3VWE2eHZKbUx4akp3M0c0NzJ4cS9CU2p5T01HYjJZ?=
 =?utf-8?B?aU8rc09wRG1uSHROWFpKVEV5UjJCRDFPcDhWVjVXenpzd0hjazlyZkNRSHFz?=
 =?utf-8?B?aVNOUFlSa2RueG1RVWQvZURYTVNDQzE3bDN0aXZSVmh1N1BMdGwwcmtXbkVB?=
 =?utf-8?B?MlA4b1F2SnkxQndXSjZUdnJTWDV6RWxQNFgzc1ByZS9SRTAzQVcraVE5S05Y?=
 =?utf-8?B?SWlFL2J1Smd0N1Vxei9hcTArZWpYRlJGL3JIY0gxdHZSNWZrbW9WMGl3Nng1?=
 =?utf-8?B?R3czM2tmT3R3bFZHVE84cXprZVZtVkFmQ3NMOWo5TFJ3SnRrNWY4WG9jQUs4?=
 =?utf-8?B?a2ZsaHMxbkFKUlEwSlJQWDcvck1UZFhxdDBuVk8vb2pFY2R3T0FQVXA2NEsz?=
 =?utf-8?B?NkowTS9aVXg0a2s5bTNvUWZGdStud2NTa3Z6RW1xSnNaemVucmtWSnhCWEQ3?=
 =?utf-8?B?RThIdm16MWhJT0daZ1Z6MU51OXF1M1NTTmJnL3VRem1rSFhGcnEvRjJUemxS?=
 =?utf-8?B?TEhvMzJRaWk1OGdFVWRQRzJTTng0dW11RElLNDB0RnN6di9sWjIzc2k4Yy9S?=
 =?utf-8?B?eVNwZjF2QjVzNUs0Z0VNM0g5ajZPSnRzTlNZc0JqRnVkbCtjb1hrNXhqOWI5?=
 =?utf-8?B?Zy94VG9PSUNSMGZjenFRU0pzaExwWUo4bk1CSU91WGk5ODYxK2Q0MjZucmho?=
 =?utf-8?B?KzBPTVZWY3hLUjF6VEVkTjIzRWJoVFhZQlFNdkFFU0pkM3NXNCtOZWFyNmw1?=
 =?utf-8?B?bEp3d29jZlNSZTF4MGlGWHdKR0ord2dTb3FtZWl1VVZlZVE0TW80U2FrOURj?=
 =?utf-8?B?ZFJENTZuY2MvSkVPbDF1bk9Yc1dHYUZ3K3hyTjJYeUV2ZXFMM0Q4Z2x4aXc5?=
 =?utf-8?B?WFA4R3hlTHhVTmsxbWdHRmNJKy9TL1F1ZnAyVXBXaGRSZy94WnhnM2Vyem5Q?=
 =?utf-8?B?aExEVjVIRnlWOXN3cHVQQTBySlhkbkpQeUkyYzhLdWVxNkF6MG0zT1BxVGlO?=
 =?utf-8?B?UGpZNzdtbnFlTjNGZkJWYk9UaVIzL0drQUpFa0xzckk3NFREeFZOL0o2WExP?=
 =?utf-8?B?MjA0cnpCYjFoa3dEamFUU3RuYkhNYVdyM1ZWbkl2UVRNS0ViU0NzV1RVT1FD?=
 =?utf-8?Q?jQomHMRWzzhbcFlo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624d4c7d-56c6-4813-3cd6-08de84cfdb9e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:22:21.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mv4hF7rJPH/NR7KhKnLw07lfxO5eKVaY8i5og30Ur5fbdRHCe8ZYSRPM7dHHGBaXfiBrvN/tTc94reaEbFoCJemjolRwqMPpf9cNk2oyHb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7129-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E63602B92AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_NR_IRQ_2 quirk to handle hardware integration
where the FlexCAN module has two separate interrupt lines:
- one for signaling error and bus state changes
- one for mailboxes 0-127

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 21 ++++++++++++++++++---
 drivers/net/can/flexcan/flexcan.h      | 16 +++++++++-------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..a6b15496853c 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1770,7 +1770,10 @@ static int flexcan_open(struct net_device *dev)
 				  flexcan_irq, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
+	}
 
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3)) {
 		err = request_irq(priv->irq_err,
 				  flexcan_irq, IRQF_SHARED, dev->name, dev);
 		if (err)
@@ -1791,7 +1794,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1823,10 +1827,12 @@ static int flexcan_close(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		free_irq(priv->irq_secondary_mb, dev);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		free_irq(priv->irq_boff, dev);
-	}
 
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
@@ -2213,12 +2219,21 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_2) {
+		priv->irq_err = platform_get_irq(pdev, 1);
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
 		if (priv->irq_boff < 0) {
 			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
+
 		priv->irq_err = platform_get_irq(pdev, 2);
 		if (priv->irq_err < 0) {
 			err = priv->irq_err;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..f05036ca54f5 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -58,22 +58,24 @@
 #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
 /* Setup stop mode with SCU firmware to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
+/* Setup 2 separate interrupts, main and err */
+#define FLEXCAN_QUIRK_NR_IRQ_2 BIT(12)
 /* Setup 3 separate interrupts, main, boff and err */
-#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
+#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(13)
 /* Setup 16 mailboxes */
-#define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
+#define FLEXCAN_QUIRK_NR_MB_16 BIT(14)
 /* Device supports RX via mailboxes */
-#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX BIT(14)
+#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX BIT(15)
 /* Device supports RTR reception via mailboxes */
-#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
+#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(16)
 /* Device supports RX via FIFO */
-#define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
+#define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(17)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
-#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(18)
 /* Device has two separate interrupt lines for two mailbox ranges, which
  * both need to have an interrupt handler registered.
  */
-#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(19)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.43.0


