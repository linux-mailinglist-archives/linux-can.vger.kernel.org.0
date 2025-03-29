Return-Path: <linux-can+bounces-3293-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F68A7564D
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 13:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92277A16B3
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3311C5D61;
	Sat, 29 Mar 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FqfM8lEO"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908B1C3308;
	Sat, 29 Mar 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743252874; cv=fail; b=nELbMzwWLBBdGa/3KsrimcFsPbWqTisdY/OQBiCC6FQ84P7CNHxmG675mKOxpcNT3jJy+4FOevxXRVqs1eau4lM4QAbyGHiXUidqGqFurZ/WUBsgLT8BNPYqJQqJKo9Bf4TnJwGMzkVuCsN+gluRzSUFGdGYPaKuvdmlsGq6Av0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743252874; c=relaxed/simple;
	bh=l/gJkZuSfteZPou6+fM5utmyVjWdaK/6FtcKCdDZHK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+qPV/iO+NybK21sC7wHsqF/wZNNjzdLgjBB7h1xQOfvPEjhx0afSQ32igB22Kdi3HwbZ4ktce333RXn84NCbKaCM5M3Dp2xYNa8rmsg5CRex2hyK8e0mUgLWBheznQhrI7AO+NHwEvW/jJ+R/qfpXeqnMGxjGBuxJEZ72b5+5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=FqfM8lEO; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF+TfnmJDlvlzg2YmOHMF1iqdAw0YAah1iNveHizIdm8DHchqQBpeu1bSCso/ddb9Ja2xsERrCMp7opGZp4cb6k/hoQfjzo56DanoeiTTso5Gi9JNP8zyoIjwJ9o1/d+nk60D789CaWoOa5zKiOZsYbPTAe7t0guJuMVnw8BBwxq7BrDc6/3ocy7MNLWZXtzQyl13IlfY+5sk7ui5CF2NpWQ5JkUXPGpJ3q6bsxvE56YnyZUhYV5W9JKKaejjnmwxGwnXAK14ovYaALxt5pjba8FK/N2X2cS2V0iszRbDHtLLs5XaJfWn8WU24inpCAoQCSDRVVjPpeqX4rvjndXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/gJkZuSfteZPou6+fM5utmyVjWdaK/6FtcKCdDZHK8=;
 b=C8pOlPy8TX/zgUwfOz+/u1FhVFNzawtxqE6bWyjx1lzu+GFA5+G13sB+LNsAkVmczhzjEP4TQNtIpeTDy0tvJDwjLqD49F8nSOTVQ6ikqHyQILoxh2s4HO/fhvv9KcwEk0oooFShAfLOcZQbzqPRec0gNaWJ/cCmQyOVrPLJ+7TS3lSLk8bmB2vPy9uDoRJJKCsogIingdu/c4ceZL8gUzrX130hcrrEpIcw9aFgQ3NQIN4hYkH2pco1AYMcU1Ca/rIIdoYnLzGWLTdxu8+vHsZVGiZ4Xjki1p3O1gRMWNwNt2O3tnK4V0gG6xEMpTWm4iouB8+g2Cm1/XebJnx+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/gJkZuSfteZPou6+fM5utmyVjWdaK/6FtcKCdDZHK8=;
 b=FqfM8lEOtpvjsNI6D2iwNikLxWQLiK8k0WYr+zILJO7C9BIPCLQ1pLzI2RrhPF9VDfuboSlgDvZ7ICwgskmE4rKpi4J/Mv8FzT7d6zKSDZXOAOAe2x8Vq/dvKkuW/cJW92EeD0o99Idu/3NNyV7m2wbw4Vyz/Zzjv+u9g9FLAEo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11281.jpnprd01.prod.outlook.com (2603:1096:400:3d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.51; Sat, 29 Mar
 2025 12:54:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8583.028; Sat, 29 Mar 2025
 12:54:29 +0000
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
Subject: RE: [PATCH v7 14/18] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 14/18] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
Thread-Index: AQHbnkmNAL0jRP1y8EqmTeCj0JLD2LOInCOAgAF6RIA=
Date: Sat, 29 Mar 2025 12:54:29 +0000
Message-ID:
 <TY3PR01MB11346D77C31FCD878687AEF5C86A32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-15-biju.das.jz@bp.renesas.com>
 <014afe2e-768a-45ad-9e43-f2fd6a003663@wanadoo.fr>
In-Reply-To: <014afe2e-768a-45ad-9e43-f2fd6a003663@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11281:EE_
x-ms-office365-filtering-correlation-id: c95d955b-2771-4614-593d-08dd6ec0d815
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjVrYWtTY1BFallnMjZPYTJyOU5nbGFMZFB0RE43UlBHcVRqZ010OWlab3ox?=
 =?utf-8?B?QUg3S3dvU2NTbVlBRk41ZnZFbEYrSHkyUkRIRnVsS0FPc1BKYW0zaHo5MTBC?=
 =?utf-8?B?RXNscHhhVkhENDdKMXRBWnhMejdzZ2t2N3pnc1IzM2VuTUUvcWJ4RWNMSlAw?=
 =?utf-8?B?cnFlVG9HWUtDM1hCQk1mK3NGdmtzRVMvYkhJYTVMRTcyNVF2aVF0bldJVUNQ?=
 =?utf-8?B?dHRRQzBmMHRSRVpabUYrV1RPWGlxUi9NQVBqV2lwblF4TWgveXJENzZpb2hF?=
 =?utf-8?B?NGhkUkZVZzQ4WkpBc3NPZXVmb1hGSGx0SkRoaENTVEZXT3JhV252NzZMS3BR?=
 =?utf-8?B?SEJYZytZQlhOWEtCejNzRFZEcVBRaXpQcVhSWFNXMXltNjZ5MU5kbXZiS0xG?=
 =?utf-8?B?WUJSZHFvVjJnb2RuL0xHeUVqa1pXOVhHUG04bGpXaTYvbVFYTjM5NzJBWXdh?=
 =?utf-8?B?WXBoOUZuV2pPQ3lsR1lJTjU1eWtod1VCWGtZaTBaWDZsT2RXdFVYclpybzZQ?=
 =?utf-8?B?NHYvZ0MvcG9sL3pOYVNweXBaOVhYWHJxL2FlOUUzMm0zNFc1cjhTV3VlU0c4?=
 =?utf-8?B?NWFLUmY5RnlVWWY2SGpYZlhWMjQyZ25lMDV5amZrR3gxZmc0RWxOcEluSGxo?=
 =?utf-8?B?ZlpQNjc3TzlwZFRua3BiT1R3aGVhNmREV05oRUxCdHR0OVJabFhlcUp4bmlj?=
 =?utf-8?B?LzNQMkpMREQwOHd0NjVNQnl3d1FYdnljdHFMeHgybzVrRWdaMW1MU1FoNERU?=
 =?utf-8?B?dkZWUndOZjRZajFQN0xhY29lYkRLRVNZeXFjaXpEYnYzd2dNa2xrQmdBR3ZL?=
 =?utf-8?B?M056RXpLWklwVS9xUi9rMTI0bXRVZ3JucFlGL2QvN2VwN2ZrTVNIQmxKVXR0?=
 =?utf-8?B?TU5VeDlpWGhtbk9UZGZ6QmpxTnpaVmVWUkFqWEkzV2FkNmZuZFhQSzBMY2xh?=
 =?utf-8?B?WWxOT0dkMEZPRkZ1cVFVeEJJbDRmMndXdDBFYSswZ29KeDViVkxsQUtlZGsy?=
 =?utf-8?B?MHZrMmNOMGdHVW1MajVxMjdzV2dYeFpPMG82R1FoNHh0WnJmYVNPRFFrQ2l6?=
 =?utf-8?B?Tmt1cnpHR2VvYlBSaHZwN0VJUUVUVnNLZlVqTlZONUpMR0owbTdxb05xTjVl?=
 =?utf-8?B?eWhRQk8wMXordmlocXAyN2tveFZZc1ZNZEN3UDc4dklNTDV0Wlp5YXpqSHgy?=
 =?utf-8?B?U0xXNzJQNnBvSUM4WVY0UTFYTEVoOXp5SUJwUXIxNy80Q3lIaWVXZDMvNlEw?=
 =?utf-8?B?SitIVWFaQW90L2ppSHBDckhtaFdlRVBtRlM1Wnl0ZTVBUGVQV1BKRHhQcmdR?=
 =?utf-8?B?amY2NFdRdWhNNHloWEFYWG9iS3J5VE1nbW5YektnMmxSVzFSaUpjL0xXVGsv?=
 =?utf-8?B?MURlanBsT1BaMWw0aWt1aDFYeUtBQWs3UktQZUtRcEJ5c0hFR3R5MmwySWoy?=
 =?utf-8?B?bVY1bWJQWHpYbGNHN0luVWRpamRUWFR3cG5hS1ZLbDBSWEtyQ0kydzBCc3ZT?=
 =?utf-8?B?V3JuNUZPeWRHTWgzK1pSSnJ2Vk1DbWNRSUpzaXZtczU5TFA2RkZHaGRBSnUr?=
 =?utf-8?B?b21weXpoRTNOUzBPUll5WEpqdEdUUDFZamxDYjBWaXFBd0NEKzZxMEphN1pp?=
 =?utf-8?B?Ykg1OXNRVG4xVHVMeTV4d09yQVBJRG1IQTdPQXBJUUliOGtya1lVTWo1YnZy?=
 =?utf-8?B?dFR1QlhLNFh2RFB6VmlPaWNjbVFRSmN5NFZqbTRIVWtieURpNE9HOEdvaHBU?=
 =?utf-8?B?Z0djMThGTW1KTWpMMGovOWhvc2NWTXZodUc4N1N4RWNPeFJMZktwcnp4V082?=
 =?utf-8?B?VC84QzFqZE4wMXJRTk9MT1R6NC8yVHJIejFoS2xhZG5aUUs4ckdla3NsVFY3?=
 =?utf-8?B?Y0sxSVNnam0zVDI4VVM5WWVKYUIyR2g3b1M5Ynl1dFhYTDUrdENOYmQwVVJW?=
 =?utf-8?Q?ECZJUeI/XPSFLuFbXeb0Q6ZVb4a0i1GX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUV6UVkvY05qZzJ1WDhHMUV6UlY4SEpUL2NkaWRwNEpGN2xwZlBtZEYzeVkr?=
 =?utf-8?B?RWdzVzRqNHdmVmw5ZHZvNHFCRnUvVVlaVmorN2pUMHQweU5ZdkJkM0lFdHZQ?=
 =?utf-8?B?MHpxK3ZFaFc1dnJMRnhlR1g5SllMUU5xbjlteThLZzY1Q2paVkpKOWdyV3l4?=
 =?utf-8?B?OWpROHNIMlQ4VEZYV2w4V1BFcG1vUy9ENjFpNnlrdFlFYWF2S3ZTV2laT2Zs?=
 =?utf-8?B?R1c2WEJPSkJNWVlNZ0h6bENYNnhtUFBTYkFFay9UZ1V0Y09mR0d3TkFYZTht?=
 =?utf-8?B?dGlZSjNLdVUvb09NbFhjOGVBSzVCL2tUZGhuVGE0U2thMmVnSWdNaWJvSEZt?=
 =?utf-8?B?eklCL3FjdkdQNVRONWY3S2hZU1NpekdmYS9XTjh2dkdpRkM3SHBxN0s5bU1J?=
 =?utf-8?B?L3Z2cFBDbzhoN2tIV2tYVzdhc3ZSWUlNZ0F1MDkxOTlEVGVaM2hnRVRvSXFR?=
 =?utf-8?B?M1ZiOFd2RUlLRk9NUHAraTR0eDE3d1hBNnVyWXdFdTFKWjh4Vi9EQWY5L3ln?=
 =?utf-8?B?NGx6MUM3WGJzaEJjZmt2dFRlZkxncGI3alZpeEtGVXYzVXlFSXdkZnNVRlVX?=
 =?utf-8?B?VVVNUFhkZ2NiUUtJQnJDSTRtdm1nT0xJQmY2OG9LTHpIMUxHcndIaFlNQXpV?=
 =?utf-8?B?NWNWVDhEci9oZmJyUktXZnNvS0UrNE9xYzVCWjRmcnZDdHZUdE04TDdPeXFS?=
 =?utf-8?B?cUxOOHcwWDl5dFBEUEI3Z0p2clJoQjhTeTM4TUlRYUZYVU9Td3ZvSGFCRm50?=
 =?utf-8?B?YUx6ZytDaFNhVmNKU3lEZUlKZG9ZWVZtS3FoVlFSM1dqNkxoRWEvdENBMzFn?=
 =?utf-8?B?NTloVW1PbTExdWdTbjRFaTRNZFFiKzJnbEh1ZmtKRzhlVE1PdEhUYVF6M0Ni?=
 =?utf-8?B?UVpEK2lJNTdGdVBhZjNsUXpYWXN4NGZpTEppUmNaUlBTbElMVXdqZENBNFhm?=
 =?utf-8?B?WFdJRWh0OFptMXpvOENlT1BFV1hxRThGR00rOUdSL1JQREJnYjd1cTRNc2Zu?=
 =?utf-8?B?cDRPeXhBZVJXY21nU2JnWmFLcXROYUVJNE1CaElCK2ozM0lOVXRXZHBGb2la?=
 =?utf-8?B?eXNkQU4wRS9BZ3BLbGVxaW14OWpnZ3k5WWRib09SbVo2ODNRUWhIcHZHaWRN?=
 =?utf-8?B?T2toOFlocWlqR1FpbmJlTmJnVytzOUR2aUd6MktUazFPd2NUTXg2SDYreHZr?=
 =?utf-8?B?a01TNFpISXlXWHR3RUwxSjE0SWp2WGVqbTc0UDNPVUg0anJka1BiWDBNSGtj?=
 =?utf-8?B?eEEyY0g3UU9odnlPdVpYcDRIamFuWWxaZE1aZTF5bmJCWkhrRmtna2h6MGp0?=
 =?utf-8?B?Q2NCWmZyQ0ptRTFaQkhUYnpWclYwSUxBdno1TWExZ3FGL3V4UjBUa2tZYlJn?=
 =?utf-8?B?elV6L3hpcWIvdHIvOGJQRnVrSUdCK0FKb0JwYUhGeWpQQlh4UU1nRVQ4Nk54?=
 =?utf-8?B?bTRZdE9SazFLbWJUYVl5SDRud3puUm52ZDJLeDV1aVd1VzZOWjR3Z2NQRWF6?=
 =?utf-8?B?K2dCeVRURG1yYzZxT2RhNkxZQVlaRkpXaVZHV2hzZVRCcWxJY0JQYU1NSUF2?=
 =?utf-8?B?d2ZJOWgxNVVSd3U3QUU4c2FORUN3TlFHd0FueWtYK2V3OFF0WHZhU256dXpl?=
 =?utf-8?B?aEd0amlFdEhxQW1iR29zdW1jSHZpT3QxWUtnMG5QcUFQdk1xY1N2SnhPS0Zo?=
 =?utf-8?B?Vm94VkxCb2F6NW8zeU1iL0FMRzBMQm90amtlUW1oRUtCa29jSmVTYWdycTFo?=
 =?utf-8?B?UHNMZkRUekVhdExma2V4TU5ra1EyOERsK2t5WkdGbERPdlhtS08zcVU3Vlk3?=
 =?utf-8?B?dFVyV0FjZ01WZFZFN1E3SExCc1pDVnZER3Y5aGFzL2wyWjNtQWNxWXBtd1A1?=
 =?utf-8?B?azFjYVR5cnBLa0hxMzZSVTR4bEdpZVhWczhKZUhKZFRqU2JRa1VId0F5cU5J?=
 =?utf-8?B?NHo3b3UyRmN6SEVYQUxkb0FEaXhBMVFSRXpHTnQ4bWJCc1pEeWdnaHJTazd4?=
 =?utf-8?B?Qks4bkhrZmtiaktyaEF0WjEyaU5nZjh6WXVLY0VvZ3Y3NEFNOFlydll6WVZS?=
 =?utf-8?B?YzRITEV4R1JYVUdpUUNLTG80OW4rcGhzRHdLT0ZibnBqNkk0elpoL2REOEYw?=
 =?utf-8?B?aWVSbjZmZXc1SFRvb3BaZis3VXd6NnBCNzhrTm5Bdk0zMFdMQUtXa2kvQnpY?=
 =?utf-8?B?cmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c95d955b-2771-4614-593d-08dd6ec0d815
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 12:54:29.3925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/OTQR5iOf7sJ0uT/CfgJ6hKKNyVz24VqfObgPlfKegv9vd6WISGlSKOkuJF04zWOmrfzOgmHa89zlwR6mq71HhQTVptJ0LV3/qDNmnCqYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11281

SGkgVmluY2VudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4NCj4gU2VudDogMjggTWFyY2ggMjAyNSAxNDoxOQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDE0LzE4XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCByZWdpc3RlciBtYXBwaW5nIHRh
YmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IE9uIDI2LzAzLzIwMjUgYXQg
MjE6MTksIEJpanUgRGFzIHdyb3RlOg0KPiA+IFItQ2FyIEdlbjMgYW5kIEdlbjQgaGF2ZSBzb21l
IGRpZmZlcmVuY2VzIGluIHRoZSByZWdpc3RlciBvZmZzZXRzLiBBZGQNCj4gPiBhIG1hcHBpbmcg
dGFibGUgdG8gaGFuZGxlIHRoZXNlIGRpZmZlcmVuY2VzLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6
IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0K
PiA+IHY2LT52NzoNCj4gPiAgKiBObyBjaGFuZ2UuDQo+ID4gdjUtPnY2Og0KPiA+ICAqIE5vIGNo
YW5nZS4NCj4gPiB2NC0+djU6DQo+ID4gICogSW1wcm92ZWQgY29tbWl0IGRlc2NyaXB0aW9uIGJ5
IHJlcGxhY2luZyBoYXMtPmhhdmUuDQo+ID4gICogQ29sbGVjdGVkIHRhZy4NCj4gPiB2My0+djQ6
DQo+ID4gICogQWRkZWQgcHJlZml4IFJDQU5GRF8qIHRvIGVudW0gcmNhcl9jYW5mZF9yZWdfb2Zm
c2V0X2lkLg0KPiA+IHYzOg0KPiA+ICAqIE5ldyBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jIHwgNDgNCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3Jj
YXJfY2FuZmQuYw0KPiA+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4g
aW5kZXggMzYwOTk5ZTZhYjQ1Li5hOTZjZjQ5OWYwNGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3Jj
YXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTI5OCw3ICsyOTgsNyBAQA0KPiA+ICAjZGVmaW5lIFJD
QU5GRF9STU5EKHkpCQkJKDB4MDBhOCArICgweDA0ICogKHkpKSkNCj4gPg0KPiA+ICAvKiBSU0NG
RG5DRkRSRkNDeCAvIFJTQ0ZEblJGQ0N4ICovDQo+ID4gLSNkZWZpbmUgUkNBTkZEX1JGQ0MoZ3By
aXYsIHgpCQkocmVnX2dlbjQoZ3ByaXYsIDB4MDBjMCwgMHgwMGI4KSArICgweDA0ICogKHgpKSkN
Cj4gPiArI2RlZmluZSBSQ0FORkRfUkZDQyhncHJpdiwgeCkJCSgoZ3ByaXYpLT5pbmZvLT5yZWdz
W1JDQU5GRF9SRkNDXSArICgweDA0ICogKHgpKSkNCj4gPiAgLyogUlNDRkRuQ0ZEUkZTVFN4IC8g
UlNDRkRuUkZTVFN4ICovDQo+ID4gICNkZWZpbmUgUkNBTkZEX1JGU1RTKGdwcml2LCB4KQkJKFJD
QU5GRF9SRkNDKGdwcml2LCB4KSArIDB4MjApDQo+ID4gIC8qIFJTQ0ZEbkNGRFJGUENUUnggLyBS
U0NGRG5SRlBDVFJ4ICovIEBAIC0zMDgsMTMgKzMwOCwxMyBAQA0KPiA+DQo+ID4gIC8qIFJTQ0ZE
bkNGRENGQ0N4IC8gUlNDRkRuQ0ZDQ3ggKi8NCj4gPiAgI2RlZmluZSBSQ0FORkRfQ0ZDQyhncHJp
diwgY2gsIGlkeCkgXA0KPiA+IC0JKHJlZ19nZW40KGdwcml2LCAweDAxMjAsIDB4MDExOCkgKyAo
MHgwYyAqIChjaCkpICsgKDB4MDQgKiAoaWR4KSkpDQo+ID4gKwkoKGdwcml2KS0+aW5mby0+cmVn
c1tSQ0FORkRfQ0ZDQ10gKyAoMHgwYyAqIChjaCkpICsgKDB4MDQgKiAoaWR4KSkpDQo+ID4gIC8q
IFJTQ0ZEbkNGRENGU1RTeCAvIFJTQ0ZEbkNGU1RTeCAqLw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9D
RlNUUyhncHJpdiwgY2gsIGlkeCkgXA0KPiA+IC0JKHJlZ19nZW40KGdwcml2LCAweDAxZTAsIDB4
MDE3OCkgKyAoMHgwYyAqIChjaCkpICsgKDB4MDQgKiAoaWR4KSkpDQo+ID4gKwkoKGdwcml2KS0+
aW5mby0+cmVnc1tSQ0FORkRfQ0ZTVFNdICsgKDB4MGMgKiAoY2gpKSArICgweDA0ICogKGlkeCkp
KQ0KPiA+ICAvKiBSU0NGRG5DRkRDRlBDVFJ4IC8gUlNDRkRuQ0ZQQ1RSeCAqLyAgI2RlZmluZSBS
Q0FORkRfQ0ZQQ1RSKGdwcml2LA0KPiA+IGNoLCBpZHgpIFwNCj4gPiAtCShyZWdfZ2VuNChncHJp
diwgMHgwMjQwLCAweDAxZDgpICsgKDB4MGMgKiAoY2gpKSArICgweDA0ICogKGlkeCkpKQ0KPiA+
ICsJKChncHJpdiktPmluZm8tPnJlZ3NbUkNBTkZEX0NGUENUUl0gKyAoMHgwYyAqIChjaCkpICsg
KDB4MDQgKg0KPiA+ICsoaWR4KSkpDQo+ID4NCj4gPiAgLyogUlNDRkRuQ0ZERkVTVFMgLyBSU0NG
RG5GRVNUUyAqLw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9GRVNUUwkJCSgweDAyMzgpDQo+ID4gQEAg
LTQzMCw3ICs0MzAsNyBAQA0KPiA+ICAvKiBDQU4gRkQgbW9kZSBzcGVjaWZpYyByZWdpc3RlciBt
YXAgKi8NCj4gPg0KPiA+ICAvKiBSU0NGRG5DRkRDbVhYWCAtPiBSQ0FORkRfRl9YWFgobSkgKi8N
Cj4gPiAtI2RlZmluZSBSQ0FORkRfRl9EQ0ZHKGdwcml2LCBtKQkJKHJlZ19nZW40KGdwcml2LCAw
eDE0MDAsIDB4MDUwMCkgKyAoMHgyMCAqIChtKSkpDQo+ID4gKyNkZWZpbmUgUkNBTkZEX0ZfRENG
RyhncHJpdiwgbSkJCSgoZ3ByaXYpLT5pbmZvLT5yZWdzW1JDQU5GRF9GX0RDRkddICsgKDB4MjAg
KiAobSkpKQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9GX0NGRENGRyhtKQkJKDB4MDUwNCArICgweDIw
ICogKG0pKSkNCj4gPiAgI2RlZmluZSBSQ0FORkRfRl9DRkRDVFIobSkJCSgweDA1MDggKyAoMHgy
MCAqIChtKSkpDQo+ID4gICNkZWZpbmUgUkNBTkZEX0ZfQ0ZEU1RTKG0pCQkoMHgwNTBjICsgKDB4
MjAgKiAobSkpKQ0KPiA+IEBAIC00NDYsNyArNDQ2LDcgQEANCj4gPiAgI2RlZmluZSBSQ0FORkRf
Rl9STURGKHEsIGIpCQkoMHgyMDBjICsgKDB4MDQgKiAoYikpICsgKDB4MjAgKiAocSkpKQ0KPiA+
DQo+ID4gIC8qIFJTQ0ZEbkNGRFJGWFh4IC0+IFJDQU5GRF9GX1JGWFgoeCkgKi8NCj4gPiAtI2Rl
ZmluZSBSQ0FORkRfRl9SRk9GRlNFVChncHJpdikJcmVnX2dlbjQoZ3ByaXYsIDB4NjAwMCwgMHgz
MDAwKQ0KPiA+ICsjZGVmaW5lIFJDQU5GRF9GX1JGT0ZGU0VUKGdwcml2KQkoKGdwcml2KS0+aW5m
by0+cmVnc1tSQ0FORkRfUkZPRkZTRVRdKQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9GX1JGSUQoZ3By
aXYsIHgpCQkoUkNBTkZEX0ZfUkZPRkZTRVQoZ3ByaXYpICsgKDB4ODAgKiAoeCkpKQ0KPiA+ICAj
ZGVmaW5lIFJDQU5GRF9GX1JGUFRSKGdwcml2LCB4KQkoUkNBTkZEX0ZfUkZPRkZTRVQoZ3ByaXYp
ICsgMHgwNCArICgweDgwICogKHgpKSkNCj4gPiAgI2RlZmluZSBSQ0FORkRfRl9SRkZEU1RTKGdw
cml2LCB4KQkoUkNBTkZEX0ZfUkZPRkZTRVQoZ3ByaXYpICsgMHgwOCArICgweDgwICogKHgpKSkN
Cj4gPiBAQCAtNDU0LDcgKzQ1NCw3IEBADQo+ID4gIAkoUkNBTkZEX0ZfUkZPRkZTRVQoZ3ByaXYp
ICsgMHgwYyArICgweDgwICogKHgpKSArICgweDA0ICogKGRmKSkpDQo+ID4NCj4gPiAgLyogUlND
RkRuQ0ZEQ0ZYWGsgLT4gUkNBTkZEX0ZfQ0ZYWChjaCwgaykgKi8NCj4gPiAtI2RlZmluZSBSQ0FO
RkRfRl9DRk9GRlNFVChncHJpdikJcmVnX2dlbjQoZ3ByaXYsIDB4NjQwMCwgMHgzNDAwKQ0KPiA+
ICsjZGVmaW5lIFJDQU5GRF9GX0NGT0ZGU0VUKGdwcml2KQkoKGdwcml2KS0+aW5mby0+cmVnc1tS
Q0FORkRfQ0ZPRkZTRVRdKQ0KPiA+DQo+ID4gICNkZWZpbmUgUkNBTkZEX0ZfQ0ZJRChncHJpdiwg
Y2gsIGlkeCkgXA0KPiA+ICAJKFJDQU5GRF9GX0NGT0ZGU0VUKGdwcml2KSArICgweDE4MCAqIChj
aCkpICsgKDB4ODAgKiAoaWR4KSkpIEBADQo+ID4gLTUwMSwxMSArNTAxLDIyIEBADQo+ID4gICAq
Lw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DRkZJRk9fSURYCQkwDQo+ID4NCj4gPiArZW51bSByY2Fy
X2NhbmZkX3JlZ19vZmZzZXRfaWQgew0KPiA+ICsJUkNBTkZEX1JGQ0MsCQkvKiBSWCBGSUZPIENv
bmZpZ3VyYXRpb24vQ29udHJvbCBSZWdpc3RlciAqLw0KPiA+ICsJUkNBTkZEX0NGQ0MsCQkvKiBD
b21tb24gRklGTyBDb25maWd1cmF0aW9uL0NvbnRyb2wgUmVnaXN0ZXIgKi8NCj4gPiArCVJDQU5G
RF9DRlNUUywJCS8qIENvbW1vbiBGSUZPIFN0YXR1cyBSZWdpc3RlciAqLw0KPiA+ICsJUkNBTkZE
X0NGUENUUiwJCS8qIENvbW1vbiBGSUZPIFBvaW50ZXIgQ29udHJvbCBSZWdpc3RlciAqLw0KPiA+
ICsJUkNBTkZEX0ZfRENGRywJCS8qIEdsb2JhbCBGRCBDb25maWd1cmF0aW9uIFJlZ2lzdGVyICov
DQo+ID4gKwlSQ0FORkRfUkZPRkZTRVQsCS8qIFJlY2VpdmUgRklGTyBidWZmZXIgYWNjZXNzIElE
IHJlZ2lzdGVyICovDQo+ID4gKwlSQ0FORkRfQ0ZPRkZTRVQsCS8qIFRyYW5zbWl0L3JlY2VpdmUg
RklGTyBidWZmZXIgYWNjZXNzIElEIHJlZ2lzdGVyICovDQo+ID4gK307DQo+ID4gKw0KPiA+ICBz
dHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWw7DQo+ID4NCj4gPiAgc3RydWN0IHJjYXJfY2FuZmRfaHdf
aW5mbyB7DQo+ID4gIAljb25zdCBzdHJ1Y3QgY2FuX2JpdHRpbWluZ19jb25zdCAqbm9tX2JpdHRp
bWluZzsNCj4gPiAgCWNvbnN0IHN0cnVjdCBjYW5fYml0dGltaW5nX2NvbnN0ICpkYXRhX2JpdHRp
bWluZzsNCj4gPiArCWNvbnN0IHUxNiAqcmVnczsNCj4gPiAgCXUxNiBudW1fc3VwcG9ydGVkX3J1
bGVzOw0KPiA+ICAJdTggcm5jX3N0cmlkZTsNCj4gPiAgCXU4IHJuY19maWVsZF93aWR0aDsNCj4g
PiBAQCAtNjEyLDkgKzYyMywzMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNhbl9iaXR0aW1pbmdf
Y29uc3QgcmNhcl9jYW5mZF9iaXR0aW1pbmdfY29uc3QgPSB7DQo+ID4gIAkuYnJwX2luYyA9IDEs
DQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHUxNiByY2FyX2dlbjNfcmVnc1tdID0g
ew0KPiA+ICsJW1JDQU5GRF9SRkNDXSA9IDB4MDBiOCwNCj4gPiArCVtSQ0FORkRfQ0ZDQ10gPSAw
eDAxMTgsDQo+ID4gKwlbUkNBTkZEX0NGU1RTXSA9IDB4MDE3OCwNCj4gPiArCVtSQ0FORkRfQ0ZQ
Q1RSXSA9IDB4MDFkOCwNCj4gPiArCVtSQ0FORkRfRl9EQ0ZHXSA9IDB4MDUwMCwNCj4gPiArCVtS
Q0FORkRfUkZPRkZTRVRdID0gMHgzMDAwLA0KPiA+ICsJW1JDQU5GRF9DRk9GRlNFVF0gPSAweDM0
MDAsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgdTE2IHJjYXJfZ2VuNF9yZWdz
W10gPSB7DQo+ID4gKwlbUkNBTkZEX1JGQ0NdID0gMHgwMGMwLA0KPiA+ICsJW1JDQU5GRF9DRkND
XSA9IDB4MDEyMCwNCj4gPiArCVtSQ0FORkRfQ0ZTVFNdID0gMHgwMWUwLA0KPiA+ICsJW1JDQU5G
RF9DRlBDVFJdID0gMHgwMjQwLA0KPiA+ICsJW1JDQU5GRF9GX0RDRkddID0gMHgxNDAwLA0KPiA+
ICsJW1JDQU5GRF9SRk9GRlNFVF0gPSAweDYwMDAsDQo+ID4gKwlbUkNBTkZEX0NGT0ZGU0VUXSA9
IDB4NjQwMCwNCj4gPiArfTsNCj4gDQo+IFRoZSBtYXBwaW5nIGlzIGNvbnZpbmllbnQgd2hlbiB5
b3Ugd2FudCB0byBpdGVyYXRlIHRocm91Z2h0IGl0LiBIZXJlLCBpZiB5b3UganVzdCB3YW50IHRv
IGFjY2VzcyB0aGUNCj4gb2Zmc2V0IHZhbHVlIGZyb20gaXRzIG5hbWUsIGEgc3RydWN0dXJlIGxv
b2tzIG1vcmUgYXBwcm9wcmlhdGUuIFRoaXMgd2F5Og0KPiANCj4gICBncHJpdi0+aW5mby0+cmVn
c1tSQ0FORkRfUkZPRkZTRVRdDQo+IA0KPiBiZWNvbWVzOg0KPiANCj4gICBncHJpdi0+aW5mby0+
cmZvZmZzZXQNCj4gDQo+IGFuZCBzbyBvbi4NCj4gDQo+IEludGVybmFsbHksIGl0IGlzIHRoZSBz
YW1lIGxheW91dCwgYnV0IG5vIG5lZWQgZm9yIHRoZSBlbnVtIGFueW1vcmUuDQoNCk9LLg0KDQo+
IA0KPiBOb3RlIHRoYXQgeW91IGNhbiBlaXRoZXIgaW5saW5lIHRob3NlIHZhbHVlcyBpbiBzdHJ1
Y3QgcmNhcl9jYW5mZF9od19pbmZvIG9yIGhhdmUgYSBzZXBhcmF0ZSBzdHJ1Y3QNCj4gcmNhcl9y
ZWdzLCBhcyB5b3UgcHJlZmVyIQ0KDQpJIHdpbGwgZ28gZm9yIHNlcGFyYXRlIHN0cnVjdCBhcyBp
dCByZWR1Y2VzIHRoZSBtZW1vcnkuDQoNCkNoZWVycywNCkJpanUNCg==

