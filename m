Return-Path: <linux-can+bounces-3100-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB82A630CE
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 18:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C931618972A5
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DF1D7E52;
	Sat, 15 Mar 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WZH0qRhq"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011057.outbound.protection.outlook.com [40.107.74.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D84A06;
	Sat, 15 Mar 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059916; cv=fail; b=PvxI1pxp4dZ5nUgX6Jy2W6af9W1Y3JWKvofFfMDjTWE7gev+pr64ma8Fucbq6D0lo2eX5MQ7M/IfuTviWUhD8svbjAmshWQyX5rlpaZ5ldBJXU9jerXBbmyKes6nXWQ59TByBF39QL0yGO1JLqMundnlj8TqeuI/XoPog7HYFkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059916; c=relaxed/simple;
	bh=fRyQux3R/k4327k7JGveXejsYbNvDDW48BWbuBIuqPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+rO+Ab7bJ5Kftz7ZUlBzaeg94F3dpWq7CqZwnCYUpBk7o2leggsAAB3GAO1ykSomcQ8A44gmaEkj2z/cOAS92Txd9N2jAQKI//2jFHjuTcZTwHOQru33ozRZ9NDiuhAvGr6jCdTgls39dG6YU0W5CN6wt4ThzcW3nUoUp/c2i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WZH0qRhq; arc=fail smtp.client-ip=40.107.74.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4kOcXDuj3iWMbl5r79zkzAG7uPG13K4/5LrIiAiSkpfap32RzmtSbCRVWThWFx0XbLLADo3FtG7IOWAFuPOcWYQoljpcpcHTFnYwNSJqGe6Rv4ivzan/ysvNu10lxGOszrD5631xOmf6QITGRa21ppt0ItPReGGBuwTKsYBVh+Ufpv3s/oj+9b5xwvuD4A88Sr0xp/2ThD6vVwdL6cmMW+s6HQHo2m0GrKOwr3vw5QKPgGuVbckLXrFC/7doWMCV7vJE596EMqRPQNznT28VPp592hgIKNH25WO1VWamqko1Lv5DTWtku8q3b8eL6ReKDn95bCBu5PLEaNHwNvnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRyQux3R/k4327k7JGveXejsYbNvDDW48BWbuBIuqPo=;
 b=Amaw+vV5QdokBB89yszFqT1TRcwK9Tnx5ZHSRlOXE5YP8j9XBZF6hAKrgTmVb7ZiQvy3ZF94HMGE00wAxr/fJu10qotdmyiOc3P2nlOI7LNM7OvZAreoyTTDhlsoijDIZ48rP9HZiPeJJC5d9AYL4rFpesoeBVcvo+U8qzodMQGPAXwgoYcKZoTbTI8JqCjfgMMIIOeawgt362oxUfl2yFpdlouuWuIKt7qcV6ri/CTU0D8adIkm2TeViwlEGEHXhQkZdw7XAfYOMuRBzJmyMlImkyPBz/kt05VKSuYet4gjlotTnuUgwvmp4urwZ9DU8x0b1u9YLZwdXjfgwtVteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRyQux3R/k4327k7JGveXejsYbNvDDW48BWbuBIuqPo=;
 b=WZH0qRhqXOVa02DRuoz7n4N6q5uMtOz9PVi39B76W65m7Ntw6eSseOTJRUs0x6H3CBjYgFGP3NmwpPkKd87zfvENdgetv4XncRFqwtCC3Am13kaexicO7oP4M/yaKVtJT9exhGd+4+lMjKxFCU3JsCC/lr8c2ncycWkCIwa0EiI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS0PR01MB5892.jpnprd01.prod.outlook.com (2603:1096:604:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sat, 15 Mar
 2025 17:31:48 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 17:31:48 +0000
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
Thread-Index: AQHbjpVh5pBDjQAOZU2YFEmYsgBFpbNywusAgAG/fpA=
Date: Sat, 15 Mar 2025 17:31:48 +0000
Message-ID:
 <TY3PR01MB113462D2249AB5B239E8213E286DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-9-biju.das.jz@bp.renesas.com>
 <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS0PR01MB5892:EE_
x-ms-office365-filtering-correlation-id: b442a1e2-8807-4031-b2f5-08dd63e74415
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTAvSnh4dTFFRVY1OXlMVldoUDBWQUxTRDY4VXNhbndidkRtN3dORXJiY3hk?=
 =?utf-8?B?dTVuK3VwTmIrYWRKWmFHajV4aVFmMFNycUxmYXI3RkIzb1d0ejRmb1ZoNjh0?=
 =?utf-8?B?bzVSbXZDUjVlWVdscHEydEg5SVFoanJ1NGpLMVBxdDhUM2p6WkRvK2YrempI?=
 =?utf-8?B?ZFhKTGx3Rm95MFFhQ2pabFVheGxkVzI3OFA3OUJrLzkrRExLQURzNjIyNm9R?=
 =?utf-8?B?OWFjK2JMTkNoOW5uM210dEtkejNtSWNpbFVUaVFUTThtNTNqKy83QVNUQ2hG?=
 =?utf-8?B?bDYyRG44NkV4a21VQUlhWmdpZ3d1MGFPNUtxd2YrMnQxUzhtTmRmK1p6WGgv?=
 =?utf-8?B?cXhQcEZseUMzUDUzTS85QVp5bjJlclQ2YlJzTUR1aW5rSzlFekVjL3JENnRU?=
 =?utf-8?B?T1lWQXdSYldsaWtVemZNdmJ4M1AybVNtckVTUjNqOEtQVlkzTFljNExoOXZN?=
 =?utf-8?B?cDMvbjh5WlhPYzdWZ0NPemVqeFppRnV6a3BrTmVkMElHYnNVNE1jWVkzeEE5?=
 =?utf-8?B?WVZaZTNyN29Bby9lNWxiQ29VejZ6QWNDK2E5TGJqTGlnRDhHNU15cjRvKzFV?=
 =?utf-8?B?U2FRMkJITnZrMUFPOFFURXU3aWhDaEIyMFdWMHhOQmxPdC8zL3ZhYy90SWVT?=
 =?utf-8?B?bkZBb1l5T2x2OEJiV0s4NjFuYTBVZDVueU5aQTZzUXVQTDVFNWdiQ3l3TmF6?=
 =?utf-8?B?R1lzb1ptZ2ErdTFEOERDNE1EcHpacm9GYjNLQStMbGx6QnJQVXllU04wNG83?=
 =?utf-8?B?a3ZMV2V3L0czaVpKUFI5RklWVk52V0VTaDg3UjlCbW03YnBzSlNyQjJha25s?=
 =?utf-8?B?U25nTkYxU0xLcVF4ZGFJcmlPVG9vdnZKbDlyYy9pSi9ZRTJObEJQa250b0kz?=
 =?utf-8?B?Z2t6TVFGWHZISFh2L1htdzNtM3QvVW9vcHNKdVB3bVZtK1U5RmZIMnVrVkt4?=
 =?utf-8?B?b3cvZFU0ZEpkbnVyWFRHTHJTS21RajZUT0RMc3dHTjBLUnFkOFB6amRhNVdh?=
 =?utf-8?B?Rm1CSnltTmZXQXQ3ZmMwVzZOeDlnaW5MVUJXM0dLR1BVZWhYMzE4OXFLbzkz?=
 =?utf-8?B?aHZRYkdIVyt3a1NWRFV6ODh5amVGVjkyRDN6a3dvVjF4KzY3Q2tMUTJNRG54?=
 =?utf-8?B?ZWgxNmxwL1Vhd2JSdnJFc2JUK0VLL05TV3JTQlNJNDZuUkZ5QjlUZnh6Q1JD?=
 =?utf-8?B?S3d2S0YwelVaTHk1Q3BNY3BFbjFXNHpvUFU1ZExsN3E4ZiszQkxzWjVSNnh1?=
 =?utf-8?B?RWlqNXQrTStOZ1VMVkhsU1ZzTUJ6enRXZ0FKZEtjUTd1ZlR1VFlmVGpyTHZJ?=
 =?utf-8?B?eVdDM3l2K0tkR2drZVV1dHk3UWZ0SktTWEx6elUyWGhSZjRsR0dlbjRLWEpv?=
 =?utf-8?B?TTJWZ0RuaHJZUTArc3pNNHNmUmZ1VkwrdnowMUlQRll5NkZmUFRHZEMxMzFt?=
 =?utf-8?B?WktJSHFTeVp6WEdYMlVFRmU2WlRkVzRTa0JpVFYrNDRFejlzMVJsZEwxTWFF?=
 =?utf-8?B?WGlxUVhPRG5tRjd5MjFQZ0VNeHl5QkhxWlI0d0VXdmhQeEFCbHhDNndCd2NJ?=
 =?utf-8?B?NjRnWk05ZHVxaThVRGhnZlZXcEFTL3NrVXNidWlwRkhBazRYN3VRcmE3M0cy?=
 =?utf-8?B?b3g4S2hObXJFTUpDN0x1M0R5UDM4dnJ0M1ZtS25IeFdTS2x0a0JSemFDNXh0?=
 =?utf-8?B?RkthYVhaUkl2THcxVFN3WThhNVFLKy92U3JqQm11bHhLUFdPK2hyVmhsTmc1?=
 =?utf-8?B?WWt2dlFjR0czaDRBd3RtbjdjZ3pFYWFNTE02aTYxRmJzR09ZOUR1NFQ2MnlQ?=
 =?utf-8?B?a1ZQT0t2N3NOYUVoV3N0aXNMV212V3ZITTFkekVacHpEQ2dsTWhwZWZCUDY4?=
 =?utf-8?B?S09sbE9uRzhGNHk0UFdwZjJ6TERZR01IMW9TSitMSHlaUG85TkxucE50emdD?=
 =?utf-8?Q?rVDoPaBuo3cLuaye1fki/o+8r7Hadz7b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3d4Q3ZDTG15b2RvY3lUV1JUb0tWQVg3L1NzYjlHR093aUZ3WXNHeThqdDQ5?=
 =?utf-8?B?TjRPVDJaL292WnVHNVFENmVGQ3hZMk55Y0ZiQzVoZmJHR1hwZGdoVkhmWE1X?=
 =?utf-8?B?ZWVkVlh4dGlEUVJWZ3VLZHRwMHlIOS9UQnZoeFpRZFRicDlTQkZETDB3N0sw?=
 =?utf-8?B?d0xPRGZTeFhTbHBxR1NqT2NUYlRzVzgxMUdiTXNuaThVYml6VVlZaEtqQys1?=
 =?utf-8?B?ZkJoWUNIRXAzU1ZjT01KSjFlbkJncmRmWmxRbnFiZlhIeUlnMXU4bUNLZFlC?=
 =?utf-8?B?dWNVNjRyVmtkSkp3dGJ2a043dmU3TkZEZ2F6STV3Y01rZjU3eDZxWXB0cTNv?=
 =?utf-8?B?bWdjUWpiQUJMUFVuNHphMlVlZzJzV2twdm1kUElPYWJvcEhmY0ZFdHNURXBv?=
 =?utf-8?B?NEkxUG1VQ1FBdElrTmtNZEhNa1JCSWNXTjhmMXRyVFVlb1ZlQUpJZnBlRkFJ?=
 =?utf-8?B?Kzh0bGVaTm5CYzF2UjFpUGxHQWUrN05tQWNIUUthNERZMEhaVXU3TUNwcGFZ?=
 =?utf-8?B?enI0QU9ieEpoUXl0ZG43U05RRUMzTlBIUmR2bjZ4VWhIVlB2aVFWN2h2a0wy?=
 =?utf-8?B?aGFWSzRzdVM1YUdKWnlqNlBKNVoxWlFJL3NiaEU5R2h2UUhBMDlRRDFDT2RQ?=
 =?utf-8?B?NE5KbXZwbTRMRitGZGlUYXViTzRXYWN0b1J0ZWx3VWlYclVMdXd1anMxelpN?=
 =?utf-8?B?MitpUTdvNnQ0amFvS1ZvSGh4M21tby9iV3A0ZGVCQ3hEY0NobjFYMGRER3gy?=
 =?utf-8?B?TWhpaEE1Ym9wM0NoZFdjeXgzaWM5cS9PSS9kLzgxK2dKWFNQZ3piejh4Zmps?=
 =?utf-8?B?RlBVcnRsZTRzOFYweGNEVy83V2c2QkZRSWFka2lFNVZqaHRYakJucDZhTmx1?=
 =?utf-8?B?UENYMm40dTJxN3pseGZ1c3JZUzFXUndaa0VEZGI4bnNrSTFIS0xmWC9rd0dU?=
 =?utf-8?B?NGF1UzR0azh1cWV0V2ZJODJJdk04czM1ak9EUnhIeFFtakN5T0Nnc0RLOU9o?=
 =?utf-8?B?T2dNUGxyU2MrcmI2aFllQmxkbEZJR2Q3cmtJdVhjWWVtUzRmVWxRd3JHd1BW?=
 =?utf-8?B?UmJHeWp0VXdUSFJyYTNrVVY4SFJwekQ4YmdPL2ZOSEJUMll6QUtVOVhTTzFF?=
 =?utf-8?B?eEJYdXQ0bnl1WFJVZ01GYzNBY1J0R2hZTGttR1ZOZnBaKysvSW5CMnp1U3F2?=
 =?utf-8?B?MnlFckJtM2dyd1JGMnhqazZTc3R1THNZYkhuc2FZTDVSVFV5Mk5QYjhmSWt4?=
 =?utf-8?B?N2hudVlZVzFncFMybHRqTStObTRpNnVZT0NYTVRDUm5SaUVZaEh4RmhJbjFm?=
 =?utf-8?B?MXQ0TlJXcG12UFdrL3B2WTRyTDJDbUpVMkswWUtwM295NFFsL3dSMkx0Mys4?=
 =?utf-8?B?MHlzeklzZDJqT1ZnY1VqZWtBVjE0U3lndFl4VFFJa3ppdjN3WXJ0ZExMaUxs?=
 =?utf-8?B?bCsxczlVVHJmcHMxYTF4ZjU4WGZSSTBQMDJ6aFlKVUM4WlZXMUhpZ3pIUXI4?=
 =?utf-8?B?Qy9YZFQ0N1k2Ym1NTUZTM29mNkZVTFBHU1ExYTdvZzhqcy9lOVJDcnRjR293?=
 =?utf-8?B?Q0ZmMlVnSUdGa2E5TExwSWk2b3RZMHNubnozOSs3T0liNXNaMEVWQ0x4Z2Rq?=
 =?utf-8?B?Q0VRK0JFbU51NlJqOFVKMlhFbk1WMFpPZEl6TVE1RDRHaiszVnkyU2xDTm5n?=
 =?utf-8?B?WVhDNzRhYko3TlNEc3h4SjRxWFNRYmtPU1lHN01QN0RIVWZwM0pBcFJSNE10?=
 =?utf-8?B?TVNTcllmVmdtS21GcS9aaHFNNmVnbVl5Zmw1ZWN3eFhyaHM4Ukw2SGxXUGpX?=
 =?utf-8?B?SzliS2xkZ1B2em9YRzhlM0ttNGZFT0lLRTl4aWY1U20wc2Mzc1lrUE0zbnpM?=
 =?utf-8?B?UjZ3elp5b3hRbnVDVVV3bUpQU2NhbWlMOHc0YnZzMkFaLzlGUlFuQ1UyQ29x?=
 =?utf-8?B?d3gvUDdpbGUvZDY4MFY4QjBPbXZwbFladzBIWEVIb0ppYmg5VDljUHV5eVht?=
 =?utf-8?B?VzZqeEoxZ2VTQUgxZlVDM3JuOFhES1hLbmFWbi90RWpoWFFFckhsSzFOanNN?=
 =?utf-8?B?ZUZ0NEdSMFBKa2t5R21saS8vYU05bHRpckxKWDJWQ1hWZzdVRFZjVm42dWNW?=
 =?utf-8?B?UThVR3V1b2NNRkYwdjFYNHNYaFQ5NjdleXd0S2p1NG9pdUo4UmdqRkthbkNa?=
 =?utf-8?B?N2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b442a1e2-8807-4031-b2f5-08dd63e74415
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 17:31:48.7005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cN1BOp5QA+VpR5xPs0fStKU9o1YZbhTTVR4yQeJqD9Eyfw1jHiQDnVeE9zlemzVFD8f3zKk95O3J4/g17qHLim8anTapasmP5gPfvowlgwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5892

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTQ6NDgNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAwOC8xMV0gY2FuOiByY2FyX2NhbmZkOiBBZGQgc2hpZnQgdGFibGUgdG8gc3RydWN0IHJj
YXJfY2FuZmRfaHdfaW5mbw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBw
YXRjaCENCj4gDQo+IE9uIFRodSwgNiBNYXIgMjAyNSBhdCAxMzo0MywgQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBSLUNhciBHZW4zIGFuZCBHZW40IGhh
cyBzb21lIGRpZmZlcmVuY2VzIGluIHRoZSBzaGlmdCBiaXRzLiBBZGQgYQ0KPiANCj4gaGF2ZQ0K
PiANCj4gPiBzaGlmdCB0YWJsZSB0byBoYW5kbGUgdGhlc2UgZGlmZmVyZW5jZXMuIEFmdGVyIHRo
aXMgZHJvcCB0aGUgdW51c2VkDQo+ID4gZnVuY3Rpb25zIHJlZ19nZW40KCkgYW5kIGlzX2dlbjQo
KS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3Jl
bmVzYXNAZ2xpZGVyLmJlPg0KPiANCj4gQSBzdWdnZXN0aW9uIGZvciBpbXByb3ZlbWVudCBiZWxv
dy4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTkwLDExICs5
MCwxMyBAQA0KPiA+ICAvKiBSU0NGRG5DRkRHQUZMQ0ZHMCAvIFJTQ0ZEbkdBRkxDRkcwICovICAj
ZGVmaW5lDQo+ID4gUkNBTkZEX0dBRkxDRkdfU0VUUk5DKGdwcml2LCBuLCB4KSBcDQo+ID4gICAg
ICAgICAoKCh4KSAmIChncHJpdiktPmluZm8tPm1hc2tfdGFibGVbUkNBTkZEX1JOQ19NQVNLXSkg
PDwgXA0KPiA+IC0gICAgICAgIChyZWdfZ2VuNChncHJpdiwgMTYsIDI0KSAtICgobikgJiAxKSAq
IHJlZ19nZW40KGdwcml2LCAxNiwgOCkpKQ0KPiA+ICsgICAgICAgICgoZ3ByaXYpLT5pbmZvLT5z
aGlmdF90YWJsZVtSQ0FORkRfRklSU1RfUk5DX1NIXSAtICgobikgJiAxKSAqIFwNCj4gPiArICAg
ICAgICAgKGdwcml2KS0+aW5mby0+c2hpZnRfdGFibGVbUkNBTkZEX1NFQ09ORF9STkNfU0hdKSkN
Cj4gDQo+IEJvdGggc2hpZnRzIGFyZSBkaWN0YXRlZCBieSB0aGUgZmllbGQgd2lkdGg6DQo+ICAg
LSBSLUNhciBHZW40IHBhY2tzIDIgdmFsdWVzIGluIGEgMzItYml0IHdvcmQsIHVzaW5nIGEgZmll
bGQgd2lkdGgNCj4gICAgIG9mIDE2IGJpdHMsDQo+ICAgLSBSLUNhciBHZW4zIHBhY2tzIHVwIHRv
IDQgdmFsdWVzIGluIGEgMzItYml0IHdvcmQsIHVzaW5nIGEgZmllbGQNCj4gICAgIHdpZHRoIG9m
IDggYml0cy4NCj4gVGhlIG9kZCBzcGxpdCBpbiB0d28gc2hpZnRzIGlzIGR1ZSB0byB0aGUgTVNC
LWZpcnN0IG51bWJlcmluZyBvZiB0aGUgZmllbGRzLiAgSGVuY2UgSSB0aGluayBpdCB3b3VsZA0K
PiBiZSBiZXR0ZXIgdG8gdXNlIGEgZmllbGQgd2lkdGggcGFyYW1ldGVyLCBhbmQgZGVyaXZlIHRo
ZSBwcm9wZXIgc2hpZnQgdmFsdWUgZnJvbSB0aGF0IChsaWtlIHlvdSBoYXZlDQo+IGFscmVhZHkg
ZG9uZSBmb3IgSUNVIDstKQ0KPiANCj4gTm90ZSB0aGF0IHRoZSBmb3JtdWxhIHdpbGwgaGF2ZSB0
byBiZSByZXdvcmtlZCBhbnl3YXkgdG8gc3VwcG9ydCB0aGUgdGhpcmQgY2hhbm5lbCBvbiBSLUNh
ciBWM0hfMiwgYXMNCj4gIm4gJiAiMSB3aWxsIG5vIGxvbmdlciBmbHkgaGVyZS4uLg0KDQpBZ3Jl
ZWQuIFdpbGwgaW50cm9kdWNlIHJuY19maWVsZF93aWR0aCB2YXJpYWJsZSBpbiBzdHJ1Y3QgcmNh
cl9jYW5mZF9od19pbmZvIGFuZA0KU2ltcGxpZnkgdGhlIGNhbGN1bGF0aW9uIHVzaW5nIHRoZSBm
b3JtdWxhICgzMiAtIChuICsgMSkgKiBybmNfZmllbGRfd2lkdGgpLg0KV2hpY2ggd2lsbCB3b3Jr
IGZvciB0aGlyZCBjaGFubmVsIG9uIFItQ2FyIFYzSF8yIGFzIHdlbGwuDQoNCkNoZWVycywNCkJp
anUNCg==

