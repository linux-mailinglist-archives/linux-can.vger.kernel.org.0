Return-Path: <linux-can+bounces-5698-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943AC89500
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F2357DAC
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEF2E5439;
	Wed, 26 Nov 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oWtjVuvA"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011010.outbound.protection.outlook.com [40.107.74.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D8246BB6;
	Wed, 26 Nov 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153169; cv=fail; b=CFKsAuOoab2h+KwsvPl/lpmZHCG7t4s8h4mdxIsCYRly49g1aPLFkm5J8EeBF0ohRw9yfZexmTuS6yWxvOFrYONQrJIxx9liLMlV1m4GjttXTGUfisK15vJy/NkvUnmsoYwxg1NcnENEoh+hdZqlaXr+td+IqNJbz59ODZ/97bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153169; c=relaxed/simple;
	bh=4dyIx61zQxfeFnBTDkAZZR+ZVmmNH4uBTtrG6L6hZAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eMM4XOQIgQFngTxULLUAX/WA6KYFR05ZocHT0cH32g9lBQCNZGoHoQL6ItcYQtPHRLbEstjeTLm/xPjJMtxfoeusy1cvz60xi5Zd704XPK5AtDuARPis2RdNqGvL8g6cookY62TUbJRUYOdgtMC47jNrdZbuKuKZ2l5leYfmcxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=oWtjVuvA; arc=fail smtp.client-ip=40.107.74.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ28XMLhIlfosFDCGH7OSEVFZeYZob1MJQliuvWDkxeKdF13/IH40IccNOQp+c3POpL0r/+UZOfkyqx/5Y/zgMW60OSbMN3qucS2XQD5/QkveMpasktz/avYomaAsfxNyNzPoDBoPpcY7FRpnvtB5MJqncG8KEwXOCJSWkdQdl0Mb/ioWW4C/iEnFfJnoz8rXas2Wq3c35xfYCy1nwPDxd2D6hEcFLlWGIZHPwt34FhvZF86VMmSk1UVcmsCDA5UuuYNtQZiepgKRhCoT0mTm6bVRgaPC1UCIMNXEG6AgTN717HP5RzeV94PsbL9+pPHxae8mWCnlXGMS8YWslvbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dyIx61zQxfeFnBTDkAZZR+ZVmmNH4uBTtrG6L6hZAw=;
 b=SbQtiinL+5K/tVL3FkMOFLHyHBcdeD/yE9V5bHvzPaXQ9ymAt+ZsoreZ1tAs+FWbqsXaYSzOMNlEnFjAVYBnM+/rdaefxSeqGFxiTX2NxP4xGG32ZJB6iU5GM/AafTvrfBzK4c8qO0xxeYs5jaZLTHTY08KpMpNfYJLN3rE33UCeS10JgawZJsXmZGAHqRDtjvycaGUh/jI5lXsbNtDFrA8BH7T7B96U+qXWgxLriMefYhcM++F4RG4SNlT7AA0wup5E+uR+vnrBZsN5il2UqSmE2lf0SKq8SYH0A59M6hYqq7EWybcbPBlcnFSqdIcT60IXimWKLmvLOOKPE5ZO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dyIx61zQxfeFnBTDkAZZR+ZVmmNH4uBTtrG6L6hZAw=;
 b=oWtjVuvAzr1V9peko7g95fc+Q2RfindK52MqfPMTWj0uz38qDTq9pmyROUPD+Ni8bZb27mYfau1AkEBAdL73dzHCg5XhhmeauNJm5RLjP3lHk0G6Sk6FsCFAx2D0Uf5qSnV0VFeHV7IAq2R6GIZYBWpmPwEi6qWuW5sJsO+ONJU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB15893.jpnprd01.prod.outlook.com (2603:1096:604:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 10:32:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:32:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, biju.das.au
	<biju.das.au@gmail.com>
CC: Vincent Mailhol <mailhol@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Tranh Ha
	<tranh.ha.xb@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] can: rcar_canfd: Fix CAN-FD mode as default
Thread-Topic: [PATCH] can: rcar_canfd: Fix CAN-FD mode as default
Thread-Index: AQHcWIhlB3svPBv+H0Wy/UXHjmXaKbUEzYkAgAAAbBA=
Date: Wed, 26 Nov 2025 10:32:39 +0000
Message-ID:
 <TY3PR01MB11346D523AAE47E3D7C040F3286DEA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251118123926.193445-1-biju.das.jz@bp.renesas.com>
 <20251126-nocturnal-busy-honeybee-ca8a15-mkl@pengutronix.de>
In-Reply-To: <20251126-nocturnal-busy-honeybee-ca8a15-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB15893:EE_
x-ms-office365-filtering-correlation-id: c97c1b63-8089-44de-0b21-08de2cd71faf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWFCa2htTHZ4Wlk2dVZrWEJHVEtrenN2MDh1WW5XbllHZjJvOXJKdnFNTFlD?=
 =?utf-8?B?M2VnY282czlQVkhrSWZrVUhhZDF3cWZiclM4SERGZXk0WjFWTVN5aXFxM2dE?=
 =?utf-8?B?VzJqdVBVY0pZOTRPWlcva1grbkNNSnBRcmFtZWFlYWNYQjJ2OXBNc3U1Mmcx?=
 =?utf-8?B?dTVXT25XR2Y5YUVpVmVucU5tNVhNUUVWNDZjZjNKZHA5cDRudkRxWDFIbGlv?=
 =?utf-8?B?Sm8vUDlzZWdQU2I3ZVFObHpteWlyQm1vVzlsZmI5TG1oMkpjckdFcHNhQ3Zn?=
 =?utf-8?B?bGxxQzFzeWJRRE9pZW50cmY5RGNMdFc2T1o1NExZL2ZYWUJwNUhOcE5OeDdJ?=
 =?utf-8?B?aUZ5T0dPakV3VVJxdzlYdTlPUWRBbXFTbXJYejBTRTJUMnE5UVh3b2NVSzVz?=
 =?utf-8?B?eHFnbUtLUnBGZ0JQaHRySXJGdFVkcHArN1BROEs4UHJFODJ5eEFHM20vMHBW?=
 =?utf-8?B?WThtVXVFNEd0SWRKSmNvczBlVjVFTktqV2UxZEprNGl6cjc3Mk5aMkJIcFEx?=
 =?utf-8?B?SDJsMXdCbUw3YlFnWWNWVktJTlJRVmp4TnhsblZYRXQ0OGxGNFVadlNGS3FF?=
 =?utf-8?B?RERnT3JsZjJ2YjlKSmI1OWxkT2oxcXJYdVp3TXlCanFSWGg4bGpDQjFnUnVY?=
 =?utf-8?B?M2t0RktKdm9EN3g1ZWJhS1NVUHRQMlNpMjZuYTNxVUxUTlF3L2t6aUxwdGpL?=
 =?utf-8?B?dGVGeWdZOGZPYm8wRUpCL2d1WVh6alBxMVVEbGF1eERYNDhRZEhOM0lIU0VL?=
 =?utf-8?B?aUtqclVVdXE2SzJyaVJZOFVVQ3J5NG9Fd3VwbkhoM1luc2ZBTVdFanQwbjZH?=
 =?utf-8?B?WjNYY1phTDZ5bWpxSVl0bnpFVTA5b09rV3NPemlsdGdHS3NlQ2d1T29kUm1n?=
 =?utf-8?B?VG1SYWwrQXpHWEdmZlpyYzh1aVJoaFJjbnBtc3F5TUZoZW9BKzUwRlhIYzJQ?=
 =?utf-8?B?SXhKUUszZVhaMHUydFpMbHVSeEFYUXhEU21NaXpRNVpBMStXeTUyVStmQTIx?=
 =?utf-8?B?ODJUUEs3VjY2eEN0a3Rydndnd1o4bzZ4R2taSmEwZFVIN0NjcVVuMXdJSTFt?=
 =?utf-8?B?RkQ4dzVwKzhiTzR1aVRuaTZGdXJrZHpZSGlWMVozaitWNTlWUGtESHUvSk9G?=
 =?utf-8?B?dkZaOUU1QUp0VjNoM2MzMlVhejNZRi8yMXdqdFZ5cWxzRWs1SmxrdERWZDQ4?=
 =?utf-8?B?SExNNndiakwrVnltYlhqMFdobGJRU3hZa09UUUF1WjVXQURSZ0tBQVFRNHRP?=
 =?utf-8?B?VlQ4YWwrcFNDWm11NzR1NktyY3o5cW9sNEF0dlRXaWp0TllFSFpCcTg0UlB3?=
 =?utf-8?B?c21BRHA2QVlXYUl5YzBTb3ZQZEtRQUJ1UmhtaXUzRmFVMEdXUlMyYk9pYnpo?=
 =?utf-8?B?YzhrVXZPUkNmVzZKZ3lTR001K3g1RUcyejFrZEYvaklqVkNnM1VkMHM2QmM3?=
 =?utf-8?B?QUxzczBpNTltUzRiZWhhRllWQUNTd3IvWTBQeXBybTljQzIrSW9wQmw2c2s1?=
 =?utf-8?B?N3JKZVo5YjA4T1FPZjd1Nm9TdGRVSW45dzFISW1PMXprTTc4Nmw3c3VPZmRp?=
 =?utf-8?B?UExmaHBxVVZVSFRiUlZ2RzJrMW10UFhEcXN3ZWREYXVUY3hUeDhSd01ZTE5p?=
 =?utf-8?B?aTh1cFk3MDhLSUJJL0FMTEk3bEVLb2tpdktWL0U4THNiVmFBM3JRaHdDdXh2?=
 =?utf-8?B?ZVBNWXE5SnhHODRTVklVZ1F0NDBxOWN2VGV6KzJ0Smp5ZTIyZUxMeEpDNm4w?=
 =?utf-8?B?cjBqL3d5N2psUzV4VzU0L2dLOWN4VjMyTmhHRVZQbHJuVStoQnM3Y0JwZjBG?=
 =?utf-8?B?Z1ZsZWIrQVovVFlRTnhXVGt0Y25MMXlia3E4Uk45ZE1UbXEvSVZnOUNlSncy?=
 =?utf-8?B?UitlUFV0UGxSQUpuUmpEUmhxS09sdUN6WmxZMEE3cDR2SmozcHNIN1NSM25M?=
 =?utf-8?Q?6MWVmb/vOREMZMCe+SAJEstowlvoAdDs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0RaU3RpYWZSOXNRRHo3YXdMdzExUitCMUJxWmhCOEdicHMzNWVkbGNGanZQ?=
 =?utf-8?B?Nm9rWGxic1ZML3p5V2kvSmRvRjh0Z3hnUlRMbzJubzVYVzRyUG5aQzdScmE5?=
 =?utf-8?B?VW1UYituZFpMTjV6N05QbDBkK1J1anNsdTVPS2dPK3luS2NkM1BUMm1mT3Bn?=
 =?utf-8?B?TW9kaUFyL0JLMTY3MGFXTE9iMG5nUHlYd1VvZHRGUm1qS0xTMHpucThxWnNB?=
 =?utf-8?B?YkVQbFBhSHBXa3ZWNFpRdUZBdzN3YytpZTV1RGpjV2thQm5mR0hkaXdtcHVa?=
 =?utf-8?B?RnM1cnM3VXVBVTBUR1pMR0orVUdXVXp5alhBbkpYemZEbnNGUGplRzAwaFZm?=
 =?utf-8?B?clRVcWx6NXM2QWl3VDQ4dzQ0ZFl6VWc0cDZObnZlMW9WN2V3SDFYVFdJSkJF?=
 =?utf-8?B?UmNNcUhndGVEaWg3MDNBeWZZbDVQakk2eFZ1eE9wRFZZNHNDZUlEUDIzZytk?=
 =?utf-8?B?aHhOSmVZOGlkMnhxbjRKWnhqR3AzVnlJanhNM3VHY3BjbytxUDRFaFQvanF2?=
 =?utf-8?B?Vk1tcHpkNysrUnN6YnNrS3VIZUM3M1NqeERFUmF4UGVVeklKc0x5MU9aR3JT?=
 =?utf-8?B?bU14c05ZMDBiN1QvK1I3bnFMZnMxTEUzMjh3VlRHeXpQWTE3SXVZd3FPNkls?=
 =?utf-8?B?c0JjamZNbW14MFJnVCtHSmFYN3duNllTallDZFRzcE82T2NBZisyQ2NZS1hn?=
 =?utf-8?B?ZHNHZGZTNDdxbDIxamhpK2dqOTFnUEZRWk55YUwySUY4Q2ZoU0EvQ3lyRXFl?=
 =?utf-8?B?VGc3ODJUMllnYkZXbWlmZVZzbHpFMWt2RGxjWjdoZWJYaG5GTXk1a2JqSW9Q?=
 =?utf-8?B?THR4bHRMN2RraWRqMnBrMXhEZlhadmxKS2pSTU9aY0c4Tk1qNG0zNUQ3b3Jx?=
 =?utf-8?B?UjNnL255eVordDYvY2hjaUU2QUNCQThxaHl0T25xUVVUbHVGdCt3djhoYzli?=
 =?utf-8?B?cnkvUi9zWjdxUVlQMHZCdG10S0JsVVZQNVhPR01CNWNLbU9zaTJCcVhwSDNz?=
 =?utf-8?B?aHh6ZGROWHhiYmF4K0l2U21mNlVPZGJ3dGNuWVhsZUppdnQrV2lMZENsOWRN?=
 =?utf-8?B?eTRJRHA1R0kyWExlVGhGeWd0RkF2eVdBSGlXR2xTUkdsT0Rid0pWcnFzeXk2?=
 =?utf-8?B?V3hUY09JWm9DU1MzcEJFakFxWFREdlY4QjAyZ0pJeXJKSDcyY2w3SFQyNTcz?=
 =?utf-8?B?VjhMWTZPeThxNEhqUlRsTzYxd0p0UzN0VmwrSjBSZDZ1d0ZaMTNENnRGQUs1?=
 =?utf-8?B?RmdhVzlaQzJZamp6R0JwRnFBc08rcC9TODAzOUdFMVhIUG1mOFNOdi9YUkRO?=
 =?utf-8?B?V2h4WHNrZlNUVksvd3F4UitLWkZhT21ad1ZJb29GTjh2WEFJRVRrR2FUWE1I?=
 =?utf-8?B?Q3M5RE1pNlVGamxxZW54ZUtEclZ4NlZ3SmZVOEg1MWZZQWI0NTc0MVpJakla?=
 =?utf-8?B?UjluVTV4STRuSEVGOEtla05qQm94WURiM0p3Ym5DVWsvbVJVcWFiOE9vYzhn?=
 =?utf-8?B?Qkhjem94bHBQYURmbkVCeXdweGtxVGI5QXN5a3R1TjRsV21mN2VyMS96cjFG?=
 =?utf-8?B?VVdYckxhR1pTVHBUN25ieGM4bWR3WkFTVStnNzZRQ3BrQTBXWGF3c1hITXRE?=
 =?utf-8?B?Y2Z0SHNvRzF0NjkzOUMvUlJYUEZ0a2pqUEY1WkVuU2s3ZmwwUGtkQTFFWnk0?=
 =?utf-8?B?T2twSzZjZEVyNDFVcFV1dGFMdG95by81Wi9CdFFySkRXcWxrWjlHbEhWMzdX?=
 =?utf-8?B?MGlSWmpwRk9MMmJQenEzcm9Zakd0MFpmSUZjNmY2QTc1elVRV0ZqcTE1Vy93?=
 =?utf-8?B?eElRazZQS2lGcU9XTUdGbFlXcXpaWCswTUlDK0pxTjIrTzRiaDBEdHBqcmhy?=
 =?utf-8?B?anBWMGlLMGFoRFlLd1MxN2tuaGV2OGhBelpXQ2hJdDZxbVQwM1krdEhUd1RV?=
 =?utf-8?B?WUdrVi8vajFuWEJDTEhENFFsQi9OVHpEUHBlVldRWmFnbHJ3OEsrcmc1MDFF?=
 =?utf-8?B?a3lQM2d1ano0c2xVbnRjelYyRkNiVS90b3BndW9ZanRaR21yemVtSVZtUG9V?=
 =?utf-8?B?WUlkdDVuanVOaXJEYnRUTGJ2UFgraFZJbW1URE5KMlBvOHBwaUVrcWhXeFhq?=
 =?utf-8?B?YU5mUnRwaGFRVk1sUUQyY01WUWVwYWgzek5uc0NkWWlNMC84WUlGTW0rUndI?=
 =?utf-8?B?S0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c97c1b63-8089-44de-0b21-08de2cd71faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 10:32:39.3971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CceazswY1OJHedo1iOkjX3U4uzXAtqX2GyR33D84m8FMpP+mFLJ7ysZzLOsgGBfoqF760y0ESqIWTwEmkhqPJ+Ky3hdHMOAGYaO9SjWkLxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15893

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyNiBOb3ZlbWJlciAyMDI1
IDEwOjI4DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNhbjogcmNhcl9jYW5mZDogRml4IENBTi1G
RCBtb2RlIGFzIGRlZmF1bHQNCj4gDQo+IEhlbGxvIEJpanUsDQo+IA0KPiBpcyB0aGlzIHBhdGNo
IHJlYWR5IHRvIGdvIHRvIGxpbnV4LWNhbj8NCg0KWWVzLiANCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+
IA0KPiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiBPbiAxOC4xMS4yMDI1IDEyOjM5OjI1LCBCaWp1
IHdyb3RlOg0KPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gPg0KPiA+IFRoZSBjb21taXQgNWNmZjI2MzYwNmExICgiY2FuOiByY2FyX2NhbmZkOiBGaXgg
Y29udHJvbGxlciBtb2RlDQo+ID4gc2V0dGluZyIpIGhhcyBhbGlnbmVkIHdpdGggdGhlIGZsb3cg
bWVudGlvbmVkIGluIHRoZSBoYXJkd2FyZSBtYW51YWwNCj4gPiBmb3IgYWxsIFNvQ3MgZXhjZXB0
IFItQ2FyIEdlbjMgYW5kIFJaL0cyTCBTb0NzLiBPbiBSLUNhciBHZW40IGFuZA0KPiA+IFJaL0cz
RSBTb0NzLCBkdWUgdG8gdGhlIHdyb25nIGxvZ2ljIGluIHRoZSBjb21taXRbMV0gc2V0cyB0aGUg
ZGVmYXVsdA0KPiA+IG1vZGUgdG8gRkQtT25seSBtb2RlIGluc3RlYWQgb2YgQ0FOLUZEIG1vZGUu
DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNldHMgdGhlIENBTi1GRCBtb2RlIGFzIHRoZSBkZWZhdWx0
IGZvciBhbGwgU29DcyBieQ0KPiA+IGRyb3BwaW5nIHRoZSByY2FyX2NhbmZkX3NldF9tb2RlKCkg
YXMgc29tZSBTb0MgcmVxdWlyZXMgbW9kZSBzZXR0aW5nDQo+ID4gaW4gZ2xvYmFsIHJlc2V0IG1v
ZGUsIGFuZCB0aGUgcmVzdCBvZiB0aGUgU29DcyBpbiBjaGFubmVsIHJlc2V0IG1vZGUNCj4gPiBh
bmQgdXBkYXRlIHRoZQ0KPiA+IHJjYXJfY2FuZmRfcmVzZXRfY29udHJvbGxlcigpIHRvIHRha2Ug
Y2FyZSBvZiB0aGVzZSBjb25zdHJhaW50cy4NCj4gPiBNb3Jlb3ZlciwgdGhlIFJaL0czRSBhbmQg
Ui1DYXIgR2VuNCBTb0NzIHN1cHBvcnQgMyBtb2RlcyBjb21wYXJlZCB0byAyDQo+ID4gbW9kZXMg
b24gdGhlIFItQ2FyIEdlbjMuIFVzZSBpbnZlcnRlZCBsb2dpYyBpbg0KPiA+IHJjYXJfY2FuZmRf
cmVzZXRfY29udHJvbGxlcigpIHRvIHNpbXBsaWZ5IHRoZSBjb2RlIGxhdGVyIHRvIHN1cHBvcnQg
RkQtb25seSBtb2RlLg0KPiA+DQo+ID4gWzFdDQo+ID4gY29tbWl0IDQ1NzIxYzQwNmRjZiAoImNh
bjogcmNhcl9jYW5mZDogQWRkIHN1cHBvcnQgZm9yIHI4YTc3OWEwIFNvQyIpDQo+ID4NCj4gPiBG
aXhlczogNWNmZjI2MzYwNmExICgiY2FuOiByY2FyX2NhbmZkOiBGaXggY29udHJvbGxlciBtb2Rl
IHNldHRpbmciKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA1Mw0KPiA+ICsrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMo
KyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nh
bi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5m
ZC5jDQo+ID4gaW5kZXggNDlhYjY1Mjc0YjUxLi4wNWRiZGY0NmRkNmYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTcwOSw2ICs3MDksMTEgQEAgc3RhdGlj
IHZvaWQgcmNhcl9jYW5mZF9zZXRfYml0X3JlZyh2b2lkIF9faW9tZW0gKmFkZHIsIHUzMiB2YWwp
DQo+ID4gIAlyY2FyX2NhbmZkX3VwZGF0ZSh2YWwsIHZhbCwgYWRkcik7DQo+ID4gIH0NCj4gPg0K
PiA+ICtzdGF0aWMgdm9pZCByY2FyX2NhbmZkX2NsZWFyX2JpdF9yZWcodm9pZCBfX2lvbWVtICph
ZGRyLCB1MzIgdmFsKSB7DQo+ID4gKwlyY2FyX2NhbmZkX3VwZGF0ZSh2YWwsIDAsIGFkZHIpOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCByY2FyX2NhbmZkX3VwZGF0ZV9iaXRfcmVn
KHZvaWQgX19pb21lbSAqYWRkciwgdTMyIG1hc2ssDQo+ID4gdTMyIHZhbCkgIHsNCj4gPiAgCXJj
YXJfY2FuZmRfdXBkYXRlKG1hc2ssIHZhbCwgYWRkcik7DQo+ID4gQEAgLTc1NSwyNSArNzYwLDYg
QEAgc3RhdGljIHZvaWQgcmNhcl9jYW5mZF9zZXRfcm5jKHN0cnVjdCByY2FyX2NhbmZkX2dsb2Jh
bCAqZ3ByaXYsIHVuc2lnbmVkIGludA0KPiBjaCwNCj4gPiAgCXJjYXJfY2FuZmRfc2V0X2JpdChn
cHJpdi0+YmFzZSwgUkNBTkZEX0dBRkxDRkcodyksIHJuYyk7ICB9DQo+ID4NCj4gPiAtc3RhdGlj
IHZvaWQgcmNhcl9jYW5mZF9zZXRfbW9kZShzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2
KSAtew0KPiA+IC0JaWYgKGdwcml2LT5pbmZvLT5jaF9pbnRlcmZhY2VfbW9kZSkgew0KPiA+IC0J
CXUzMiBjaCwgdmFsID0gZ3ByaXYtPmZkbW9kZSA/IFJDQU5GRF9HRU40X0ZEQ0ZHX0ZET0UNCj4g
PiAtCQkJCQkgICAgOiBSQ0FORkRfR0VONF9GRENGR19DTE9FOw0KPiA+IC0NCj4gPiAtCQlmb3Jf
ZWFjaF9zZXRfYml0KGNoLCAmZ3ByaXYtPmNoYW5uZWxzX21hc2ssDQo+ID4gLQkJCQkgZ3ByaXYt
PmluZm8tPm1heF9jaGFubmVscykNCj4gPiAtCQkJcmNhcl9jYW5mZF9zZXRfYml0X3JlZygmZ3By
aXYtPmZjYmFzZVtjaF0uY2ZkY2ZnLCB2YWwpOw0KPiA+IC0JfSBlbHNlIHsNCj4gPiAtCQlpZiAo
Z3ByaXYtPmZkbW9kZSkNCj4gPiAtCQkJcmNhcl9jYW5mZF9zZXRfYml0KGdwcml2LT5iYXNlLCBS
Q0FORkRfR1JNQ0ZHLA0KPiA+IC0JCQkJCSAgIFJDQU5GRF9HUk1DRkdfUkNNQyk7DQo+ID4gLQkJ
ZWxzZQ0KPiA+IC0JCQlyY2FyX2NhbmZkX2NsZWFyX2JpdChncHJpdi0+YmFzZSwgUkNBTkZEX0dS
TUNGRywNCj4gPiAtCQkJCQkgICAgIFJDQU5GRF9HUk1DRkdfUkNNQyk7DQo+ID4gLQl9DQo+ID4g
LX0NCj4gPiAtDQo+ID4gIHN0YXRpYyBpbnQgcmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVyKHN0
cnVjdCByY2FyX2NhbmZkX2dsb2JhbA0KPiA+ICpncHJpdikgIHsNCj4gPiAgCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZncHJpdi0+cGRldi0+ZGV2OyBAQCAtODA2LDYgKzc5MiwxNiBAQCBzdGF0aWMN
Cj4gPiBpbnQgcmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVyKHN0cnVjdCByY2FyX2NhbmZkX2ds
b2JhbCAqZ3ByaXYpDQo+ID4gIAkvKiBSZXNldCBHbG9iYWwgZXJyb3IgZmxhZ3MgKi8NCj4gPiAg
CXJjYXJfY2FuZmRfd3JpdGUoZ3ByaXYtPmJhc2UsIFJDQU5GRF9HRVJGTCwgMHgwKTsNCj4gPg0K
PiA+ICsJLyogU2V0IHRoZSBjb250cm9sbGVyIGludG8gYXBwcm9wcmlhdGUgbW9kZSAqLw0KPiA+
ICsJaWYgKCFncHJpdi0+aW5mby0+Y2hfaW50ZXJmYWNlX21vZGUpIHsNCj4gPiArCQlpZiAoZ3By
aXYtPmZkbW9kZSkNCj4gPiArCQkJcmNhcl9jYW5mZF9zZXRfYml0KGdwcml2LT5iYXNlLCBSQ0FO
RkRfR1JNQ0ZHLA0KPiA+ICsJCQkJCSAgIFJDQU5GRF9HUk1DRkdfUkNNQyk7DQo+ID4gKwkJZWxz
ZQ0KPiA+ICsJCQlyY2FyX2NhbmZkX2NsZWFyX2JpdChncHJpdi0+YmFzZSwgUkNBTkZEX0dSTUNG
RywNCj4gPiArCQkJCQkgICAgIFJDQU5GRF9HUk1DRkdfUkNNQyk7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICAJLyogVHJhbnNpdGlvbiBhbGwgQ2hhbm5lbHMgdG8gcmVzZXQgbW9kZSAqLw0KPiA+ICAJ
Zm9yX2VhY2hfc2V0X2JpdChjaCwgJmdwcml2LT5jaGFubmVsc19tYXNrLCBncHJpdi0+aW5mby0+
bWF4X2NoYW5uZWxzKSB7DQo+ID4gIAkJcmNhcl9jYW5mZF9jbGVhcl9iaXQoZ3ByaXYtPmJhc2Us
DQo+ID4gQEAgLTgyMywxMCArODE5LDIzIEBAIHN0YXRpYyBpbnQgcmNhcl9jYW5mZF9yZXNldF9j
b250cm9sbGVyKHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYpDQo+ID4gIAkJCWRldl9k
YmcoZGV2LCAiY2hhbm5lbCAldSByZXNldCBmYWlsZWRcbiIsIGNoKTsNCj4gPiAgCQkJcmV0dXJu
IGVycjsNCj4gPiAgCQl9DQo+ID4gLQl9DQo+ID4NCj4gPiAtCS8qIFNldCB0aGUgY29udHJvbGxl
ciBpbnRvIGFwcHJvcHJpYXRlIG1vZGUgKi8NCj4gPiAtCXJjYXJfY2FuZmRfc2V0X21vZGUoZ3By
aXYpOw0KPiA+ICsJCS8qIFNldCB0aGUgY29udHJvbGxlciBpbnRvIGFwcHJvcHJpYXRlIG1vZGUg
Ki8NCj4gPiArCQlpZiAoZ3ByaXYtPmluZm8tPmNoX2ludGVyZmFjZV9tb2RlKSB7DQo+ID4gKwkJ
CS8qIERvIG5vdCBzZXQgQ0xPRSBhbmQgRkRPRSBzaW11bHRhbmVvdXNseSAqLw0KPiA+ICsJCQlp
ZiAoIWdwcml2LT5mZG1vZGUpIHsNCj4gPiArCQkJCXJjYXJfY2FuZmRfY2xlYXJfYml0X3JlZygm
Z3ByaXYtPmZjYmFzZVtjaF0uY2ZkY2ZnLA0KPiA+ICsJCQkJCQkJIFJDQU5GRF9HRU40X0ZEQ0ZH
X0ZET0UpOw0KPiA+ICsJCQkJcmNhcl9jYW5mZF9zZXRfYml0X3JlZygmZ3ByaXYtPmZjYmFzZVtj
aF0uY2ZkY2ZnLA0KPiA+ICsJCQkJCQkgICAgICAgUkNBTkZEX0dFTjRfRkRDRkdfQ0xPRSk7DQo+
ID4gKwkJCX0gZWxzZSB7DQo+ID4gKwkJCQlyY2FyX2NhbmZkX2NsZWFyX2JpdF9yZWcoJmdwcml2
LT5mY2Jhc2VbY2hdLmNmZGNmZywNCj4gPiArCQkJCQkJCSBSQ0FORkRfR0VONF9GRENGR19GRE9F
KTsNCj4gPiArCQkJCXJjYXJfY2FuZmRfY2xlYXJfYml0X3JlZygmZ3ByaXYtPmZjYmFzZVtjaF0u
Y2ZkY2ZnLA0KPiA+ICsJCQkJCQkJIFJDQU5GRF9HRU40X0ZEQ0ZHX0NMT0UpOw0KPiA+ICsJCQl9
DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IC0t
DQo+ID4gMi40My4wDQo+ID4NCj4gPg0KPiA+DQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksu
ICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgIHwNCj4gRW1iZWRk
ZWQgTGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSB8
DQo+IFZlcnRyZXR1bmcgTsO8cm5iZXJnICAgICAgICAgICAgICB8IFBob25lOiArNDktNTEyMS0y
MDY5MTctMTI5IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAg
KzQ5LTUxMjEtMjA2OTE3LTkgICB8DQo=

