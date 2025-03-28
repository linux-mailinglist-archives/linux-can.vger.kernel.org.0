Return-Path: <linux-can+bounces-3253-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F778A74635
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1595D3AAC54
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4A20E003;
	Fri, 28 Mar 2025 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="e2SziC8z"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011041.outbound.protection.outlook.com [40.107.74.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C391DE4D0;
	Fri, 28 Mar 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153709; cv=fail; b=ZIMSp/AQqx/8rUO8jMCS9opnLovKXMKkhsrvqezJ5aZUdRr1S+7dLxDXwRVHL2iLH4Op0FwyazdbeqXXqhYdjENtP3C5eGI+LbWq2J+rm5ZUJ4/azW3ecJYMjz9MGGmHJbnJzb+z4U2TDRG6PUSS+ws9E6fjVnCj019uC77lBlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153709; c=relaxed/simple;
	bh=iA0qWHyURm5i5ozwiJh09UuQvJFpzZFu1IU/SQhqteQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IaXefhMXbjqiShOtz/LPxJZR2Et3VwCvWujtiTNHkma8nTjxnRYVe+iNWrWVJpSL0LVZ1J6rH809RE91O69utD91c7+6Uamt4EP7SsPxdm5dgvTvXEN5XPeU5e7/JBpET/jPbYrOI6aOE4Rj3oRUaanW2hrPWC/tq5DgJs1s1u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=e2SziC8z; arc=fail smtp.client-ip=40.107.74.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiCB34fJfFJdKcCGVN2f2TcuxsHdcpXAS472yYpFCkXMN3PBbIqn65HRAuVCooDp0xWxDNOqiVtJ9ljVCv50hRHzlO0uuxESnMJA+7FkLGXHNMB5oyLcVxY9tewAW6gNoL0G5l2/2e6MHUW5/S0jJzSIephVSm1SSNMTW9DSrAb6bQyhHkr03p1W1CQdz+PHq8M6W150DlavhY3Egl8keva0RUnvwEicuNVzuHb48hbw2K6zo2Vh4N8Au4Uskrak+Tv/YYETteP0mvI/b9iqCb8aza2ol4VHO3wpCgtHEOIWJ7jl1dzKZ60I8RnUP0Gmd+m02Mxij481It/U3/fMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA0qWHyURm5i5ozwiJh09UuQvJFpzZFu1IU/SQhqteQ=;
 b=kHBkON0iDErEVKyuNJBnonIPl9BocNxR+28xuAnkRGsWBgHLDDOQrP//99CMjXLAAqxAp+2iIuxvZk8LuKJfwsSAsLByLv3PrA7kgTTIB+blY2kwkggl9kuHgSjh4HM+ZV++B1MTBf8EmMRfOIt3q73Yx1TLGbNR7vTBSvOIJcPzLYjgW5gaFf9mKl+qQTlEFa2O9uiN0XdY/9gAYcZeeXuCilORQrIl96i3GjhfOB/7/UbeXP62xrkYeikvjlUJXx4SfFp64YGT0jPaODqHRXUX0Jz949EatXVu7NgtNKz/GYnvtSdhprg0v2MJaulRgaRfdxP7m47k2Kna/1345A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA0qWHyURm5i5ozwiJh09UuQvJFpzZFu1IU/SQhqteQ=;
 b=e2SziC8zd14GR8oxMARy0EdNdzRhgg28zg7PofpL9dOxrZ6Cj3kf5Pokxqnh+h5/SoCWpemTLW/GFKAt+GJamHQbUv2ZgPHa2H5OM4YmwNOI/48noDmuhNREsbYC6xAoQsEsncBYwY//Jcq2VEL+9XHJEOlHvbuwd2s8/xSgb3A=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12287.jpnprd01.prod.outlook.com (2603:1096:405:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 09:21:43 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 09:21:33 +0000
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
Subject: RE: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Topic: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Index: AQHbnkl63JoFqVndWE+hQB80zsNhELOIReiAgAAAqiA=
Date: Fri, 28 Mar 2025 09:21:33 +0000
Message-ID:
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
In-Reply-To: <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12287:EE_
x-ms-office365-filtering-correlation-id: 74ea47e4-4065-4831-ba91-08dd6dd9eed4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjNFdWJ1Sk11QXVINGR0QWtxRml5OXMyanFxZjVqYlRmYWxYRisrcGlHWlRr?=
 =?utf-8?B?RFlkVkRJMWliSzdhRDFjWGRFY1lUQTcyN0ZKNjVuaWJWaGlDd0NIc09OUWtL?=
 =?utf-8?B?c0kvVzBEcTZ3MWs5dUJUdlcybjkrVW1rMVpwZ1VWSWo4dCtGNXhodDUxb2kw?=
 =?utf-8?B?Wk1XbE0zUWFQR3d0MkV0U1pEeUw2UzQ0K2ZQSHZnd0Q0dFRLdlFNdU5yMDlL?=
 =?utf-8?B?Tnk5TE1SWGtqa2pEY0xpb0t1NDJ6a0RCSkptRHlROCtWNTdnMzdSSUYzZSt3?=
 =?utf-8?B?Y3huTVFCOER5U2hMWndRaXlxUmFoR1F2VnlFOWlLTEI4YU1OQkVDd1N4NE9w?=
 =?utf-8?B?b2hpNVE2TmRnSExYYUtxOUNJNjY2TGxjcmpvRVBqb3p5N3lXZDdldmMzWFZ3?=
 =?utf-8?B?S1N2THFtbVNiTVcwbCtJTHA0K1dPVTVRMFltNE1jSDBFTk5TdWhLM1dPYlpu?=
 =?utf-8?B?VGg2aGppMmlHMG1vc0FzOG1BampLZCtiaFpHRzVoU3BmU0x6QUN5Zk55SkpK?=
 =?utf-8?B?d3ZNTlphdlplTHZVcHhtTmtLckdTQTlVaWUzR1N4UU83Nnd0ZFZ3TTBnd05I?=
 =?utf-8?B?dnN2ZU1YN1FZYUxJN21SbVArdVhsYTZwaUpMNVRXQ3BFV3hoQTZHeXNTN2FG?=
 =?utf-8?B?T1ZSYkJoNnBkbnlvbHFKQU14WDlUSlo0NUI1SUZBV3FnaDExRGVsK3owbDlF?=
 =?utf-8?B?MDVqR0h0azNQZmJFT1hwTkVySDFHMkNNN0xmMEJlN2k0NWtaQ0tYU204QlZN?=
 =?utf-8?B?dFdSQ0hReWxyMzB5T1hpOSsxWHZSY3FUMzZhOUw3YXBiNWZoUU1yWThJQXpD?=
 =?utf-8?B?d3ZIQTdMNGZKa0l5UkpaOHpTVEVUNUswQ21zbmZxam93WGdLSWZsTTloekJl?=
 =?utf-8?B?REFUUnRiV1ZTaEtmM0VycE9LSUxPQWZLV3Z6MkVKcjR5ZE1kZzdZRUZuZkN5?=
 =?utf-8?B?b3J0V3kyZGdRb01rd0dWRkJDaFlISFd5NjNvSTdoRW51LzVteGRyeklPeWRr?=
 =?utf-8?B?WDYyLzRVQmwvNTdqRXBnbEZRbjZGYWFSaDZTM2RwTHdkKzR0UUpSWFptZ1g5?=
 =?utf-8?B?cGZuaFRJZXRMQTFDMmRLVFpkM2k1RHk3bWFFMGp0M21IbUpNbWdVd3VVUnZ6?=
 =?utf-8?B?TklVN05KY2hJNjF0SWVOd2ZYU21SKzdHS1U3RS9rbzZDNkFiR3VHYnBBNWMv?=
 =?utf-8?B?QlBkWXJ5NmluRjJiTFgwSEMrVHQ4MytwampFdXNjQ1BuZkNlcmFNYXV6UUpU?=
 =?utf-8?B?YVhLNlZhaUVzU1BXeXRGenVxYmdXRnB4cnZ5MVFzNnVBRG1jOGhSMlg5RmR6?=
 =?utf-8?B?M0ZCOEZLNHZFKzcrUkJlMnZHdzVyL2x3NE56QnNNQ2VtNkh0RGY4bXFvZjdW?=
 =?utf-8?B?ZVRuRk9veUY1VmFLd2tyeWt4b3ErNVZwYW01dDUweUZYalB6aGlmY1hYUzFY?=
 =?utf-8?B?aHE2cmV0OXkxYnlyS2tReFJEbmtCK1NJSEt6d0xJRkl0cytXVHdVbDhNakI4?=
 =?utf-8?B?MjRIdWs4R1ZJd3M4ZzBYcDBpWkVlai9YK2NQTXNjWnlwR20wNWc1VXZzcnZT?=
 =?utf-8?B?NUZmOW5OejJ0ZW1OZXBya0NIZXlmTlhXRHV3YlNxbENMNDR2Ym5uSXFieWRz?=
 =?utf-8?B?WkpsZlN4c3QvWDBuSkttOGV3ckVmUTZLd2I0OW5xcTQ2YjZsMmJnRnQ5M1FY?=
 =?utf-8?B?RG9TenNQNklDUk9TUWJTaGhlTlM3R3padTFGcUZLRDk0U2VpTlNWRitJMzFI?=
 =?utf-8?B?NzMrWVVrZHpKUVVpWVZTcHhpUU00S2xJNjhVanpaY2tkVURHWHJPaG5OcWpJ?=
 =?utf-8?B?c05EYk9MbENzZEpYNWlkd21hNk1jbXBOeXNqajdac20yQ1NRcTc0emhYcXBJ?=
 =?utf-8?B?Smd1cVZiRld2bVJmOGM3WU5QbCt6ZEV6QlFrSVNzUUpMT3BHaDNhcjY0UkZB?=
 =?utf-8?B?UXFpbHg1YlA1dldzUlJNQnNTdFNrWTJxU05nWU40cnFqL3lwanhQd3BDU3Z4?=
 =?utf-8?B?dFZ5NGR5bVRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnovWFFDNjBCK2p2aUQxV2NBYTAwS2djRkYrQUJXUDRIVVpERS9XMWkvWVdm?=
 =?utf-8?B?R2Fyc1BDNll0bkltOXpHdi84ZnZjaVEyS0ltNER3eC9CdXZ2UmpqOEx4aVhF?=
 =?utf-8?B?OWcwWkZ4Q2wxYXExMzFiaDFodjgzbXRSakJzTDFSN1lPdmNxemdCUGI0WW9P?=
 =?utf-8?B?eE1FMGdjZis5dXpkZ0NITVRtT0paZldRMGZ4Z1NTK1JIS0dTa1RnZnJjUlVn?=
 =?utf-8?B?WlZ4dktYeVNtaTV6RHYySm9ESTdTVzJyZTRjQzB0UzVXNXVPSWgwZ3Vyekpn?=
 =?utf-8?B?d1ZyMEp6T1NsSUtkTnNickdsT1J5dU8xTTNtSUlBRFRJaUZodTB2ay9ReWxX?=
 =?utf-8?B?OWQ0VHlzVE9hTGZlRDFsVFd2b25CYkJFenAzMGRxeEprcVlxanY5dkUvZzRm?=
 =?utf-8?B?bEVSVUFHT2JPSXBPazRXWnhGV0xyYS9xNVJjVHNDTzdxWENmdm1ZbU0wNmk5?=
 =?utf-8?B?bUVWemY5NnI0RWxvL0dxYlhidHdiRGpXdk5yamloaTQrNjdPU0NTeVJpYTlZ?=
 =?utf-8?B?MDZQaWQ2NElhK212a3lBMS9xQnRnTU96akxEcys2ODVDWG1oWXBkREFRZHgz?=
 =?utf-8?B?U1dQWjlZME9SbmVjNThZT2FVWXlRMU5yK2RTQTJKa2VSK1BSWHZsZmE1cTVS?=
 =?utf-8?B?UUMrZXJLUnE4SVdpa2pvUTFQYk9neDg3RjhHbW1uNko1MzBYYWVIWDNxQ01B?=
 =?utf-8?B?MkYvQVBKd2dvV0hrekxXbEtrL0lNL2Z3aS9KMU9Hc210djdLQkYrR2d6V3ZM?=
 =?utf-8?B?MzFOaDBjRTNVMi9WbzJ2bDYrZmE4R2Y3Zy8wYTVXbmx0RkJDM2xRSFFhaUpo?=
 =?utf-8?B?NlU5bTEvM0dYcTlsU0pxdEYzWU5vNUpVcDYyTGhGS3h6RmVOeUFlM2x5Q0p4?=
 =?utf-8?B?R0h0N3RnV280TjladFNTZmZlVDA3T2dqWkxsYjgxZ2xlblpxV2liZ0JWSHlY?=
 =?utf-8?B?c0ZrUS9YR3JudVM3Y2FWWXY5dnZBdXBpd3lCd0xVOVY1N1pib2N5MUJMWmJv?=
 =?utf-8?B?V2V0RlN1dndVK2daWFdxdzFHMU11cExPcnhJVzdRbnV0enE5dWRZVlhBYWVr?=
 =?utf-8?B?UitvMGc3eUhrUFZkZmx1bTdoZ3lIOEgwc3pEL2RuS3MvcFEwaWN6VllZS3pY?=
 =?utf-8?B?akloOWltMmlRY1VOUWk1TzNKRmswckpZSEY5b24xT3FxeTB1UmVwdWVNWUJU?=
 =?utf-8?B?TGxUcVQ3d2lRMkpvdXJvSXFIVVlhYlEzMEZzMzlnR3FaMm52cEZkU1Q1YXFL?=
 =?utf-8?B?eU9qWDgzMXc1RC9HUVJKaVp1aktIWmJsWExlT2JmVzl4aDdwWFdOTlNET2hT?=
 =?utf-8?B?Zm9BUUR4b1JwS29ZdlZ1cHYxQWtNajlxclI3bGZON2dvOVVmOFVvUmdUdHVX?=
 =?utf-8?B?L1JVUmRNOExSTHRmd1NYRldySUEwdzhnaDFrc0sxSnh1TXAvZGwrNGVuYlRx?=
 =?utf-8?B?dktaSXkxUjBBNU1Qa21Xc0ExNkM0UEY1WUZ6YkpFSWRsQndKT29ZdGdYSXFO?=
 =?utf-8?B?NWR4S2VrMXMrRWtTRHRNRkhUb1BBY0dSSm1vaVFnNVp6WlFWM2lTRERyeEMy?=
 =?utf-8?B?bnZHcHptcE45UWR4d0NmRGpBcFhkT1B5MjVyK2tTSmVINURJR0JEa3RaVjhJ?=
 =?utf-8?B?azJoUXpYOWJvZncxQmNESzRWdmVad3kzNlhYbHZoRUoxQWJMTHZDQm9KUjJt?=
 =?utf-8?B?aGx5Mkl6ZURDMHE0OVl2bGt4MHkzSHA5NlE3blh3SXFhUHJxcUE1a0Q4ZHp4?=
 =?utf-8?B?b2tLMXhTUTlURXRIcDczTFRKdnJNSSthNDdVT0UzV01Ud1VTTEF5QjJvamsx?=
 =?utf-8?B?bHhVOXZNaW5mZ0NYVkpqZEVmakE4OUxScU5EZnlxSXVvN01wMzdpNW9scEov?=
 =?utf-8?B?UzBCbWdhWEFKWGFFOE9RSnhmL1ZFb1RodjhDS2hEV1drOHpVTmRURG10N1Vs?=
 =?utf-8?B?dnByS3hNTVFvYzdhT3o5WFdVZkxUTGdFZUFNcG1KVUFBSHBzaWR6dzA5c0pp?=
 =?utf-8?B?Znl4OE0zYi9LSzhWYTlVRjVVbmlyeUF5bXpUdFBERHZ4NllIVGtwWVIzbGkx?=
 =?utf-8?B?KzF1RDhUMXhSeHRqWlhicEwyalllUUZkL05nYXNVY2RnQ1Q2amE3dHA0aWtG?=
 =?utf-8?B?U05KTlRxTS9IZVR2ZHM2dE05S3gzVjNkcXM1QXJqTU5XL2pKNlh3ayt2S21T?=
 =?utf-8?B?bUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ea47e4-4065-4831-ba91-08dd6dd9eed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 09:21:33.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdFPzCNU9FfrPnTIvBUkEs121AyuJwYEbPf6LbpLMalCKS+RTnTMvlpoHrfKRomMWz9wCKWVKHWRCn0nckdtKAxJIVGkKOmdJKNO5hfmAjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12287

SGkgVmluY2VudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4NCj4gU2VudDogMjggTWFyY2ggMjAyNSAwOToxMA0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDA1LzE4XSBjYW46IHJjYXJfY2FuZmQ6IERyb3AgUkNBTkZEX0dFUkZMX0VFRiog
bWFjcm9zIGluIFJDQU5GRF9HRVJGTF9FUlINCj4gDQo+IE9uIDI2LzAzLzIwMjUgw6AgMjE6MTks
IEJpanUgRGFzIHdyb3RlOg0KPiA+IFRoZSBtYWNyb3MgUkNBTkZEX0dFUkZMX0VFRiogaW4gUkNB
TkZEX0dFUkZMX0VSUiBjYW4gYmUgcmVwbGFjZWQgYnkNCj4gPiBncHJpdi0+Y2hhbm5lbHNfbWFz
ayA8PCAxNi4NCj4gPg0KPiA+IEFmdGVyIHRoaXMgZHJvcCB0aGUgbWFjcm8gUkNBTkZEX0dFUkZM
X0VFRjBfNyBhcyBpdCBpcyB1bnVzZWQuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0
dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjYtPnY3
Og0KPiA+ICAqIE5vIGNoYW5nZS4NCj4gPiB2NS0+djY6DQo+ID4gICogQ29sbGVjdGVkIHRhZy4N
Cj4gPiB2NToNCj4gPiAgKiBOZXcgcGF0Y2guDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nh
bi9yY2FyL3JjYXJfY2FuZmQuYyB8IDUgKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNh
cl9jYW5mZC5jDQo+ID4gaW5kZXggNTY1YTkxYzJjYTgzLi5hOWU5NjJhMTUxMGUgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTc0LDcgKzc0LDYgQEANCj4g
PiAgI2RlZmluZSBSQ0FORkRfR1NUU19HTk9QTQkJKEJJVCgwKSB8IEJJVCgxKSB8IEJJVCgyKSB8
IEJJVCgzKSkNCj4gPg0KPiA+ICAvKiBSU0NGRG5DRkRHRVJGTCAvIFJTQ0ZEbkdFUkZMICovDQo+
ID4gLSNkZWZpbmUgUkNBTkZEX0dFUkZMX0VFRjBfNwkJR0VOTUFTSygyMywgMTYpDQo+ID4gICNk
ZWZpbmUgUkNBTkZEX0dFUkZMX0VFRihjaCkJCUJJVCgxNiArIChjaCkpDQo+ID4gICNkZWZpbmUg
UkNBTkZEX0dFUkZMX0NNUE9GCQlCSVQoMykJLyogQ0FOIEZEIG9ubHkgKi8NCj4gPiAgI2RlZmlu
ZSBSQ0FORkRfR0VSRkxfVEhMRVMJCUJJVCgyKQ0KPiA+IEBAIC04Miw5ICs4MSw3IEBADQo+ID4g
ICNkZWZpbmUgUkNBTkZEX0dFUkZMX0RFRgkJQklUKDApDQo+ID4NCj4gPiAgI2RlZmluZSBSQ0FO
RkRfR0VSRkxfRVJSKGdwcml2LCB4KSBcDQo+ID4gLQkoKHgpICYgKHJlZ19nZW40KGdwcml2LCBS
Q0FORkRfR0VSRkxfRUVGMF83LCBcDQo+ID4gLQkJCSBSQ0FORkRfR0VSRkxfRUVGKDApIHwgUkNB
TkZEX0dFUkZMX0VFRigxKSkgfCBcDQo+ID4gLQkJUkNBTkZEX0dFUkZMX01FUyB8IFwNCj4gPiAr
CSgoeCkgJiAoKGdwcml2LT5jaGFubmVsc19tYXNrIDw8IDE2KSB8IFJDQU5GRF9HRVJGTF9NRVMg
fCBcDQo+IA0KPiBUaGUgcHJldmlvdXMgUkNBTkZEX0dFUkZMX0VFRjBfNyBtYWNybyBkb2N1bWVu
dGVkIHRoYXQgdGhlIHJlZ2lzdGVyIHdhcyBmcm9tIGJpdCBpbmRleCAxNiB0byBiaXQgaW5kZXgN
Cj4gMjMuIEhlcmUsIHdlIGxvb3NlIHRoaXMgcGllY2Ugb2YgaW5mb3JtYXRpb24uDQo+IA0KPiBX
aGF0IGFib3V0Og0KPiANCj4gCUZJRUxEX1BSRVAoUkNBTkZEX0dFUkZMX0VFRjBfNywgZ3ByaXYt
PmNoYW5uZWxzX21hc2spDQoNCkZvciBhbGwgU29DcywgRUNDIEVycm9yIGZsYWcgZm9yIENoYW5u
ZWwgeCAoYS5rLmEuIEVFRngpIHN0YXJ0cyBmcm9tIEJJVCBwb3NpdGlvbiAxNi4NCg0KQnkgdXNp
bmcgZ3ByaXYtPmNoYW5uZWxzX21hc2ssIHdlIGFsbG93IG9ubHkgZW5hYmxlZCBjaGFubmVscyBh
bmQgPDwgMTYNCnNheXMgaXQgaXMgZnJvbSBCaXQgcG9zaXRpb24gMTYuDQoNCkdlbjQgaGFzIDcg
Y2hhbm5lbHMNCkczRSBoYXMgNiBjaGFubmVscw0KVjRNIGhhcyA0IGNoYW5uZWxzDQpWM0hfMiBo
YXMgMyBjaGFubmVscw0KQWxsIG90aGVyIFNvQ3MgaGFzIDIgY2hhbm5lbHMNCg0KQW0gSSBtaXNz
aW5nIGFueXRoaW5nIGhlcmU/DQoNCkNoZWVycywNCkJpanUNCg0KDQoNCg==

