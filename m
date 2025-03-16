Return-Path: <linux-can+bounces-3106-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4A7A63699
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 18:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F2188F5C2
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62B1A2547;
	Sun, 16 Mar 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="K4l12Ov1"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011018.outbound.protection.outlook.com [40.107.74.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BB39ACC;
	Sun, 16 Mar 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742144558; cv=fail; b=VDc8Y9cRaI/D/3KlBUEJaOVQOmqgmxYWtiWLmgcIJiJPRwsLjWSwM9uwASfZVhj3EkwAvsx3+Dcr7IFWHV67L5kNAm774n7N+2fRdWazC0SAi03YWc+o6FgsXdkl+eaC3x2kGTv8vUUaGHDixtmdAWGceD73gI9JjmZGkt/c8zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742144558; c=relaxed/simple;
	bh=/W5fYb0ANFyOqxsXIzdfqTim4vbvox9o0TxuLju18KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eHvX9Cxm66XMI7ORJ0wPYkhX/ZHPRjCaHASqbuS1WbszCJljWxdzOvejJrhGECJEckf7gTAMrM892KFz1hhGHA75x5Hzqb9opMl9i4p9X1v/8+Iqu1dj8c1z0LzAn3oRAmodK6Nt1uTzwv7S3ZZ5mPybq6vflE74XYaYCK7A01E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=K4l12Ov1; arc=fail smtp.client-ip=40.107.74.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PihXRgsUDNfSTB+6KKGgkFpUX3UUbxUnH/d+FnDIOEnuGyCVMXM4OaVXiDn2i3xZu7r6Ixqtoa3RZlVuuKNHlRWOoX0+QmgCYjwVkHFt2NLzOH5zs0alqsU4nwM2g8/oCLzSIboDp4euc0kWe//rD9laioZik2SLUTu16uqLSGI78wjmYWfxoCwFK6x4Xqaqo8CJJP4A5TNLHOorzLsFE8PTSASerTCH5LcdZIB4xwxDqO70srgNCbcq6/kTXN4kwrZ+KOq9GRm5y9mDBtO4HsvMx7oEx3xOWSuP3Z5m265o2SKuPHP+vVgaq7CFdvQDrhGKxIc+AzIJ9v6wO4dIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W5fYb0ANFyOqxsXIzdfqTim4vbvox9o0TxuLju18KI=;
 b=Pkc8d4URjE8IzxpOa5NrwCBt+VkUiVmwpda8CpRBg8e3+mIk7IZ1ocdjSJGuEZlyZF9P9VFu7xRN8B6j2DsCMcGQ2ZQ4a0hunMvibABC+OMob9wz5sHn/WW2wQYRpxIgwD/TMgOj9Li+K/o964Y5mYFRuodAtrImeVmQa0T9yF6XgYeB/8ieS9DRXlLcJB3pdtlOvFUfSr8lROXrLvwMuzRVra2tDp8hPUNt3M/Tg/HdDZtKAOuSEx8v/8ANoKMOiGtOUC77zKXXQMDqwjiC3lv5UNHRz2bi4M7SEzys2QK5d7SA7h2aMC6fSdaA0h+X3ro3XwtsqTuPxrhF5kBYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W5fYb0ANFyOqxsXIzdfqTim4vbvox9o0TxuLju18KI=;
 b=K4l12Ov1e915k/xoifId+9EylSqIrUohhALiR9egERyu1zKOW9w24zOzuHvafbhNL3989AALkX3zQ+HVbNYZ52ru+YpS1Hmn8feoCrYk/cnLLoOwPMtRiUYD9h5BnQlfOrxTNinN0ennqpipdrlPOb/cGgTKtDARJSr8/+ILVyg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB10390.jpnprd01.prod.outlook.com (2603:1096:604:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 17:02:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Sun, 16 Mar 2025
 17:02:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Index: AQHbjpVh5pBDjQAOZU2YFEmYsgBFpbNywusAgAG/fpCAARLyAIAAdebA
Date: Sun, 16 Mar 2025 17:02:28 +0000
Message-ID:
 <TY3PR01MB11346DE82F59414FFE322F88286DC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-9-biju.das.jz@bp.renesas.com>
 <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
 <TY3PR01MB113462D2249AB5B239E8213E286DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdWB0N6a_0yfr-e+M1CTmvDy473x+RSvbi++b+oSHWgp3Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWB0N6a_0yfr-e+M1CTmvDy473x+RSvbi++b+oSHWgp3Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB10390:EE_
x-ms-office365-filtering-correlation-id: 7e61b610-bcfe-4fbc-1ce6-08dd64ac5549
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajBxWER1alI2cjRTQkxhUUcrQkViTjFmTVJvSDQxcHVEWmgwWEpWb21RY2s0?=
 =?utf-8?B?d05qRy91UDlVMVFqK2V6SC9aMU1SYzRWWStnQ3c3ai85Y3NtNFdEa1VUS253?=
 =?utf-8?B?Uzl2SVNJTzExeUY3ck83NnZlY3BsNGpsWlNla2szcmE4WFRrN3pLY1ZXQ2J4?=
 =?utf-8?B?K1RGcGtMeWRtdjNyamtzcDZtWWxkc3A1U2p2K0NaUVZiTDJaTWFWUkIzOFJj?=
 =?utf-8?B?M1YvajFHVjZpczBxTjgrRmZKQkhXY2lQcGYwbStkNUs4ZXhRYXVSdlRMZVNQ?=
 =?utf-8?B?emNhVXBiV1hwOEZMT01GdkgvOWdiOXhXTlI3ZkMwczlrU29oQTJIVkxSb2w4?=
 =?utf-8?B?SXMrNTlpM0lXOGJKYkpaTFNKT29ZL0pVaCsxN3MvWHY5M0hxSENlb2hUMlNu?=
 =?utf-8?B?dFNXazUvN3UrQTZxdU1iKzREaWZObTA4bVpzd2ttTDhqTEJ4bWZaTzF3aFZO?=
 =?utf-8?B?QmZGVWgzdmRNbUNVUHhPWlhMNERMY0lGQXZ1RUFwdDg3YldEV3UwN1R0dlpy?=
 =?utf-8?B?ZzRWT044R3pjNDBuS2FPOElhTVBtOVJIR3pIcGpaQjczQzFNZzl0ZS9MNDlL?=
 =?utf-8?B?MmZFTWYzMTVIQVdpcml6eUJhMFhrZUhwMnpyK2RLb3lWWkdrTWs5cy96UERU?=
 =?utf-8?B?SGpQRTZDMFd1QitSaWpBdW50cGNIakEzYkFVenAzNDEwaXNHcUx3WlJFZFJS?=
 =?utf-8?B?TGlPVk54djZRU3AwT1ljNUI1R2EyOUtnN0dDbjlheEMvTjRZR2hIRC93VlNl?=
 =?utf-8?B?M0d6bkZEci9EUGJrWnU4dFhUZVJrRTZrVmhZeXlhZGc2clYxeklkVFNzMTJK?=
 =?utf-8?B?SDdkN0V0em54aDNrQzJGU0Z6OUt6YU5UTmdDNzRPbXlMbjBwK1ZrNEgzcnBZ?=
 =?utf-8?B?T21UNjZ0MThjQjNqV0xubFVSN011NmdGTEhveXBXUVFPUjJnYUNqMzc1cXBr?=
 =?utf-8?B?dVN1aVBPOENDY0docXp3NUNzOXZIUWx6Y1N1NURIZmFwdmVWRmJDRklKZUV6?=
 =?utf-8?B?YWRuVVpSY3Bsc25vUmV6anVQeDdMdWQ0a09VZzhseGMzcjhIMlVOSnlXR2xX?=
 =?utf-8?B?ZFE0M1FGS2E4eENrc1JFNGJiNTV3Q3FCckhEWUxPa3hsVnhzcGYwWEtmWTZj?=
 =?utf-8?B?VVZQVE9zRVJiL3lBWlJjNTl6SE5JNnhTMmNka2JKRy9tNWFTUGxuMkdxb29F?=
 =?utf-8?B?OVJRalc2RVJjeW96U25JbFRINFZCOEpzdm13T3RiTHRaTGh2OWNEd0UrK0Nk?=
 =?utf-8?B?Qjc0QTM4R09WV3A3NUNRc3JEV2MyZE0vK0ZvT0Q5OUhTVHJMdk5mUDdKc3Jm?=
 =?utf-8?B?dG5wOERQdHVuRTI5UGVaSGdiSVpKSU40aSs2NENyYk05Z0tKck5ZL011VHBv?=
 =?utf-8?B?RnVCZDhWczJELy9qNU55by9rYlF0a1RhcUx4eVU1M0NDMEM4eEE1OE0vUjRo?=
 =?utf-8?B?T2ZBcVBSekxXNFNRd3dZamFjWGMwU3JWM2lzQW12QXl6czRKa0lHanY2Yk1P?=
 =?utf-8?B?d3ZyazBya2kvRnJwN1Y1bzV2RmJnTnNHYnBGcVBmeURHVi9KRm9KV1pwaldw?=
 =?utf-8?B?OEQ1ck5xZms5WVAvLytTbVN5MlFreEVNcmNSL1JobUVPdDJvK1AxNE1oM044?=
 =?utf-8?B?Y1NIcVRDSjVoUmRSWUIrSFdJMzMwZ1BRZXZ5ZVM5d2ZoREhzK0dTYmkwdHVS?=
 =?utf-8?B?S3dEdklkS1V5Y0pUN0xJNHN2aUM1VWhRMmh4bWpTbDlBNlNnWklDdjIwY3dY?=
 =?utf-8?B?b1N3UlhTdHdQY29EUXppMXRVanh1bGlyQWd5WmQwREpENGpTN3hQWlJ4bmRG?=
 =?utf-8?B?VkJ1bjJNVzV3UG9vOHdPQ1hUM2FVUzZJM0g3T3NoS1dzL2RmTjNlbXBUNDlv?=
 =?utf-8?B?cmlYSVYza01Db0hkVU9ORklYZ0MxWDg0U2NON2l3UW8rdDEwcnFCVXdHVzFi?=
 =?utf-8?Q?fIfkXhgTDPehJ4fBVCauUyjlPESXOVRY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q29LR05sZVZjeHlSR3A1SjVKYWRTdjRFMDY4a0xQUW1rcVF2RVlHMVRYN0Nl?=
 =?utf-8?B?QjhSNEc2QURTU1o1OXFFOFBPaFBiamxoeHVjS2xUTkw3cjhGZitwa0w0NTdz?=
 =?utf-8?B?enhGWmFBQjJiS3psdjZjUm5tenA1UGJMUUpzTkloK1J4SmJ1WERkWHd5dlVW?=
 =?utf-8?B?N1pPSk1YYnB5Qis4LzhMR2lKbU16RGl5aEZOVEFRc3M4L25nc3Z5L2NJaDFG?=
 =?utf-8?B?cUxhM1NIZlB3QVVkQkhPWnc1YW04S2hIUTZQY0NZSUNIZVk1a2VJNnR4dFBT?=
 =?utf-8?B?eHhydXErMWVUSFhMWnpvZ05ncnA0VzdSNCtIUFR5R20vTXNtb0U3NmJtdHM0?=
 =?utf-8?B?RnBPcFFlQnB6cWs2Ujd1L0xZQ3ErbGdOQWtGZ0lURyswNTdvaWVsYXkxVG5I?=
 =?utf-8?B?SHNseW4rekY0OEw4eVlseVp3TXJFMU54Q0p0eFZSSHZkVVFQdlZ0eEI2SDE0?=
 =?utf-8?B?bjkzRWNlYmJORXBGVTRmMDIxK3ZNdnhNbnVmZmlOUWhJMGVDY3RwOHdYZGcz?=
 =?utf-8?B?VnBlVWVpVnNPb1k0NmFIemhRRy92aUk4Nk5pZnpabXZoRlZ3QlpFM1B4WWcv?=
 =?utf-8?B?cGVwcnRSNERFSEI0eGtZZDh6d3dqcXpBdU01NWk4K0xaMUgrVi8wK0k1VzhC?=
 =?utf-8?B?NmY5TVA5Z0h3YldUUlJKUmRBVy9rSGk1bWx5MzdSZHBqTmxaUkxMbG45S3lG?=
 =?utf-8?B?K2hVTER5L2diZm56aTFaeUxicUNKd0kwWnoxM05PcitiMGZHUmNGTjBnZDRJ?=
 =?utf-8?B?SllWYWNXNWViVUFuWHVES3hzNjIvSmxSQklCYXZWUENRbjNCMHRLVEZhSzl3?=
 =?utf-8?B?N1RNWk9oYjB1ZjFLUW9Wb1BTOEViTWh0cG01RjVsZ0dacjU3RGVScWhDNmNC?=
 =?utf-8?B?MEpHMWxLbFRwR2dJZEU2bHpMUm5LV0FBN0t3WDdqejc2WGJna2F4cjhLUk9a?=
 =?utf-8?B?Z2tVQ3VwdWVSYS9jOFZscHlRWURkWFc0dG9vVjhHTjFRKzhjdElMU0MvMVJJ?=
 =?utf-8?B?bXc1RjZPbHYyTE83NUZWaXZ1ZG1udkhqVzFSLzFrQWRkd3l3VVAxdUhHTHlI?=
 =?utf-8?B?NlBnWnNCVjZUczJ3cHJzb0xweGRoVnQwQk9oMXVUQWl5MFBLOVFzSTZQRU1D?=
 =?utf-8?B?MFlVdXhTbzJ5MW45NUlRTE10bHBTT1l5Mitkc004RU9INUg0WnBrTEE3bEN5?=
 =?utf-8?B?b0s1cEVzMTZDOTVJSGdSUndsVHRPSDZQM2NUUmRJZzVxUGJtTGZwdXJDamlU?=
 =?utf-8?B?VCtHL3dOU2ZqcTVFV0s4aE1LUmZkVW9NK1c3NDVXdnBITGdXeE9NaTErWHdZ?=
 =?utf-8?B?YXlhblpPSmkwU3lhS3pXeVNIbGhRdnlYbXVVR3JrR2t0UGJhRTRDRk12L1Vy?=
 =?utf-8?B?LzdDNVBhWEh0SEtycmRkMjlGNkxrT3Z1OWRQRFUrcERQbVVocjV5MTlxTkNp?=
 =?utf-8?B?SDM3UGtJMDIvdldTZUZHUTNtbjJ6ZXJQeUVja3JJemFGWTBRRzJZMU01Q2Z4?=
 =?utf-8?B?V1pEVVFCQ2crb2UxUWI3bUw5VE9tczhwTWlxeitva3E0WDMzeWVXUXRvVTEw?=
 =?utf-8?B?Z0NzeS9ZTWZ6QWlSMG5oZ2Y5Zjlab2V5VFhFSnFQblNGeFllbm9qbjRHM1E1?=
 =?utf-8?B?TWFyWkJLV3R1b1cvY0ltQjFBNzhSN0oxd1pHWWxHUllLZE5henFSSXlqa3lB?=
 =?utf-8?B?NGVrRFRSNFloclg3d0hPQk91MUN4c2k4TmFLa0ZsNVY5S3hWbjhLTjJEc2x3?=
 =?utf-8?B?NTlDWUNhbDNSYkswMCtNZkVFK0tub2JDOWFLSjBjbTdpWHRweElNYjRRcUVl?=
 =?utf-8?B?SEhLVWNCblA1ZFVrOVJQQ0psYktkSEczbUdNaGd0YVY5UWRvS01RZmZqT2N2?=
 =?utf-8?B?dy9FK21hME5lVkdKWFJYL05Ba2paWm1GYm1YSTZPU3RDdlRKalp1bWRhb01l?=
 =?utf-8?B?KzY1aWplSCthdXN6RGZvODBWWTc3NXdmeC8xSVRvZmpZbG96WW5nQVVkdnYv?=
 =?utf-8?B?QVViaS9raklUOVBDeVpwQjBvZHpzQXdPYkJuN2hOVWJCYjI0MTJLTURyaWww?=
 =?utf-8?B?ZFRtcG8zZHMrZU9lak1oMVNYZnRCWnZjZC9YMEZXZHYxcFp5bWthemtHN3g2?=
 =?utf-8?B?VkoxWkJpWkhwU0RYc3ZYQjJMcTFuc2Y1eVlab3EzUXRlS3Z4UjFKUldxTTRZ?=
 =?utf-8?B?Y0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e61b610-bcfe-4fbc-1ce6-08dd64ac5549
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2025 17:02:28.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JctIw9GNfDLksky2GeHL9yVA320beL9jxJbZutsdcYPDLNTRWrJOzhxyRoxfuwDMlbjwaw59TIh4hJTs82RVKmSDi7ghnAtcwZe+Wqe2eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10390

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTYgTWFyY2ggMjAy
NSAwOTo1Mw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA4LzExXSBjYW46IHJjYXJfY2FuZmQ6
IEFkZCBzaGlmdCB0YWJsZSB0byBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvDQo+IA0KPiBIaSBC
aWp1LA0KPiANCj4gT24gU2F0LCAxNSBNYXIgMjAyNSBhdCAxODozMSwgQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+IE9uIFRodSwgNiBNYXIgMjAyNQ0KPiA+ID4gYXQg
MTM6NDMsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4g
PiA+IFItQ2FyIEdlbjMgYW5kIEdlbjQgaGFzIHNvbWUgZGlmZmVyZW5jZXMgaW4gdGhlIHNoaWZ0
IGJpdHMuIEFkZCBhDQo+ID4gPiA+IHNoaWZ0IHRhYmxlIHRvIGhhbmRsZSB0aGVzZSBkaWZmZXJl
bmNlcy4gQWZ0ZXIgdGhpcyBkcm9wIHRoZQ0KPiA+ID4gPiB1bnVzZWQgZnVuY3Rpb25zIHJlZ19n
ZW40KCkgYW5kIGlzX2dlbjQoKS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlq
dSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+IFJldmlld2Vk
LWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+ID4N
Cj4gPiA+IEEgc3VnZ2VzdGlvbiBmb3IgaW1wcm92ZW1lbnQgYmVsb3cuDQo+ID4gPg0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+ID4gKysrIGIv
ZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gPiA+IEBAIC05MCwxMSArOTAs
MTMgQEANCj4gPiA+ID4gIC8qIFJTQ0ZEbkNGREdBRkxDRkcwIC8gUlNDRkRuR0FGTENGRzAgKi8g
ICNkZWZpbmUNCj4gPiA+ID4gUkNBTkZEX0dBRkxDRkdfU0VUUk5DKGdwcml2LCBuLCB4KSBcDQo+
ID4gPiA+ICAgICAgICAgKCgoeCkgJiAoZ3ByaXYpLT5pbmZvLT5tYXNrX3RhYmxlW1JDQU5GRF9S
TkNfTUFTS10pIDw8IFwNCj4gPiA+ID4gLSAgICAgICAgKHJlZ19nZW40KGdwcml2LCAxNiwgMjQp
IC0gKChuKSAmIDEpICogcmVnX2dlbjQoZ3ByaXYsIDE2LCA4KSkpDQo+ID4gPiA+ICsgICAgICAg
ICgoZ3ByaXYpLT5pbmZvLT5zaGlmdF90YWJsZVtSQ0FORkRfRklSU1RfUk5DX1NIXSAtICgobikg
JiAxKSAqIFwNCj4gPiA+ID4gKyAgICAgICAgIChncHJpdiktPmluZm8tPnNoaWZ0X3RhYmxlW1JD
QU5GRF9TRUNPTkRfUk5DX1NIXSkpDQo+ID4gPg0KPiA+ID4gQm90aCBzaGlmdHMgYXJlIGRpY3Rh
dGVkIGJ5IHRoZSBmaWVsZCB3aWR0aDoNCj4gPiA+ICAgLSBSLUNhciBHZW40IHBhY2tzIDIgdmFs
dWVzIGluIGEgMzItYml0IHdvcmQsIHVzaW5nIGEgZmllbGQgd2lkdGgNCj4gPiA+ICAgICBvZiAx
NiBiaXRzLA0KPiA+ID4gICAtIFItQ2FyIEdlbjMgcGFja3MgdXAgdG8gNCB2YWx1ZXMgaW4gYSAz
Mi1iaXQgd29yZCwgdXNpbmcgYSBmaWVsZA0KPiA+ID4gICAgIHdpZHRoIG9mIDggYml0cy4NCj4g
PiA+IFRoZSBvZGQgc3BsaXQgaW4gdHdvIHNoaWZ0cyBpcyBkdWUgdG8gdGhlIE1TQi1maXJzdCBu
dW1iZXJpbmcgb2YgdGhlDQo+ID4gPiBmaWVsZHMuICBIZW5jZSBJIHRoaW5rIGl0IHdvdWxkIGJl
IGJldHRlciB0byB1c2UgYSBmaWVsZCB3aWR0aA0KPiA+ID4gcGFyYW1ldGVyLCBhbmQgZGVyaXZl
IHRoZSBwcm9wZXIgc2hpZnQgdmFsdWUgZnJvbSB0aGF0IChsaWtlIHlvdQ0KPiA+ID4gaGF2ZSBh
bHJlYWR5IGRvbmUgZm9yIElDVSA7LSkNCj4gPiA+DQo+ID4gPiBOb3RlIHRoYXQgdGhlIGZvcm11
bGEgd2lsbCBoYXZlIHRvIGJlIHJld29ya2VkIGFueXdheSB0byBzdXBwb3J0IHRoZQ0KPiA+ID4g
dGhpcmQgY2hhbm5lbCBvbiBSLUNhciBWM0hfMiwgYXMgIm4gJiAiMSB3aWxsIG5vIGxvbmdlciBm
bHkgaGVyZS4uLg0KPiA+DQo+ID4gQWdyZWVkLiBXaWxsIGludHJvZHVjZSBybmNfZmllbGRfd2lk
dGggdmFyaWFibGUgaW4gc3RydWN0DQo+ID4gcmNhcl9jYW5mZF9od19pbmZvIGFuZCBTaW1wbGlm
eSB0aGUgY2FsY3VsYXRpb24gdXNpbmcgdGhlIGZvcm11bGEgKDMyIC0gKG4gKyAxKSAqIHJuY19m
aWVsZF93aWR0aCkuDQo+ID4gV2hpY2ggd2lsbCB3b3JrIGZvciB0aGlyZCBjaGFubmVsIG9uIFIt
Q2FyIFYzSF8yIGFzIHdlbGwuDQo+IA0KPiBOb3RlIHRoYXQgeW91IHN0aWxsIG5lZWQgdG8gbWFz
ayBuLCBhcyBuIGNhbiBiZSB1cCB0byA3IChvbiBSLUNhciBWNEgpLCB3aGlsZSB0aGUgcmVnaXN0
ZXIgaG9sZHMgb25seQ0KPiAyIG9yIDQgdmFsdWVzLg0KDQpPSywgd2lsbCBhZGQgc2VwYXJhdGUg
cGF0Y2ggZm9yIGZpeGluZw0KDQotI2RlZmluZSBSQ0FORkRfR0FGTENGRyhjaCkJCSgweDAwOWMg
KyAoMHgwNCAqICgoY2gpIC8gMikpKQ0KKyNkZWZpbmUgUkNBTkZEX0dBRkxDRkcoY2gsIG4pCQko
MHgwMDljICsgKDB4MDQgKiAoKGNoKSAvIChuKSkpKQ0KDQpXaGVyZSBuIGlzIGdwcml2LT5pbmZv
LT5ybmNfcGVyX3JlZy4NCg0KYW5kIFNFVFJOQyBpcyBzaW1wbGlmaWVkIHRvDQoNCiNkZWZpbmUg
UkNBTkZEX0dBRkxDRkdfU0VUUk5DKGdwcml2LCBuLCB4KSBcDQogCSgoKHgpICYgKChncHJpdikt
PmluZm8tPm51bV9zdXBwb3J0ZWRfcnVsZXMgLSAxKSkgPDwgXA0KLQkgKHJlZ19nZW40KGdwcml2
LCAxNiwgMjQpIC0gKChuKSAmIDEpICogcmVnX2dlbjQoZ3ByaXYsIDE2LCA4KSkpDQorCSgzMiAt
ICgoKG4pICUgKGdwcml2KS0+aW5mby0+cm5jX3Blcl9yZWcgKyAxKSAqIChncHJpdiktPmluZm8t
PnJuY19maWVsZF93aWR0aCkpKQ0KDQoNCkNoZWVycywNCkJpanUNCg==

