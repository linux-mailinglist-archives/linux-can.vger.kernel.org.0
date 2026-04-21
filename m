Return-Path: <linux-can+bounces-7388-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id piYtCHVR52mn6gEAu9opvQ
	(envelope-from <linux-can+bounces-7388-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:29:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9611439875
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DC2D3069BEE
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF03BD240;
	Tue, 21 Apr 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oyBeOk8w"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636A3BBA0A;
	Tue, 21 Apr 2026 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767185; cv=fail; b=pfKzvku3jU6aitGtH+lppjX3D1ydtDWo2WxdaggudN5Qttmfjoq1WBMdey8zMthT/BDlxCEn37QQ75suPmK/AfQzJwuVgIHN3OUFcAIND/a2bmoQMTMqg9y4LxbkI16k7JuuFFvF5ZWaWvTJkt0pcJqtoEWv63ZWn5jPU/t7miM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767185; c=relaxed/simple;
	bh=AmkQXFLaAgioZXQr+kr0ifiAPUfa04f++MCQqAML8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEvApSf/K+vJwwPCPaZvNkM6JSSmZ//XniqMHpyoL6/w8MYqW8fyhsG+saTLEhfKDdlJCOFoITX2L+7u6YdHFD+MEa/3KrFaasaFJBAy+Nc/yDpH0sS1hFF0kBOsg+apBseIE/n/eJldDL8+OLaBIq3xnUqfbhy6BgIxkGNpXwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oyBeOk8w; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gol8eL0RWHx6Hoa/+goU9ZfeBJwaBYtxCkhj1miDPL3pZ2sjsiLRyeG3jU1IuNtVaIooOU3+8FK81A4DaD8M809DcinRAxuVWKz8cxlZshSU64Un4qH/Op81aNt9bpklPi5z9SyiRENWPVhF8lbcoMv14kQ6t6P1AZTGZyyqnmvzZvyQgIae/2+ErUHV5DWOICqf4gc5hach+JEBb1mZeU6dqM5GatWTY9LsLU837klaNgouzklwOiIp/taJsbGaiUrAfc2xXYKHVq8DPGrmljNYQqYlgd58fC99hHautDhLW8E8KsYJsp+aEnM/IReCtsnDvf8T0t/JgVSI0UGXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=jVQjkmdmpj4Mesipy/1YdyuwN1E9knOSHsBHOZXhkU286R31J2FLPsozlAZnXrdiMUtLz7oi3pvqJ3YsLpC4vqYxESIGlJy8F3rSTqlpULZIaeq6+LB6jojkk+K18laPQygJmjMiq2bwtC9U91v0C8LNtuwsFJJFfHK0cibnFwB0QWFj6szMPowuKWq0xbbdv9BRqRc9MzfBpJZ36aCcs/FBFRwkdllAxPBils7hcfsNXKTMGMpQrE+H6fZiA7npeGGiHDefB73AncdstbLVVV+Z8waFQIwYyCgReFJoJiBOHuldEMc+x4ktqe6Lnv6nZbzdBuWvUzEV0xfZqyF7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=oyBeOk8wm4eanUwGTrZ3eiGdbsHsv5rndrzbOh9yFhh8IQfD86wn+LfKDKbCWWpIqFDtFul9Grx3Z+G8wh6Y+CSo3NK11J+vDc+QK4orZAY0pqaDdN2Ab4UHCtgkp5y9lfvAK+ZG/15z0kH14MfJe6zXHnJD0KYLWEKuNiwvmhWKSiVqYKy4yAPNyLiwY/k7+XGfUnAQXnTom7YiQshWyw6SCZUBTa+9voTz8Xe7mnNKAMRyE6OwoWahWXOPkKktj5dG3OK37tZTsNENnMh5h/TS4Ebdsv7c+KUXl1kWymspqhOZsIOrvmAwB4kgedPL0Z86vn2aPcuimizo4pEMSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:15 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:15 +0000
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
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH RESEND v4 7/8] arm64: dts: s32n79: add FlexCAN nodes
Date: Tue, 21 Apr 2026 12:26:02 +0200
Message-ID: <20260421102603.4122332-8-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::7) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f50f3a44-98a6-4467-36dd-08de9f906b35
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 +xYzS8F5GwG9+grChaaqi1hdVgsPNz+LOC8g6FIM2EDNuG77hQMvvR+QI1aUUwTkwj5LdjJIuE+/ZKjZalmi8esA93nGWnRcnHj1bQfXiBLYw2F9BTpESYCs1uDqXmdQb+hhU/zU5FOvcSP2SlOHq60kREfkWm1Mcjh4N5PXrpgPid3x7Z5+tKVntxBhGoH9PJLLTIBoSJfG2nXcudGpRYGD+lyDaIDl76gscLSLouBueaIAAErIq2Kgtl1k0K5sgDeUk05ObEDVwTagy+lvU/mj6Yky+/HoGudUEicaaPzSJPFiVCrtsBpoN5njeaDcftFGx7IJOWbIP8qEKvKR4BCcAywy/o5gr55/50uFXiN9wJWgXRaae1gw9Sb4Ho6hW7CHIL/qSBU7xiYXmzDLbHTztYTVGSYt4MYm7isWIVmoS3Ms6/Y9VtDzRSx20RthYiBKaN3IfG0PUnsrJlkvyACpCQXsGq8nWfZzKG6SDBFNcTymKtclfY2cqAKFnrXygtbG130W2uKnEtSYvB1FgfHT6z9ti070dDwk6AyJhkGfFkAsSC2DyuauCbgPSq2vOiy4lp1uNAmI6E7onJ/PHX/dgAE9T69B7yg0pTqBSsnwCW3o7l1n6Wl4Ej+m2Sd9YSRdXZwwFdIN7ZmEvRttuD/Prs8RfpTOV8qU/or6/5BcJ4jKxkZh4GKCF8cLp6huHSFLYlNYyANyu2cji+wl7Ior81o9lVyBK7p0Q3pimL4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TGNtTnlRYnRQcXB6cXFJSkM0M3owSjVBeHU1WWpXeElLZ3NSeXI5VnJ4Snow?=
 =?utf-8?B?Ni9VTUE2Wk4zSWxIYW9Iei93SkovQVVxSlNvTnZaczlFMzFmRGZjM09zeWZw?=
 =?utf-8?B?VG1YNlBtUFhSZHFIUWVOZExsNkxVVWFCUTFQY2hiUG1iT01GMTdiWVYxR1lG?=
 =?utf-8?B?OHJqMndJcE9RZkxtMndFME5FREpvVHBoUzlTQnhiNVc5SmU3L09nem45Y3Jo?=
 =?utf-8?B?YWh5dGEyTFg3MXZ2ejU0emZuRkQ4Y205NkNzRUZZM2t1dk9jTDhHV3JHbkVE?=
 =?utf-8?B?NzV4T011VWx2K1Jod3lWeFplb2pzUGpRNWJTTmNGMk9DNVFLcmQvMHZwTVhl?=
 =?utf-8?B?dk1EWkdwUzdXSHByQWZmOGowbXBLMjB6cXgzbks2OFh4bmd3WS9wSE1oTVQz?=
 =?utf-8?B?ZGpqaXFnSVVFcjViR2FGWUxCeFFxcWRmR0FuVTh0NDhRSFBZOFRaMkhrbXg0?=
 =?utf-8?B?QzR3cVIrSWFKbnR6KzJxSENQZ0dKbzZSNGhZc0NiOVEzVzB0czFMTnoyZGpy?=
 =?utf-8?B?NFcrN3QxVnVwSmhsYVJJVDNHNWFpOXhpTnA0K2JuQWRWeUlZUnMwSmVmd2Iw?=
 =?utf-8?B?T2krcGdzR2dVV1N2Z3VtaUFhNGg4dFh3bWRsajh3M2RLTWxtSmM2ZmFEZHB1?=
 =?utf-8?B?YVFRaStEWGR5Ky9WZ1Z0L3ZGVEJ1QU9IZGxydURTUXJxRDBkNGZMQmxFMk9H?=
 =?utf-8?B?aEJ0Uno0eWgwcDNzNjQzSWZlL0ZZSk5VQ0dqeXBJczVkWFF2Nngrb1ZwcGxn?=
 =?utf-8?B?YUZaeHlvSSt2Y2dhMUNKT2pBTWFOdE9VL1VzdWNIUjZyWXJDZW1URFFkemVY?=
 =?utf-8?B?U1l3NkdIM3A3cVFxbnZ5b3B4Z3E3V1pjRkJnWVBNYjdiS01pcFIxaHlaWnky?=
 =?utf-8?B?eG9BL0RwUlFzdTZwTC83QW12YlhPd281VEZYSXZFQkNWV1hTQXo2MXRMdy84?=
 =?utf-8?B?VXo1dHRwQVhSa2JxQXZpaHIrMjR6L1VxdFFiWWZab0ZRTHFPRTdnWHdkTlA3?=
 =?utf-8?B?VzFxSzhKWjJyUTZsNjN2QUl4OWIyVEhPZ0FmRU1VUmR5WTF4Y0JwVDRiL1dk?=
 =?utf-8?B?VHRNZjd6TGpEMHBXYjJsWldUYmtLalJpUUNqSzJ6ckFHNzNKUEQ4ckZmUk9t?=
 =?utf-8?B?cFVlOU5aL0VzZDRUcTgrNURoUXkxKzExS1NlK0c5enB1c1VJaXExbmRlY2kx?=
 =?utf-8?B?emtPMzMyUjJIOFRaRisyRWJlY0k1RUx0dnR6MnYzalk3MnlQZHZjWGJLTWxU?=
 =?utf-8?B?YmdvYldWUzdvN0crR1JpdjJ2Vm1VeVh3MTF1Y1EyR1E2QlI5V1VVQ1BSVTVw?=
 =?utf-8?B?ZEg4c1FrV1hFWkYwMjZUTmIxVzRXelc4dFpIazZKUkpITXV0OGlhT0pDeVRM?=
 =?utf-8?B?MW13c2FpTVVXV0ZjbkNEU2s1S3NhVEFVMGVHOUl2dWtqQTZaVDdEdmc0Qncz?=
 =?utf-8?B?RzFXY2J2WXFPd050M2JsbXdnUjQwZnAzRDFJNHlwU2tHVmI3YWhXUk1MdStu?=
 =?utf-8?B?d2g5Y3ZCVHRwMTZlMlg3RU8wYSs0TVBFcEZlaFB2YlZGay9uZnJTbTQvM0NM?=
 =?utf-8?B?N0dIZklrL1oyU1ZXdUIxRkhaU1JmWVZvZDRRdVFVak1Xa2JxVDZiSUFQeEV3?=
 =?utf-8?B?QlJLYUhRdEpCaytPb3YwQWQ2djc3RGc3SUZmY2lXNmRMME9rcGI4UytLLzFs?=
 =?utf-8?B?TzRJaTNvS2s5Z3FWbkViUGpkNWpKYStXenlkdEc3TGg5YS9HdEZ2WnlDdWNm?=
 =?utf-8?B?aDhsTzFMWVoxSUwvVitydlEyK2ZPbTdONTVkT1A0ajcvMU1VYktDVkVUbXdt?=
 =?utf-8?B?K0FpVk4zSlE2SzRSdVJ0Wkc3YUZVSWdlQmF2U1MyRXRNbTRuWTNLZTRYb3Fv?=
 =?utf-8?B?WlNDMmNTMTVKRnV2WFJGWVUxQ25DV2pYcHRyRXRzREcydDRXalFsVXRWYjRD?=
 =?utf-8?B?Qk9SSkxxY3NzdER0Vmt3Z1NYWmhrcGZsbm5BaWpxbXV4bkYybmliVzJONHF2?=
 =?utf-8?B?a0NCK3JDanBGVU1FRUZvTGJBcWcwdmxNNk50UjBza1c1Nm50OUNOa2VRSnRY?=
 =?utf-8?B?QjBIdnE3TGcrNGlxNDIydWowdGxqTVQydVljYVNKTVo2MnhlV0UxYi90aC9B?=
 =?utf-8?B?TnZKaExGOWhKam5qcjFyZzF3VmtaSFYyZml2RHhVRmp0RWRaNERRcEFWSHJ6?=
 =?utf-8?B?SVZDdmhuNGtXNks0N1lPNFBNbEczd2xuT2IxLzFLUlhsT0NLNG1HNkJzdE5l?=
 =?utf-8?B?OURnYXlubFRXeUNpczU3UnZTZ01YS05VcWM1VWF1MElpUkZUUE1IcnRwMlIx?=
 =?utf-8?B?OFRXSW5MWkxjdStKMHU3NVdJMFRQdkJha09pV1lPZkYxQWZ2Z080MFVteU9T?=
 =?utf-8?Q?t9nIhNIVWEIdseiM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50f3a44-98a6-4467-36dd-08de9f906b35
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:15.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYP3szBM3B/QDdyquufFjGNPaerGlXIaWYDbA+tq9bwczG6ZEESXbRHS4I0Hj29WLG6Murxq6qVRUS6tra/3NA71GUJ1H7Ny3fTMRxzoWOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
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
	TAGGED_FROM(0.00)[bounces-7388-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,3.72.198.72:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,55b70000:email,nxp.com:email]
X-Rspamd-Queue-Id: B9611439875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The S32N79 integrates multiple FlexCAN instances connected through the RCU
irqsteer interrupt controller.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..c1a4fdead91d 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -352,6 +352,56 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rcu-bus {
+		compatible = "simple-bus";
+		ranges = <0x54000000 0x0 0x54000000 0x4000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		irqsteer_rcu: interrupt-controller@55101000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x55101000 0x1000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0xf9>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+
+		can0: can@55b60000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b60000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <0>, <64>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@55b70000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b70000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <1>, <65>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0


