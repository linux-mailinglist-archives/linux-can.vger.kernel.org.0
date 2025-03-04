Return-Path: <linux-can+bounces-2978-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC677A4D28E
	for <lists+linux-can@lfdr.de>; Tue,  4 Mar 2025 05:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0AE173604
	for <lists+linux-can@lfdr.de>; Tue,  4 Mar 2025 04:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506B19E83E;
	Tue,  4 Mar 2025 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DsjToD9Q"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70F27468;
	Tue,  4 Mar 2025 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741062304; cv=fail; b=YD14iBqg8RWeZ0YeLxSo+SJTWyZrARqDvVt3TDnlolzjtwhfOSDHBi5fBsPz0U/eluOE33oVH/6oc7P/WkOWLp0Lylh7qdi3jFdbtFRqMXsMfJcUWCLSTE6HJ6uEbPTdIM+3wbO/puAq4TEANGsP+Jnqd8h1Sz6fdvGLJU8pFHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741062304; c=relaxed/simple;
	bh=60Fc8ziq1K9XP/3nvc6ANdsVRrs72cQBXqjaqSWaCtw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JnkUgs5Z0oziZgwUqmPWVGZO3g4y/9SeXxXBhjLhH4fZ5w3MhBVCQckDUS1TIS7mJ3eZ9JIWuAQSFh3EheBR8FzRXpcM2/KVdl2mwyxHz1/9NzyJSt2kss8wUQ9ERVp7CUSfVEFv3QhC4G3dAA3q7vn6zc64nQOy/zTLUO3unE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DsjToD9Q; arc=fail smtp.client-ip=40.107.247.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grj/1fV3PTqJz/ZGmyyEEwZtc+I46FASe7Cb3kA5i8dQr/WRfLLpr+fI4QywqhJF9kiQxr9ZvSsXPRIwkO0JJ17VvzFuXkwOTIDCu8UhqcDIuPdHXGD8bVc1jJlLZm6g/5meKxDKSs7y7AFYFoyrMoOmQTB5RnFQQ4bXsc1K1p09tGAQdINnzMRYLOQJ7cKM21Z405BwCugMHxGeJOvznM2rL6T+88clzJqTzTU9LgCgoSGIbQBCBg7mhaECjQ4piA6NvLCnL+rX1brxqIcgRNcL/S8R2Wlsh/BA9ZNOAyJ0DB7wEDxIcTBzv/ujbf/JQq6QZ4F4tCd+GAtotEROOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60Fc8ziq1K9XP/3nvc6ANdsVRrs72cQBXqjaqSWaCtw=;
 b=d+k6Fiwnh5ZQH4IKKObjehD0SuUEgbi0zDwo4xwbR4X9kgWd9ua4grO2lSJQa9KMaE620ZvGTnDs2e6rm8oxJp4T7uhSZ+MPp0atod13G4LP5MkilXx5vT24uJ1E7mAnXHTuYkQY3ZE99jY4RDbQnk5cidz54iHD5FCVZzHWjYAZKp2W0rNIEVj3d/L+DehQ5We2iyj2dUKc4gcSjFci+OyTjOZxbiIPVGSX3PCvvnpscmDcUH0+9k2L/TDhSE96sm1VSXIrtj+pyxBAI1N8DN4MOjR7U/TAsDu8lPY8uNbLfFdcZgmf4jmDHfjj5/F2WaNeFkUBWB7l8YhzWUUd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60Fc8ziq1K9XP/3nvc6ANdsVRrs72cQBXqjaqSWaCtw=;
 b=DsjToD9Q2NE5Ad2kdnmXv/nLdLSpl1YmQAb4x6kNd2Zoq3CqOUv2Ua2C6c1reCUoc2adlKQewQAgDg7hwJTl+87E9y8hyA2qF3d5tBPNA/T93C6bBix8x8NStymNrL7E8VjkE/OCKsnhPbqbMT1J9yQzAc4AQEHsIB4ntzG4WH53D3LXK19PMwQRGV+toe+KLESo23ssmgZJ4nSsfT6PPe9FrWk5+SX7SUo1fCxaNYJhOTqXxXnTJkZED1i91gXSZra1sS8cgStSbGBWdUAhIovZB0V61ms4zCfe5v42WUjO4K1q8JE0JVQ1WvlYY/BpAE9OgXt35LsKw4Yy7JLP3w==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 04:24:57 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 04:24:57 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "mkl@pengutronix.de"
	<mkl@pengutronix.de>
CC: "Ciprian Marian Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] can: flexcan: disable transceiver during system PM
Thread-Topic: [PATCH] can: flexcan: disable transceiver during system PM
Thread-Index: AQHbjLaa9fdoQD7urkqi6wWn3cn3N7NiXBgAgAAEdeA=
Date: Tue, 4 Mar 2025 04:24:57 +0000
Message-ID:
 <DU0PR04MB94963271989728FA82C5A25D90C82@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250304033731.1762899-1-haibo.chen@nxp.com>
 <01b6fbe7-6e49-4ac2-af2f-a512ae865eae@wanadoo.fr>
In-Reply-To: <01b6fbe7-6e49-4ac2-af2f-a512ae865eae@wanadoo.fr>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI1PR04MB10052:EE_
x-ms-office365-filtering-correlation-id: 906f33c7-6c67-466d-4b1b-08dd5ad4853b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REQ5aHR2S3JFS0hjRDI2TnFvZW9qb09aVXJpTjZEYUF1eE1wTUlTOFhJNFlG?=
 =?utf-8?B?ZUg3SkJ1MDBUTDloMHl5aEtNc1I4OXhnM1MvS1M4YjBrbTlEOWlrSDRaUDJ2?=
 =?utf-8?B?VDBMSXV4d0NPVVpEUU9rQ2h5eW0xam9pSmV1U0NCNHk5akxCSDJrbE13Z3hj?=
 =?utf-8?B?K0Mxb1p0eHFsTTBaVXV0VDJ2d1NGTkdKWUp4KzRXRFlraHlyYUhLY29UTHhq?=
 =?utf-8?B?cFd6czR3ZGQyWHZ4K0hHVnZFNnBhQXh2RGY3aDk1RFhZV3dVandSakdjTFRz?=
 =?utf-8?B?R1NkMnhBc29UYWtMcTkrNW44VzhYY2tCUXY2eElHak1uVFNzRSt5ZDhmZDBN?=
 =?utf-8?B?Q3h0cUdIdGptTWJGVVM2cDhFSXRablZhTHJKRk44ZzMzYkdwckxyQ1Q2MUNw?=
 =?utf-8?B?YWoxM0wvWENubGxHaDFCLzZyTEQ4cTNuRlNkak15dWMrVlFVLzhodzQzejdL?=
 =?utf-8?B?aXlsME1iblhRNlVwS3BQTXZaK0Nyd3RBaGt5NjdOTnFaYTlWbytoU1lKYk1q?=
 =?utf-8?B?ODFTeHRjYnQ4U3dnVkpnQW1QeDBuRVJnNG1QYUdUUE1iRnZGR0E0NkQ3eEtk?=
 =?utf-8?B?c1Q3Qy9VdzFtU1N1eUsvUW8zMzQ0d1h2dHdEb2dnMFlNNTJlRjlrWHczRTQ2?=
 =?utf-8?B?MGI4UC82a0NDWlBrTU9TS1NSZm95d2YyS0NNR0JTeXduK1BqNitMRFM4NStz?=
 =?utf-8?B?QXpjeElBdWVPL0VXZXZlQVByV3VwbEZIQXhQY1N2OW9wMksyZkFBQ04xVERw?=
 =?utf-8?B?VmxqNC9NakpNdFRlVmlha0JZQVBsSk5EYzR1K3Nad2lCOHJ1Y2lkQmZjc0pj?=
 =?utf-8?B?K29JVHRlTVN2UXROUElmaldkUlMvUXZ4bGQrN2FnRE01NmptbnFlUXBTV1py?=
 =?utf-8?B?Q2Ezb00vNEk1RzRBanJnNzVoOCtrMjE5MVZFL1REYkhQcWd1eDlXZjM3WTZj?=
 =?utf-8?B?Sm9GT1FxODR5emc4Y2xndEIrTzlqS0E0KzRyc3FzcWh2b2hmWDlHcTlnaW9W?=
 =?utf-8?B?UHkxQVZ1WmY4bFJMWjNIeGh0K1FwblVzUjU4RW1nOXBDOWwyQ2MwMG40Z01D?=
 =?utf-8?B?UUUzRmNKL2luSEVTSmg2MStDK0c2MDVpaE5ZZFhzWU8rWkJwUTcwbTQyVTNP?=
 =?utf-8?B?NHJUS1A5aERiMkFIaTdXT1JiL3RGZG9lZXdocGxRVkgxTmdSVlV5YzJ6RU9Q?=
 =?utf-8?B?R1ZsL2o1a25PNzlkOUlxcHFab2xmN0FZc3Z1QzZ0QUxZNExBZGNTcTNZRzlR?=
 =?utf-8?B?UEZuaFd3dU11WEgydFV1MDdxVmEwUEdPSTZYdUloUG1GUi85OU5zRXdSbmNw?=
 =?utf-8?B?OWt0djRlR0s4N1U5cTllMHhNNU00Y0tLSlo1b3FueVdVRXhwUlo2NVBTV0Zs?=
 =?utf-8?B?dFJYYXEraE44eUF2UDhiQnhUNHFla25vVjQrUlEycDNRclE0QzkwYjlQNWRz?=
 =?utf-8?B?cEFpcDNXK21DbHdxb3ArYi9sR3RsNG5MQ0wvTkMvVXZGT1ZTb0VPVGhQRGVs?=
 =?utf-8?B?WURXK2FUc0VGcE1tcWN2Y2c2NDhkQUd0SFYxa0Z5VnE5ZnMzdmJ0cGRCM3Mx?=
 =?utf-8?B?emhqZzZuY24vL2ZycGhvUlRkL3hqYVgwWTlja2tsVU5OTEg2K1RzZ296RHZ4?=
 =?utf-8?B?aXJhN3dRWGVOUTh5OUdJYmZwQmVseWlEUWw3SStqeHh0Mk4vcE1SSzR2Yzd4?=
 =?utf-8?B?ZUwyaVB3dTQ1WEcyb0llOUN5cUM0M0w2VUtjOWtHb2VxN3d1MTRwazY1Nm8r?=
 =?utf-8?B?cWx6ZmVQTkhCSDNEQjE1WFJpNlplcE0wZXhkZ3JXejhGeVlnWHV6Z3pLenZl?=
 =?utf-8?B?dzN6ZnhDM041cEZvNmF6OFJTVy9BMy9oUG5IRHAvc1pEZmtnR3Q2cGU5ZS93?=
 =?utf-8?B?Z3ZYR0psMUcvSnU1c2VSZTZkUmtuUnFxQUN0VFlncmIvWXBoNnFRVFFiQ1Bz?=
 =?utf-8?Q?X+XqUKqU5FwqIgNXEcf2bp3ISl6d7yaI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0tkeCtta0c2VzBWcEsvQTJJTUxZeTJZRUZOYnJ4cTl2RUlvS1RtbkN6ancx?=
 =?utf-8?B?c1l1b3JSN1BNTFNMMGkyby95bGVpVVJZSVF0eGFOTHVqOVhDSHFGWENZTTU1?=
 =?utf-8?B?Nld6WGJFNDBKZFVSRlAwRzVEV1R0T3pGcjkxYU9kdzNSRXNBbHRPL0N6UHMv?=
 =?utf-8?B?cGRqRnBzRjlpcHpyV01wbWwzRGlCK1E1akhMczJGOE5uUy9CMGpPWDJNZ294?=
 =?utf-8?B?dllibjY0MjAySVlha1hra3VXVVpsY0JCQVM5bjRLMUlFem9pbElyZHNTM1N6?=
 =?utf-8?B?MC94RFlwVVpSZi94Q01HSlVlV3NINGMwK0tWZ29nVTZtUzhUK1FsUWxnWEFi?=
 =?utf-8?B?cTBYckNNeHJBWmxBeWxlRnJETUFZa1lWbW5iS3VaRjRKcndQWkl0WjM4VVJq?=
 =?utf-8?B?c2NYZUlSMDdacW1JSGdEMDBRYUtqR0RPbzlENGpUV003TTV1Yng5OFVYTkhn?=
 =?utf-8?B?V0NldHByeFVGMUhPeFlDbDJnamR2V1lxdWQybVIzTHZRdDZrbkFXbGtwcWp5?=
 =?utf-8?B?MjBxOXJJanJuakZ2ME5jR1FRNUtrMndzdU5BdVI2UW14Q3VWVkVmczQwK3Yz?=
 =?utf-8?B?L0ozMk1JZms3aUU0ODR0QlNnNWQxTFpkQ01KT2JqQlBHQTl4RkVrQ0tkMk5U?=
 =?utf-8?B?M0RJd2prWUhFc2Qwc21aYm9FOWdJa1p5V0l2THFiT0dJSWM5NzFxMldwOEls?=
 =?utf-8?B?eFdxSzZqVHZ2T1UwR3lRNjBRUi91emFsMTRFdXJYMHk4a0o5ZUVDc0tzZGpH?=
 =?utf-8?B?N2dZUjBxQ3lYaTJMai9UaVF1ZGVpamVMYzljS2k4d1kyOUZ5K3NLL0ZiY083?=
 =?utf-8?B?UDAvb3hDZW45WlRsbUtyUHV3VDBFY2RkdlpEbllXN0R4blZDL1lBbXBJRndh?=
 =?utf-8?B?aThtcEIvdUFVOUJkc2orMFY0WWNCLzJYcHFhby9lN1l1TGI3Um9zZmpUNkpu?=
 =?utf-8?B?L0pNMWxLWTJBejhyaGNveVdnaW9oNmh2a002aFJHY00xcTNnN3ZobVVSTzg2?=
 =?utf-8?B?aUtCdmRiQU5BVk5xRzNQOTZNbHNmU2hEVXZTalY2ZFhHeDBoSkVEeVFXVmlL?=
 =?utf-8?B?aHl0Vkc0VG9ucHNMM0N1ckdrd0NGUnF0WmtHMnFkMFNXMzEycFU0dUwzYUF6?=
 =?utf-8?B?QmUreEZhYWs2bUR1a0o1M05weHZ2VDZjQnExa2w2a2xYK1laWm1zNWsyVzlu?=
 =?utf-8?B?V0oxOVgrZThxZ0dDQU8ycXZCOERKdXBFNU81Ym5Kazg2TDc2RHZvcDZtSVIv?=
 =?utf-8?B?TUcwQ1A3cmpiaUdRcTdFMHI4Q2RWRnB3ekdueHBNVHBTcEcxOWl2VkRkNjJx?=
 =?utf-8?B?ZlZhMzZBdE85cEJxNkl3R2lycmhLTS92b0EvN21tc2wySEE0cnh1YlFGajBV?=
 =?utf-8?B?c0ZYVGR3d0VvUTN3WlA0TVBQUWZQQkxFSUNNdVBVWXZ6VEZFZUF4aWJFWi9V?=
 =?utf-8?B?TlVpMkVaeWJZM0xCWU0yNjFkSWttQy9ON1dsMEN3ekNZWUpYRHIwV0lKV3hs?=
 =?utf-8?B?STFTUDFTbFdYODBxdVExelNSNWlab0VNaHBRalZRcjUxMjdvYmlWd0ZReG5p?=
 =?utf-8?B?eVhXZ2xRMnJjVHpwb3dIMThvMGlCRitIMkwzUWp1eHFUenFwZWtmY3hpZ2M2?=
 =?utf-8?B?V2w3bW9POS9ja1ZYNWFMaithcG0wRW9QRFNUenlXZXc3ZHArd1hzclR4UmZh?=
 =?utf-8?B?R2EzTDZOTi9tdUdZK0dDY1cwcHE0SW1VSllWR2lZdjNQajV2bDljSi8wc01w?=
 =?utf-8?B?ZXQwK0VOVVZ0cGhpRnVjM3g3OFV5aWhac3JOS0pJeHRJdWVWeFlubWdNUVp6?=
 =?utf-8?B?SkI0RnFVZlc5ZWVhbEZEN0lhQStkRW5HSmVwUE1zN01ENGdXNmEvYllTRVpk?=
 =?utf-8?B?SGVrZ1l6RlIrajllVm1lcTJDMFFEWlRKcHlKL2xvajd2bWhna3IySmpCaVh4?=
 =?utf-8?B?UWQxbEJ3N0pCUjV2VHErcFVpVGVLTFBKUFk1QVJvQUdxdytpREhVbkhndUdV?=
 =?utf-8?B?SllDQTQyWVFSa3Z1V1d2aXlKWjJZcU5GTTlRRlJ1eHFyWEovV2lnbDB3dGdM?=
 =?utf-8?B?RThkYWtyOGVycVBuTmZhL1hST3hBT2wyR1hNMGNDN2xQakVRMGE5TnJxeUN0?=
 =?utf-8?Q?nLOY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906f33c7-6c67-466d-4b1b-08dd5ad4853b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 04:24:57.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1h1DBc3cl9EMP+wLA3XeJMwuKm8idnIM7KAZ+SFn9J7r5gtQyVtn7ABg7TA6nNQ18CBTgUV+6lW/8mkGJnXnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5jZW50IE1haWxob2wgPG1h
aWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyMDI15bm0M+aciDTml6UgMTI6MDYN
Cj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IG1rbEBwZW5ndXRyb25peC5k
ZQ0KPiBDYzogQ2lwcmlhbiBNYXJpYW4gQ29zdGVhIChPU1MpIDxjaXByaWFubWFyaWFuLmNvc3Rl
YUBvc3MubnhwLmNvbT47DQo+IHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb207IGxpbnV4LWNh
bkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBs
aXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2FuOiBmbGV4Y2FuOiBkaXNh
YmxlIHRyYW5zY2VpdmVyIGR1cmluZyBzeXN0ZW0gUE0NCj4gDQo+IE9uIDA0LzAzLzIwMjUgYXQg
MTI6MzcsIGhhaWJvLmNoZW5AbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxo
YWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBEdXJpbmcgc3lzdGVtIFBNLCBpZiBubyB3YWtl
dXAgcmVxdWlyZW1lbnQsIGRpc2FibGUgdHJhbnNjZWl2ZXIgdG8NCj4gPiBzYXZlIHBvd2VyLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPj4g
LS0tDQo+ID4gZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4vZmxleGNhbi1jb3JlLmMgfCA1ICsrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi9mbGV4Y2FuLWNvcmUuYw0KPiA+IGIvZHJpdmVy
cy9uZXQvY2FuL2ZsZXhjYW4vZmxleGNhbi1jb3JlLmMNCj4gPiBpbmRleCBiMzQ3YTFjOTM1MzYu
Ljc0ZjMxMzcyOTVmYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi9m
bGV4Y2FuLWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuL2ZsZXhjYW4t
Y29yZS5jDQo+ID4gQEAgLTIyOTIsNiArMjI5Miw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVz
ZWQgZmxleGNhbl9zdXNwZW5kKHN0cnVjdA0KPiBkZXZpY2UgKmRldmljZSkNCj4gPiAgCQkJCXJl
dHVybiBlcnI7DQo+ID4NCj4gPiAgCQkJZmxleGNhbl9jaGlwX2ludGVycnVwdHNfZGlzYWJsZShk
ZXYpOw0KPiA+ICsJCQlmbGV4Y2FuX3RyYW5zY2VpdmVyX2Rpc2FibGUocHJpdik7DQo+IA0KPiBm
bGV4Y2FuX3RyYW5zY2VpdmVyX2Rpc2FibGUoKSBtYXkgcmV0dXJuIGFuIGVycm9yLiBDYW4geW91
IGNoZWNrIGl0cyByZXR1cm4NCj4gdmFsdWU/DQoNClllcywgc3VyZS4NCg0KPiANCj4gPiAgCQkJ
ZXJyID0gcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2aWNlKTsNCj4gPiAgCQkJaWYg
KGVycikNCj4gPiBAQCAtMjMyNSw2ICsyMzI2LDEwIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVz
ZWQgZmxleGNhbl9yZXN1bWUoc3RydWN0DQo+IGRldmljZSAqZGV2aWNlKQ0KPiA+ICAJCQlpZiAo
ZXJyKQ0KPiA+ICAJCQkJcmV0dXJuIGVycjsNCj4gPg0KPiA+ICsJCQllcnIgPSBmbGV4Y2FuX3Ry
YW5zY2VpdmVyX2VuYWJsZShwcml2KTsNCj4gPiArCQkJaWYgKGVycikNCj4gPiArCQkJCXJldHVy
biBlcnI7DQo+ID4gKw0KPiA+ICAJCQllcnIgPSBmbGV4Y2FuX2NoaXBfc3RhcnQoZGV2KTsNCj4g
PiAgCQkJaWYgKGVycikNCj4gPiAgCQkJCXJldHVybiBlcnI7DQo+IA0KPiBJZiBmbGV4Y2FuX2No
aXBfc3RhcnQoKSBmYWlscywgc2hvdWxkbid0IHlvdSBoYXZlIGEgY2xlYW4tdXAgYnJhbmNoIHRo
YXQgd2lsbA0KPiBmbGV4Y2FuX3RyYW5zY2VpdmVyX2Rpc2FibGUoKT8gT3IgZG8geW91IGNvbnNp
ZGVyIHRoYXQgaXQgaXMgYWNjZXB0YWJsZSB0byBrZWVwDQo+IHRoZSB0cmFuc2NlaXZlciBlbmFi
bGVkIGlmIGFuIGVycm9yIG9jY3Vycz8NCg0KR29vZCBzdWdnZXN0aW9uLCBJIHdpbGwgYWRkIGEg
Y2xlYW4tdXAgYnJhbmNoLg0KDQo+IA0KPiBTcGVha2luZyBvZiB3aGljaCwgaWYgZmxleGNhbl9y
ZXN1bWUoKSBmYWlscywgcHJpdi0+Y2FuLnN0YXRlIHdvdWxkIHN0aWxsIGJlIHNldCB0bw0KPiBD
QU5fU1RBVEVfRVJST1JfQUNUSVZFLg0KDQpUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVzcG9uc2Us
IEkgd2lsbCB0YWtlIGFsbCB0aGVzZSBzdWdnZXN0aW9ucyBpbnRvIGNvbnNpZGVyYXRpb24gYW5k
IHByZXBhcmUgdjIgcGF0Y2guDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IA0KPiBZb3Vy
cyBzaW5jZXJlbHksDQo+IFZpbmNlbnQgTWFpbGhvbA0KDQo=

