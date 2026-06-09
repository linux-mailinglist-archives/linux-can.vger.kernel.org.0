Return-Path: <linux-can+bounces-7778-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qiMVL+QnKGrm/AIAu9opvQ
	(envelope-from <linux-can+bounces-7778-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:49:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B066154A
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:49:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=nu+jCJW+;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7778-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7778-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E6853119D51
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6063451DA;
	Tue,  9 Jun 2026 14:30:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5C3438AF;
	Tue,  9 Jun 2026 14:30:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015408; cv=fail; b=qameRTMlleAQIPiN3KlxLT4eG/hrbFCgOMUA5ZQ0olxjdcMbeakX4o0a7BXN6wYEgsRTql7Rn9UCIZRWbawA6nec5TmCQdIPoWC/imPuz/zG3Fg1e4JBlMyJE4x2jSrmUIi7KQ8kDhkPG6x9H7+gnVjoDDSmsj6TZ4NXVfsr/gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015408; c=relaxed/simple;
	bh=6K5ovCF7LlLU3RuXRapYSM6s03UgxstRKBaIyMdwDbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnPtVcHAovXwHkvg8+/YSHPAQY7yVaDKGjReKrHWq6v6wfrRO4+uJMXDHLnZ85gNK7KIZqDstLcJBpTxAgQCm+0BGfgRi/RBYhYPuBh9XjDcaNUt+4kCfMEJ6z4LJHucdzFv2UVh5q/CpFdB+RVTU5X8fZOlvsU9kg4dplhKC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nu+jCJW+; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So23xyBAaR+8gGpPNC5OGgbfPbE9OfyaPtBhjEqMDHiUkcuzMXkm+u9ciXheQg3I30AudgEJwZ+f9xoShTPQBFgdzDR+fXI+bCp2u8eMNhDtx3zGa6yDZ2SWOImXRejTF3QoDnqdwXxN1ywlfGIcCrDykR2xdfdxH+1yxgbAI2QVnfNeOZmMVSpNjlqZuvDg4N9IM/+K7czI6KiWx/1wY6oT6rqGl/Xzk0Tb1vbsPsn33ZPX8P/5u+YBdWhVp4jGLc6+XyAuKog/CeU0meqGKR0rJZuWo+HQ1jlUM5ImMIJ+DibMwCOEdmoyGuAm7Rw6L30wy/6V02qWyJ9iIVA7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKgIOGR2T5gCFT7G6SceF4Xob+IkVeidoEyct8TGBB4=;
 b=Z8opDzwKRTiBpe83QPXo9bjReGWYryZ86A/T4l08+qdCevzXfkADwaxFvv1lkyQSgIevxeXzpo38jikEKufo7X8pID5PZhpe9fx9BgMyPadfyXLNfW780Eu8a+8DNe3YUGfhahZK7UcYV8PpHq/aNLuI+QnLw6tgbMUpHxKQu924N//M1Kj5anYjPnb9jhvn6nTbztWJQ3Yip6SBfcgRMS/ecS8FI5wOl+n/rswz1ZrBKTgDpSM3tGpHu15VqaaejHFl04KonhqvU+92+gWfUZ35J8QY+s1XaWao2hC2rwGukTezBUtsyzYEclKccDV2CpCuu9aaAAmypqBBNufpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKgIOGR2T5gCFT7G6SceF4Xob+IkVeidoEyct8TGBB4=;
 b=nu+jCJW+rKD/rP9kceSya43/WkjwKR8RnvsOTyMvncHdVxpjg8OdWKHiT1wZzfGv60YRQnnRx8yF4k2TfsTgSWyOvnn/CjTtKZwa4jTueXsW6aP2OOx5otC1W6L+/GXzzMbi4haW1HSmVBYtFWY8cJDndnfHG4HTW2uKLipPgiMza0bQsDO3pyDVTveRujqtLGnMIBqV+WxAIwCqVm4B9re5pP78Aqz9YQFZ8iGQfLc5N8RynmTyiNIOGMsp0HwOugh7r7W1J9b4nsfhlEacAQI+PtpWhDRwVKOh49Gj8tDDfwo7PKbjRbpNfEWrrZRPfRRM8TKmcFYwIYLWILy0KA==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:30:00 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:30:00 +0000
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 2/8] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
Date: Tue,  9 Jun 2026 16:29:48 +0200
Message-ID: <20260609142954.1807421-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a03860-e5a8-4798-1542-08dec6339696
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 HcJJhNGadgnY2aLnDy5VuzBhnHkX1MEGWsXD4JdlEC5PCuoaIgymV6n7DLcJxx8ecenWB+D1L6cUawuQBRW09Wepow9P7u3ET/FbhNjoapRkgAkyXNemLeebuhSx5ifPE5mD4hhArD9tg2IAeJ9neRtpdDDyhZSw2Sj+CXxdmBEcvynoL/7Hvvob3sjMaqRIHZNT3RL5NSLJveY17B1JNKc/e382eZ3k75A8Cx/JxMq0qWv8BTaCf4hizIWfp8V1Nj0j7ZWOFMu2YYgIWggayN4AkXZoYVtxvM23EsVtQHCE8EuSiyotrVWCp1cJTzEXZasvVZDhR/rIkOmaNKJW6hsqVo+BLNXvf0+SNubrCYXHGnWweeLSoxeiMJ3MxmYBzs0r+KQYVKM3JzqdG397gTWdo0E8s7h5YJgAwo18iBOppVtl/Ze3CrdLDfyXaExBX85unYMLKIkX5KzhTfThiwgHZfIAzfOivzLb58IJFZd1EV2HMhL6JggRn9HJhFZEbJ4tJPZepoayZsMr9/ptsW2I75vYxNcAbUrnNGe2dIzrz8iXAMryt+gSEr96hDhTru6skrpA/kOE4LU5L/nNUtPG75tm2PqJh399hi/CrEc8dJeltioq3tHcIrzM28NPRJtFMT6qe2sv4I5R0Jl95b7qbjK/HHe125YMHxX3+Q9Yzt4oZddVygcbf/u/0bgg
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aDkyTmFaYWRpb1RVYVlvVXFSQlpSMVM3ejFxbUgvUXVHb1E3S3VmM0dDbTBy?=
 =?utf-8?B?UVp5Qnc4K0dZcmpGOVorL21XRWMyT3lkQzRHMmFyeXUrQTVFQVFhNFEvOTRE?=
 =?utf-8?B?ZE4zaTlRSFlzNjZJd0JpdXh3dGk1aktTR1NrMnlFOXBlQStVd1BPaXBrS3d0?=
 =?utf-8?B?eDFSbHVZLzUvMTdtYnVOSGl0ZVFLeVdsNFVVdzN6K2xvSk1oTml4d2MvcDVx?=
 =?utf-8?B?dXNxbHZkUTJKeXVpUXdrWFlYQ2ZyVnN4aDBva2hTRlZBWWZ4OC9Ya3lFN0lT?=
 =?utf-8?B?WFpSTnhGOE9OTzBiLzNmN3BUVzBzTURvNUxvMERlWnBXWmhhWFpqMitUY3VH?=
 =?utf-8?B?aklnQ1d0bTJVb0JtUThtZHA4VEZ4amdXQVdxem01ZkN2TUxlMmlKcSt2dkNp?=
 =?utf-8?B?d2JKNnhzbGgreDJ4L0lwc2NNa2I4cmsrd08rN2x0UGIzSmVyKzgvS29LSThR?=
 =?utf-8?B?ZGtJcWxlUEoyVmsydUFGZkFzSkpadkppYkxaZGVXUnZSQWVaRHJXYm1jdy9B?=
 =?utf-8?B?d2JiZkpUay81R1hXL0QveTREcWtmOVEzck0xTFFmSENEQjFENkdrbzJIRXIw?=
 =?utf-8?B?SDF5dENEVEFwbTJSQU9CRC9xK2lIQVorK3JobWY1eWVPd2g2ZkNkK2xjZVEw?=
 =?utf-8?B?N1FGSjI5UHZVVFNsWmpBdGNnUW10UEg5Y29pNkpRM0RtUUhKL256ZCtrZ0dY?=
 =?utf-8?B?V0R1ZVRDc3BiK2c4RXNnb2cxT1NuMTJDdXBNRUphSEUveC82dEJtcXN5QUxx?=
 =?utf-8?B?Y2VCMmhwb1JSem1mYTZsandUWmpaYmQ0S0pha2lVTjRDcEhpakRja3lkNFRq?=
 =?utf-8?B?Y2l4R0lLOEMvZG9ZNFV4ODY4eUhJZTFyNFlvVFFxNVA0YTBFZng3MkVGY2hM?=
 =?utf-8?B?bksyUWs3d25pZHFXc3NhbCtZZnhWWjFEdm9XR3R6R1plZUdMdUtKWGVhMDdn?=
 =?utf-8?B?QmJrdnJrVytOVHRHK1o4dlZXRk5BQlNQdVUrL1NCTmwrNTJjTU9KVWhLUGU4?=
 =?utf-8?B?cGlhbFJJaitFYkwyYXN4VTJ1cDhaRmZXRjFkdVJoZFpTcG1VQ2c0MVYvN080?=
 =?utf-8?B?dUYyRFNyNDVUTERmLy9UWWRMRTFodWY0RjNhdG50UitkS25EV09LL3gySVQz?=
 =?utf-8?B?Q2laUGNqNVZ4NEhUMG9XblMyQjBoa1A0SVBRY3N3Mkd4Ykp3R0Y4anhOQzZV?=
 =?utf-8?B?THkzNWUvdWx4YVRBRXZXcHVIZk1OZmZoS3o1WkRFRGUwYmdLUHhURFMxZjBK?=
 =?utf-8?B?cW9BVEtZWFk3aThFVDdEZUpiMFEyVGlSUDBCN1Jwc0F6TUIwUVE0U3VGTG9W?=
 =?utf-8?B?R2thWjRtRlMydlkzQU01eXhZTWI4a0J0eUFCODhqYytTU09TQjdXY09LektS?=
 =?utf-8?B?R1hPWXRpR1AzWW5ubll1WTZtN0NyVDJoWFpKdTUvMXF1bElTN3ZmUGttTnIv?=
 =?utf-8?B?SkpXOHE0bFpNNXArOTgvYnlRTjVTUDVMdTl2UmNTdHJUR3JiNzRYL2NjcTY1?=
 =?utf-8?B?SitGR2V6UmhtTzJ1Z0EyU21TRllVWmMzMEt4ckZVRSt0b3p4ODkxL0g3eUhS?=
 =?utf-8?B?Zmp3NnBoZ1AvMW5NWTczNlIyTTlENzFzUjNJYnMxOERMOUFKRVBlOE80WEo4?=
 =?utf-8?B?cnozY0tqQXVMb1BUTlJ1cXE5dzJKWVhVSFZrMmVKRW80MUFHMmF4UTNWQSt0?=
 =?utf-8?B?bE9GYjduWjVjR1pRejJESkg3OE9IclVrUjRQQll2dVlxQS9CQ0Vkd3dmSkNB?=
 =?utf-8?B?RjEzNlFDQ3RNYXRpV25XOFFYMHozM25mMUpnSkk3NWJseDNxWGpIV1JmUjRo?=
 =?utf-8?B?RldBRlkwa28rWjBJZk5uU29KWlUxbisramlEQWZNZ1g2d1FaWSt0bi9abFdx?=
 =?utf-8?B?R3RETmk3ei84Z0E1VnZWM2tCeTVwYUkzZEZrcHRGRmI1TFFtUG9PbjZBdFpq?=
 =?utf-8?B?R2NKUGxsQjZYOTc0cFZWZXdsaUdBUzBoT2FBb2RiU1JVZWRtK3FzUUxRWDRj?=
 =?utf-8?B?SzBBc3NvbDZvUzZUcUZpSFdSdml1RnEzTFpzcEZFRlFacjVjZm11dThZMCs0?=
 =?utf-8?B?Z3RxTUFxLy9SVVFRL3N3azB0ZWdha25DZ3IvU0h2YTN3aWl1S0FmT0lwbHdD?=
 =?utf-8?B?dEhEN1YweUE2WU9yenJtMDF5U2p0enV1am5DcG9ZQVZvZjdiLysrWE5JeDZk?=
 =?utf-8?B?TnM3TWRkcVJiVnBDZlRWdFRqNngvQkdWdlJZd3gxa0JwcWVGNWROQ1U0ZjNx?=
 =?utf-8?B?VzRhMHRpN0RmQm5md0RnNDVvWjk4UytDOXk3OHM3SjBBMkNFa0RQWkpDeW9E?=
 =?utf-8?B?WlZpbW16M2hUYW5TdC9Rc0hIZmcwa29mSHV4M2d4T0cyaHJha3J1c3Y4RUZH?=
 =?utf-8?Q?kA0uzxe9Chgi/hdU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a03860-e5a8-4798-1542-08dec6339696
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:30:00.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRGe9DuhQ0P1XcuzT+s8m+lunZAuZUoIq0KJKnDuG1LbuYfvZ56HNdOxZGzSgfGjdq8HfgpCx246XQz1g/S1CdonlIHJAr7IgFzIYCT0Ml4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7778-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F4B066154A

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers.

On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
err, secondary-mb) remain active so their handlers can fire while
registers are inconsistent.

Disable all registered IRQ lines around the IMASK/CTRL writes. This
also fixes the resume path, which calls this function.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f73ff442d530..7dde2e623def 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
+	u32 quirks = priv->devtype_data.quirks;
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		disable_irq(priv->irq_boff);
+		disable_irq(priv->irq_err);
+	}
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		disable_irq(priv->irq_secondary_mb);
+
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
 	reg_imask = priv->rx_mask | priv->tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		enable_irq(priv->irq_secondary_mb);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		enable_irq(priv->irq_boff);
+		enable_irq(priv->irq_err);
+	}
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
-- 
2.43.0


