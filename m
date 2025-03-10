Return-Path: <linux-can+bounces-3034-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BFA58F9D
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 10:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5910C188FDAB
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52F22539F;
	Mon, 10 Mar 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NW+BBxdv"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011047.outbound.protection.outlook.com [52.101.125.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA121D599;
	Mon, 10 Mar 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598900; cv=fail; b=H4mSWAqWLzvPQ/rlIx1oWb4IWFQAco1BnlEW5e0Spf/6fcXUc9HBQmUZyzbGdeJs7gDxbbdApVoW9QNu8/Qci0bwJ4RKwcn59O/0pd2my+WjlcVrBP9NmVOQreCyJZL5gRiNBL98xPVPgCdtzzDfzYsGuQmoy7L89haI4QUxFUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598900; c=relaxed/simple;
	bh=mMxHqP+x5uo9taKn9G+xW8HlEbF2D3CfAWojjCExsWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Njq8pAagB1NLWA/RWFaLchqb3bvYDLwr8J4YFCoVB2SJyNLsadzbh4mqzzzlbSVQPfSc4awdvgACnWOxn/QoghwcZwGYo6Aa3xNIK7JxTmAZ2waxRguTehMgnNx3NUqWLImdZ2iscfvxE19PblunzcPXkZimbiXvYboh3os3Y5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NW+BBxdv; arc=fail smtp.client-ip=52.101.125.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOV+Iz5YKb2HN2FhEzAPyHaTsDdqi072r8eqcEF3gsYu6eNVFChTN4I1VHHhfvuTuLNRPakUSag1oqlOubWK4Keu3eFqOLPHESKMlqghSL78qtXsH0QyhUJSMXGzi0BvwHjquW3hlBuzFwwCRyNKd/TiriPPf9rf8AG6kY56+6hQ2TmBobXbIz74oBt8JTARKTtxwIcNWm6kqu7UXRfykhoZhNF+l0k29d9z5u10xwN+Ns7PSf6ZmXoV0JqJm4uE3Og7baGDGGualXfZk0+26JOY3h0K98s9XHbbeFmfivcsWatuQLt1qWsZgOGcoA1ONE13LUH1aD1SOAsv49L1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMxHqP+x5uo9taKn9G+xW8HlEbF2D3CfAWojjCExsWU=;
 b=Dgl9Gtm1ipOH9fQFFbmc0tn5du1n0SlJkHdzcox0ijEgRbuhkJB4BTpZnYe8UVHgZQERunIvBz0jS0tMd3/yZRkm2/WfVIvRzGf+dkcq2Mrg7A8XfjVQ57Mf9PpNjmqiEm+dEp1Ku3TTUAmjiEw4zXl6Aj76ugbLalPzWATvDpwNGZ4fVYUa1iAzCS53hNEsvoa3MC8Bc30l0zI3iwwkiwOzmlbJKnpVEOD8QK8LIp2qZnnXAfu0SNGiKJ7WqluivzgLtyW1/MP1iGeKJ0VvseszKXUI1/APsU+xoRHRbcn6DVX28GIbXMuyQaCRcsh54Za4N9cggOua8TyaQd2Elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMxHqP+x5uo9taKn9G+xW8HlEbF2D3CfAWojjCExsWU=;
 b=NW+BBxdvDyi+uRv9S5tdGUJStd8I8YvsgIB29w5bw9YRFMQTsC2QW1nLNC4SWFlAQc8Rzw6luV+edi/r6SojX/zwYaC9K16LuB4edhWYotGUHd7IQsuopVc8pDF/nLgugJPuQFue1M0uT01Pt1IwFSxl57V51w50i4U9uv4yiW8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB8107.jpnprd01.prod.outlook.com (2603:1096:604:166::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:28:14 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:28:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Rob Herring <robh@kernel.org>, Ulrich Hecht
	<ulrich.hecht+renesas@gmail.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
Thread-Topic: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
Thread-Index: AQHbg3wwxySbXtRqN0i0VotwnX4XtLNn1ygAgAEFZsCAA1LPAIAABSPA
Date: Mon, 10 Mar 2025 09:28:11 +0000
Message-ID:
 <TY3PR01MB11346B8F2576A85B0006B9D6986D62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
 <TY3PR01MB113462D6EF7BDDFE403FD0DC286D42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUyLLCdTHkhFJh9rK7Vv5S98anw8-Cc51MafzQ5DF+V_g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUyLLCdTHkhFJh9rK7Vv5S98anw8-Cc51MafzQ5DF+V_g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB8107:EE_
x-ms-office365-filtering-correlation-id: e9093408-8c9c-43ef-b060-08dd5fb5e07a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eC91Z0s2ZVBvTy9JNmtVTk9TbTRhdFg2bXp4NXJHU2JIQWYzZElJakNGWXVX?=
 =?utf-8?B?L0J5djNVd0RZUVBiQzBuQzlVbjcwMy9qUG1CaWNtMERGQlE3N2NWL0dzWk1o?=
 =?utf-8?B?ZTludnVrd0x4Mis4dzVmL1lkQ09MNWhxUFJSbDNmTEtMUUJwbTVXZThFRzNw?=
 =?utf-8?B?Tk83NW5uTnBtUC9HcGc1dVh3L2U0TGVVZjAvYlZaUFNtbUxDQnRWNS91bU5q?=
 =?utf-8?B?OGZXRSs4cGNiZnNTMktYZXFqSDM0OEFNWG9oc0dQdllvVC9tUitTeDRZR0Nn?=
 =?utf-8?B?U3NVYk9yT2orZEVHZ24velp4UmNjeG4xZTJjM2RTVkNhUG9PazM4Rk9CdGh4?=
 =?utf-8?B?Qzc1bVA3R1M2ckQ5Vmp4Skd5citHZW5VUEwxQ055b0pncmNCcFJvckpvVXhw?=
 =?utf-8?B?OVJNbGRJSU45elBnSTF0T0FvRGM1bFhGME9nK0lTQ0lqZVA3NzUwL2FBYzZG?=
 =?utf-8?B?YStKR2JEVDR0eHlkaGxkU1IrVFpOQW9kNDhGeHNUdWhlbUVNRFNhUWFhS0w5?=
 =?utf-8?B?Zms0eXd2N1ByOVlibVlQeEgwc0taNFhpTDh2VUhDZExNMjUzRzNVb2xScUdI?=
 =?utf-8?B?ME9IelpvNDhDN2FaRmprV3hqczRFWU1HZ21VSDJyWTgwb3MzeGlpZXNpSWxR?=
 =?utf-8?B?TG9ZN0duY0dsYnlnSkNkQ3U1RFpDV1J1OFI2ZkF0NXJFTEpsdEMyaEtzR2xH?=
 =?utf-8?B?SC84aUFzTW9sTFBsY1c5Qis0L3ZyWnVtdUhQZDgybjlIN1hDeDNsRkxGUU13?=
 =?utf-8?B?R1ZYOW1RR0d4a1JrWXRUSlFENWRyMURBeFIvMkIxazQvcDFSVWdCV0owSkps?=
 =?utf-8?B?czlZWWJLKzh4M3hUUzYrQmc0d0thVjE5cDNNUGlFTlh6NlRjWGlJTll5QUJv?=
 =?utf-8?B?L2JHdXl2YXRQNnJjQU9DdVd2NlFtWnNyQmZudngwWnBXS3M3c1VqS0ZhaENT?=
 =?utf-8?B?dkg2WktKTW9WMUpPWDZ4TWpvOG5wZkhreUhQYmtLMVhLK3g4Q1VJK2FzdUJl?=
 =?utf-8?B?alYwSkx4U1NteTkrUmpTVFYvKzBneFQ0SmRDdm1WeHZwdkFON3Q3NThoZUVU?=
 =?utf-8?B?ZnBtL3pudnNUY2ZmZmJBNExRYzBzLzUvc2FEWE5OYm54NkZkZmlBUHZBSmNs?=
 =?utf-8?B?c3pWM2VzbExpQ2FvWGpjWm41ZEZYWUMvUXJTcTAyUWNXQ0NzOGtmeS9nOTRV?=
 =?utf-8?B?a1o5ZExRVGhZTkRFNS9vUEc4YU9laGNXaVNpSnM5WmRMd1crSVBLMHhTczA5?=
 =?utf-8?B?TmpYbHZPKzNoajVWdVpxZGg1QmVzRmpRWjNxMDBWcWhNZmRzS2tuOGpLMmli?=
 =?utf-8?B?NlpZdDM1S3hwME5FUjVGY3Vpa2pZMGl4c1NnVWVCQkFObXk0SnFaMzdKcDVx?=
 =?utf-8?B?Y0h1NVkwZkJRclNZM2lEZzE4dmpBTSttK0xhSk9YRVVXTGluT0xWMHB3dEQx?=
 =?utf-8?B?d0thRTFSOGMzb2dmSmltU1Q4ZnoxL2x0b2RnTnNtM2ZHUXdpMW9YeW1wZ0ZR?=
 =?utf-8?B?aVFwSTBlVG9iTnZQbGlERFpmSUQ4Z25BS2s5VmVyYk1sWjRIenVFcWVvR2pz?=
 =?utf-8?B?VHF3R0txOERHU0swbXNLWWFBWTh3aE1sTkJYcEl6Vjd3NGdJUys3TUtiVDR5?=
 =?utf-8?B?alZmL0ZFTWdJSTZyeHp2bm1BNk1PU1hpZXoyS2ZicjlhbExkSUordTArR2xX?=
 =?utf-8?B?MnpQL1dhZDNtQXlUUTc2Ym1ucmMvQ3pXSm1EdVpxOCs4NGxvVFVCdldMQUk2?=
 =?utf-8?B?WTVBWEJnU2lxdW16cmRqUndIeXUxU1hWTlpOL3VTMTVBeTdmYkpNOUxCNnlj?=
 =?utf-8?B?Ymx5bHk2d0NJOWMxOGZoeVpvYUExdWVmcG9WWDU3bzU3aDNzdGRnS09vS0NV?=
 =?utf-8?B?ZkJkR1NGdGNUYXBlMDRoem4vWlI4RFNTS3kwSjNhdG1LdEJvdTI5Y0FIbjZS?=
 =?utf-8?Q?wjnJ40vqN1m3E/XJzk6UxFkLR9LhMRD9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVNYZ0JyZ2I1NHA2ZVQ5b3VDRGU0VjJ5eDBqNjRTemlQYk9KcWl1VzNMNmtN?=
 =?utf-8?B?RGZOWUFmcmJPa0FvWEc3Zk1HK0orS0x0QU11Ky90ZGxVb2pxdzQ2M0pKMGlW?=
 =?utf-8?B?OXZUSXRoK1BHVTVTek4rcVM0T2MzT0YwdEFkYVZOR3lDT2krWTlqb08rR2pu?=
 =?utf-8?B?SjFVU2djZm5DY3VyWHNuRFJPcysxWHNyYWc0MkUxVzkxeUpoUkV5Qm9OMUZJ?=
 =?utf-8?B?ZWpNNVJqdEhHM3d3bkF3YWc4ajJlc2JXS3FTd29xM29UbUdwMWY4RFhyL0M2?=
 =?utf-8?B?YldhaEp0SEhkcUFJVTVXSEg4NTZKY000VEVzKzg0VVBzT1ByYS9ML1pESUI3?=
 =?utf-8?B?WStMaUZZUndrTTNLM2c2WVpxSmt4bENtRVQ5dzhla05uOXUrKy9aejNFV3pw?=
 =?utf-8?B?clVndDZiME1aZWtNbmV1enErOGhxY1U4TExQWlNkdFVzRW1KeXJDSllmMEQz?=
 =?utf-8?B?NG8wWDBGaEZNK3g0ZktwN2hvU1h5VEt1RzMxWFpWWWFtTURtS3BrZkhXTEVF?=
 =?utf-8?B?Ny92YTBkbThjLzJ5NnBpR0J2bTFzVVJlTk5yRkhpdWhuYzc0MXVuVzBGTHpC?=
 =?utf-8?B?VTQ1bGNRa0VxRGc2b2FEbS8xZzYvRVpNWXFQbjV3aTNnOUZqSU1rci82Yzl6?=
 =?utf-8?B?WUhnYUJlMzZjNXNOM1VUV0diMGJ3MXJTQmhNOE8vcEZ6QVprVll1Y3FydXFQ?=
 =?utf-8?B?WG1HeENLYWZmYU94OFBxZGMxQXpzc0p3Z2pqbVByeW9VbmQzMGw3dXVPWC9i?=
 =?utf-8?B?bVFZQ1dTcXkySWxTWjRLcWg4ejhibkYrcU80VXV3OEVmWjVKWXE2cEVTUGMv?=
 =?utf-8?B?Y0VBT2wySHJkY1MvT2xuVllxdkYreWRWZlFIM2k1M25rK2x1dDMzRy9yUm9x?=
 =?utf-8?B?OEp1dHliRnRPeVNvZVEyeXRVeVQ2Q2liWjNWdTV4TGR1Q1VFTWVFRjUxNkpC?=
 =?utf-8?B?UDdCOHZrTGw2T1pxMUdqd0dMaGRFZFZWQnJVOTVMVXRNOHM1eGc3aDNlRVpp?=
 =?utf-8?B?U01SL2N0dU5jaHo2TjNSY3ZYaW9rR2VMb05mVjNoR2RXZGV5dFd0cmpLWnM0?=
 =?utf-8?B?aUVTVEsrL1BDblVRVm92b3BxcEE4TnhiajZMbnA3VFBnQzBrdDRDU3NSUmRY?=
 =?utf-8?B?bkZ0QVdJekZOUzJBSDhiNm13aFhnU2R0Rzlvb2Q5VUJEOFZFak9VbGVYRElp?=
 =?utf-8?B?Zzc0dTRTQml1OU9VNFRTZzRnMkwxaTVLeDVMYnlwc3EzaW1HbTdSSVFIVVhN?=
 =?utf-8?B?YXhvVFljb2IyRUpmUTBYUW1MZmd0dS9lSDQ5ZlVMaGkxb2d1YlhHeEZLMjlF?=
 =?utf-8?B?TTFCOWFET0Zra1NIaU42K2J2eUtVeDZMcE04ZWdkSWpNUkNhTzF3NjFjbUFl?=
 =?utf-8?B?clVRd0RVbWpVYk5lS0lLZGpFWWlSS2hPQkxmekVBMlNRTkF2TFFQOXNwOW4y?=
 =?utf-8?B?U2VCL2oxK3VCUElqM0RSdDBxbFNscmlnSk5MR3ZwMWNqNUlZT1p0S203RmtH?=
 =?utf-8?B?UHA5Ri94UjBDTk1URjhnWnJMdUxjTHA3UkRJQWgxZDhPSVlFNW8yVEdaUDAv?=
 =?utf-8?B?RVU2WnFMU3k3VVU2YXpyNFhSSWkrK0duMnNxUDlDZjlqL2dFT1ErdURnS2Nh?=
 =?utf-8?B?MkZ4K0tSRkg5dm1YMElzVTZwS1pMbW9NemJsZmZMeVhYbm9CV0xXRW1XYmhR?=
 =?utf-8?B?L1MyME5rV2RMVk5lazFHclJENFNYZGtmd1h2UWlHdkFVc1BHOUJrbTFoNWpj?=
 =?utf-8?B?TmV0Y3FTVVhZUjBQRXpxeXkwdm4yVHBnQ3pXVGFyY1ZtVXlQa3VOa0RaYk1j?=
 =?utf-8?B?OHZjRktuSk5ZR2VCcEtxUVFaMnM1RXd3cmZROE5zSlJ0Ym91ZldkRSsxL29x?=
 =?utf-8?B?SlJJVkg0UXhGQzVXNkxIbmdzSlZiSEpSNXpYdUxXU2J6WG5YOUUzNTZUS3hX?=
 =?utf-8?B?TU1iaC9uN25zb3ZQdThvTGtUaXN0dUp3TnpBYmY4eWdlbHZWUG9lWktXRjRP?=
 =?utf-8?B?eTJmVUMyNnFKQTc5RmxNNDNqNVhEUGJxMEEwNmk0NmpaemlUUFF4U2NINWRz?=
 =?utf-8?B?cmxrN1FaOGJzMmtNRmJCZjBBQXo4bHRIZDAwQzhDYWpQbC9zOGFVMG5Ib050?=
 =?utf-8?B?aHBPRDF1d21IM0M0K2RmZlFZMlF5VHJNVHZuNGs0dXErUjFwRzM3TVlEejZ0?=
 =?utf-8?B?K1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9093408-8c9c-43ef-b060-08dd5fb5e07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 09:28:11.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t13oF3MJCSngnGUWNSGpQHb0MLt5KlLcdhC9aIHhH/D6lOL668eHBtKSAJSwqqmh+DqS1Caf8A2yurb7fs6AiSGtMfi0XZdCSjDKLkCqbac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8107

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDEwIE1hcmNoIDIwMjUgMDk6MDMNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAyLzJdIGNhbjogcmNhcl9jYW5mZDogRml4IHBhZ2UgZW50cmllcyBpbiB0aGUgQUZMIGxp
c3QNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBTYXQsIDggTWFyIDIwMjUgYXQgMDc6MzAsIEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIDIvMl0gY2FuOiByY2FyX2NhbmZkOiBGaXggcGFnZSBlbnRyaWVzIGlu
IHRoZQ0KPiA+ID4gQUZMIGxpc3QNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIDIwIEZlYiAyMDI1IGF0
IDEwOjQ1LCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+
ID4gPiBUaGVyZSBhcmUgYSB0b3RhbCBvZiA5NiBBRkwgcGFnZXMgYW5kIGVhY2ggcGFnZSBoYXMg
MTYgZW50cmllcw0KPiA+ID4gPiB3aXRoIHJlZ2lzdGVycyBDRkRHQUZMSURyLCBDRkRHQUZMTXIs
IENGREdBRkxQMHIsIENGREdBRkxQMXINCj4gPiA+ID4gaG9sZGluZyB0aGUgcnVsZSBlbnRyaWVz
IChyID0gMC4uMTUpLg0KPiA+ID4gPg0KPiA+ID4gPiBDdXJyZW50bHksIFJDQU5GRF9HQUZMKiBt
YWNyb3MgdXNlIGEgc3RhcnQgdmFyaWFibGUgdG8gZmluZCBBRkwNCj4gPiA+ID4gZW50cmllcywg
d2hpY2ggaXMgaW5jb3JyZWN0IGFzIHRoZSB0ZXN0aW5nIG9uIFJaL0czRSBzaG93cyBjaDEgYW5k
DQo+ID4gPiA+IGNoNCBnZXRzIGEgc3RhcnQgdmFsdWUgb2YgMCBhbmQgdGhlIHJlZ2lzdGVyIGNv
bnRlbnRzIGFyZSBvdmVyd3JpdHRlbi4NCj4gPiA+ID4NCj4gPiA+ID4gRml4IHRoaXMgaXNzdWUg
YnkgdXNpbmcgcnVsZV9lbnRyeSBjb3JyZXNwb25kaW5nIHRvIHRoZSBjaGFubmVsIHRvDQo+ID4g
PiA+IGZpbmQgdGhlIHBhZ2UgZW50cmllcyBpbiB0aGUgQUZMIGxpc3QuDQo+ID4gPiA+DQo+ID4g
PiA+IEZpeGVzOiBkZDNiZDIzZWI0MzggKCJjYW46IHJjYXJfY2FuZmQ6IEFkZCBSZW5lc2FzIFIt
Q2FyIENBTiBGRA0KPiA+ID4gPiBkcml2ZXIiKQ0KPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+ID4N
Cj4gPiA+IFRoaXMgZmluYWxseSBmaXhlcyBDQU4yIGFuZCBDQU4zIG9uIHRoZSBXaGl0ZSBIYXdr
IGFuZCBXaGl0ZSBIYXdrDQo+ID4gPiBTaW5nbGUgZGV2ZWxvcG1lbnQgYm9hcmRzIGJhc2VkIG9u
IFItQ2FyIFY0SCB3aXRoIDggQ0FOIGNoYW5uZWxzDQo+ID4gPiAodGhlIHRyYW5zY2VpdmVycyBm
b3IgQ0FONC03IGFyZSBub3QgbW91bnRlZCksIHNvDQo+ID4gPiBUZXN0ZWQtYnk6IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4NCj4gPiBUaGFua3MgZm9y
IHRlc3RpbmcuDQo+ID4NCj4gPiBTbywgdGhlIGZpeCBub3cgd29ya3Mgb24gMyBkaWZmZXJlbnQg
Ym9hcmRzIHdpdGggY2hhbm5lbCBudW1iZXIgPiAyDQo+ID4gUlovRzNFIFNNQVJDKDYgY2hhbm5l
bHMpLCBXaGl0ZSBIYXdrIGFuZCBXaGl0ZSBIYXdrIFNpbmdsZSBkZXZlbG9wbWVudA0KPiA+IGJv
YXJkcyBiYXNlZCBvbiBSLUNhciBWNEgoOCBDaGFubmVscykuDQo+IA0KPiBOb3RlIHRoYXQgb25s
eSBjaGFubmVscyAwLTMgYXJlIHRlc3RlZCBvbiBXaGl0ZSBIYXdrLCBhcyB0aGUgbGF0dGVyIGhh
dmUgbm8gdHJhbnNjZWl2ZXJzIG1vdW50ZWQuDQo+IA0KPiBOb3RlIHRvIHNlbGY6IHRlc3QgY2hh
bm5lbHMgNC03IG9uIHRoZSBDQU4gYm9hcmQgY29ubmVjdG9yLCB1c2luZyBhIHRyYW5zY2VpdmVy
LWxlc3MgYnVzIGZyb20gU2llbWVucw0KPiBBcE5vdGUgQVAyOTIxLg0KPiANCj4gPiA+IFVuZm9y
dHVuYXRlbHksIGl0IGRvZXMgbm90IGZpeCBDQU4yIGFuZCBDQU4zIG9uIHRoZSBHcmF5IEhhd2sg
U2luZ2xlDQo+ID4gPiBkZXZlbG9wbWVudCBib2FyZCwgd2hpY2ggaXMgYmFzZWQgb24gUi1DYXIg
VjRNIHdpdGggNCBDQU4gY2hhbm5lbHMuDQo+ID4NCj4gPiBRMSkgRG9lcyBpdCB3b3JrZWQgd2l0
aCBkb3duc3RyZWFtIEJTUD8NCj4gDQo+IElJUkMsIGl0IGRpZCBub3QgYXQgdGhlIHRpbWUgQ0FO
IHN1cHBvcnQgZm9yIFItQ2FyIFY0TSB3YXMgdXBzdHJlYW1lZC4NCg0KTWF5YmUgd2UgbmVlZCB0
byBjaGVjayB3aXRoIFItQ2FyIEJTUCBwZW9wbGUgdG8gY29uZmlybT8gTGV0IG1lIGNoZWNrDQpp
bnRlcm5hbGx5IGZvciBjb250YWN0IHBlcnNvbiBvZiB0aGUgUi1DYXIgVjRNIEJTUC4NCg0KPiAN
Cj4gPiBRMikgRG9lcyBpdCBieSBjaGFuY2UgaXMgaW4gc3RhbmRieSBtb2RlPw0KPiANCj4gWW91
IG1lYW4gdGhlIHRyYW5zY2VpdmVyPw0KDQpZZXMsIGZvciBzb21lIGJvYXJkcy4gd2UgbmVlZCB0
byB0b2dnbGUgR1BJTyB0byBtb3ZlIGl0IGZyb20gc3RhbmQgYnkgdG8gbm9ybWFsIG1vZGUsIHNv
IHRoYXQgaXQNCmNhbiBzdGFydCBjb21tdW5pY2F0aW9uLg0KDQo+IEFsbCBjaGFubmVscyBidXQg
Y2hhbm5lbCB6ZXJvIHVzZSB0aGUgc2FtZSB0eXBlIG9mIHRyYW5zY2VpdmVyLCBhbmQgc2ltaWxh
ciB3aXJpbmcuIFRoZXJlIG1pZ2h0IHN0aWxsDQo+IGJlIGEgcGluIGNvbnRyb2wgYnVnLCB0aG91
Z2guDQoNCk1heWJlIGNoZWNraW5nIHdpdGggQlNQIHRlYW0gd2lsbCBjb25maXJtIHRoaXMuDQoN
Cj4gDQo+ID4gUTMpIERvZXMgaXQgd29yayBpZiB5b3UganVzdCBjb25maWd1cmUgc2luZ2xlIGNo
YW5uZWwgYnkgY29ubmVjdGluZyB0byBhbiBleHRlcm5hbCBDQU4gZGV2aWNlPw0KPiANCj4gSGF2
ZW4ndCB0cmllZCB0aGF0IHlldCwgc2FtZSBmb3IgbG9naWMgYW5hbHl6ZXIuDQo+IChiZWZvcmUg
dGhpcyBwYXRjaCwgdGhlIGxvZ2ljIGFuYWx5emVyIHNob3dlZCB0aGF0IGNoYW5uZWwgMiBkaWQg
bm90IHNlZW0gdG8gd29yayBhdCBhbGwsIGFuZCBjaGFubmVsDQo+IDMgd29ya2VkIGZvciB0cmFu
c21pdCBvbmx5LCBidXQgdGhhdCBpbmZvIHByb2JhYmx5IGRvZXNuJ3QgaGVscCBtdWNoIDpeKS4N
Cg0KV2hlbiBJIHRyaWVkIHdpdGhvdXQgdGhpcyBwYXRjaCBvbiBSWi9HM0UsIHVzaW5nIDEgY2hh
bm5lbCAoIGRpc2FibGluZyBvdGhlciBvbmUpIGFsd2F5cyB3b3JrZWQuDQoNCj4gDQo+ID4gUTQp
IGlmIHlvdSBhcmUgdGVzdGluZyBpbiBsb29wYmFjayBtb2RlLCBpcyBmYWlsdXJlIGhhcHBlbnMg
Q0FOMi0+Q0FOMyBvciBDQU4zPkNBTjI/DQo+IA0KPiBGYWlscyBpbiBib3RoIGRpcmVjdGlvbnMu
DQoNCk9uIFJaL0czRSBTTUFSQywgd2l0aG91dCB0aGlzIHBhdGNoLiBDQU4yLT5DQU4zIGZhaWxz
LiBCdXQgQ0FOMz5DQU4yIGlzIG1pcnJvcmluZyBtZXNzYWdlcywgYW5kIEkgcmVjZWl2ZWQNCjIg
bWVzc2FnZXMsIHdoZW4gSSBzZW50IDEuDQoNCkNoZWVycywNCkJpanUNCg==

