Return-Path: <linux-can+bounces-7385-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGt2CkJR52mL6gEAu9opvQ
	(envelope-from <linux-can+bounces-7385-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:28:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E64F439821
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F146301BACF
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69D53BADBA;
	Tue, 21 Apr 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sBsbRkb+"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BCB3BA25A;
	Tue, 21 Apr 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767183; cv=fail; b=MDw3tf9QhSu0zT6y22PvkMzewc1oVDPIXgjumEGRXNx8IhREmSP0+aStK9V+8CHcZzjbkPQgGnT+MXN/+l6i52zH6LbTFv6cb8T7n8bfIQXdagwTYzy4ZtxB12foP03F4Qt9RG2JnXJ4cPLkRy00x3vhbEA2OVq3c+Y4iKB+9pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767183; c=relaxed/simple;
	bh=D1Xd1s7YrEqbtvlFTkhmj8SJVSWChuDXoZfzKtuxKH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eagnwhLw5MunRBzowgyzCgnAOa/nNeg3bHQin+QT57rhf2HqdDfE0Sinohut70/HlxzcFEm6zCULZj+nzzmGaAgHd4K14I/pcQGnh5sY0K+uSgLnn/Lo/N1Y+GJnqY/qs3ut1iTWUxUOaPSHHbebFOxOsDMOAv3JsEcmenVuk4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sBsbRkb+; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clZHe9NYxazJ/uc7gNQgJ3xdxN28CpN3GU/9/bOHCoVo2AJAtu8yk33QNxtMn36++WAFcfGg6cvHo2O+zUwivTMsUhk6LkZcqHDy5uh5IeoWhiLspX2gpbFdqk3V8RL+e8xXFVa11aRProgY2FAKEPE8L4iyHK+otfNlo7hLJ63oeyxeogz3+HWpuJRpmf0O1l171s0bvT/B6264FrX7F8Em0N3vw3Vlx8wcXnZYsjKxTwyI8TlTppnkcystyjSlRjGofwRCwWpklIOokoOvspgeZoEONzGvtLexF2dSsxV4O1TbdHQNfQjiGRneZlvZ38lKbrYauDbULVfd9JlKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O/zHz6VHNH2clBthNEnurAD46ZT8OtXUs1Vwyt3dZ8=;
 b=FjgVZ1WJu5ANzgoU82lF8Ah0r5HH0QHxoDZeCAR/5vYQ3ckmZYkxZamXXXHF1hoEwnnJkMiGHFS4WdooIfji8jqzQyG2UCeP6Djzu95+QXYGaRCB9GB65FwQPHcQ+3ZEWpTY9Rt9gnwRiD75XVo57Ev2+xazTNLmRwP2OIV7PsfcFtayafq+5PgmKtXF50hNBGK5QGyD41rkTGVOwVXV+1sFB1m8AatEZtEPBzvYhprnK6r/TZ/DZlOcA6wsRCN5VK7dGiPceSQNkMBDlj2oi4pJeK+ooloRiR11YlazGvrlyfbBSH4BuSr9PgVoCC+OfsWOF6zD7yRDa+idGTH6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O/zHz6VHNH2clBthNEnurAD46ZT8OtXUs1Vwyt3dZ8=;
 b=sBsbRkb+MIKPvR7T2dtrOXNdYT0lmkxdstJcfA0xxCj1/7YC2DFlRbejoNfGW+ijb58QjJcNsb+thnvWuJk1lx/ZowB7SIeUUq5VMMy1EzIAuTT3OiMDXZ4enXuJ5MBiwRgJ8kKZCnPV8Uqd/57R3CmFFW6RK0K7TlCmBGM4CReJkjsFrlvBmhFaaHa+Cxi83D5HIOY0Sdbnm2ZV2+n4fjBKFzKkDQ9Krh/CwlkRBqekXhjsBV5J7Lk88fSvZy99B7cpnnK/znqgtq3fsEtWShhnDXN1DO1As3wMuK93Oev5AlgZ6ZdNAdDa/+/QBbuvbH0txnWaytL1q8ld11suTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:11 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:11 +0000
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
Date: Tue, 21 Apr 2026 12:25:59 +0200
Message-ID: <20260421102603.4122332-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 73019943-f225-4b13-6ff0-08de9f9068dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 ZBHHoxiLL3D5fHXAY9pxaJo5QxeHMWI8MpHoFkHLSAdDQbZmA0tD0S4Qhsa/BZSauGlzRQX7LOvT4UEE0w39XoMT5v1w0NG5KGmNPZvovLgov0XULy/60BrRTFKOB6Hrcb10UGrHJQa05VMT7vC4XBDh+cz88iElXT1LK8oRCntQRCXP2MHvucESq9E/g/mpQk3mkHprkAG0BDta4dgS1SJcsRAOTCby1O0gpMhP78He8JEXtFTADOU1/c4zgvdktgc2DJV7eyqIf9s+Gx+19QxhpJ2ZibzyG5XiNxTR96tRt54vGPKeWo7jVwD37qRZURkeoAXEoRHF8r7OgLqXpvWeOtdl1lx/ZtcKJ+pvGkqGEYmpm/tcOM/XKGG1G6dSIH2nHFliWWnjX+Y7zZWcYS+9UBUPoV/yY0UBmQoixVYiRYjUxSPTdppfygqPW/gJwAaeaOIh7yGc5/p2yM2w6FCYE2I/r0FLVCJiNRH06BFlZA2Ggr/mA+EEk7YE7SdjuLEE+nQafuNa+B7PejQ9SWSznHMcIpjM9mVtPme9785VNv3mrQx1/w8t7Yap2DCS3CD1CEOPsS7kC5IMcrkqiEoU9HFA41bvdRw3ndyyCUG2ek5sd2ac8sAbM62SgLRiyAQSpGaoz9CLhJ6WcQsvU/mj95HmBCZxuQY+t8EyG0hHUxwV2vIwYGInDS5sEg8TUiJobTZVRSa5ZRIJtvtHnjPp8tqOF3BQEWrHd3VeXWE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OGhidlh4a1NFYkVsZGI3dloya056WDh2UmhPY2dCeVVNUjluQkMwR09NUTJa?=
 =?utf-8?B?YXhVQnJPNmxueXRPZkJnRkMxUThFcTdXOWNGSDNrRVF6bldDOEx3VG9JMnJS?=
 =?utf-8?B?Y1BiRldaVUZWL2F1b3dEa0NPK1E4dWZvRUVsTVNQUHJGVHB5aEp3dzM1blRR?=
 =?utf-8?B?Tmx5aUJGSWFOZ0JSVzJBNUNURzJiZWxaZHZTVm9kMEp0NGNHQS9IejlHVnZs?=
 =?utf-8?B?cnFQVHVLOGdyVkVoTGdYb3FuMFZQVmNsa2FzZVB0QkpHZkI2NmFKdFdYYzgz?=
 =?utf-8?B?VkI0SlJtUjZKbjJHVFZDcE84OVdoRzRFTEdqQk10UlRuRVQ4RmNwT0JkL1NF?=
 =?utf-8?B?VTM2WGREdjdzeVJ3WWd6Nms0T0FXZEtISmlJZDVieTNhZkhMQlRRUUN0Y0tK?=
 =?utf-8?B?TzNKTzArTGtFSWFPQUlLc1NvNUFENTJLZ2hiajVqOVByNFFFY0pmYUhOVTMr?=
 =?utf-8?B?ODl3VTVWN1pXRWZHMldLZWlQUzZ6SzlMRkxKQXRGeXpORnJZd0M4QUxiUmRy?=
 =?utf-8?B?RlV0bzdzeEVQa0VXUWkwK1RMNTFlOG5RTklUL3U0ODdRTktuMHpzU1VaeTl3?=
 =?utf-8?B?MEZHUExwTlIwUzdsUmxhV0tEcVFKbHhMMGJ2alZoNk9iTVBRN3M1VFRXVjVK?=
 =?utf-8?B?VlBvd0ZlaWVPcGZmeDRBZDhaelJLZ2dHek9JMUJoS1l4NW03bTh1WGE1Slhv?=
 =?utf-8?B?Ym1CVTByemhTcE1DK2ZaVnVpMEduYlRaVWs2b2RpUlVFYkRuU0hmd094alhW?=
 =?utf-8?B?ejI5aFVzYzZiMkMwNk00YTRQcVNUVW9Gbm53RzBrTzFxQUxwd3hBYVcvdkE5?=
 =?utf-8?B?WnZCeHliYUx6NXczamluc245dGFTR2dncDA0cS8wRHY2c1lpd21VcDNyaWZj?=
 =?utf-8?B?anlPMUVibU1nYnBIL1lIaTlwNEk3eU8vZ1JHeUdvN0ZuMWo2T1k0eVVvNUg1?=
 =?utf-8?B?ZTd3ejZwYklvR0RUTzZrOXRWZ3dVL1BJK0xNZlI0dFFwc0xtUDdBOVkwRG0v?=
 =?utf-8?B?RTRyeUl4ZXVSbEhUdHIxTVZ0NHFvUEhTUDhvS2hjeXcyM2VydEtZNmdFK1Zk?=
 =?utf-8?B?aGpLc1NIdGV0eEJTcThtMXY1M1VBZTZBRVlBb2VKbnluTDIwZzZ4bXhzMngr?=
 =?utf-8?B?UllEc3F3UE9VVTdNcnR2S04rRGpUMnY1cytLZkNIR2NDcFF3ZEdOeUZvMjVk?=
 =?utf-8?B?UE5kVEk1eXBnM0ZWZ3NwSEZqRXlWd1ZaRFdmRjJqZ3NHY1lpMUREM3pyUzJR?=
 =?utf-8?B?UHozR2ExUnhWemhmTU9hMVZKZXVZajUrQ3I1TVE0NGdJM2F4Y3dacVdic0lq?=
 =?utf-8?B?eVdLWkVkL2lQdm1pMXhacmhoekNSOXdESUhCZDRBZUFuMTBROUpTbW1BTlFY?=
 =?utf-8?B?OXZaajFUUTBlTHM0TFVHZ3Z0NTk3cFdDaTVRSi93UkdrT01qQVNHK0dPbk5B?=
 =?utf-8?B?VFlNdlArcUIvNk16NDg2YmZTeUVXZkhTdzF4a0prVTBMNU1YQmFCRkh3TW9G?=
 =?utf-8?B?UngwYmJiODlYNnUvUE9hWkVXZUJTSlo5aVgvY29sMDJQb0o5cUtKZ3hNcGp4?=
 =?utf-8?B?ZVdaNjJTR2xOVW5DbC9jd0JrUGtxb1JCWnBSc04yV1NwM3g4alk3dE5xRWgr?=
 =?utf-8?B?bE5uSEIza1oxYUpJMWlrSGVORERmbmYrS0hBVDFtdFZWRWJCVWpDbEUwN015?=
 =?utf-8?B?VkF2TUd2cUkycWdBeDRucFUzdUg1UmdJaE9qUTF5VGFEbjhxQ2ExZDZFY3dk?=
 =?utf-8?B?SjQ5dC9qbFk3Z3dCeDBXYk1sL0taNWRidFdjcnJCb2JsV0JCU3hNQ2I5bVpF?=
 =?utf-8?B?L2x6RzllZk1STXI1NXRqTnQ3UytaTmJ1TG52ZU1rMGtkUzgzT2xSaWlrNm41?=
 =?utf-8?B?VU5BeGFRRWdKOVdLTmVCRFdrRkt1UmRQMi94QVE5Q05DZzUvdnpGaFVuSG9Y?=
 =?utf-8?B?T3hQQ1JtS2s0eXJEZGxYdXRnVVRETTcweXF4RkVWd3ZZTVpRUnNjUGhvUjd3?=
 =?utf-8?B?RXVtbUxPVU1QaEgvTm1HYXpBZTNsSGk5TGxlVFZ5TFl4d3gvMGF4M0IxVE55?=
 =?utf-8?B?QnJSRlgxMXlvbHZUSjZkWmxqSE10RVdSbjBWclRNYk5TUlRTOHhqSGNJMFVH?=
 =?utf-8?B?aGNSNUN0QmtaR3V0cmNnczhnRXo1Zko5Y0gzdFJuSXFISExCVzdsWmM2ekp4?=
 =?utf-8?B?NGFBYWhqdWdnVUZxQTVveGM1blJoY2s5K1ZHOXRFNVBBVHo5SG1lYXNiYVBZ?=
 =?utf-8?B?UVZvUk91TDc5b1RsajZPTlRwTjM5TzFFcEZZWC9reXAzc2xQdFdqN1RqVGRU?=
 =?utf-8?B?TFIwaVdOYVFPdVRZZWRKVXhMWHpraHZaV1NOdkNXN21ncGV2bFc5SHdVWndi?=
 =?utf-8?Q?deoM/EZo9HmFfObU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73019943-f225-4b13-6ff0-08de9f9068dc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:11.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtxqX01xGyxY7RfzyxTss7gM2bg1GMGjuPwKqD0mtaXlrFFKHAXt4UkH8JSfmImixjvqwWEVXTCSwlj+ivbywpZwKZDwwet8Y1cJhnMwZB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
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
	TAGGED_FROM(0.00)[bounces-7385-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 5E64F439821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


