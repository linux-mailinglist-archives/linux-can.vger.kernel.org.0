Return-Path: <linux-can+bounces-3268-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE9A74916
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771BB7A3842
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA31AAA10;
	Fri, 28 Mar 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OJ66hZPS"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504FF18C01D;
	Fri, 28 Mar 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743160678; cv=fail; b=GvgkGX9ZFNJ0QdrFCxdqaAkgaZYsvvAfBRNGidq+Bpdvp1IHxrxPuRTOG+viXBjUkYWd1joL0+U1DwqYfLKYmDGYRYvzLXHbonTmDRTeCUmom1a7Ga6uzc5iRGGHsskWr83NqhiUTdWn1PJp7WOVk65DXIS1KZECapTAT+uWzKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743160678; c=relaxed/simple;
	bh=4ha2FSdNg2orochSCPvFGSa6jeiIY76D+q+HevwegIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PEQFK+Lz31lsoTJFxx13LxecdaRLh7E1/SkG8QWDWUDnM19fC1NJO4/vYoNey193Armw9T6Z3XAeA8oHvnVcwbt318o/adRECoRqZcWRCFjyklSRN9hTgFIV19GDDU7xBjKFVT68Ht9K4/s1UWhwL06BdgMWfjYRSw+9vpJZD3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OJ66hZPS; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRr8gP2XDne5zPnW8lod0HDw7PoKSuFyToEuDF+eGctHVwzo/bEQhn/jdMhv/KrPj7Hz4nwZphBi7/l1/wx0zugDYNWt4ZjXFXCYnYm6OuLlknh0s1t8zLDws158j2Ymr445sBJVMhFvkvbAIgRqRvO/K/GvxYl4gwepc3ffoK9j/CYbC6ABEt4V09YVDTIBLT5rpK00HeiurKnaH520bFsRP/TcnbFStl/wZx964irWL+zFUIR+e0mecK6FS4iJFE7XduQFKA1cWFZkrB40b//cCGs5WH+Whr59N8Wqc6w4RyFG3xq2cD40bUM5H631U9FhhSUKJ/VLDxPPT/qLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ha2FSdNg2orochSCPvFGSa6jeiIY76D+q+HevwegIw=;
 b=TZxo6TAYY7z8+f6g8ROtuBa5B7zCjn4Kja9Xw0GPwhwDVemen7OjTbw8/PyKQzTWEdbFd+4FbyYuwgMehhhIb/+2rk9L3PqODa3M7lUI24knoJxCMiFjbPnCe40ilqjunMUEVXh0WFe2yIvyu+94kL8Qw/Of7+eijlWnAHqFpWYAqfrcsAOEChlQQv29QqGbhwn9jeZJhoGYcrOGEiUmAgw2GqvyQrmkpfwUqRuQB8j2Je4luMRehcQb8LonKMDR4XfR82wKlj28572y6DQtG/yJLacUBC6Fs97bKmhQQARLN3KpPo3Svr70VcVEhM9nsd02dr1yGzRGRrdliE4K8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ha2FSdNg2orochSCPvFGSa6jeiIY76D+q+HevwegIw=;
 b=OJ66hZPSJlE61mtOVwXQS0ejpcnIdtfz16l8YSPf63E2TqZe5kUc5gRXtwT+UapkkphaHEbcXhYAx3N8hz6boJ7bxwaVVuCauEUQrbUyU7kBdqA8cUZUfeM3qT0CPzMV60QfJbHNAwkVxu4W7HjrcpAXLhkFetKBRK4lw5+B0u4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6753.jpnprd01.prod.outlook.com (2603:1096:400:b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 11:17:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 11:17:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
	<mkl@pengutronix.de>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to
 struct rcar_canfd_hw_info
Thread-Index: AQHbnkmCjkAVW17T00yjXS76ILH9B7OIZhsAgAACf1A=
Date: Fri, 28 Mar 2025 11:17:50 +0000
Message-ID:
 <TY3PR01MB113466234D837B22985BBCE0D86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-10-biju.das.jz@bp.renesas.com>
 <98b10d18-89ae-4fef-b9e3-f548b88c616f@wanadoo.fr>
In-Reply-To: <98b10d18-89ae-4fef-b9e3-f548b88c616f@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6753:EE_
x-ms-office365-filtering-correlation-id: dde7974b-a4b5-4b05-657a-08dd6dea2d28
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXJuTHp2Mzg5ZmQ4V2ladUh2TWlCR2VDTm9qV1hiUWt6ZU9jWHV6cXkxTXNM?=
 =?utf-8?B?c0N3eEFEZ2NVUEJKTkcvT2c2cFNLcVlVVkI0S3ZQZ3d4RUJMcHkya24vK1Rt?=
 =?utf-8?B?NlRpd01NVHRCWUkzdDBiQVBIQ3MrUDRFZEZxTnlpUUlITS9RT3o3c3N1WC8r?=
 =?utf-8?B?djVZaTJ1azFMKzRiZ2YreFQva09tc1I4ejJmNU5ISGx3bGx4NDFCMjE3T1JU?=
 =?utf-8?B?QzBqbDlHdzRIMUl2TGNhUTNSbHk2VnNBaTFOb0NoOENaMzQ5enE0OFZ1MERX?=
 =?utf-8?B?MFM5blNZVWtwNlIySFNXOXhKQjBRVUFxRElWcStpYUwzNDdlVFZwbGFjUmJz?=
 =?utf-8?B?YWE2RW9CZDJYUTBBYkJ6QWt2YXgxT0ZqM2tqWHVrQ25ZSExaV2ticHVkUjVN?=
 =?utf-8?B?WkNpVVVzejBNaWJxMVpWVFM5MklQR2VsNHZWYWpSbVZsZkUxNFIwakc0TkEy?=
 =?utf-8?B?MU45Wmkrd3ZCV0V1d0FQRy9JL1JqR2I0dEFYVkxHTS9kWHVKckZDVStUai9O?=
 =?utf-8?B?WGluVjRoYmk2TVl4SGMwTXVxRE1QUWx3TlFGNzE1NUJudktCLzlNSXZaTHFv?=
 =?utf-8?B?MGFIOU43RE5Jb3oxUWd4d1FXVTZ3OXEwUEdyQTVjS0t6a1I5bzB0UVQydWp5?=
 =?utf-8?B?TDRER2FnNjFzc3ZYaHVrY1dtbHNxQmhsNWg4RDhoaloyOVhJKzRoRkJBWGVP?=
 =?utf-8?B?bHZDS2ZDV3VMMUxybENrb1NlamVGcEhoWFVzMFloYnJBbGtqVmp1N2NPNzMw?=
 =?utf-8?B?d3V4a1NHcitLVU9nTTE0dHhPUURnQ1BlS3ZoNlFGWWdTSTNhc2Q5dmZiNGVF?=
 =?utf-8?B?T3BKMTh0REgzSzdmT3lkNTRnaWdlUG93dWhadzJQNUpzOEpVSnJPWGduWTkv?=
 =?utf-8?B?aWhNeDQzWWhOTHlvSW5GNXk3MUhlamw0OEd4QTlIN203TmU5QnYvVkJBcGpE?=
 =?utf-8?B?N2pQSXBHL0ptK0RSN2d3SXJGUWxYLzFqblgzdnBrTmNYUXNuUTdQS3VYV0pn?=
 =?utf-8?B?ZXRUVWg4eVNiSHd1TmtXQlhvWDlnaUFxUWtZWlBVVFdRMnRHNkpOcHJpanZ3?=
 =?utf-8?B?ejV6S2lFYVY2QXpETC9wM1poOTNBR2R0VjcvS1BTMFRCVUNDM05NUm90Nmxy?=
 =?utf-8?B?VzRreGFlbHhIL1VnUDlJdzczT0RxS1l4cXRwRXE5TzhBZzFGVFR1N2tqMjJL?=
 =?utf-8?B?dEZ2WnZRekVyMnVXZDZWWjV0QmxTRnM0WFRyVGxXQ0xIMjF0UHdIR21weU5B?=
 =?utf-8?B?Mm9GYW9vQ3JVMHorajNHaXhpWGltZjFCMXVZamZEblhDY3p4eXZnWVZ2T1FV?=
 =?utf-8?B?NTNzZkMwMzBCUjJkOHhiM2p5SFhSMGhNWlgxSGgrVkNqcFNFWnNvcFFyT0xT?=
 =?utf-8?B?Z2xaNnU1Ky9zWkVBZ0FDcVhVb25ub2VpTWt0alUzdlZRTXpiR2FzTjR1R0tH?=
 =?utf-8?B?WCtYQVNMeEZTakpERFc2N2pDS0RUYU1ObnFOcjdpdXhSWXdkdGI2QkdyVG1k?=
 =?utf-8?B?TDY0VTYyTlFIUnNVMHZOUzhzSE8weldpWTRHVUxpK01PTGloZW9jTmJyZ2RQ?=
 =?utf-8?B?S2RTV2JrRTQ0WGx6L1FqRkdUSjVtenNhRFJoL3ZOS2d4NGNWY0Jya2t0b05n?=
 =?utf-8?B?M1F3UStLNWpYbjZtRDJQVStJTFhjUUgzTzhubS9lS2dWcUJ6WmxCcFRYTHBU?=
 =?utf-8?B?a015SkJCU05YZWxJVjRuWllFd1J0eFY0RVhOTWlHRThtSnFzUlF2aHBCTkov?=
 =?utf-8?B?UTFuRzd5UWNhSE4rWE1zZTBiUG5wVm9KaTFkSGI0cjFlUnNvd1FtWHArMUl0?=
 =?utf-8?B?dVlYb09IekQ5Y1Y2bW1BSSsrK3JiNzNxNVM2TG5mTmZhTzl0TDVCNjlWSHVW?=
 =?utf-8?B?cWRFTndxc21xbUE2M3VsL09VMnhyYmZNWVViVlJlM3ZjVXRRc2poWW1FREg4?=
 =?utf-8?Q?wPD4l6BiBhr+5ZkX5Eu9+8ON8kH9yJoT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUlvM3g3TW1TaEFYSzdWMmZyL29qT1BJeGtsWHVvWmZIak5rOVNXM0dpOHdn?=
 =?utf-8?B?TnFlaEhCb29SQ2dDY2ZMVUlWQjRWZHdhZEVjMlpjNkRuTjFsOUxwT3RDYmg0?=
 =?utf-8?B?UzdCZGovVXJSakg5KzBkS01KN2RxOEZjQk12ckJNdUVvT0VDTnRLblpSN21V?=
 =?utf-8?B?RElPalFJYjlBL0E4c3ZUTmFZeU1vaVFjRk9NTVM5a2dSV0VBcmlDTlNPZ3Vy?=
 =?utf-8?B?UlZqYUNuZXFaUEpOMkJMSlRtRmJ1SkIzTEpuUklRRFoxd0t4RkRUbmozdDlB?=
 =?utf-8?B?UU94bDdzQlY5OXV5bXUza2FsWmVkYzdNQytiZTRLMklQclFzMlFTUkhBN0Nq?=
 =?utf-8?B?dURWMWViVVVYSjhhZERVMm0xNVAwOWRYZGdDeHI1NGFlSkhxTFBua2FwMUJr?=
 =?utf-8?B?T1paR0VDZitEbUJWd05tZXZsbHV2NGx4OFFTdmVaUmdEaWYwcVpQeDFpRnlq?=
 =?utf-8?B?bGhHQXQrcEtWd05vQVRQeFFkM1RjRld0dHhCMzlhdTkrM0RjSG5NY3VSUTVj?=
 =?utf-8?B?TlIvMjdLbEVwSVNteVZZUUdTSTR2N1ZLa3ozRmVvSWRLTXRHMlVKdEIvMlhF?=
 =?utf-8?B?TDEwdEZEYWdBT3VqZXBiNzNkRThGZUt6S1h3bkdtYWFIUVRBZCtsZk1WYnRC?=
 =?utf-8?B?OFJnTEJXcG1kOG8xWmJUVmNzckVoL3ZsSXZYNnNWZ0VTREJVQ3MzcUd6YkFR?=
 =?utf-8?B?UUpsbjJWWUtQSEV3MkM1L1A4Rm5uVUZtT09PWjEybzhSZDZXaUpUZWNsb1FY?=
 =?utf-8?B?VFRJTnhZNmlWaWVQU2ZadzlsZGs2UGFsWXJvajBJaU90dHp5dW8vNE1KYVZC?=
 =?utf-8?B?VnpmQ09MdjYxZnFTcWd6eEhPTENxTzB0UjByQjJHZUluS0R1Y1R1a2hnVzQ5?=
 =?utf-8?B?NDZxMG9Db0xER0NIWHZkaWdhQ0JNSDFZUG5uazR6ak9NenZCTFhiODlva3Mr?=
 =?utf-8?B?R1dvYmdsTlFQTk9pMStmVHpCWFhPMVJWaEdKTm41R3BJN0t6eG1la1RnT1Ur?=
 =?utf-8?B?cU9BODd3anJpZ253TkIyUmpJNTIyUDBjdTREdVBwaG4yTE9Wems3SmJJaUM1?=
 =?utf-8?B?enQxZEhTY3BLYWZuNStqTHViZUF6R3loUG1NZzlPRnB5TlZaeW5yQlp1clYw?=
 =?utf-8?B?VmJXMFFNMVptQUhCbDc1ZDJ4bThLcDI1YndGWm1OTjYydjl6RjlBVVdqU25a?=
 =?utf-8?B?NU1QK092cFg0cDlXUUp4Rm9kdndiSHZ0WTViNzNQMkVSWlMyRyt4RlhqVGlx?=
 =?utf-8?B?SFJYczRpZGtIK0FOa2tlYUk0czl6L3YrTGxzZC9Qa1Q5YkkrMEpKVlo1dklv?=
 =?utf-8?B?UWVMM01peVVsK0dwYjZUcFRaU29mdzZVdm4zSGJUUWV5bFN1L2JyTklyYVoy?=
 =?utf-8?B?UFlMUkNDb2lZQkg4d252a1AyQUlnNFpzNjJoRWk2Qm41cjdsc1NwbGt3VEF3?=
 =?utf-8?B?bVRUcnNRRk50Rk9uV1pLeWpwUHIrWmI2akdTbm81UXU4djIxbk5xTjEzRE5j?=
 =?utf-8?B?d3VpYXdxZDVYWjkyV3R6TEo5dmdrYWlmbHJCYksrQUs4d1A2OCtPbnJNRUxu?=
 =?utf-8?B?Tk13UDlFSk9CUFlYejR3aVJ6QmxJOFB4bW1abVVKVFV3TjNxVi90aDloOXdw?=
 =?utf-8?B?MmUvcmlZcXNTMkhzR0tWTy8wckFZcHNxTmdlMkZtU1NCbVBqTGtsa1JpVm1u?=
 =?utf-8?B?WkUzYlQvclA4MFNYN1ZMNEZkbHltQ1VhcnBpbDhtT1B3Q2FucmxwdlM4cFVt?=
 =?utf-8?B?OGZFblFaamJYcFFIdEZTM3YxckRra1F1cmhYWVRPSlhSOUdkK0dPcExYRm9H?=
 =?utf-8?B?UmhUMmwrRVYxdE1tS1J6TytGOUlFT0tCbUVUQ0VRZlVUU2Rqdng0SHNXaTZk?=
 =?utf-8?B?bE5lVzk3WWk0eHdxMHlJOVg3eUxrQXVqOGZEemtzWjRvS0wxM3pXN3Fjb1Z3?=
 =?utf-8?B?c2xmcTJWVVJOV1ppNjlMeGkrQTFNWHFXZWYvOXpzMUVHQ3VSRTVLTE0wYTcz?=
 =?utf-8?B?dVUyQkRxcVIrMk12R1l2RW1hQjZzKzFNU05uaDdsbXpDRlJFTzhTSUFEYkNC?=
 =?utf-8?B?QlR5a1FzRytxQ2JIMTQ0QkVncGs2eCtMQ1NhYTh3ck1reURMTjA0ekVKaWNH?=
 =?utf-8?B?THpTcE5UYkt1c0lCdDd4TkxGUnkxS1BQOGNTbWZkTkRMNm5tUXJERGtTcGZY?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde7974b-a4b5-4b05-657a-08dd6dea2d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 11:17:50.3433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7MH2OJaoQB/6AzqCdCTa24a5EI4srGQV5wvab/6KkPyWcoKb9hf03g+3E4XOhPNUHykf0UIaVD94bPmFWHK1WEkvMvHvqvHT5/fHyTLms0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6753

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyOCBNYXJj
aCAyMDI1IDExOjA2DQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
OyBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogV29sZnJhbSBT
YW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT47IEdlZXJ0IFV5dHRlcmhvZXZl
biA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+OyBVd2UNCj4gS2xlaW5lLUvDtm5pZyA8dS5rbGVp
bmUta29lbmlnQGJheWxpYnJlLmNvbT47IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7IFByYWJo
YWthciBNYWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMu
Y29tPjsgYmlqdS5kYXMuYXUgPGJpanUuZGFzLmF1QGdtYWlsLmNvbT47IGxpbnV4LXJlbmVzYXMt
DQo+IHNvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwOS8xOF0g
Y2FuOiByY2FyX2NhbmZkOiBBZGQgbWF4X2FmbHBuIHZhcmlhYmxlIHRvIHN0cnVjdCByY2FyX2Nh
bmZkX2h3X2luZm8NCj4gDQo+IE9uIDI2LzAzLzIwMjUgYXQgMjE6MTksIEJpanUgRGFzIHdyb3Rl
Og0KPiA+IFItQ2FyIEdlbjMgaGFzIG1heGltdW0gYWNjZXB0YW5jZSBmaWx0ZXIgbGlzdCBwYWdl
IG51bWJlciBvZiAzMQ0KPiA+IHdoZXJlYXMgb24gUi1DYXIgR2VuNCBpdCBpcyAxMjcuIEFkZCBt
YXhfYWZscG4gdmFyaWFibGUgdG8gc3RydWN0DQo+ID4gcmNhcl9jYW5mZF9od19pbmZvIGluIG9y
ZGVyIHRvIHN1cHBvcnQgUlovRzNFIHRoYXQgaGFzIG1heCBBRkxQTiBvZiA2My4NCj4gPg0KPiA+
IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJl
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gDQo+IFdpdGggYmVsb3cgbml0cGljayBhZGRyZXNzZWQsIHlvdSBjYW4gYWRkIG15Og0K
PiANCj4gUmV2aWV3ZWQtYnk6IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFk
b28uZnI+DQo+IA0KPiA+IC0tLQ0KPiA+IHY2LT52NzoNCj4gPiAgKiBDb2xsZWN0ZWQgdGFnLg0K
PiA+IHY2Og0KPiA+ICAqIE5ldyBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvY2Fu
L3JjYXIvcmNhcl9jYW5mZC5jIHwgNiArKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNh
cl9jYW5mZC5jDQo+ID4gaW5kZXggNjJjZGUxZWZhMGMwLi43Y2VmMDY3M2ZiYzggMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTkzLDcgKzkzLDcgQEANCj4g
Pg0KPiA+ICAvKiBSU0NGRG5DRkRHQUZMRUNUUiAvIFJTQ0ZEbkdBRkxFQ1RSICovDQo+ID4gICNk
ZWZpbmUgUkNBTkZEX0dBRkxFQ1RSX0FGTERBRQkJQklUKDgpDQo+ID4gLSNkZWZpbmUgUkNBTkZE
X0dBRkxFQ1RSX0FGTFBOKGdwcml2LCB4KQkoKHgpICYgcmVnX2dlbjQoZ3ByaXYsIDB4N2YsIDB4
MWYpKQ0KPiA+ICsjZGVmaW5lIFJDQU5GRF9HQUZMRUNUUl9BRkxQTihncHJpdiwgeCkJKCh4KSAm
IChncHJpdiktPmluZm8tPm1heF9hZmxwbikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4gV2hpbGUgYXQgaXQsIGNhbiB5b3UgcmVuYW1lIHRoYXQgeCB0byBwYWdl
X251bSBpbiB0aGUgbmV4dA0KPiB2ZXJzaW9uPyBJIGRvbid0IG1pbmQgaWYgeW91IGRvIGl0IGlu
IHRoZSBzYW1lIHBhdGNoLg0KPiANCj4gSSB1bmRlcnN0YW5kIGl0IHdhcyBoZXJlIGJlZm9yZSwg
YnV0IHRoYXQncyB3aWxsIGJlIGEgbmljZSBxdWFsaXR5IG9mIGxpZmUgaW1wcm92ZW1lbnQuDQo+
IA0KPiBQbGVhc2UgZG8gdGhlIHNhbWUgZm9yIHRoZSBvdGhlciBtYWNybyB3aGljaCB5b3UgYXJl
IG1vZGlmeWluZyAgaW4gdGhpcyBzZXJpZXMgKEnCoGFtIG5vdCBhc2tpbmcgeW91IHRvDQo+IHJl
d3JpdGUgdGhlIGZ1bGwgZHJpdmVyLCBzbyBvbmx5IGRvIGxvY2FsIGltcHJvdmVtZW50IG9uIHRo
ZSBwYXJ0cyB5b3UgYXJlIHRvdWNoaW5nKS4NCg0KSXMgaXQgb2ssIGlmIEkgc2VuZCBhIHNlcGFy
YXRlIHBhdGNoIGZvciB0aGF0IGNvbnZlcnNpb24gZm9yIGFsbCBtYWNyb3MNCndoaWNoIHdpbGwg
YXZvaWQgaW5jb25zaXN0ZW5jeSBpbiB0aGUgZHJpdmVyIGFzIHNvbWUgbWFjcm9zIHdpbGwgaGF2
ZSB4IGFuZA0Kc29tZSBtYWNyb3Mgd2l0aCBtZWFuaW5nIGZ1bGwgbmFtZT8NCg0KQ2hlZXJzLA0K
QmlqdQ0KDQo+IA0KPiA+ICAvKiBSU0NGRG5DRkRHQUZMSURqIC8gUlNDRkRuR0FGTElEaiAqLw0K
PiA+ICAjZGVmaW5lIFJDQU5GRF9HQUZMSURfR0FGTExCCQlCSVQoMjkpDQo+ID4gQEAgLTUwNyw2
ICs1MDcsNyBAQCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHsNCj4gPiAgCXUxNiBudW1fc3Vw
cG9ydGVkX3J1bGVzOw0KPiA+ICAJdTggcm5jX3N0cmlkZTsNCj4gPiAgCXU4IHJuY19maWVsZF93
aWR0aDsNCj4gPiArCXU4IG1heF9hZmxwbjsNCj4gPiAgCXU4IG1heF9jaGFubmVsczsNCj4gPiAg
CXU4IHBvc3RkaXY7DQo+ID4gIAkvKiBoYXJkd2FyZSBmZWF0dXJlcyAqLw0KPiA+IEBAIC01ODYs
NiArNTg3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gcmNhcl9n
ZW4zX2h3X2luZm8gPSB7DQo+ID4gIAkubnVtX3N1cHBvcnRlZF9ydWxlcyA9IDI1NiwNCj4gPiAg
CS5ybmNfc3RyaWRlID0gNCwNCj4gPiAgCS5ybmNfZmllbGRfd2lkdGggPSA4LA0KPiA+ICsJLm1h
eF9hZmxwbiA9IDMxLA0KPiA+ICAJLm1heF9jaGFubmVscyA9IDIsDQo+ID4gIAkucG9zdGRpdiA9
IDIsDQo+ID4gIAkuc2hhcmVkX2dsb2JhbF9pcnFzID0gMSwNCj4gPiBAQCAtNTk1LDYgKzU5Nyw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHJjYXJfZ2VuNF9od19p
bmZvID0gew0KPiA+ICAJLm51bV9zdXBwb3J0ZWRfcnVsZXMgPSA1MTIsDQo+ID4gIAkucm5jX3N0
cmlkZSA9IDIsDQo+ID4gIAkucm5jX2ZpZWxkX3dpZHRoID0gMTYsDQo+ID4gKwkubWF4X2FmbHBu
ID0gMTI3LA0KPiA+ICAJLm1heF9jaGFubmVscyA9IDgsDQo+ID4gIAkucG9zdGRpdiA9IDIsDQo+
ID4gIAkuc2hhcmVkX2dsb2JhbF9pcnFzID0gMSwNCj4gPiBAQCAtNjA0LDYgKzYwNyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHJ6ZzJsX2h3X2luZm8gPSB7DQo+
ID4gIAkubnVtX3N1cHBvcnRlZF9ydWxlcyA9IDI1NiwNCj4gPiAgCS5ybmNfc3RyaWRlID0gNCwN
Cj4gPiAgCS5ybmNfZmllbGRfd2lkdGggPSA4LA0KPiA+ICsJLm1heF9hZmxwbiA9IDMxLA0KPiA+
ICAJLm1heF9jaGFubmVscyA9IDIsDQo+ID4gIAkucG9zdGRpdiA9IDEsDQo+ID4gIAkubXVsdGlf
Y2hhbm5lbF9pcnFzID0gMSwNCj4gDQo+IA0KPiBZb3VycyBzaW5jZXJlbHksDQo+IFZpbmNlbnQg
TWFpbGhvbA0KDQo=

