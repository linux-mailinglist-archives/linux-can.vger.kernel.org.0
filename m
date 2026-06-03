Return-Path: <linux-can+bounces-7741-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nlxuGv3UH2qOqgAAu9opvQ
	(envelope-from <linux-can+bounces-7741-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:17:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D582A635193
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:17:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xON5SIeC;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7741-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7741-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09740305E8B4
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5F3FADFD;
	Wed,  3 Jun 2026 07:14:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943863FADE0;
	Wed,  3 Jun 2026 07:13:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470840; cv=fail; b=TuAZeEKbomW46D7ik+3YTXMCa/uG233DUjctbdbuSKgrWIytA/B5pg0w/F9cT8DaHUONNyIBozAQq4V+YW2RElDK+61oPHYefjFtg1LqHhYXUE2EcqTpxu5HIdKl29mHnBskyrLgzjdSJRmfdLXwQ91VPI5Bn1dDr1knf85/3Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470840; c=relaxed/simple;
	bh=D1Xd1s7YrEqbtvlFTkhmj8SJVSWChuDXoZfzKtuxKH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AmaSiql9CZeFZZbG5+wWyBgEf7PzyLb0zw38c/tvnH0tplPi8XlwJi7znqmdDJLep+TH6bZXIC5+l5D+lmuKnEelQDoS11gpQpQ4YzX98x8wd0l8qspKrE4Lnp9cyxceZ5NJIXk1F9Om2bzdNmK5tXvVTz+RVI0er9Jh1k8zPNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xON5SIeC; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDiy2OAcOPKU6j8rOvrorp1y12z2ZN8pzImifN37J5h/8ckcLT1DaxI4rOSyjv48BRsQ3w3VRkdQS88/7d1eKJixWjau3oKXEEiufwOHchSc42EYgfrgUNo2dGK53+Q73jJ67TiAoJ+gL8NrnqyGayJ9kO6hY179Y2XaHPJu/A64vu+3I4TxSMxjWNhvsnc/fyUGdNLL7nXkF1LMiFphxaw0kEO8aBcig2ZLfg82O2mqJznTcS3/WZX2VXvqLb09melvDRKXXSanoMGDUetSh6ysUoONAwstL0X3YrVMywaFB0DbBkjdnssck4JuT5oQUIop2ibKW4PU3axk/DaQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O/zHz6VHNH2clBthNEnurAD46ZT8OtXUs1Vwyt3dZ8=;
 b=d3X/xFt7oao57WrEdsdUR6Df3MhOURo/blPox3WolLZndw8fQV2AXdrYWN5YOkW4pvztXK+tw6bphA0HCzHth3hypV4b+RVH2cjMTAWK7YEoJxH4C8qheGUVv2zI37Lgen2j1nd/57O0Om8W4Jn5ki9Zt1s3znWBlh1TLD2uioFYXnscu+2F94KZtXHxJ22IDMgSmhMFMs89fJ7sLc/R0cG7kg2Ko6lkEesidn8ZHU98RAHrM2nR78N52hQDA8b8TaiF4zWXymXN7S+bVDNkyBX+O7YECQ9PxZughJ3EYPyiIzgg6cmKroi2579C4l+V3Wj4k3aE/bEmxfp0I6SnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O/zHz6VHNH2clBthNEnurAD46ZT8OtXUs1Vwyt3dZ8=;
 b=xON5SIeC11dng7ZtKLdyumnPGoqkuy+1jOp7iM7Ch/0nsrzHeWSixZe3JgM89A16Se9Fn2PGMRLVi1YgfzZqup+sWIIzO+fN+qAeSs6DQtBEXw5L6HSQq0xfvq2Buk+zaCZFLzGdzB5O+KN+OUA+LN48W1X/K0M/z4vNAv84YwFH7g9hmQxVYRRWTqRYpM8n1kb/jaweh6wHS0D1KDHRn/Yh0Vh/K5Bonp/RetjwB7b6xV+b8o5b9XsIQYyHOPsts0fXf55dERDk5Dsswfy+XqweE94hZk1TrFh37/C0u13qCxDeVckFml1CZ7xPEzNmOrLwLlqv1lDbyoYgegaNVg==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:13:54 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:13:54 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v4 4/8] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Wed,  3 Jun 2026 09:13:38 +0200
Message-ID: <20260603071342.641874-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: e1504c47-47d0-4def-aee2-08dec13faba2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 diLWSW4wVMpLT0BQJ4oIrF7diZ6hGlhuDtUSYxGT9UVj6fTqC273T380OOHw5veNRTW6Yg9lNI9PJpKR+ocHF/HnYPvmnwiRfJn1PEeRtIxL6CKpnEDi8azM2UtJG/Q2szPsqyBV1gtM4Lo9YNDYK22NDgZXd/Ns0KSRxwD35Yw+NSfYCY3aFpjW6HW++iM1fqo0ZtCZLXqDKZWl2WPJoH/qFZIzkal72Nmw73p0iRg/ZPW/0/LassEOuP1p6UdgpF2rl4rC36vasyMy+j13u8jatXgdTMM+wj3jB3o/VZ4APk/9LZnG6YwCmrE/31ZggED6R89ccVDqn9q/OZrtky09I/wK16c1460EKC0kYBkn59PU7wzCRjrvAWeqWaiEn1pA9VHzha32AeQJ6LWhbx4/w4nV4iQj9BrFTzRMMslkHSzGO054TAWdtbheh+BaRMRQvaJVSaeyDhZt5ySK9bNfSxr8zn2zMwvyATtRTMbBHN3idM/FbWJkqOZ49+N1F1ri9nD6WJEvz0J+xO9zbJxk3j/FOtqBTCLO6nk04TszFVfMTWGvy/935saJE5FMgZR4xN2uA12nN4Ku+7b8WhWG5OKUvryKvDz7MSjyomp1dUHl/IZNcpIgHjOwBg+VJri/nDkefSVMWiFhuez/MUVkPAwVQZCAQYLS02TsRi1YbJBEVd+QInc7uHcduSbQ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VWc1TkptSGoyem9jOFh2T1lHdzgvdU9EWkFmTW50L3lNUjh4R0FmeVR5d1V4?=
 =?utf-8?B?S0xUUUhXU3VHS3dyUU1WdEpQQitUNHlMb3ZGOUxoVnRaVDAyUi95VHM3dXRs?=
 =?utf-8?B?Zy9LM3p0TDhZeUo5WncrSlhlYjIvVnZEMmZ3NDFZSm5qN1ZmSzlpMHBxRFlU?=
 =?utf-8?B?TFRIY2RBaFpZcWU1dHlLZlJtTEczcm9PK0puKzJCSmhlMldwSzBqemFUYVh3?=
 =?utf-8?B?MlJ0TFR1M3JJaTFvTlRNczhTb3dxMTJlZDdWRis4cTd0ZExwbmFXdFJqS2Q4?=
 =?utf-8?B?Um1acngxT3NTa3FNeENlbUVkYWhCOWk3YlB5L01GZGVLbmpwemNwazBndUpy?=
 =?utf-8?B?eHhCdkt3K3graWdNcUpVdmJNYTlJWHVBOTlHZlpHbE1RSzQveUJQNjhPUGpo?=
 =?utf-8?B?MDhyZDN4NU1wb0ZqaG9UbmVRckptK2FSS0RVZG5wdlc3K1ZIN1VCQWUxeVAy?=
 =?utf-8?B?RWdHSXJxWG5vWVhoU3AzK0ljU0NkMWlvdEp5UzBNS2N0ellpSThtdVNtRE84?=
 =?utf-8?B?eTRBaTlOb0Fkc2NmMXViY0x4TkJPeDRKbGJpbjRldkgxN2RRdDV3MnR1MU9G?=
 =?utf-8?B?d1NFcE84UldJaGxSSzJ6NVVLQlA2WjR5TVdLWDNUR3NuZTZqQ29rekxyditu?=
 =?utf-8?B?ODZ3ZzdUNmNaWXlnSWZkSzFTQUFDNDlNZFk3UEZvVlFDVitXZWZpMXU0VENt?=
 =?utf-8?B?NURmQURRdEt1K2NDeXJjY0o3K01QSHhLVTVyUXk2Q0w0QVUxdk1JM0JYMDRB?=
 =?utf-8?B?S3FqeHVFakJjaVpFdFFFenVITk0yMmwyeDFTbGp2TzF2bTFEWnNwdFFKM3dL?=
 =?utf-8?B?QW5oN09MS1piQ29BMjRxUzhnQ3IwUi9KdGlpTTFrc09jVkZjaWdGY3hpaXht?=
 =?utf-8?B?aFdNMzVTRzMveHB3cmhQNHp2b2tWcEo5SmNqcG8yUjF5bExCYWNDam96aDZL?=
 =?utf-8?B?YXBHd1k3WXJMQTlCK3lZUUhpUkhybHpqUmVvL3dDcXdsa2R0TEl6b2V5bXRn?=
 =?utf-8?B?T3FlMHVzeCt3RE5LemcvUjZjUWRUdDZmeGlXS2JZSm1RK3dNdlQrcjlrclEy?=
 =?utf-8?B?V3VYSW9vTkI5OXdseU90Z3pkSVFTbDJnL01kbVBKRWs2K1lWTzBqd1F2VnIv?=
 =?utf-8?B?ZXkvazJWUWc3N2Yrd1ZZSWZqSnVKNGJnRlZjVXFEQm8rRGJsT2xxUitIeUgy?=
 =?utf-8?B?ZkxTUUVvdjJBeU5zeU41Z3VIV2dNU2dland1Ym4yVDAzdERuazQ0ZTJEZWN2?=
 =?utf-8?B?RGhZZUNYV1gyQUVicEd3ckxuUHkwVllldFk2dnVOODkyQWVLcVd4NllhZjFa?=
 =?utf-8?B?a2MycTlFZ3Q0RHcxR3JCcGdCNXcrdnNjMVZaZGwvRUhXcktkeXB0SVlSTWV4?=
 =?utf-8?B?dTV6SHI2bUtiM3JaNWJpOVF0dDBWWVR6QTlWeWJjSlNmYWtMRk5TVmcrWFpN?=
 =?utf-8?B?Z0RpdEVoRGZWRUN2WUdMb1orT0xLSGI1S3lReWdqNTlTSWFWTGhtUHNSMTJm?=
 =?utf-8?B?UkN3L2pNQmlTZDhQSmJaekZvR3p4dUpFVFV5R2IzY3R6dTBsRnBkZ0oxeGpt?=
 =?utf-8?B?d3ZyaklxajJWR2VMSStEdzBKZm9kc1VaVWhmNkc3NmE0RWN0OGpPSDJhZnYr?=
 =?utf-8?B?L1JTRGZiU2NmakRuMVpRRGFEQmNOaU9zQWVKK3lXK3lGWGVwaVF6NWFkSk4w?=
 =?utf-8?B?b0EwWks3NjJLWHJta01oL3ZRemw4TzNMNmJSRHdlMWxRekRISzIyeENQZzQy?=
 =?utf-8?B?aHpId21yY1FLNHo2TVlMZXVKUmdHdllweFJKZFpxbDU3ZGkwTjJFV3d3WHZ4?=
 =?utf-8?B?UGdWQU1nT3BXdWFtaDhXU1A4Y0Y1ZmcwTWx2QWlzR2crS3JZalJYeEZCeGdY?=
 =?utf-8?B?SFA0bnV2cWJxdnN6SVJHSjVFZXRBUUFIc3BIc2JrOUhSbFp1R0FLbHZlMUVv?=
 =?utf-8?B?cEI4dysxUnJHZWc0VmI4ZjV4MjlSMG0vd1dGL2J4cXAzbnBiSis1Z09CV2Y2?=
 =?utf-8?B?NDBqVmJKVmh2bWtuM0FSZmZRaStUUGZZUFIyejQ0cVNoUG9RQjhUYWdIekZJ?=
 =?utf-8?B?QlN0UUE5U1AzQ3E1dDZEaGtlL0c4dlRFeDlnTXh2TU5OUk80czlyNU4yVlNK?=
 =?utf-8?B?bkM0ZDgvaGF0ZWZ4K0I0cnhMUTUrYXE1cjNqL3ViSFNYRFdjSG1KUDVCeEsx?=
 =?utf-8?B?REhGZW5OTVM2NHFhTi9SV1RLSDBVc2YyZXJFSWdPR3hMZ2RMSUExdmlLcGFu?=
 =?utf-8?B?VStDUVYrUGh4T0pUa1dBKzY1OUNJQWF2bkhtc0lvcDlHZytzMTVzdm82Z1pD?=
 =?utf-8?B?Q0g0WjZ6QUxBbHdRWUVNVnh6RlJqdXlNNDNzL2dnMGxLcG83YWZ2S3I2Mm1Q?=
 =?utf-8?Q?86gT+5o2SNbXfkhM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1504c47-47d0-4def-aee2-08dec13faba2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:54.5280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwWRksdLZ803CpyD4/659P2EtJBu9V5uqWZvIh+XylvFQhmVP/vXKp/C2cUolu/O+nevQJ4cMQsjAjrUBoBt3R++GIB6MktF2vh1JpCDsY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7741-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.nxp.com:from_mime,oss.nxp.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D582A635193

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add NXP S32N79 SoC compatible string and interrupt properties.

On S32N79, FlexCAN IP is integrated with two interrupt lines:
one for the mailbox interrupts (0-127) and one for signaling
bus errors and device state changes.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f81d56f7c12a..d098a44c2b9c 100644
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
+            - description: Bus Error and Device state change interrupt
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


