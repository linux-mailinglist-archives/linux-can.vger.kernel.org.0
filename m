Return-Path: <linux-can+bounces-3151-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8FA672AF
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 12:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB213B46CD
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5420A5D7;
	Tue, 18 Mar 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ERGJF0ON"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011057.outbound.protection.outlook.com [40.107.74.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5491209F5C;
	Tue, 18 Mar 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297224; cv=fail; b=n6OTkoQnIIzpO8keKsqAAKzNoUsGccqbbvs6OCEDNVM0fcF6Y77jR9SijrHzsGa73vgz9opug/DAqasK8AkMhHHcpII1RGPWR+7Q6XKdHE4pQleN8C+6a0z4nZVZxvHAJoforv5Nyg1kFc4FJBqHFefWJS9mZ0iQTJStfJLHR34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297224; c=relaxed/simple;
	bh=eEbOMLllF43ZSA+DzMI0iHgKRl3ovFVGhSK4AqHZ4KM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gkSbj82ZSCbPcEVhshXIiYWjwq+5nn1rxGLZBvjwEikfP5Rx3pv/ESmOcI0qUszx4Fe9dYm4hWyNir0JW/RK0wQrE9QNhQFhpK2tOliwcqVhdWsM8KGXwHNyphmvY2Jitctnkcbe6sdixvCAiVozBvqbiKueAoo53g5gCZIAzas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ERGJF0ON; arc=fail smtp.client-ip=40.107.74.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upRnZeqxx+Rwl9RoT3h0+Gv3qRKmLW9o3N74fGOmDaM8UwmEZ0o3VFx8Zi4CBT43hXYCzC9sdrRxm1fsXgoRa+jCmRhoE9J3fLubhRW4U/M0U2DOVqM3DRf6enZ1Cfv+BmaG4zhc8cdbGOI/2XZqxAedKobez0P261Ly0m0fR7/bV6xOfngZDjlFqkv/FECcsOPi7BSOuanKycekH+YblAWQbtfyNJIGgE+VqlbHOh1UhvLYHaJXAgbegHoVz6eDDSKni3n+4+TuwaWd4HIqRBk6cS3WD4o2EpSO+i+pRqqqbyiQQv6MmKhZ8xOnPOFaHX7mk2b0pvLajSN1GcEEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEbOMLllF43ZSA+DzMI0iHgKRl3ovFVGhSK4AqHZ4KM=;
 b=L6BBO9CAE6+Yka6UxqHzcYvW9ifQng2qxw3/EbDgilcFxKdDfC+nESKj+JyLf6GgTrBlFAX6VKCijWPvmIJjmB/2JLQaFr/+PXmEIOxQQIZklTmC8+pAmZB9SE+pQ82rLGvsV80tHwaLQ07eBRt62rDJC1jBeNAQvVGKMQE1jGS1nQV36zsL7Ik/0E3b32hmv75IvAFpz+d9TQzHzI/BzR94LcMo0Blb9xqdnvCetVR+VldA+CJD0GYGpxsjUlRPwmN9Vo8+DlTT6j3FQdujbvLdTxRNZ+/6n6SgJxdWX6lr+AjsjM8N1DN80uUdjHHA4zUtwoYeFtzXxJbdBY8Fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEbOMLllF43ZSA+DzMI0iHgKRl3ovFVGhSK4AqHZ4KM=;
 b=ERGJF0ONPRDsxsIr39u1DZjAqfIgK40KneHN16HdIpE2f/i5qwI3ALRfLatvMHxzCkrbB8kiiuUC9MNDEh5wpzoQr10AXfmy8QobeD1fQ8JA+bPyJWrnk6UeEfBJV4TvD3FfeGAZ4aTxnyBln3GO1T9BlLJwS0BKPmpPU/pQxrE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB14361.jpnprd01.prod.outlook.com (2603:1096:604:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:26:54 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:26:54 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Marc Kleine-Budde
	<mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Index: AQHblzlRqz9AKXyTHEGDaGzuM2Z5HrN3XvaAgAAGwaCAAAdpgIAAEBGggAEwseA=
Date: Tue, 18 Mar 2025 11:26:54 +0000
Message-ID:
 <TY3PR01MB113465F5D2C480EE3F0B47FA986DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
 <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
 <TY3PR01MB113466DCECC55DDE9913833F186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXbk8gqhd4FFGmFNQRrEwbOToQvr-00LE2pZWoZq65GGg@mail.gmail.com>
 <TYCPR01MB1133298C8595B3CA5D890289486DF2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB1133298C8595B3CA5D890289486DF2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB14361:EE_
x-ms-office365-filtering-correlation-id: a5c60b74-fe77-444e-dd83-08dd660fc97f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y09YcFI1MFdmdVV1NVE3Y2ovNHdqT0dYd1VEYWoyYkN5QVhWOEtNK0NmMW96?=
 =?utf-8?B?NUNoazZRZ3ROekZNNjV6QityVGpvQVhPWEpibHllL0Yzck41ZDloNHE5ck9h?=
 =?utf-8?B?TmVVS2pDUG10bmNKVG5LTDlUVzEvN1hVZXFTUGxNbW5kd013ZUZIdkhpRU1P?=
 =?utf-8?B?bFJSRG51MGtZMHk2c0ZiTURDcm56dGVFMDVIbHhQQWlyL1lqMzJ4OFRkYk1y?=
 =?utf-8?B?OHJwRS82QnpWdGIwNzhxR0NQRTF4TkJMOHMvRHlQTXZTZFZqSlR6V3ZFYlBo?=
 =?utf-8?B?OTFiZ3l3OENNekFYL2ZrVHIzOHN2NzJlbEFYU1Y4TGdBM0NDdkh5VlBqaGt3?=
 =?utf-8?B?ZGVaWDhvZllWR1p1cGFYdkF1bHJqbVA3Vm9DUTZsUERTWWpmWHV6dDJZQjlM?=
 =?utf-8?B?VXI4UnI5UXAvSjFzRi9XakVKVk5yK2pzenBDU0JVYzZMMjFKMzllTTA4THlt?=
 =?utf-8?B?SVkzSnBjN1BJSE9NbGwzSU04MWhWdWJCWWpBOU5GY05rVzlGd1h4dzJXb1Vx?=
 =?utf-8?B?RC9JZWFLQXJxa1hLRTIvWVQrMllmNlE5d21Jc3dnOTB4M2RFT3Nrd3ZNbkVa?=
 =?utf-8?B?eVp2L0JGYW4zWTNwQmFKcjh0L291SlNkUklSMGdaVEtQRjkrc1NYa0xnMlVI?=
 =?utf-8?B?dGJZWnpsdnZwWFBNazc3S1AycEJ2R0FwcEFWK3RiZHg1SVVsS1dWMFI1bWRx?=
 =?utf-8?B?V2ZkWHRvYzRnUzZkblYrdTBkRFZ2aHRMb1hqZ2laaDVuWXBubk5OREpnMlJl?=
 =?utf-8?B?UkZFTkNJdHdEOXlaRllDVW83cFF5amlOWHp4bnpmblhTa3FzdTBtNzhTeVFu?=
 =?utf-8?B?UWVyTUc4bjV4b2paWFIrczRLbXVVTHZMRFIwd1Yxc0F0OFBRS3MxVXpDNURU?=
 =?utf-8?B?UnFKUkg1am1teDNwSUExVkFSMGJaK2E3ckNleDNRV0ZzMWdzdHVrUjk5dHV6?=
 =?utf-8?B?T3B0NGdzWkUycXlMUjh4UCtla2ZRME90RDQvQWR3NXU2eDBmSXR5R3VsRzEv?=
 =?utf-8?B?UW5BYWRvd2xqRFN2T2RGcnRrUS9UbnpoVWN0KzN0K3N4VE5mTDNQMFVGL3Rz?=
 =?utf-8?B?eEsyejd0cGJWaGRlY3hWNmNJOE9aNUdKK0dOYnJCdE9nQmM0d3UyTmFvMHA3?=
 =?utf-8?B?dElyczFyQXFsb2JQbUQzbzJXWlFUdWVJRXl3bHVyelBzMjZ5MmxrMkFzZklo?=
 =?utf-8?B?akRyOGVrZnc1aDFtU0ZoK3ljaisvVUlBWEVOQzZLR2VzOVJkVXdMekVJSFZu?=
 =?utf-8?B?Q2tNSmdKUGNRVFE0WHl3bVJESWNlRTEvUHNQWGw4dHp6QTUzTTB6S1M3UXM0?=
 =?utf-8?B?anRSYTBjaUF4cWxla0lsM3BETitPYmptelM5eDI0UWVmS1BuK0JPSHRETWdI?=
 =?utf-8?B?S1JPQTlnVlg3cFJucEhCNU9WaFl2MkQ5dXZzLzdYV3JEM2ZDWUR0dnlQNXVW?=
 =?utf-8?B?UEIxWWRjMGtBc2FJZHI2NC9CR1JPUitPSVYyNXZwRFh5dWFpMDQ0RnlCVVRD?=
 =?utf-8?B?UDRvN1VreGJjNkFseHNRL0xOK2U1V2JoOElBUFFvVC81WWhESi9ZekIrc0h4?=
 =?utf-8?B?Qk8yREs2TnJFUXNmZGtkOG1SSngxeW1PWVVBYlRoVFdGTzQyOU5UcUk5NjJN?=
 =?utf-8?B?YTU1dVVLRXg3SmhEUW1QNTJWTVpMcXNSUUwyZmVjbENPdUNSa2hqK1pnd0x5?=
 =?utf-8?B?QzhUWXZBYkxCWVhvRHlhVjk3VGNQYXF6S1VrUldnZGpoQ2lzV0ZCZTByQjV5?=
 =?utf-8?B?QUxUeFZWR0NHK25UZzJmc0dqZmp2Vkt6RTFjZTd3UnBwRE1tV3NJVWRpOEJt?=
 =?utf-8?B?VWR0Vk50RjhyNkF5OUNCSW4wVXBqRkRsOVYyR25ualNnQ1VldWw4TXNyMGxS?=
 =?utf-8?B?YjU3WUFRQzZVQU1yaDdVOW4xb09oMlZhMytQcWlodWp5aStVTTA3TDBoeE5L?=
 =?utf-8?Q?PjJNaDYaRDT9UMLAcHDRH3g+Y3KP+G6o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1k0dVRtYUVvcE1hWVcwV2RHaVZpQXFvbmZseTYxWXdUb0x5VFNpeWxXQlBl?=
 =?utf-8?B?UmpPd0JmNTE1Uy9zRFFDMFNhblcyblBvSWlMeStvMnlLNk9yN2RSSzRJa0di?=
 =?utf-8?B?SDlSaHRYNmE0Q1JTTFFtT25SWU9KbktlU2NnZW52NUdFTm0xMWI0RGU1QTBy?=
 =?utf-8?B?NE9GSWlxV0dQMmN1UEVmbmlMNXNrTmRHTjcwc3VPa2prMGdmb2d5N2lYOE9W?=
 =?utf-8?B?dU5HM3FFVGhndGpuV0tkK05RSTRQYzdZa3d5R0hJR24yQ29DMzcwQm1YU1pq?=
 =?utf-8?B?a1pxUjdHTUpuZ2krL1l3dVUxdjVodUVzdEl2elc2dkt3QkpmSWpMQXZSYU5K?=
 =?utf-8?B?cXVuY3ZiaUJuWkZOU0I1RVRQbG9zRGdxMzVuMDVqV0JucVAxeWlBQ1BJZUVq?=
 =?utf-8?B?MTBoZGhwYzZDbUhvTXNXSjRKemxqK0o4VWIyejRYYktjbjVySHRaMEFoVFVS?=
 =?utf-8?B?SDNOd3pzV1lvY1pLS1NxUFMxcFJTbEdGdEVwSlk4TmJGcFY5WGNoZklHM1J6?=
 =?utf-8?B?NmRsMW1nSDFTNlkzRzRyU0V6UGFhNUR3SzArcWFuM3p0ZVl5SEt2VmtJRi9N?=
 =?utf-8?B?eFN2Y1JEdEVOZ0xMaVhkNEhYajltamlWcTEzSmswdWlYcmYvY2dSRU1nL1Qx?=
 =?utf-8?B?WVFQa1ByY2FSUVZ0alJZV3VGbWUvaWUyUTVpSnNvNmg2dVI3SXRMdEtLcmNi?=
 =?utf-8?B?NllCRHJVTmRzUlVtQ2hrL3VEVzY1M3Ntams5K09DVk0wQWJrWmRrdzgxWWln?=
 =?utf-8?B?bzhvZkZKVDVybHIyRmxPK0FJeEIvaVFIOEpmQmo2MTYxQ2c0U3ZQS1ZJSWxw?=
 =?utf-8?B?bjc3eitLcFRoYXBKZDZsZEhtbm4ycUFXN0hOaDRzOXJCN1U3MDRKNGZYeUpo?=
 =?utf-8?B?T1JiZG9qOGhSOUlTOU1EZFF6a0Z2Nm1oSUpORk4rNW1lUXNLTHBpWGlNbXA5?=
 =?utf-8?B?OG4rUkFHWEszMTZQWkxUdm5lSTZBdjlDNy8yMmtrT1FqUGhESTVLTHZ6cEtx?=
 =?utf-8?B?dHZmL01rMENCWjgxdERhZG5vKzdrWm5OVEsyYTV1dFh0Yk1icTc1bkJqdDhQ?=
 =?utf-8?B?WG5SMDdCUHdQTURDVFNzQU5oZEEwVW5OZ1FBWWFSWllLdXJYUUlLeDd6Sk5O?=
 =?utf-8?B?RWc1dmM0aDNDRmpRWUplMXowcjhuRStIcHVEbmFUN1QycEJzRmNiQ0R0REtJ?=
 =?utf-8?B?bkJiekY5V25aTElDa2xZSVAwUU91UmJNT1lZQUplazYvWEFmN0xqREoyTnN3?=
 =?utf-8?B?R1pQeTE4VkM2cFhUbi8rTEJScXBGU3JnUHJDVmRsK3dvZTlQcFRkWVRJZ2t6?=
 =?utf-8?B?YTF4VnlYKy9xM3Z4ek82Q2dUbU5XZEVhYWtqaTk2OXlQODY3YzlyZ1A5bHl2?=
 =?utf-8?B?WTg2eXJ1cmxkVUFMcXZVeUhiMUxWTFozcTNwRlFiVXBOSEdzS0o5YnE0QjBj?=
 =?utf-8?B?QnZ6MmZkdGNqQzVRQS9pSi82a0xEZEtxOVA1WllSekhvTzI2TGZpS3k4bmpt?=
 =?utf-8?B?REh4TWV0ckZoVTgwWTgwbFhlQlU5R01mcVk2aDl3ZFZNdlB0Q0lMK2NmRXQr?=
 =?utf-8?B?VDV5T2FPQXU3eFJIUjVYMTNaQURGM1gwWGVSQVk4SUZhbTBicHkwSXA1NVRv?=
 =?utf-8?B?a1FUNkN5cWpialc0WmlGTmgzcDhjaDZwOTBxNGVoUU4rK0FBMS95SWV3RDBP?=
 =?utf-8?B?dlJLN2pRaEFlN0dUMjFsTkxvZlkzcjlZdmNuVk9vRFF5VU9pQWhhWkYrcFhC?=
 =?utf-8?B?R3N5WXJjakIrdzhzaXFFWGVSTGNMalV2T1A5RkFPTTNLNHpuVzVGeWdlVzNT?=
 =?utf-8?B?Wjl2ZnhpYkdpZjR0cUNxWmh5N3ErbHBCYVpxakxjL1VTdTgxTUw4UXNFdlAw?=
 =?utf-8?B?bGVPSVB4akVnZ3lzaWxaay9FOGJqVWUxOUVhSENOenNGYlJ2ZXRwQTN1VmZk?=
 =?utf-8?B?RktKZlJtL3RQMlZ5T3B0N3huaTJ5eDJsd0huM3BPYlRUUkdITUZsV2dXZHJG?=
 =?utf-8?B?dEJ0Zmo1RlZqaEVZS2NmeURYMHZxK2Z0dzIrdStWaWtUZlFQb2pFdGZ5SFJR?=
 =?utf-8?B?Y0RDT3o2V0VPWWRvblM4VnZKZktrYVlsc0JwOWF4Ly8wSzV4Nm9KcmlDSzFm?=
 =?utf-8?B?a0V4eldKdDMySDlFQ3FMT1dJbE9ScnJudnEvWWMwZ0xQUzl1L2k4MnBoL3B5?=
 =?utf-8?B?VFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c60b74-fe77-444e-dd83-08dd660fc97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 11:26:54.7596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6FZrFXnUhz/4aRrpG90rKlY5XT4eqWt0PVEDHabYDrijQnq1xslqCiyZDpo8CE+VHlOCKsDvO26T6CAkjkquGu9M2VR6hsrhDF+0q9mnc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14361

SGkgR2VlcnQgYW5kIE1hcmMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQmlqdSBEYXMNCj4gU2VudDogMTcgTWFyY2ggMjAyNSAxNjoyNA0KPiBTdWJqZWN0OiBSRTog
W1BBVENIIHY1IDEyLzE2XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBtYXNrIHRhYmxlIHRvIHN0cnVj
dCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IEhpIEdlZXJ0LA0KPiANCj4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGlu
dXgtbTY4ay5vcmc+DQo+ID4gU2VudDogMTcgTWFyY2ggMjAyNSAxNTowNA0KPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjUgMTIvMTZdIGNhbjogcmNhcl9jYW5mZDogQWRkIG1hc2sgdGFibGUgdG8N
Cj4gPiBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvDQo+ID4NCj4gPiBIaSBCaWp1LA0KPiA+DQo+
ID4gT24gTW9uLCAxNyBNYXIgMjAyNSBhdCAxNTo0NiwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4N
Cj4gPiA+ID4gU2VudDogMTcgTWFyY2ggMjAyNSAxNDoxMw0KPiA+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY1IDEyLzE2XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBtYXNrIHRhYmxlIHRvDQo+ID4g
PiA+IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gPiA+ID4NCj4gPiA+ID4gT24gTW9uLCAx
NyBNYXIgMjAyNSBhdCAxMzozNywgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PiB3cm90ZToNCj4gPiA+ID4gPiBSLUNhciBHZW4zIGFuZCBHZW40IGhhdmUgc29tZSBkaWZmZXJl
bmNlcyBpbiB0aGUgbWFzayBiaXRzLiBBZGQNCj4gPiA+ID4gPiBhIG1hc2sgdGFibGUgdG8gaGFu
ZGxlIHRoZXNlIGRpZmZlcmVuY2VzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6
IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IHY0LT52NToNCj4gPiA+ID4gPiAgKiBJbXByb3ZlZCBjb21t
aXQgZGVzY3JpcHRpb24gYnkgcmVwbGFjaW5nIGhhcy0+aGF2ZS4NCj4gPiA+ID4gPiAgKiBDb2xs
ZWN0ZWQgdGFnLg0KPiA+ID4gPiA+ICAqIERyb3BwZWQgUkNBTkZEX0VFRl9NQVNLIGFuZCBSQ0FO
RkRfUk5DX01BU0sgYXMgaXQgaXMgdGFrZW4NCj4gPiA+ID4gPiAgICBjYXJlIGJ5IGdwcml2LT5j
aGFubmVsc19tYXNrIGFuZCBpbmZvLT5udW1fc3VwcG9ydGVkX3J1bGVzLg0KPiA+ID4gPg0KPiA+
ID4gPiBUaGFua3MgZm9yIHRoZSB1cGRhdGUhDQo+ID4gPiA+DQo+ID4gPiA+IEFsbCBtYXNrIHZh
bHVlcyBhcmUganVzdCB0aGUgbWF4aW11bSB2YWx1ZXMgb2YgdmFyaW91cyBwYXJhbWV0ZXJzLg0K
PiA+ID4gPiBIZW5jZSB0aGV5IGNvdWxkIGJlIHJlcGxhY2VkIGJ5IHRoZSBsYXR0ZXIsIGxpa2Ug
eW91IGFscmVhZHkgZGlkIGZvciB0aGUgUk5DIG1hc2suDQo+ID4gPg0KPiA+ID4gQnV0IHRoaXMg
d2lsbCBpbmNyZWFzZSBtZW1vcnkgc2l6ZSwgcmlnaHQ/IEN1cnJlbnRseSB3ZSBoYXZlDQo+ID4g
PiByY2FyLWdlbjMgYW5kIGdlbjQgdGFibGVzDQo+ID4gPiAyIHRhYmxlcyB1c2VkIGJ5IDQgaGFy
ZHdhcmUgaW5mbyB2YXJpYW50cy4NCj4gPiA+DQo+ID4gPiBJZiB3ZSBkcm9wIHRhYmxlcyBhbmQg
dXNlIHZhcmlhYmxlIHdpdGggbWF4IHZhbHVlcyBsaWtlIFJOQyBNQVNLLA0KPiA+ID4gdGhlbiB0
aGlzIHdpbGwgYmUgbGlrZSA0IHRhYmxlcyBmb3IgNCBoYXJkd2FyZSBpbmZvIHZhcmlhbnRzLCBy
aWdodD8NCj4gPiA+DQo+ID4gPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kaW5n
IGlzIHdyb25nLg0KPiA+DQo+ID4gSXQgZGVwZW5kcyB3aGVyZSB5b3Ugc3RvcmUgdGhlIHBhcmFt
ZXRlcnM6IGluIHRoZSAodHdvKSB0YWJsZXMsIG9yIGluDQo+ID4gdGhlIChmb3VyKSBoYXJkd2Fy
ZSBpbmZvIHN0cnVjdHVyZXMuLi4NCj4gDQo+IE9LLCB5b3UgbWVhbiByZXBsYWNlIG1hc2tfdGFi
bGUtPm1heF92YWxfdGFibGUsIHJjYXJfZ2VuezMsNH1fbWFza190YWJsZS0+cmNhcl9nZW57Myw0
fV9tYXhfdmFsX3RhYmxlDQo+IGFuZCAqX01BU0stPipfTUFYX1ZBTD8/DQoNClRoZSBiZWxvdyBw
YXJhbWV0ZXJzWzFdIGhhcyBtYXNrID0gbWF4X3BhcmFtZXRlcl92YWwgLSAxLg0KDQpJIHdpbGwg
dXBkYXRlIHRoZSB0YWJsZSBhcyBiZWxvdy4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGlz
IGFueSBpc3N1ZS4NCg0Kc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyB7DQotICAgICAgIGNvbnN0
IHUzMiAqbWFza190YWJsZTsNCisgICAgICAgY29uc3QgdTMyICpwYXJhbXM7DQp9Ow0KDQotZW51
bSByY2FyX2NhbmZkX21hc2tfaWQgew0KLSAgICAgICBSQ0FORkRfTlRTRUcyX01BU0ssICAgICAv
KiBOb21pbmFsIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAyIENvbnRyb2wgKi8NCi0gICAgICAgUkNB
TkZEX05UU0VHMV9NQVNLLCAgICAgLyogTm9taW5hbCBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQgMSBD
b250cm9sICovDQotICAgICAgIFJDQU5GRF9OU0pXX01BU0ssICAgICAgIC8qIE5vbWluYWwgQml0
IFJhdGUgUmVzeW5jaHJvbml6YXRpb24gSnVtcCBXaWR0aCBDb250cm9sICovDQotICAgICAgIFJD
QU5GRF9EU0pXX01BU0ssICAgICAgIC8qIERhdGEgQml0IFJhdGUgUmVzeW5jaHJvbml6YXRpb24g
SnVtcCBXaWR0aCBDb250cm9sICovDQotICAgICAgIFJDQU5GRF9EVFNFRzJfTUFTSywgICAgIC8q
IERhdGEgQml0IFJhdGUgVGltZSBTZWdtZW50IDIgQ29udHJvbCAqLw0KLSAgICAgICBSQ0FORkRf
RFRTRUcxX01BU0ssICAgICAvKiBEYXRhIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAxIENvbnRyb2wg
Ki8NCi0gICAgICAgUkNBTkZEX0NGVE1MX01BU0ssICAgICAgLyogQ29tbW9uIEZJRk8gVFggTWVz
c2FnZSBCdWZmZXIgTGluayAqLw0KK2VudW0gcmNhcl9jYW5mZF9wYXJhbWV0ZXJfaWQgew0KKyAg
ICAgICBSQ0FORkRfTlRTRUcyLCAgICAgICAgICAvKiBOb21pbmFsIEJpdCBSYXRlIFRpbWUgU2Vn
bWVudCAyIENvbnRyb2wgKi8NCisgICAgICAgUkNBTkZEX05UU0VHMSwgICAgICAgICAgLyogTm9t
aW5hbCBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQgMSBDb250cm9sICovDQorICAgICAgIFJDQU5GRF9O
U0pXLCAgICAgICAgICAgIC8qIE5vbWluYWwgQml0IFJhdGUgUmVzeW5jaHJvbml6YXRpb24gSnVt
cCBXaWR0aCBDb250cm9sICovDQorICAgICAgIFJDQU5GRF9EU0pXLCAgICAgICAgICAgIC8qIERh
dGEgQml0IFJhdGUgUmVzeW5jaHJvbml6YXRpb24gSnVtcCBXaWR0aCBDb250cm9sICovDQorICAg
ICAgIFJDQU5GRF9EVFNFRzIsICAJICAvKiBEYXRhIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAyIENv
bnRyb2wgKi8NCisgICAgICAgUkNBTkZEX0RUU0VHMSwgIAkgIC8qIERhdGEgQml0IFJhdGUgVGlt
ZSBTZWdtZW50IDEgQ29udHJvbCAqLw0KKyAgICAgICBSQ0FORkRfQ0ZUTUwsICAgCSAgLyogQ29t
bW9uIEZJRk8gVFggTWVzc2FnZSBCdWZmZXIgTGluayAqLw0KIH07DQogDQotc3RhdGljIGNvbnN0
IHUzMiByY2FyX2dlbjNfbWFza190YWJsZVtdID0gew0KLSAgICAgICBbUkNBTkZEX0FGTFBOX01B
U0tdID0gMHgxZiwNCi0gICAgICAgW1JDQU5GRF9OVFNFRzJfTUFTS10gPSAweDFmLA0KLSAgICAg
ICBbUkNBTkZEX05UU0VHMV9NQVNLXSA9IDB4N2YsDQotICAgICAgIFtSQ0FORkRfTlNKV19NQVNL
XSA9IDB4MWYsDQotICAgICAgIFtSQ0FORkRfRFNKV19NQVNLXSA9IDB4NywNCi0gICAgICAgW1JD
QU5GRF9EVFNFRzJfTUFTS10gPSAweDcsDQotICAgICAgIFtSQ0FORkRfRFRTRUcxX01BU0tdID0g
MHhmLA0KLSAgICAgICBbUkNBTkZEX0NGVE1MX01BU0tdID0gMHhmLA0KK3N0YXRpYyBjb25zdCB1
MzIgcmNhcl9nZW4zX3BhcmFtc1tdID0gew0KKyAgICAgICBbUkNBTkZEX05UU0VHMl0gPSAzMiwN
CisgICAgICAgW1JDQU5GRF9OVFNFRzFdID0gMTI4LA0KKyAgICAgICBbUkNBTkZEX05TSlddID0g
MzIsDQorICAgICAgIFtSQ0FORkRfRFNKV10gPSA4LA0KKyAgICAgICBbUkNBTkZEX0RUU0VHMl0g
PSA4LA0KKyAgICAgICBbUkNBTkZEX0RUU0VHMV0gPSAxNiwNCisgICAgICAgW1JDQU5GRF9DRlRN
TF0gPSAxNSwNCiB9Ow0KIA0KLXN0YXRpYyBjb25zdCB1MzIgcmNhcl9nZW40X21hc2tfdGFibGVb
XSA9IHsNCi0gICAgICAgW1JDQU5GRF9BRkxQTl9NQVNLXSA9IDB4N2YsDQotICAgICAgIFtSQ0FO
RkRfTlRTRUcyX01BU0tdID0gMHg3ZiwNCi0gICAgICAgW1JDQU5GRF9OVFNFRzFfTUFTS10gPSAw
eGZmLA0KLSAgICAgICBbUkNBTkZEX05TSldfTUFTS10gPSAweDdmLA0KLSAgICAgICBbUkNBTkZE
X0RTSldfTUFTS10gPSAweGYsDQotICAgICAgIFtSQ0FORkRfRFRTRUcyX01BU0tdID0gMHhmLA0K
LSAgICAgICBbUkNBTkZEX0RUU0VHMV9NQVNLXSA9IDB4MWYsDQotICAgICAgIFtSQ0FORkRfQ0ZU
TUxfTUFTS10gPSAweDFmLA0KK3N0YXRpYyBjb25zdCB1MzIgcmNhcl9nZW40X3BhcmFtc1tdID0g
ew0KKyAgICAgICBbUkNBTkZEX05UU0VHMl0gPSAxMjgsDQorICAgICAgIFtSQ0FORkRfTlRTRUcx
XSA9IDI1NiwNCisgICAgICAgW1JDQU5GRF9OU0pXXSA9IDEyOCwNCisgICAgICAgW1JDQU5GRF9E
U0pXXSA9IDE2LA0KKyAgICAgICBbUkNBTkZEX0RUU0VHMl0gPSAxNiwNCisgICAgICAgW1JDQU5G
RF9EVFNFRzFdID0gMzIsDQorICAgICAgIFtSQ0FORkRfQ0ZUTUxdID0gMzEsDQogfTsNCg0KWzFd
DQoNCkRTSldbMzowXSAwaCBEYXRhIEJpdCBSYXRlIFJlc3luY2hyb25pemF0aW9uIEp1bXAgV2lk
dGggQ29udHJvbA0KRmg6IDE2IFRxDQpEVFNFRzJbMzowXSAwaCBEYXRhIEJpdCBSYXRlIFRpbWUg
U2VnbWVudCAyIENvbnRyb2wNCkZoOiAxNiBUcQ0KRFRTRUcxWzQ6MF0gMGggRGF0YSBCaXQgUmF0
ZSBUaW1lIFNlZ21lbnQgMSBDb250cm9sDQoxRmg6IDMyIFRxDQoNCk5UU0VHMls2OjBdIDBoIE5v
bWluYWwgQml0IFJhdGUgVGltZSBTZWdtZW50IDIgQ29udHJvbA0KN0ZoOiAxMjggVHENCk5UU0VH
MVs3OjBdIDBoIE5vbWluYWwgQml0IFJhdGUgVGltZSBTZWdtZW50IDEgQ29udHJvbA0KRkZoOiAy
NTYgVHENCk5TSldbNjowXSAwaCBOb21pbmFsIEJpdCBSYXRlIFJlc3luY2hyb25pemF0aW9uIEp1
bXAgV2lkdGggQ29udHJvbA0KN0ZoOiAxMjggVHENCg0KRm9yIENGVE1MLCBJIHdpbGwgdXNlIHRo
ZSBkaXJlY3QgdmFsdWUuDQpDRlRNTFs0OjBdIDBoIENvbW1vbiBGSUZPIFRYIE1lc3NhZ2UgQnVm
ZmVyIExpbmsNClRyYW5zbWlzc2lvbiBzY2FuIGxpbmsgcG9zaXRpb24gb2YgdGhlIGNvcnJlc3Bv
bmRpbmcgY2hhbm5lbA0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K

