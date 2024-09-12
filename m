Return-Path: <linux-can+bounces-1479-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9697616E
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833E81C22532
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75618A6BB;
	Thu, 12 Sep 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jDutvuDF"
X-Original-To: linux-can@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C7146A6F;
	Thu, 12 Sep 2024 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122289; cv=fail; b=PuEv/gbfA0tL5C1rD0pJhEx6PNsPD1wJ04SZuJ/Et7nVVlXV9tO3NhMoQMtoDMMiL9HUf4JhDA4RuSrM9N6NQQ7UBu7ozUBxfx72grkdEr1r+I3nG3YatNf4LhZ8ul2ags8oXUnWlNTZjylcgIvrgMl471C6P1c2FMNpCRNR2wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122289; c=relaxed/simple;
	bh=LW/z+nftmxivOa2kMFanr38eNew8Amrj+jp+x8SQSoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/b0k7I0VGTN/+YXRrp/U5vCGPJs9qbLgZSyIl1MczLM/DES/P+aXvl1X/LIvFszbHFeBSW+27rTDiEXJ222mivl5poijnA07bzfzz/fT7lorGXnSqcjp9fD6BFuXx85FNgirETvwlwjBqjjK69G956Xz0sK9MbIzsT/IiS0vOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jDutvuDF; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFXohDxbDIKDyToRSokrjXOGJwZQ8cH071ZD1jgwyMtUtvGx05kWfd7qxTYzFjtVX0QFSG7oJH8f7jvbEReDGj8gu+9qi6rxRwoUAmcEISSHFVbmFdRD4bi9HqpOhd6RWp4m5FO/vFHCN+FUFhZFMs6bRQq25mU2Aa00Re4MIPnxKd0VfMXm3oU+zU0CbDjEyfH4eEt8Pf/IEh4faFdfC2EK8iIWwcGtuSmsDcsZshPBHeAx/LWsJgfv2QUYRl183dLXtNRh1xnqXQju+3PRiUPIyc+8h6kRAjNDvUShGfs0razkvj6e62gGhJrwkB2igaVlqegohnU8KjaetOuVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW/z+nftmxivOa2kMFanr38eNew8Amrj+jp+x8SQSoc=;
 b=UaL+hoqn/OkEc9z3lGb8YSmetwC24WHA+PUUNk1OXOb3DpONkhivHQ/W6/FM3NGkVEaK75mZjFQWrKh8xWoqJLB1xjyxrFjPhOTzXTec7Ci1FIe1CxyF9C7VgDZB7R+kqgv+wifkvRdaoiQse5vYVSrhF8uQVfvUKig7h8WL31MvpNFsM6W940meZdfFTbGGIunOb+JGRRYHga1fZE2uwts4Q+CFEOjrTeFP2VPONO8zvwTTHtgfWTRaqFeKrWDvmiP9EpVDAhFPabPB7lrClR4M22D2BvNv2HN4Va/BZ1Aq6LrrzSpx7Fa+c3kS9k/UpwV/zBHDpkzjrsHm9ieZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW/z+nftmxivOa2kMFanr38eNew8Amrj+jp+x8SQSoc=;
 b=jDutvuDFVG344OhkL7Jru7PXvX5I4/4CdtyU74UqqHWZbKj38SgxMJXmXHadbx8eMPNTHAzZH4KB/bcU5xE+WGbFEXQ0pQ8G6GVFNbEwu6ssBhrfNOe9962klIvMKKtNcgGjOzoc79AM9N6prL0FX3ROHbry0kAZ7TVlIMQULiRASbK1QFVWY576f2nQoGVg8+X5qjoBczTlWeRNRtnlpO/P/Cgr+SPQf5iwx/GI/s4UDXq27UcKcR6KmWjwMIMjJTBeqJy55WjVep23x+QdWJxiTiP3uV1lnm4BgC0y4o8HNG7ynYXP/+EIs64F+UX6HY9o7XYQb752dNKu5ay7Ow==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 06:24:42 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 06:24:42 +0000
From: <Dharma.B@microchip.com>
To: <Charan.Pedumuru@microchip.com>, <mkl@pengutronix.de>,
	<mailhol.vincent@wanadoo.fr>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Thread-Topic: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Thread-Index: AQHbBNfr4/GsQBRrSECF7JHCMbv3E7JTrzaA
Date: Thu, 12 Sep 2024 06:24:42 +0000
Message-ID: <b9cb559a-a250-493d-87e2-c602f8b61196@microchip.com>
References: <20240912-can-v1-1-c5651b1809bb@microchip.com>
In-Reply-To: <20240912-can-v1-1-c5651b1809bb@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|SJ0PR11MB6765:EE_
x-ms-office365-filtering-correlation-id: e2207376-dd57-410c-234d-08dcd2f39684
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?azdOZG9LeFdiU2M4dWE1UjdadWwxcGM5L0c2MlNpc013cTJsNGtiKzVZVWVv?=
 =?utf-8?B?elczTTFlQU5mbnlOdDIwbE1GQjhmeWlVMWN2R0lEMkZtOHRYUzJuTEZzODFL?=
 =?utf-8?B?UjloTFRJWUhuMjJVRUxJWkpKcmRZRndXaFVWNTBBQlJsOU9CNVhsbmNveVIz?=
 =?utf-8?B?aVpvbjUxcWNsYWprS2k5NnBVRDlqWlBtNFB4c3I3QU9PM1RBRDZLMnVnMDJ4?=
 =?utf-8?B?cVp4cWRTNHF3L3JBY09ldnZaTFdNZWlETjcrbUxYNVFKczduV2xvUUVMMG13?=
 =?utf-8?B?TTlHRDh2Z2Irelc1RWJoZWN1b3VLbTc2NTNYQnFOQ2toblNFaFkxYXZzNkJt?=
 =?utf-8?B?T1RvdHQ2Y0FUMXdpWFZrK3RDZmRYWHVUc0tTU0l2L1dNeHBSR2x3d3I2bnZl?=
 =?utf-8?B?YVpGbDB0T1AyYy9aVTNjUHVKL2ZQOUk2ZmJ6OVdjcFZXczg2ODd5QkxTSHo5?=
 =?utf-8?B?TXROdmNnSnRMOHVsOWplL0MyN1RRY2sxSnpMRVJHUmJFb2VpcytMYWhaLzZG?=
 =?utf-8?B?MUN1aVVSUFlGQlR0Rlh4TUFxaHBrOVU0U2xXTGszdmtTY0FiN1BEdXdSbGdY?=
 =?utf-8?B?MVN0bHFHS1ljTENQN2hTY0xjeVArQk1iMXdtc3ZPTjVaTmR2UzlKSG1xR0xT?=
 =?utf-8?B?ZStPYjVTZmkrdWJTYlZmRE9OeTRJd2w5NFdQN3U3ajFtWHc4V3ZuWFEyMnM4?=
 =?utf-8?B?WGpWZ1hra1lMcS9hdDJEYjZXUWpuZ3pPOUNqYlY4UlExckd4VGFZK2Z1QkZ4?=
 =?utf-8?B?UlpzYWtPY0hpK2hKUml6c1dzNVJCZjRWTHBXYkxvN1kxL2FsMVBROFJtRnhs?=
 =?utf-8?B?eThlK0pPdjRWSjNJRzFzTUVTbHNDZVFScGl6RXkzcXZJU0k5VmlXdGdKenVw?=
 =?utf-8?B?QlhBeGRoa1FGc0JsS0dPWEYydUtaM3pDQzVzRnl6Y0piUE5KeGZCVGFSaHFJ?=
 =?utf-8?B?T2NEOWQyMjFqSmwxMHYydHpsQm5IOFJXZk5lRm5md1dkVXpyMWlFUGpId3Rt?=
 =?utf-8?B?d1d1V1ZJZG8zNlJmdlIvWmcxeU8xVGJnY1FiTUxJL1BFaW9QMCt0aGFQcWFx?=
 =?utf-8?B?c3I3QlV4dUNUbmNIWUtQOHZsaE5tSHBiR3VjU0h3ZVovVUJ5dEViWjJPaFA2?=
 =?utf-8?B?a2NKb0pkalk2MFpybktubGZaMlU0YllFeVo1WjlvUG81WlA5WWRwZjJ2RExM?=
 =?utf-8?B?UW1uRVlrWmVwMGFMclgzTXcycDZTZmpZenNVY1VuVXltRUo2RkJuTDJkcDYv?=
 =?utf-8?B?ODBRUVFac2RXTDNRNHp0UkJ5ZDQrcDNzMkxQTFRjYmsrRGxFdU0rYmt0NkR5?=
 =?utf-8?B?UEZiNHhSM1RQdEJkbW8yeEN3N0pEb1VCWEVpV0NOOGdFRjFXV1ZSNGVmaUJB?=
 =?utf-8?B?UWx1OHZoOEp2OGQraGJPckhzdG5hSGFpdk1EakhiM0grV1JTMkg3MXVCUjd3?=
 =?utf-8?B?VE5KbzhTblYranpzZnVsQmF0QzJzSHNPUmE4dks1YWE4aGQ4ZklpellOWURT?=
 =?utf-8?B?TGFrbUFvTHZDZUpSRm85dDlXWXpYbTdXMy9VS3YxWWZHak1pbURNKzIxcFNK?=
 =?utf-8?B?SXFvcFZid3RTSEpZSUpnM0ZMM3BpNkwycjJDeVBDenFpK21yQkpoWjBHWGZC?=
 =?utf-8?B?RFhobk5MNHVpVEN4ODFOZ3pGejBmNWFLZ0xUWmw5TFVDZE1McU53OEtEZG16?=
 =?utf-8?B?RW1vdkZLQlkzTUIvanJxbzAyZk9EcFgzR0RVMW9uQTYzRWpKZWRzcnRpeDlH?=
 =?utf-8?B?S1IrZ0ZibUdCN2ZsNEdycXNONWhIY3VzanI3LzlzcVdsNWdncVdZTTA2cjJm?=
 =?utf-8?B?WGZiV2tjRys2RmthWnA2UE56WGpDdzI1cVo1MGFUOXZpQllWR2tzTUdDa3Iz?=
 =?utf-8?Q?+FS65F/f+b993?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2VRQVpzdnNXL3BqVG5FaElHSVIxMFk3R2xjNUZSakVKWjlseVdJQXZObWlx?=
 =?utf-8?B?aDB0NDhpek44Q0dlNm1mNFZWYjB5NXR5TlRzVVZkaHNTUk1uRU4vYjd6cCtx?=
 =?utf-8?B?d1kwOXZVU3kyRldLVk1mcmFyRFNTM01ybjZ6SVJ2dlJraXZKVGJzMnl5T250?=
 =?utf-8?B?bnFRcXBBWlNnMWF4TTF5RmM3cDgxeFlIdXlrUnJ3NlhyeWNFOEVSZnI4bTdL?=
 =?utf-8?B?NVlkTHk1TUtyaXpPTGprV3ZnWVgxTDRMQlZSa3MyK2FPRE9jRVZDM3J4a3dh?=
 =?utf-8?B?L2E5KzdBTXd3Q05ZM2xyRnBTekx2cEJaVzFpVkVJVXJsbGFTaVBON1NNRXdW?=
 =?utf-8?B?Zm5vZzZWMkRnWVhtcXJsc3FBTEt3TGdNZnF0WDdNSDFJU3JJMkZoSmdTZ2k1?=
 =?utf-8?B?eTFlZE1jNjNDUnBmQXFaOHlYVDlWbzljWm1qOEpMWUUxejMyeW9ESU41WGtX?=
 =?utf-8?B?NUZKeFZkTXpLVzVWek50bG56THRFL1U1UmVsQUhlRXBRN2F3dTl5cnhLSVBM?=
 =?utf-8?B?S1c5T1dTdGpOMmJBQys0R3NQeHg0cjd5dDlTQzhnSGtOWlFpOG9hNHh2dDlz?=
 =?utf-8?B?dW5XN1BIZXlOQkRFQ0FuZTgyS01QSmFDOVUzL0xickZvVExXLzNhRzE3aHd1?=
 =?utf-8?B?eUdBNVQ1TENsRDJRb01tMjJMSnkwSWRHWm8xNlpWYVlnRmhrZGNqeHZmdXhG?=
 =?utf-8?B?TW90SG1PWS90RHN6QmRkZEpYZFVWTXcwQ2NVOVUxR1V4UnJobEU5UDlEaHA2?=
 =?utf-8?B?dEF4SnNVWHI5TG5xa3FyWkErUDBWZjJBZjY4b0VWZUtML200Z2ppeXF5bVo1?=
 =?utf-8?B?Uk1yT0gvVndTRGo0WG05Q3MyNXlGbkZXY0VFWmhad3RLbzRnZno5TzVhckFH?=
 =?utf-8?B?a1BuVkk4cDRnMXoyaUdILzd5aUNPbXhMMjVVRFNxVTFMbnFEaDArak1jb0Nh?=
 =?utf-8?B?Qm83MWpMUUFIMjhzNGpmTURtV2IzYUxpcEt0T1N3TERpek9KSGhFaFdVUXJZ?=
 =?utf-8?B?SjRhZjNtWTh4WDFaMVFEWms0dkw0MndjZjRzUjBhUW1GNkpUWW9Jc0todzk5?=
 =?utf-8?B?SnlxSlY0WW5VYVJPRWlCTzZKLy9udnRqZ0tWYnVPNEtiTnExd3hVdXYyVUg0?=
 =?utf-8?B?akZVd3IyS2RyWitpYW5rZ3o3cjU2YmhpQnNseTRhV0xFWTJ2cmYvSjdnR0gw?=
 =?utf-8?B?a1FQdHlXelI5eFBUbkY3eDl6MVVIYVJhM1cxMXhldHJXaGt1Rm04L1FtVy91?=
 =?utf-8?B?T2xDMzluTmY4WThyOUp1M1pGeHE3SGI0S3hTdVVjQ3VlRyttU0hiK3NRUjBa?=
 =?utf-8?B?Y3UxTnVMYk5XaDF6WGdjaG1qUHgxc0Q5Ry9CY2sraW5jTXZlOG9DLzY0YW9L?=
 =?utf-8?B?Q0VKQzNxVVd6OHZEK0JETktDS25hU20wRkM0REhRTmQ5elQ1Z0h1SHFzZDZW?=
 =?utf-8?B?Y0J6UXhiQWg4STRZei9wKy9YSWJwSXc3WlRpbFJCODg1VUlmL3pXVHNZdmkz?=
 =?utf-8?B?cHFSWUljVHRGYXc3ejBLTWZ6c0VYcFI0UlJpai83MFNZYWdXSmJKOHVYWlhi?=
 =?utf-8?B?Y0dIWHNhOS9BTFg4M2hMbk9sSHU1eitHMGlvZlRTTEpFV2ZrSjF2Q0NKdXpE?=
 =?utf-8?B?WnJyL0FBSWVPWEtWd1IrMGZYTEtRbW94VjhIeGdvQ2lDODhHZERoMXFYMi9J?=
 =?utf-8?B?ak9MUzBWaCtNamlGdW96TkNzY3o5R0VhQnpCWkV0cFZyTDBOYUNFTzR0VnRn?=
 =?utf-8?B?N1MvSVZRWjVETElOZXhVT2NmaGM2a3ZxcytBdmg0UDRkNlBDamowQW1YMEhB?=
 =?utf-8?B?K0ZMVkRrbUF6VEQ3cE16UzJWU1A1bVZXQ050S01VRndMMUtYbTJJbDlIUzlY?=
 =?utf-8?B?c1pmK1Q2N214K3RtMWpKWTBWVm1iRE1WS3U3UWNIOUNBekJGVHptbG1SNVZa?=
 =?utf-8?B?blczMHVxazE3WWErWkd5Y01zczRtQjVMZFRHR1hqbmRCM0JmcmJ0YVpQaXRI?=
 =?utf-8?B?bVRvaExkNVJyVVU4VE51eUoyS2tDODFRbVh3SEVXeTIzYTlyWWhhRDZtY1Z5?=
 =?utf-8?B?a3J3THhIZ2FLdzRMTkpIWUZROWdSYjRpVlJKSmNUa2JSd2VNRUs3SXE0THBB?=
 =?utf-8?Q?pW/XkTffuOolONUog345wTtgr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C110F9E5BE2BB044A3A45189CF3F86F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2207376-dd57-410c-234d-08dcd2f39684
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 06:24:42.3833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tg6zzpXNZvILVDXD+XsGMc5SMWKRdxaR1Y/bUWFmPUMWpgKiZmMOLyeZWiqfBuVsPcF0AoZkojMZaZT7EvWqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765

T24gMTIvMDkvMjQgMTE6MTkgYW0sIENoYXJhbiBQZWR1bXVydSB3cm90ZToNCj4gQ29udmVydCBh
dG1lbC1jYW4gZG9jdW1lbnRhdGlvbiB0byB5YW1sIGZvcm1hdA0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ2hhcmFuIFBlZHVtdXJ1IDxjaGFyYW4ucGVkdW11cnVAbWljcm9jaGlwLmNvbT4NClJldmll
d2VkLWJ5OiBEaGFybWEgQmFsYXN1YmlyYW1hbmkgPGRoYXJtYS5iQG1pY3JvY2hpcC5jb20+DQo+
IC0tLQ0KPiAgIC4uLi9iaW5kaW5ncy9uZXQvY2FuL2F0bWVsLGF0OTFzYW05MjYzLWNhbi55YW1s
ICAgIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9jYW4vYXRtZWwtY2FuLnR4dCAgICAgIHwgMTUgLS0tLS0NCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2F0bWVsLGF0OTFz
YW05MjYzLWNhbi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9j
YW4vYXRtZWwsYXQ5MXNhbTkyNjMtY2FuLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMDAwMDAwLi4yNjlhZjRjOTkzYTcNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9hdG1lbCxhdDkxc2Ft
OTI2My1jYW4ueWFtbA0KPiBAQCAtMCwwICsxLDY3IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiAr
LS0tDQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL25ldC9jYW4vYXRtZWws
YXQ5MXNhbTkyNjMtY2FuLnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
bWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IEF0bWVsIENBTiBDb250cm9s
bGVyDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIE5pY29sYXMgRmVycmUgPG5pY29sYXMu
ZmVycmVAbWljcm9jaGlwLmNvbT4NCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJs
ZToNCj4gKyAgICBvbmVPZjoNCj4gKyAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAtIGF0bWVs
LGF0OTFzYW05MjYzLWNhbg0KPiArICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTl4NS1jYW4NCj4g
KyAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLWNhbg0KPiArICAgICAgLSBpdGVtczoNCj4g
KyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gbWljcm9jaGlwLHNhbTl4NjAt
Y2FuDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTl4NS1jYW4NCj4gKw0KPiAr
ICByZWc6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBpbnRlcnJ1cHRzOg0KPiArICAg
IG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsN
Cj4gKyAgY2xvY2stbmFtZXM6DQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBjYW5f
Y2xrDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcNCj4g
KyAgLSBpbnRlcnJ1cHRzDQo+ICsNCj4gK2FsbE9mOg0KPiArICAtICRyZWY6IGNhbi1jb250cm9s
bGVyLnlhbWwjDQo+ICsgIC0gaWY6DQo+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiArICAgICAgICBj
b21wYXRpYmxlOg0KPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiArICAgICAgICAgICAgZW51bToN
Cj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1jYW4NCj4gKyAgICB0aGVuOg0K
PiArICAgICAgcmVxdWlyZWQ6DQo+ICsgICAgICAgIC0gY29tcGF0aWJsZQ0KPiArICAgICAgICAt
IHJlZw0KPiArICAgICAgICAtIGludGVycnVwdHMNCj4gKyAgICAgICAgLSBjbG9ja3MNCj4gKyAg
ICAgICAgLSBjbG9jay1uYW1lcw0KPiArDQo+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNl
DQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ICsgICAgY2FuMDogY2FuQGYwMDBjMDAw
IHsNCj4gKyAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05eDUtY2FuIjsNCj4g
KyAgICAgICAgICByZWcgPSA8MHhmMDAwYzAwMCAweDMwMD47DQo+ICsgICAgICAgICAgaW50ZXJy
dXB0cyA9IDwzMCBJUlFfVFlQRV9MRVZFTF9ISUdIIDM+Ow0KPiArICAgIH07DQo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9hdG1lbC1jYW4u
dHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vYXRtZWwtY2Fu
LnR4dA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMjE4YTNiM2ViMjdlLi4w
MDAwMDAwMDAwMDANCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC9jYW4vYXRtZWwtY2FuLnR4dA0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDE1ICswLDAgQEAN
Cj4gLSogQVQ5MSBDQU4gKg0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtICAtIGNv
bXBhdGlibGU6IFNob3VsZCBiZSAiYXRtZWwsYXQ5MXNhbTkyNjMtY2FuIiwgImF0bWVsLGF0OTFz
YW05eDUtY2FuIiBvcg0KPiAtICAgICJtaWNyb2NoaXAsc2FtOXg2MC1jYW4iDQo+IC0gIC0gcmVn
OiBTaG91bGQgY29udGFpbiBDQU4gY29udHJvbGxlciByZWdpc3RlcnMgbG9jYXRpb24gYW5kIGxl
bmd0aA0KPiAtICAtIGludGVycnVwdHM6IFNob3VsZCBjb250YWluIElSUSBsaW5lIGZvciB0aGUg
Q0FOIGNvbnRyb2xsZXINCj4gLQ0KPiAtRXhhbXBsZToNCj4gLQ0KPiAtCWNhbjA6IGNhbkBmMDAw
YzAwMCB7DQo+IC0JCWNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1jYW4iOw0KPiAtCQly
ZWcgPSA8MHhmMDAwYzAwMCAweDMwMD47DQo+IC0JCWludGVycnVwdHMgPSA8NDAgNCA1Pg0KPiAt
CX07DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDMyZmZhNTM3MzU0MGE4ZDFjMDY2MTlmNTJk
MDE5YzZjZGM5NDhiYjQNCj4gY2hhbmdlLWlkOiAyMDI0MDkxMi1jYW4tOGViN2Y4ZTc1NjZkDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBC
Lg0K

