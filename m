Return-Path: <linux-can+bounces-1189-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9F94EF5B
	for <lists+linux-can@lfdr.de>; Mon, 12 Aug 2024 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869B41F2239F
	for <lists+linux-can@lfdr.de>; Mon, 12 Aug 2024 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872AD17C7C2;
	Mon, 12 Aug 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Zkzg3Q4e"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2129.outbound.protection.outlook.com [40.107.103.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAC17D375
	for <linux-can@vger.kernel.org>; Mon, 12 Aug 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472319; cv=fail; b=Nd1kz27uNm5mis6hWZzjWSfQDUMWneE9Lde7r4i3E39htvHihK5ogJwKBiZtnaMjUQAMoZjp19Rm3prOtEVDgO//mCGlKn5rbgbmvIYUEwdylScM3vj3sJ/3KOCFXQ3Dkap38lI2CG66EonZTGuUG7PhLo3BZgEsGnWgsfx5AEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472319; c=relaxed/simple;
	bh=5xrkYDDyKJ7KEUAT5iONlAqH7q+hDdLjYgkWq8BZ9rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3s0x9EhOalX1u2fcgeoXELXEop4aqRW6t/0B+Nvq1w7zJbMYf7413842cdm50+2wMGqM1qOSrAYuUkyr/3nO5njZwke0+EVqp0uW6ANkxoXzmZbb+UXYu/a/2cUnm+wY4fxeLVEKkhyVEgGnQiIK/mXJnpHNdsD1rIRcJMFfWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Zkzg3Q4e; arc=fail smtp.client-ip=40.107.103.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogZEagH8bAiUYgMSWyfThKsu7d60bxyaARbwyMvuB215nMi0nIeRu7aggoEZuKPz50CJeKyYThZN3eVz8EOYXZuFt8oqfa0aCfjogFRNBa3YDy9Xacdmt6q1QQdJk1ZE6R8n/tEe3+Ar3Aa5y9SW33zDJb2LKjesv9trYMqXvxfnvEXK134TqTlGF8Kt+uXJH/cJXe3Da8/i12DC4VesZ3ghPSmnCHTXwtyclUTjtiVvMEeGKFzcWzsKcRk+oA8lvGZLWrT6aMBKZelBhhozg2xgrk6p3JubxXoUaH7a8916GSsKxcUJrHBjSMAmJQqzyjnnUE+U3knyz6yA+sBu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xrkYDDyKJ7KEUAT5iONlAqH7q+hDdLjYgkWq8BZ9rk=;
 b=rgZy3GwTWGQ+vot77tQlQjbFN2tRpsMUIuy+CBY8HyRifgd7vkX7G3P2oX3yzEX47n1PjUV4VtX+4kwA0AcP2OmHL1ufmKQenR0z84uZd5VEbDEwt4IAMZU+hT7xZZRQz1zQAvigxyjyWqn4nP2TUO7wUUygZbSUW70uNyrLvx+XR4VK6iGaS7Ymcpdl4q6E9Wxl8Bf77lNaO7LFJKzZwiGeyXL6uRKaZOl6mhdXKnRfu/tzhRNRn+bU/VSfee4b8wk/YpI1Oj3nutgfSFqaJTQEyN+VfeCNgmTLrPFmUfnrNF+HvhLfJbDHu3ZbK5kxbypgbI5wlrvUaPviTmT5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xrkYDDyKJ7KEUAT5iONlAqH7q+hDdLjYgkWq8BZ9rk=;
 b=Zkzg3Q4e1KS6EyMv6eVIiJjsZimjaFoU6pNRNqP9Xa1zCUQRDiGPC1Tn6bQRql/Ud/TmBnAHNXSfAEwZzvCasmNJ7UuWt6AeqVr4iQd+IajCJMuY1+Ucv42TOQmV47Rz6S7ZOPFpzIkxNahc0ddst8RY3Yaaj/rnQ+E39FWLKKo=
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:144::17)
 by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 14:18:32 +0000
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::33fc:adc3:2221:4b68]) by VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::33fc:adc3:2221:4b68%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 14:18:32 +0000
From: =?utf-8?B?TWFydGluIEpvY2nEhw==?= <martin.jocic@kvaser.com>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jimmy Assarsson
	<extja@kvaser.com>, "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: kvaser_pciefd: Use a single write when releasing RX
 buffers
Thread-Topic: [PATCH] can: kvaser_pciefd: Use a single write when releasing RX
 buffers
Thread-Index: AQHa05tV4PbN/MxK5EqirzmixWGrlrIY84oAgArnoIA=
Date: Mon, 12 Aug 2024 14:18:31 +0000
Message-ID: <d092e2cf51c4b99355d729dd1612146a046a3373.camel@kvaser.com>
References: <20240711135451.2736466-1-martin.jocic@kvaser.com>
	 <20240805-mindful-unbiased-lobster-384ed9-mkl@pengutronix.de>
In-Reply-To: <20240805-mindful-unbiased-lobster-384ed9-mkl@pengutronix.de>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P193MB0559:EE_|AS8P193MB1285:EE_
x-ms-office365-filtering-correlation-id: f7a946c8-f0ab-4555-5b8d-08dcbad9a523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWdGNkhiU1grZ2ZpdzYzbkNrNGVBM1RGTzNGcm9UN3QxV0JubzZmZklZWmpD?=
 =?utf-8?B?ZERHT2NZNFAxVzE1WnhWSVpLcnBNcktZUUZZc0V2U2dOaTlZazN3R0lLeDYx?=
 =?utf-8?B?TFFoV2RGVkIrZjFQVVByeTNzMlF1dVBGVkh6L1FycTdmRHFvejBZa0hic0c3?=
 =?utf-8?B?TkZGNTB6azRLVWhQeThkL3EvTCtSUndibWxXZFQ5bERSR09ldmFvVjBxeitU?=
 =?utf-8?B?UklldTU4NUNtejc4UTU5emQrN1VBQlRBRWVUOEl4TW1SSXl6MUl2ckgvdisx?=
 =?utf-8?B?VmM2dyt0cTJNN2lFWVdCTlF1ZFAzajJmZUlLMHFVNFFjQWZJb0Vxc2tuczlo?=
 =?utf-8?B?Q1REOFhSUWlaVEhDTE1iWXUzN0xtU2d2VnZRdlRQSFhnWXl4cURQblphdVVU?=
 =?utf-8?B?VWdJWmc3RXFKdmVYTk9MTE03UWF3OGJwQVllQS9vejJwa2k5OUdRdW9uMlZw?=
 =?utf-8?B?TG9FL25rY0toc3EySDhMQ05XekFueEhoMTlQVXB1L2hnTVVsQWJXK0hVNGJF?=
 =?utf-8?B?K25KVW1qa2FBQnptclRZU0d5M2hhUkFGbzUzR25pbVNiY1h1SDMxeWZseUdw?=
 =?utf-8?B?SG1KWm84cFB2M3BSQk1MUWpGa1ZZdTBCMTcrUzZOYzYweWZISXA3V2lmdTBi?=
 =?utf-8?B?UHRGLzJvVHJxWXk1SXQ1UElXaStBYnI4ZXltb1htWUxRcHRuNE1sMmdTOXZw?=
 =?utf-8?B?UlJ1NG15WW4xd25pYXNFZ05OVkQrcVNlTzQrNDZRN1NYc2RIcFVPL3pURFpk?=
 =?utf-8?B?WUhXV3BOU3B2d053bG5lQjdDNjNvcEFTQmFETFJqTGlqZUNGMmZkRDIyUk5T?=
 =?utf-8?B?dFNCSjhUTDhObGtqcVZtV0xlY3g1dVdOb3RTcEhJU2U5QkV2a25xOXAwRjFM?=
 =?utf-8?B?bUhCdjd4SGptaXBUN0x2OU5FOFJVZ2tRNHFUeTlWRjhLdHAwTlFiQ0JUSmM5?=
 =?utf-8?B?SVQ0TmVzMG40UFdzalVmTHNVNFk2RE1Uc211eXo2MzhLNUhWM01iaHNpSkxo?=
 =?utf-8?B?ZlQ1ZzBOWEgzWUtidDFremo3eWRBejlkSVhpQ0FiZU1kSU1xTmtIV0t0MTlJ?=
 =?utf-8?B?Y1p1NkxpOHU0TVBoNkd3cHBxTXJaRVNuMkQ0aFZtN2Ixdy9pZmpVcFZCaFlm?=
 =?utf-8?B?Z0h0VHdGMUJuc3dsS3VGUkRIbG9zdlU3MXg2TDRNcnI5MUZJNU5leHZSZEth?=
 =?utf-8?B?WGRNelhVRGpaV2dnVzFFV0c5K0EvZjIrdGJTSGVxVGZvSDg5cHBBUEw5U3Nz?=
 =?utf-8?B?YjdkVEtxcmNDd3plRzJ3NmErODh1SVRMWjliZ0tRVDdJTHlIL0lnN2VDdjFJ?=
 =?utf-8?B?aU1jcGs2a1VrbUJQVy91UWJ6cHl5S2Q0OXpFSytseHc0V3dTT2pTR2Z0cVZP?=
 =?utf-8?B?NHQ4bFViZ2RjVEhNOUhUTHZYazUrcUZxd2RsK0czV3VoZEpRWmJ0SHIrZHVL?=
 =?utf-8?B?Q0VzVXFWKzFhV01jTUlXYlFacGUrQlBsenI4MFpNUm80NFBabndqZ24zbFNK?=
 =?utf-8?B?NlZNRm0xVHFQalBWTFBLTjZIaklIQ0hDM05RSmtJd1ZPSXZ5M0tYRDM0Ymh3?=
 =?utf-8?B?Q0o3cTlydWJCUEJoVWlsT1hSSkE0N3JiaXoyYjdpNDUyY1BPK0pMYWIrOFlW?=
 =?utf-8?B?U3NDOHcwQVhGQ0FYczdMMkpIZ3JVQVd2bjJxc1FVMjIzc3oxUy8ydWlkR09W?=
 =?utf-8?B?WTArdnNJYlRLZ2VaNjhMSE1tVXhGeGVnY1V3YU5XaHA1YXMzYmlGeG41Qnox?=
 =?utf-8?B?ME95cUhHRXR0ZTRqRFBWd05CcnFYZjQ1dTVOL2VXT0RvRVRLU3E2UUlnaS9M?=
 =?utf-8?B?UGlxc1hoUElsc1l3QUxydVova1BFN3NDNDZxZHZmclZ4WXlxT1k0aE05R3Nn?=
 =?utf-8?B?SHcxNWN5Y0xHU3FMZGR3Q25IeUtOdThzOUN3cmhBeUhadkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0559.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjYrYXFvOG9PQ2M4WmIydno3M1pQVG1wbkNML1lwdENVRzY4TmgvdGFrYWpF?=
 =?utf-8?B?b0E2aHJCWkltdm9zV3NIQ1dkVmx6c0JiNVQ5UUtlbGVrSld1Zm9weGcvYXZ2?=
 =?utf-8?B?enE2SVJWV3VYV282bUtBS1ZIekE4dWxsMXh5MUVsNFJ1NWN5RVRHcDZKb1BP?=
 =?utf-8?B?ZnA2blQrQU8xRFBQODRJVDNqYlluN0RERC80SGRHcWRnaDBFYmU1b0xlbzQ5?=
 =?utf-8?B?R21CalB5aTRQV2NMa2lOdEhheDNTVTFIVG1wdXlZdERoNmlvdWhYUVQwc1h2?=
 =?utf-8?B?emtGRkJGRXJXdzgwOVBVU2UvMjdtcDVJb29BTy8xQzRycTladndrOFp6dEg4?=
 =?utf-8?B?cHB2NjkwTEZPZHRnTjJZUWhjVWZhSFBNUHdEY3NHZHVPYTY4RC9IaTBxVk1z?=
 =?utf-8?B?Y1FxaUdiMlNRZjByME82S3lVQWtVTWNvRjV6eEJESGUxdEJDRzVhV3ZKSitD?=
 =?utf-8?B?UDhJazFCNStmZzNGNTNhSkt5SkFIbkFVeVVsSHhINTlFUCtzc0RIZlpuOENF?=
 =?utf-8?B?bmIvajlaYWFyOEVOUjRFK21nbjhLRmVOaklMZS9nT3BqRnR2aUJnam5iRFN5?=
 =?utf-8?B?UmQxNXpBQWxXblNhVitBT2dISjJpRVNER3BDK0RVV0I2ZksycVVEVTQyUjdP?=
 =?utf-8?B?dmtkQXJjcDlBSXEzdnZFNFZQMWMzVkVreEhDaldyTEhiZy9NTWErQTFPYm9V?=
 =?utf-8?B?R2tIU2dJYVBJdTNIK05rUVJLZjRnTnZMeWpPSDZ1c3c1a1hTWnhjaVVnSUo3?=
 =?utf-8?B?NkRJbFRPTkxvd2NCQ2g3Undvdm54cW1idGhoUGR3TWtJemJsbERGV1U3TVc2?=
 =?utf-8?B?NUk1czR5VWNnMStHVFIxQ2lVWmxQTlpWYzhTTzdDMFRMSVFuSUpVWEl5UjE5?=
 =?utf-8?B?UW5JQkZsOHhqaWdhMFY5NzJLRU5zbExMeGhpQjZkSHNNS2pKTzZFS2RMZjIz?=
 =?utf-8?B?N1NQUTdYYnBQU3RKdDBkZTlVdHBLTUlkeVJFcVBvN0VFVWJFcWVJeTd3eFZm?=
 =?utf-8?B?ZWZSamZpWkQzT3plbDBmZy9VMU5vTkZEOGJvWGx4VmxOOU5oMFpHWks4V0NI?=
 =?utf-8?B?amg4WGs5TDh2V0FZM3I5WjRUWU5MamMwWG5XWnRaSU1scHpwb0V1c01iU3pH?=
 =?utf-8?B?SWpUYXRyQ1pOdHpWNUlPRTlReU5MK1pDQlVJL2tNeUFOM1h3Y0pBSXNsczgv?=
 =?utf-8?B?Q01LdGRkdm81Tit5VlRtMVQ2NnpzSHVvMklKeThnNG85MUJoZkVPaXg2SE5S?=
 =?utf-8?B?Q1ptZ3VEZVQ0a1FNaUxZQnVVT3dYNEhQcG5rSk9vd0xLYlFYMVpZT3MxSXpE?=
 =?utf-8?B?YTdwL3prZE43WmVoeFdyMmJlRU5HZTlRdE1Ia2lOSnlOUHR6bWhyZWRWZU5W?=
 =?utf-8?B?czNBNWZsQjNxS3RzVnU4UmNGbEdHNkUzTEQveVNFcGJyc28wOGlheDBxdUZE?=
 =?utf-8?B?bHB5NFpNMXA1SjNPaWxZV1dxRUloY3BXRE5MQ0IySHBYa2tsMHBFMnFoVEc0?=
 =?utf-8?B?MnN2TEQ2RHIwbFAzbHZjK3hyQTlIenZ5bXlCUWpuS0x6Y0pJV2FRSXNxSjhv?=
 =?utf-8?B?N0ljclZ6eWh2NzNBVE1EbTUxS1FMamszdmYrVmdkOFZTZmsyNjc0ZFkraTFt?=
 =?utf-8?B?ZlZrZFF6T2doU3ZvdEsrNWg4MnhYUmFjSXNtYmxyUUwrdUQ1Q1lWaDdHTUtR?=
 =?utf-8?B?M2U0eEdPWEs0anQ4UDJ6QXk4OFhMeE0wR2l4MDRCMTdramM3Y1NYZVJiandn?=
 =?utf-8?B?WEtyS1BDUlJ6RFJhOUhENGs3dHBUdWxUY2RzZXg1OXcvZktmTnN3NGsydkRC?=
 =?utf-8?B?bWFDSCtMWFhTc1J0ZlFlS3BoMFluZm1hOW5tY3NadVVGNFF5RlM2azRRMUxo?=
 =?utf-8?B?dlU2Zm1ONzJETHVGYlJERnBIWmtsUU0vUUZ0UG5sMm5EdG1qYVF4dmZaanpW?=
 =?utf-8?B?aGxMcTVRSmtScjY3WEIwMDBKQVAzQjZ5UFJpandtemNVWjNlKy9PMUcvV1Zo?=
 =?utf-8?B?bitBbGtuVzJJZHFrNWJwaWk3UEphRE9UL1V0N0F3Z2huOU10RWRNeC9kTE5D?=
 =?utf-8?B?S2lESUdhSWR6RzR5ZlVFcGdSeGhIenhKdDNidjJrUjJ4bkpvY2QxcEU2Z05Z?=
 =?utf-8?Q?68ptLcl6pIUqsIkk/qdzS6I/M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8547AD3C92C9B548AD3AE61B7527780A@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a946c8-f0ab-4555-5b8d-08dcbad9a523
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 14:18:32.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vwSLEsK2Ahe+mjGVJ3AQImEX3mScZg2cGO0lne5cK1sOPmTDk1VZKULwtqhb1GSjXRiq0QV9nLOWlYiPF6fZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1285

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDE3OjM3ICswMjAwLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90
ZToNCj4gT24gMTEuMDcuMjAyNCAxNTo1NDo1MSwgTWFydGluIEpvY2ljIHdyb3RlOg0KPiA+IFdl
IHNob3VsZCByZXR1cm4gZnJvbSB0aGUgSVNSIGFzIGZhc3QgYXMgcG9zc2libGUgaW4gb3JkZXIN
Cj4gPiBub3QgdG8gbWFzayBhIG5ldyBpbnRlcnJ1cHQuDQo+IA0KPiBEbyB5b3UgbWVhbiByZWFs
bHkgbWVhbiAibWFzayIgbmV3IGludGVycnVwdHMgb3IgIkFDSyIgbmV3IGludGVycnVwdHM/DQo+
IA0KPiBJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIGhhcmR3YXJlLCBidXQgaW4gc2V2ZXJhbCBv
dGhlciBJUCBjb3JlcyB0aGUNCj4gZHJpdmVyIGZpcnN0IEFDS3MgdGhlbiBJUlFzIHRoZW4gZG9l
cyB0aGUgd29yay4gSXMgdGhpcyBhbiBvcHRpb24gaGVyZSwNCj4gdG9vPw0KPiANCj4gcmVnYXJk
cywNCj4gTWFyYw0KPiANClNvcnJ5IGZvciB0aGUgbGF0ZSBhbnN3ZXIsIGJ1dCBJIGhhdmUgYmVl
biBvbiB2YWNhdGlvbi4NCg0KTWF5YmUgSSB3YXMgdW5jbGVhciwgd2hhdCBJIG1lYW50IGJ5IG1h
c2tpbmcgd2FzIHRoYXQgYXMgSSB1bmRlcnN0YW5kIGl0LCB0aGUNCmtlcm5lbCB3b24ndCBpc3N1
ZSBhIG5ldyBjYWxsIHRvIGFuIElTUiBmb3IgYSBzcGVjaWZpYyBpbnRlcnJ1cHQgdW50aWwgdGhl
IElTUg0KaGFzIHJldHVybmVkLCB0aHVzIGVmZmVjdGl2ZWx5ICJtYXNraW5nIiBuZXcgaWRlbnRp
Y2FsIGludGVycnVwdHMuDQoNCkt2YXNlcidzIFBDSWUgaGFyZHdhcmUgdXNlcyB0aGUgS0NBTiBG
UEdBIElQIGJsb2NrIHdoaWNoIGhhcyBkdWFsIDRLIHBpbmctcG9uZw0KYnVmZmVycyBmb3IgaW5j
b21pbmcgbWVzc2FnZXMgc2hhcmVkIGJ5IGFsbCAoY3VycmVudGx5IHVwIHRvIGVpZ2h0KSBjaGFu
bmVscy4NCkkuZS4gd2hpbGUgdGhlIGRyaXZlciBwcm9jZXNzZXMgdGhlIG1lc3NhZ2VzIGluIG9u
ZSBidWZmZXIsIG5ldyBpbmNvbWluZw0KbWVzc2FnZXMgYXJlIHN0b3JlZCBpbiB0aGUgb3RoZXIg
YW5kIHNvIG9uLg0KDQpUaGUgZGVzaWduIG9mIEtDQU4gaXMgc3VjaCB0aGF0IGEgYnVmZmVyIG11
c3QgYmUgZnVsbHkgcmVhZCBhbmQgdGhlbiByZWxlYXNlZC4NClJlbGVhc2luZyBhIGJ1ZmZlciB3
aWxsIG1ha2UgdGhlIEZQR0Egc3dpdGNoIGJ1ZmZlcnMuIElmIHRoZSBvdGhlciBidWZmZXINCmNv
bnRhaW5zIGF0IGxlYXN0IG9uZSBuZXcgaW5jb21pbmcgbWVzc2FnZSB0aGUgRlBHQSB3aWxsIGFs
c28gaW5zdGFudGx5IGlzc3VlIGENCm5ldyBpbnRlcnJ1cHQsIGlmIG5vdCB0aGUgaW50ZXJydXB0
IHdpbGwgYmUgaXNzdWVkIGFmdGVyIHJlY2VpdmluZyB0aGUgZmlyc3QgbmV3DQptZXNzYWdlLg0K
DQpXaXRoIElSUXggaW50ZXJydXB0cywgaXQgdGFrZXMgYSBsaXR0bGUgdGltZSBmb3IgdGhlIGlu
dGVycnVwdCB0byBoYXBwZW4sIGVub3VnaA0KZm9yIHRoZSBJU1IgdG8gZG8gaXQncyBidXNpbmVz
cyBhbmQgcmV0dXJuLCBidXQgTVNJIGludGVycnVwdHMgYXJlIHdheSBmYXN0ZXIgc28NCnRoaXMg
dGltZSBpcyByZWR1Y2VkIHRvIGFsbW9zdCBub3RoaW5nLiBTbyB3aXRoIE1TSSwgcmVsZWFzaW5n
IHRoZSBidWZmZXIgSEFTIHRvDQpiZSB0aGUgdmVyeSBsYXN0IGFjdGlvbiBvZiB0aGUgSVNSIGJl
Zm9yZSByZXR1cm5pbmcsIG90aGVyd2lzZSB0aGUgbmV3IGludGVycnVwdA0KbWF5IGJlICJtYXNr
ZWQiIGJ5IHRoZSBrZXJuZWwgYXMgZGVzY3JpYmVkIGFib3ZlLiBBbmQgdGhlIGludGVycnVwdHMg
YXJlIGVkZ2UtDQp0cmlnZ2VyZWQgc28gd2UgY2Fubm90IGxvb3NlIG9uZSwgb3IgdGhlIHBpbmct
cG9uZyByZWFkaW5nIHByb2Nlc3Mgd2lsbCBzdG9wLg0KDQpUaGlzIGlzIHdoeSB0aGUgcGF0Y2gg
bW9kaWZpZXMgdGhlIGRyaXZlciB0byB1c2UgYSBzaW5nbGUgd3JpdGUgdG8gdGhlIFNSQl9DTUQN
CnJlZ2lzdGVyIHRvIHJlbGVhc2UgdGhlIGJ1ZmZlcihzKSBpbnN0ZWFkIG9mIHBvc3NpYmx5IHR3
byB3cml0ZXMgYXMgYmVmb3JlLg0KDQpUaGUgaW50ZXJydXB0cyBjYW4gYmUgKGFuZCBhcmUpIHJl
c2V0IGJ5IHdyaXRpbmcgbG9naWNhbCBvbmUgYml0cyB0byB0aGUgSVJRDQpyZWdpc3RlcnMgaWYg
dGhhdCBpcyB3aGF0IHlvdSBtZWFuIGJ5IEFDS2luZy4gUmVnYXJkaW5nIHlvdXIgcmVmZXJlbmNl
IHRvIG90aGVyDQpJUCBjb3JlcywgSSdtIG5vdCBxdWl0ZSBzdXJlIHdoYXQgeW91IG1lYW4uIEFy
ZSB5b3Ugc3VnZ2VzdGluZyBzb21lIGtpbmQgb2YgdG9wLQ0KaGFsZi9ib3R0b20taGFsZiBzb2x1
dGlvbj8NCg0KSWYgc28sIEkndmUgdHJpZWQgdmFyaW91cyBzdWNoIHZhcmlhbnRzIGluIHRoZSBo
b3BlIG9mIGF2b2lkaW5nIHRoZSAibWFza2luZyINCnByb2JsZW0gdG8gbm8gYXZhaWwgKElJUkMs
IGl0IHdhcyBiZWZvcmUgbXkgdmFjYXRpb24pLg0KDQpIb3dldmVyLCBhcyBhIHNpZGUgbm90ZSwg
ZnVydGhlciB0ZXN0cyB3aXRoIHZlcnkgaGlnaCBpbmNvbWluZyBtZXNzYWdlIGxvYWRzIGhhcw0K
c2hvd24gdGhhdCB0aGlzIHBhdGNoLCBhbHRob3VnaCBpbXByb3ZpbmcgdGhlIHNpdHVhdGlvbiB3
b24ndCBiZSBlbm91Z2guDQpUaGVyZWZvcmUgSSdtIHByZXBhcmluZyBhbm90aGVyIHBhdGNoIHdo
aWNoIGRvZXMgdGhlIHByb2Nlc3NpbmcgaW4gYSB0aHJlYWRlZA0KaW50ZXJydXB0IHVzaW5nIGEg
KGxpbWl0ZWQpIHBvbGwgbG9vcC4gQnV0IG1vcmUgb24gdGhhdCBsYXRlci4NCg0KQmVzdCByZWdh
cmRzDQoNCk1hcnRpbiBKb2NpYw0KS3Zhc2VyIEFCDQo=

