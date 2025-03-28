Return-Path: <linux-can+bounces-3291-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66019A74F22
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 18:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F342D1892447
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9831DD529;
	Fri, 28 Mar 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RjkFMm/2"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011063.outbound.protection.outlook.com [40.107.74.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488671DB92E;
	Fri, 28 Mar 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182088; cv=fail; b=q1KdsMjtw8LvYVajHA8E9nQuTV1+P7KovG12tgV+gAB8JCjiaPNAOOttwwy521b6BQ57BMWQVcQwEm5xVFW6SrxB2epOguDsjenG3+VvRdzsueGqpPqYuClZYnqXwXTMx65bCpJy5XIcNHsT3OXqv9lWj312GM4CdInx+8AqqOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182088; c=relaxed/simple;
	bh=KFelXbdhMvc5QrbVeWIj3E2bVbT9jJJrk0/hmdjsbYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oLOyjF1MFzg19Ak+B2gd5Q2t/wB5a2z91YwLRkm6Da64d/LnqF9tDTOkMSMnLgB7QNKjJ8A7bEQtJ5gEExISbLSy8PuQ3f/En8QsfHWgHTG4BZvsL4qbGEXLpH2MHzqA3ZkvNq3tcmTbAhflHW+eptJMs14u3NjaotVxdzJR8RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RjkFMm/2; arc=fail smtp.client-ip=40.107.74.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoKrGLyBZtwqHyE1UOtYdhiXqCkUL6L5bj0gA8HhqcRkyUY37pa9nGP+MZIf7BhmQxBc1AK343dQcXG7oaF4+LhoX3Kx9Jb2WYB3n/oCYDBMl3nGqZ2rRchYH0oyQ7hDkgs6iI4VSEY+sx0Cjx2PmVw5yRe39fNoWCHXtMf+cE4GmhBG+OQioUAX2DKgPX4E4xGjeP/0OyCNp/KIIHjd4RPpW/i99DgN7DYIMALNMwn7U/Xk/BmmSZmDORdbPDsPrE+hRUf7Su8wmqWYAf7MVPCS+wDsJwYrSdSL1Dai8arvLWxmGkU3r2iy7CErEbX+qH4WsgEVm/TIG5R/ftLjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFelXbdhMvc5QrbVeWIj3E2bVbT9jJJrk0/hmdjsbYE=;
 b=w6rkJuAAIQIPLH4LLER8Qr1BGapx+RqLnHkKOtNUqPtJk2Ro7skTGC6Qgeo9EbDJRIsgOqHkOCHKl0Vj8/NScR9gZF+/xTNUi/AgPySUZLQmu4r2n0YYUYs/YM3iCGWyknXNvVe5uzt9OnuLxeWRZlfM2dEDC8d0YAric38raXWkiD8FyuNrKvSnLq1NCO1REN0TpkV7QGCS1bJ0nrr86+vW/9+APjR4OcB00UBDxwBJlacXAMEjEWCl9e8G663S9U7mNu0h81hllbaxSX1dr6YRvOuOu26KyBrHwXZIZXCUAKAggfi/TcX8Ftpje9oJszzoixWT3V1uMPQE+jonWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFelXbdhMvc5QrbVeWIj3E2bVbT9jJJrk0/hmdjsbYE=;
 b=RjkFMm/2T/8p662OiCH8SgJZRh4AEIpDu70+16t5OIGf5HJcZblaEZ0EFnOcJxqCzozXHzXjoh/Ls4HCXhtyoQmhMFB8l/s9zZFdOuc9xbJeslrGR0bMZ5DYxWAmqgYQaOybKTUAH9kf4pGwDDIcx48IjvrK1ZPM46Auh0+aTmg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8668.jpnprd01.prod.outlook.com (2603:1096:604:19a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:14:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:14:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
Thread-Index:
 AQHbnkl9i1pj+Nv9/0+uivOvdWdzlLOIXgMAgABSoRCAAAiogIAACvnAgAAH9ICAAACIcA==
Date: Fri, 28 Mar 2025 17:14:42 +0000
Message-ID:
 <TY3PR01MB113469F4FC1DF4650BAAA1AEF86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com>
 <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
 <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdW7qTBVuHCxVfpOom-dEkROYfPG_neUiY7iUq=HAgAjFA@mail.gmail.com>
 <TY3PR01MB1134664605538933A2A59285186A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdVkVuxUQRMU8XQE+=+USuaMWbzfkS_69W=mse+-FdhpOw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVkVuxUQRMU8XQE+=+USuaMWbzfkS_69W=mse+-FdhpOw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8668:EE_
x-ms-office365-filtering-correlation-id: e821a95b-fda5-4dfd-a10e-08dd6e1c07e2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUVmMktrUzVucXE4M0FpNG5Zazh4RVBZL3hwNVlobk1aT2VVRDRpWXovSXRh?=
 =?utf-8?B?WVBLN0kzMFdyWHQ1RVIwNUNOaU1Wa0FSRURRRWdQUmdFd0dIaDF1NFAyOTZz?=
 =?utf-8?B?SXZOelVwSjRmVFFWaml3T0dDcG1IVHg1OVpuUXlkTk9pMHpvampYWXBvSS91?=
 =?utf-8?B?NDJjWFoydWx0UWhvQzRKZWVmWnJlZkRwWThUdmxNOWNwby91dGNPWFdPNFJT?=
 =?utf-8?B?ZHBxK0ZxdUoxMzVwVThOTllaR0xqVk0rVDR1SjZQNE9PeHBITjIrSU9ZNXJu?=
 =?utf-8?B?cldpN0FUS1lpZFRuVWNUa1Q4M2Nla1ZTa1o4N0tJSXhZQ1J6aEYvMkE0UWZG?=
 =?utf-8?B?NklDL3VXSTl6dEd3M3UwZDY3QWx4Qzd5cEpkb281ek5Ob0NpNVowM0s3dGVj?=
 =?utf-8?B?OVdJSnprREVRTytpOVlrQ1RzeVpKaFVSbFJhTGlyY3JYdUpoRkFlRDlvN3Mv?=
 =?utf-8?B?aGp2eW9DNWQxQlp2aEJ2WWkyY3FsaTloTXAzbEhoRVNwYUVSMmxkWURWSVdr?=
 =?utf-8?B?SlYzRkxoSFVwN0lvSGl3aENzUXJvT2g3MG00eDQvTXRkbkxNN0hIL2JIdFNn?=
 =?utf-8?B?b1pwai94RGxjbUlrYXNPS2VhVkdUdkVXa3VjTkdvejBmaTU3WTdxRzk3Z25v?=
 =?utf-8?B?b1JXdHpITGVQQjJaSVV3RFR2S1hZWEQySHQyem1lZVUwbmhtSEdHSS9PZFoy?=
 =?utf-8?B?SU5aajNNSXppT1hzY0d1bXNqN0VZdDNORmIxbWR2bERFQVZIUjZuc1hsaGZR?=
 =?utf-8?B?RVRjb1RoR2RaUUJieU5WUXpQQzJLY2NJVEsrR1BIZEtGV1h1T0V5ME0vTkFp?=
 =?utf-8?B?eE1PdTBOYzRyTmpxa0NmcFE5UEJuSUViSWZDNEFYWVd5MUpYM1JTQnR3VDBw?=
 =?utf-8?B?bzE2TDZ1WEVnZXBWWVhoTUVpSC90amdRTXg5c1lOaXg4OHRpcmQwYzgrd3h0?=
 =?utf-8?B?YVdwbzhaWFYxM0NOVlp2eldnWlN6bnoxeENCUWMyUkNSM1RHQWlwcXpDc0Vk?=
 =?utf-8?B?NTl1V2g4NnRCdHgwcWNmVXRLSXlKbUtiUUhDaTRaUGp0V1VRUmRSTG0yNXhF?=
 =?utf-8?B?YVFSVExEU3FsUjd4OWdOUXFWQjNsakFXOUY0Wm1wa0xiMHJpb2VXM1ZRaEk4?=
 =?utf-8?B?a2FZTlJuU2RwRkp4UEtIRjZ6cENZYXMwUFZiWVRDNGt1WHZzQStCTnNYU2tU?=
 =?utf-8?B?T3MrOUZ0VWVHZTdVL1FzY0IzQU1SYWMyR2lHdnArT29iV0ltV0VuRDBaVU1D?=
 =?utf-8?B?UlMxcERCMVhqbmx0clJmVWJCNkhnRWxGSHpsL0hqbE1oYU1kNE1YTml2L0V5?=
 =?utf-8?B?TEMvVEJFandGU1hMUmpQeW1VU3cxOGg1L1JyK2lDNU9WczU2N2Q2ZTZ1LzFy?=
 =?utf-8?B?bkV1K1JmTzdiZ3VxaDNOejRkaW50TTVURXlndXZrYnFSUE9lNjNhQzVBM0pN?=
 =?utf-8?B?anNmWEdURFZnM29sUUlDY3FrMEdBMy9qOVpBMU1JVnRsVVVTb1Z1MnVPRkl2?=
 =?utf-8?B?NVhkcXNOdTFHYXV6R0xtYlpWdW9vWUwybEw0QnZDcHpGd0pFczhKL3liVElP?=
 =?utf-8?B?SENiV0RFaU1OT1Y0dlBUVkwwMlpxSjJySnl2YTVZRzJUMk1RTHp3RmhRdzlh?=
 =?utf-8?B?ak1vejFjditHcjBVdkhiZGNzaHNyeW9PakQxWHRveDVKeHZ1T0JlUU4weG81?=
 =?utf-8?B?ejNwMjNSbHlOVmdWdm50YmVpakUzZjU0dng0RTRBTk1BUVRlTEV5VFo1aGg0?=
 =?utf-8?B?L2ZIZEt2c1ZOTzRSV1hiZFFXaXE5Q2h3UlVmYWZacWREU29adU1WYlgzaHBh?=
 =?utf-8?B?alBSZDVUd2lqWnUwVmF5VC9WdGxybjNWa3A1eFVPMVV1ZHBTWjRYUFNUNktC?=
 =?utf-8?B?eXVpNXBzVG5GaUFWV2NFMVBnZmRRZEVBdnJxS1J0Uk1qRmp1Z3FmVFAwM2JB?=
 =?utf-8?Q?xEbouSfI5NM6oa5ZloWphP6e+lP5Zely?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U04yb3lOcXlMeTVUWWplaUx2YUZRK0sxcC9SWnVqK3o5eTRFcGxtMEdacUR3?=
 =?utf-8?B?eDNaRllORGc2cU5UOFBOODY4MWhxWEdOdjNJekNJeWNXQnNDSFlNWXRkY2V3?=
 =?utf-8?B?SGJTalowU1dkTFVHQllPUzg1Y240SDRja012clZjdDNubGVhMmFJcmpaNDBS?=
 =?utf-8?B?OU45RDI5WFZMU0RCdHIrbzYzVzhjbGlIdkNZMHZGeEZ3WlZHWm1WSkVCcjcz?=
 =?utf-8?B?bVNHOWpqaWFqUlB4VDIwMXZBZllLL2YxRHZPRG1JYkl3Ky9LL2lxTHVzN2Y0?=
 =?utf-8?B?V0FBMVhvK0FHbVhLUzBnanpPZkxwUFN4SFE3VzJEN0VZcjFqZllhcFZuTjhX?=
 =?utf-8?B?dUdwK3RIaXBjZVhIODJLbE5WTTArY2FJVHYvRjl2cExUTEZ1VkRiSnFjVkJY?=
 =?utf-8?B?MUdyS2RqNlp6NkV6Q0xKRklJaHFPUlVSODNySjdaeTRhdXg4WjFqdEFGS2hW?=
 =?utf-8?B?YkgxbGVoNGhRZXBpakdqZWtIVCtsOHpDVXJ1eEU5YkZGcWVsSlZicG9hbTho?=
 =?utf-8?B?cTRTVm9RTDYvbzBSSkNMMlFFQytFTWNMek9yNHJkUitFNTg0dlZtbS9QNHJh?=
 =?utf-8?B?R3FMOGJrbFk1TjFPRzlRc3ptaWUwMjd2TzhNSjNMUHlGR2RlaFRSWjMyNkhT?=
 =?utf-8?B?RUlyNXhwYk5BYVZvOUgrQTZObWlwR1hsWDVWN28yQmVrL0ZtWElMeWVrT3kr?=
 =?utf-8?B?eFNvaTgzdHhIT0Rhc0ttTWJ0ZlJmSk40WnlZM2hIMGNuTkhwbTZKa09HQmJR?=
 =?utf-8?B?YS9WdEprL285QnJMa2lkcmtUYnBOamROREVxVXBORG9VTU5HaDh5dFMxZmx4?=
 =?utf-8?B?cFY2cU9yM0Z0U0h4R0NqYi9iaWxQMFZEUWphVGVJRnBCdUhrRFdpeHlmaGJz?=
 =?utf-8?B?bXY0aXljYlhkdlRrTlZUZlFvbTdWNlhPMEd3TDY5ejFqU1RPM1o3bXdGSWhY?=
 =?utf-8?B?Q2luMFZxWnE0TzNxNklzTStkOHZPZnVsQ0xUYzN6ZEt6Y08wUVR3UWdMSFZP?=
 =?utf-8?B?T2xtNVZFSWtMRVRjZTlPVXNpSHpxNE8wSkt4RWwwazZQbWdMRXFZZUU1N3c1?=
 =?utf-8?B?aFhrVi82ZW9PTGJEZGdsaXBOSG9RcjBvWEM3eUhCdkU0Z2FXMmhGTUs0TDFT?=
 =?utf-8?B?UnJVcldTYm1LSllDcG9ReExqUHhXUEVCbEg2N0pJd2JGSEQrZFNwWGdQMit4?=
 =?utf-8?B?QlNPRkowZFk2dmF1UE1yMzJSUFByMEdzR3VsWmw3UHUrTkdxcEM1b1pPUkQw?=
 =?utf-8?B?Y3dIRm16OWtIVGV0ekdBL0lvUUo2ZFRWdWszVFF2YWN0MUpwR20yUUN2OVAw?=
 =?utf-8?B?Rm1qQjlXbmNFeWJ6K0JkSlJvN1U2UFlGMUFOcENkenNmWDNRcEo5YWxVS0Nt?=
 =?utf-8?B?UnhUTG9UcS9yTlVyU3pqdXAyODhwZkhxM1kvQVdrTldBcFp3RFRHQmN4dHpi?=
 =?utf-8?B?Q000UVBGaktXcUNrSVY3YlJuN1Roak5zbDFRV3NvV0JMNDcvQ2VpT1dqQ1Jh?=
 =?utf-8?B?ZUlRUG44b1piTXZCYU02dmdsZWwxamlRcHlTYnpIYkNMZm9MMW5HMVdNK2x0?=
 =?utf-8?B?TFFUR2QyRTJZOUlYZDVZODVDNmJqUnBuQ21wcHZmN0EvN3E5UXI5MXI1NDMr?=
 =?utf-8?B?ckNLeXdjMVo2bEF0eXZOWG5vT1V5cHFqRFBTb09aeFhPQVlsM3QzME02V05E?=
 =?utf-8?B?UFVTRTJqSVd6VEZ6N2hsRjdBWGZMb1JJejZGaXJjTUhKNmhBRXJHUUNPWWI4?=
 =?utf-8?B?a2FVL2lVNTdQVVprSXFiaTFSUjkwN1V2N0xEb05LWXphbUFRbjZ1TVhTMEVj?=
 =?utf-8?B?aWlEZUtqYkpia3BvQ1RJRGlnNUk1SFhNZXNvZU8xL0o4OFMwcTE5TWg1ZUNL?=
 =?utf-8?B?aFhDQ1psMURwVThxY2s0bEloTzhRNkNQN2pINm1SeittWS8yYTV3Uk9GRjAx?=
 =?utf-8?B?SE5hdVZFaXBzYjNMd0VVMkhOdURRbWMrZExpSE40K2tYMUVMaGtUdEpkVEVL?=
 =?utf-8?B?bUJQUGtCNU1CTmZMTEtyV2tra25ZQVZmK3RROTMwcnNDaVEwNlMrc0FBRXlM?=
 =?utf-8?B?N2RjSlFjMXo5Z0RjbXpiSWc3L2pPVmErMWFpOStzRFFRS1Nyb05PZVQ5d3JQ?=
 =?utf-8?B?K2xaQWFwQy80RGdXL29NN1c3WEdoSUlEYUtJZU9lQW1xTXVVYXR1TGdNOEFy?=
 =?utf-8?B?b0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e821a95b-fda5-4dfd-a10e-08dd6e1c07e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 17:14:42.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pogqOOpRmwv92zk1nPo3KK3f0XIHawBQNst6yoQISbfVB9vwpPyfqFVRBYmUs5LOcXhr+Flr1UUpTaVHTvhmBPzEy+J6CJEFnsCU4iTknc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8668

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMjggTWFyY2ggMjAy
NSAxNzoxMQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDA3LzE4XSBjYW46IHJjYXJfY2FuZmQ6
IEFkZCBybmNfc3RyaWRlIHZhcmlhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4g
DQo+IEhpIEJpanUsDQo+IA0KPiBPbiBGcmksIDI4IE1hciAyMDI1IGF0IDE3OjQ2LCBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gT24gRnJpLCAyOCBNYXIgMjAyNQ0K
PiA+ID4gYXQgMTY6MzksIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+IEJ5IGludHJvZHVjaW5nIHNldHJuYygpLCB0aGlzIHBhdGNoIGlzIG5vIG1v
cmUgbmVlZGVkIGFzDQo+ID4gPiA+IHJuY19zdHJpZGUgaXMgbG9jYWwgdmFyaWFibGUgaW5zaWRl
IHN0cm5jKCkuIFNvIEkgd291bGQgbGlrZSB0bw0KPiA+ID4gPiBkcm9wIHRoaXMgcGF0Y2ggaW4g
bmV4dCB2ZXJzaW9uLg0KPiA+ID4gPg0KPiA+ID4gPiBbMV0NCj4gPiA+ID4gc3RhdGljIHZvaWQg
cmNhcl9jYW5mZF9zZXRybmMoc3RydWN0IHJjYXJfY2FuZmRfZ2xvYmFsICpncHJpdiwgdTMyIGNo
LA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbnVtX3J1bGVzKSB7
DQo+ID4gPiA+ICAgICAgICAgdTMyIHNoaWZ0LCBybmMsIG9mZnNldCwgdywgcm5jX3N0cmlkZTsN
Cj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICBybmNfc3RyaWRlID0gMzIgLyBncHJpdi0+aW5mby0+
cm5jX2ZpZWxkX3dpZHRoOw0KPiA+ID4gPiAgICAgICAgIHNoaWZ0ID0gMzIgLSAoKGNoICUgcm5j
X3N0cmlkZSArIDEpICogZ3ByaXYtPmluZm8tPnJuY19maWVsZF93aWR0aCk7DQo+ID4gPiA+ICAg
ICAgICAgcm5jID0gKG51bV9ydWxlcyAmIChncHJpdi0+aW5mby0+bnVtX3N1cHBvcnRlZF9ydWxl
cyAtIDEpKSA8PCBzaGlmdDsNCj4gPiA+ID4gICAgICAgICB3ID0gY2ggLyBybmNfc3RyaWRlOw0K
PiA+ID4gPiAgICAgICAgIG9mZnNldCA9IFJDQU5GRF9HQUZMQ0ZHKHcpOw0KPiA+ID4gPiAgICAg
ICAgIHJjYXJfY2FuZmRfc2V0X2JpdChncHJpdi0+YmFzZSwgb2Zmc2V0LCBybmMpOyB9DQo+ID4g
Pg0KPiA+ID4gTmljZSENCj4gPiA+DQo+ID4gPiBQbGVhc2UgY29tYmluZSB2YXJpYWJsZSBkZWNs
YXJhdGlvbiBhbmQgYXNzaWdubWVudC4NCj4gPiA+IFdoaWxlIGF0IGl0LCBwZXJoYXBzICJ1bnNp
Z25lZCBpbnQgY2giIGFuZCAidW5zaWduZWQgaW50IG51bV9ydWxlcyI/DQo+ID4gPiBBY3R1YWxs
eSBhYm91dCBldmVyeXRoaW5nIGFib3ZlIHNob3VsZCBiZSB1bnNpZ25lZCBpbnQsIGV4Y2VwdCBy
bmMuDQo+ID4gPg0KPiA+ID4gSSBrbm93IHRoaXMgZXhpc3RlZCBiZWZvcmUsIGJ1dCBkbyB3ZSBu
ZWVkDQo+ID4gPg0KPiA+ID4gICAgIG51bV9ydWxlcyAmIChncHJpdi0+aW5mby0+bnVtX3N1cHBv
cnRlZF9ydWxlcyAtIDEpDQo+ID4gPg0KPiA+ID4gPyBUaGF0ICImIiBvbmx5IHdvcmtzIGFzIGxv
bmcgYXMgbnVtX3N1cHBvcnRlZF9ydWxlcyBpcyBhIHBvd2VyIG9mDQo+ID4gPiB0d28sIGFuZCBJ
IHRoaW5rIG51bV9ydWxlcyBjYW4gbmV2ZXIgYmUgbGFyZ2VyIHRoYW4gbnVtX3N1cHBvcnRlZF9y
dWxlcyBhbnl3YXkuDQo+ID4NCj4gPiBCdXQgdGhpcyB3aWxsIG1ha2Ugc3VyZSBpdCBmaXRzIGlu
dG8gZmllbGRfd2lkdGggZm9yIG51bV9ydWxlcy4NCj4gDQo+IENhbiBpdCBldmVyIG5vdCBmaXQ/
DQoNCk5vLiBBVE0sIHdlIHNldCBudW1fcnVsZXMgPSAxLiBTbywgaXQgaXMgc2FmZSB0byBkcm9w
ICJudW1fc3VwcG9ydGVkX3J1bGVzIi4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo=

