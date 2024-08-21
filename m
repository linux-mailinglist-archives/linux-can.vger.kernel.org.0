Return-Path: <linux-can+bounces-1202-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A75695A126
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 17:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3631C22228
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1660913BC39;
	Wed, 21 Aug 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="NueTbZjB"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2128.outbound.protection.outlook.com [40.107.247.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728C13A241
	for <linux-can@vger.kernel.org>; Wed, 21 Aug 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253067; cv=fail; b=Empk0Ea0UtR1kMkxoBlPQHG2kqu7TTUtvarmXbJ1kojlwDmLqeOMa5QRy7QzgqggLNjpcKIK1AarClBIyCEu8f34jd9PK+nDLeifIcREbHGQ8YgBQ2wyfB7C49EN2c1foxqjZoDp7AVddNgV5Sj+LXmPcp0Mz87so6OCG9x8DBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253067; c=relaxed/simple;
	bh=zI8/HYXg0fA0NlWrFZZ83/9+tLtNQvVPI+kDLXw4osU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0mevFlEBkOnirzAK9vyj33eOidrfiikGUirJ06yGfaxtPH/+MdNbZNqvSJP+YDrZ+w6oYxKv9pAqfcGRYXaL5dCYMJ6a6zcrVTQ5CbVywQCVCfAoCwqND8lnT6fcGbGx/51+MA+hxu5BzPiYGvdCF9+4CcEYg8BsQykXLSmMxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=NueTbZjB; arc=fail smtp.client-ip=40.107.247.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCFQqRAEYvqt5ugndu89+L3rguUm+YiH8jXVaRTsZIjnDPBlWVYMXm5pesMZYxc0wJ46T7l5R+4e27GteqJWzG3hl34FkN2sVokWdzfcE9LazlaENgNiEplf0j9cRJlhdE3cXls/JnHo6BjDb463uvtmztvYLKuDVzKjtiP8othn0F0R+X9syD+C3QuM901JsUTA39cDKkvUZiu7UQoHMExuS1a8o2aKGXra2bBAD4YlQ+JWqSqdn70+0z6HgGl/g5ULkJkK3hGqzztkWdsz0tEsHQqI2ANAV8jM811/fhmh4z0sf3ZJhrZWYGfQFk2aNz/E3edr6ImPAOvgWsz9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI8/HYXg0fA0NlWrFZZ83/9+tLtNQvVPI+kDLXw4osU=;
 b=KbG1ALLV8aElYKScF2gpJeTAvh43VlX9WZHztO8Vu67rRsMSz+GZAKjtM4SutdsOwY+M15p7LlTZRekiNmzWGljOTbAQ8Ax3+OQmzTWmGiNSnna4Z0SSOtMAWAcDVIoRnmyrUURP0Ywi/iB3DFvimH1Q7c/LT4u+adLQhTC1RwJoLQRKE98+yU0nn9EQBnn5jQ6KhRykObvJbieYPYfHQ7Yv1vX35ECFvva5aOu3lvi+VrNqciY7/+76sCDWn1n1HgScqq+8VlWzoVRDDJSX2HobqUrUaPXsjTvHN3HLCLCYyDv2I6Ln4ysVtXC5GQV0pO1VhkR5nzHd2KUkMIAejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI8/HYXg0fA0NlWrFZZ83/9+tLtNQvVPI+kDLXw4osU=;
 b=NueTbZjBwYnHu6IahvXdp5gqWlF+ZOyIavA0z6ix+TKD/KhbCfShwb8i83VyrQQCt0NeUkOCXI1SRcDgEAzaq/RmSpXlBAZ4bnsoUpFkqUIx0e7p5sLr41t6mVGJR6qWB3lxHG/Ksl3osQ9tCKG8JB4ih3rL4Qn0K2TeRukUA80=
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:144::17)
 by AS8P193MB1173.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:33d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 15:10:58 +0000
Received: from VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::33fc:adc3:2221:4b68]) by VI1P193MB0559.EURP193.PROD.OUTLOOK.COM
 ([fe80::33fc:adc3:2221:4b68%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:10:58 +0000
From: =?utf-8?B?TWFydGluIEpvY2nEhw==?= <martin.jocic@kvaser.com>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jimmy Assarsson
	<extja@kvaser.com>, "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: kvaser_pciefd: Enable 64-bit DMA addressing
Thread-Topic: [PATCH] can: kvaser_pciefd: Enable 64-bit DMA addressing
Thread-Index: AQHa8kTa1NpPeAc6Fkan5N9dpfqVT7IxZ/uAgABr2YA=
Date: Wed, 21 Aug 2024 15:10:58 +0000
Message-ID: <f61b536397092bd46d701cba2a0fc41430964b73.camel@kvaser.com>
References: <20240819142255.643149-1-martin.jocic@kvaser.com>
	 <20240821-proficient-raptor-of-order-8cace0-mkl@pengutronix.de>
In-Reply-To: <20240821-proficient-raptor-of-order-8cace0-mkl@pengutronix.de>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P193MB0559:EE_|AS8P193MB1173:EE_
x-ms-office365-filtering-correlation-id: 8253c9bf-82c8-49cc-1267-08dcc1f37616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QW5CWTYyZHpuRk10ekI3T3ZGV1hOUHFEVFQrOTdZTTBJMkFnbkdYVE5SZXdS?=
 =?utf-8?B?TkE1S28weGgvWG52emU2ZUZ4MTdveVV5YXhoU3VESkd6Tm16Qyt5NXdxODdy?=
 =?utf-8?B?enYxQ3d5eHpiMjFJUnliU0phSUlhMHhIQ0tqUk1ZNUovM2lKcTJ6MzJMUkpk?=
 =?utf-8?B?K1NkR1BjZTA1ckFhdVlHenY3SUJuQUliSmlmaHh5UHh4OVFBTFhtNCtnMzRC?=
 =?utf-8?B?MTBwbUJWRlAyWnVtcmZ1VnhZeVh4dUY1c3dxT1c4eFk3aUZ5Q0doSzRhYWcw?=
 =?utf-8?B?OVI1a1lTeFdlU2htaW1MZnNNWEZsanprSG9yK291WWJRQVlUOWpDWmNvcFU1?=
 =?utf-8?B?U0V1Y1h4WkJ4VGhHTzdOOUlhTUVoL2ptQ21TSGd4WnZaOWp2OFpSbVdWRUgr?=
 =?utf-8?B?NVhPNFI5Ym5aYit6ZW1PYWxoNUxoTmRJcS85RVQ4czdaR3M2RG0xSFV1aGcr?=
 =?utf-8?B?d1Y2RnNDVzdwZjBwSEZjMlREaldVSmcyZFJhK2pETWNvRVZubUdyUkJqZDF6?=
 =?utf-8?B?dEovanZrc1o1cGJQck85T0w5Z0lwTjR2YVpPcmtHdSsvNWhnaWpZTHVRdElP?=
 =?utf-8?B?SGNwZWdybmJGanhrcjBPbDRzemJYWDY0eWx0U2tmZE40VlFSNTdDQzNJSVFE?=
 =?utf-8?B?RFdKMTNFKzArS2QwRGtrdG1rSy9VcEhldDJ0Z1h0K0x3VXlpWnd1MDg3S0k0?=
 =?utf-8?B?N1ZDQ1EwQTc3aDk1Mnk5NmhhZGtDcEtKNzdRMnlKUEt0bUlCUVZWcUY2eWs3?=
 =?utf-8?B?SGk5ZzYzc1FQc0o4bDBXY3luRzlqZ1NDQm5VcXFXWWcvMVhmcjVzUm9XSStl?=
 =?utf-8?B?amVBKzdqN3l1RFJyOXlOOVVyZExOai9XNGk1bU1kWGpPdWZ1SkF3ZEtXS3VK?=
 =?utf-8?B?UThlUFh4d0R4bWk2SGhUbHhRSkdDSmI1RDd4UmpMenczbW51Y1E3SDlQZ2ZK?=
 =?utf-8?B?R0lsQVpKVzVkUG9WUHk1Wmp5MGN2Si9MTFFyWnZKQnZBbW00dUNQdDREMDk5?=
 =?utf-8?B?aTVuTHFNRlByUDJTT0RLTTZWYmpFSkRmcnRrVXhaU2NYNXlMNFlHcFVyRDJy?=
 =?utf-8?B?OUQrVWRud3RoTlQ1WjZNRW5oWHJiQXd0YW1IaHNoSU0yR3VSYWtWZytZZkxl?=
 =?utf-8?B?OXJMcVNwN1FoTUNNeEhvN01iY0ZhRGtaS2ltd1NsUWlKOEZSSHNwY1c3RWdh?=
 =?utf-8?B?Q2RqUEJhV2xxOFF2QkZjS1VuU1daWUpyYUQvQ041L1k2bUltNFZtdHAxUXNm?=
 =?utf-8?B?d01VYXhab2NEZTkwa1hIUk5NbG9kZzVDRk5MRmFnK2ZSTjIvS3dTR0VCOGNU?=
 =?utf-8?B?bkRPbDdTK3Bnd2ljYmt2QWN5cjl1VFkxYmd6WmJSNW5VVmszKzFZdkhwdzdE?=
 =?utf-8?B?akg3OGs3Qlh1UWNmSlA0ZG5Rc0ZqZE1lT1ZHU2tTSDRDRHk3cEtpS1JWSWhK?=
 =?utf-8?B?WUdmeURSMnBwWE1JZG5DbERidEY4Y3kwYXNzanJ5VSt6SXB0dSs5Rm90Mjdy?=
 =?utf-8?B?UlBZdjdsSE8zTHlLTzVlTk0rUkJsamkrWjd0Vm02NGxNbldCb284OUpLZG1y?=
 =?utf-8?B?KzNvblYxVDltZ21NWEZoc2lWRFdHejVTbVVubm9tZGtoN1BjQ1pHaHB2WmRL?=
 =?utf-8?B?aGxyRmNFOUNHUlhrVnE5aXlsczRXSjllbitZaVZpTXZOT3NwOGNVeHpJYThj?=
 =?utf-8?B?NnlaNmc3UktBVndoYzNFSGYxc09VM3FnVlcxek1Vc21FZ0V0TlVaQXNSZ0g1?=
 =?utf-8?B?OWJqTTFiWER2TzBwSjBhZkhMMVFGSlZqaWdBblZLMmN5YUhoOVgyeCsrWnJD?=
 =?utf-8?Q?zIGIx/DDMkG5eu91b/6RhLrrWiWEtcJmXCJxQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0559.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXB3c3RiZjVPK3V1elhYM0hvWGVYeHowa3RIYkd1Sm80VlAzamoyaEsxa2Zi?=
 =?utf-8?B?ZzVsNS9sVFpOYXRvTEJ5VHdlbXhqcVpVM1J0WVB4WGhJVHlhYVpjOTE1OFhQ?=
 =?utf-8?B?WDJtWGRzUGtjU2lSOXI0SmhTbVJZeHZ0RDRacnNQeG1Nd0RxeW9saFVPQk9Z?=
 =?utf-8?B?a25vTGo3SDBCdUQ1RHVaWm81dVg3c1oxYUE5K1lvZkszQmlkSmM1NG9oSmRO?=
 =?utf-8?B?UE9MZGE1MWo3cGthZUZPRDhwY08vQU9QeUM1N2hmckR4VElOS3NkWWJGTFNo?=
 =?utf-8?B?dGFxS2w0SytHZmJHUzMrdzJUSmJWMGxFajI2VjVXTnljZEhnc25OVWZ1MDhS?=
 =?utf-8?B?ZHZpTUtIQUdUQU9pNDVGaUNZQlpBQTJwKzdEQU1UQ0JvdHBVOTRtOXhCcFFa?=
 =?utf-8?B?cllVUGtocjJSQlE1L3pRRS80Q0ZMMFFjWnFuS0kxcXljdVZGMlpQYmpZY2Qz?=
 =?utf-8?B?Tjk1ZXhoN3hpeTZtYjJuNWxzSVRVVzRXRkZxSk14SitFUWpKUTdhMmo0cjZW?=
 =?utf-8?B?THRCS05IZTMranBmdk9COExOVTlvM2F5cUJsNWZ1QldEZVlLeU95WUViWnhq?=
 =?utf-8?B?bmtndGgxc2ZrTUpUODhENDhkMXNRK1l5U2h4STNsaXdOaHJsdUpsazlVNUY2?=
 =?utf-8?B?WHU3dHlpWjNNazloVlczTnVQZGw0Ym5kWm5pTnc3eWJNd1hTVW9sTGthY3A3?=
 =?utf-8?B?T1B1N1F0YkU2Wm5zK0pRNUp3d2hwK2NxMWlRczJkTU5hbnNKLzRmWU5tb2tI?=
 =?utf-8?B?K2VYYjlYYisrc0RCOE5LMG0vRHdXWGR1M0d6eHhwRDBSRlZyeGpnUnowbzhM?=
 =?utf-8?B?LzRlWkd4SWd4NzBjLytKOWlSN1FTQTkwUXBQQm1peGx4amZ0REhMLy9remR4?=
 =?utf-8?B?bVNpc2pENldXa21WZnhjZHVKenJtRXR4V1JjSDFUY09xRWRaTGJ2WXVnMC9T?=
 =?utf-8?B?Q3l1NEFmeU53K2Mxd1lKS1NMRUpVdjJ6SC9oa2EzdEgvRG1nVDgxUnJUMVVS?=
 =?utf-8?B?MnRkZ0FBUjFBMlp1bE1lVXlERmhEdXNsakE3Mi9sWENqSnEvai80a09VNHZq?=
 =?utf-8?B?VHI3K3BqYS8vdHBQZHozRHJxcE5YM1p5SVY1ekFiSEhrNVRlQWUzYWFZZGQv?=
 =?utf-8?B?TVlQdy9zWE05eGhZMG1KSWFmelp0Uy9GclpuNmI4RzhEN1pOUTYrdkJObjN4?=
 =?utf-8?B?akIwdFpscWJMdTNmUnF0NkVlLzhQdG5kNHZEeTRGQWpnZlBZS0hkVVlaaHhB?=
 =?utf-8?B?SjdDZFYrTDRFMWRQSkQzV01BNXgvYmR4a09OY3ZsaGc1Ujdmb3I3MHpsUWhs?=
 =?utf-8?B?WUU4TzRKUVhLR2wxY1poRmRLYVE1OUxJcUFTK0hIK1lnRXdtSGRYYWxScGlm?=
 =?utf-8?B?bWxiUHU3UjNuWUgzZXd6RktDNDEvczZzc1ExRWhUN0JmS1NQNm9teGt6c3A2?=
 =?utf-8?B?QTMzSTJ3a0VoWC90THZjWXN5dkVUemIyd2FLVitESUR0MTU3WkQzVDd0UG8v?=
 =?utf-8?B?TXlFWUJRelIwSEI0OTdvOWZlMmhLek1KbzNqOC8vMGo0RXNJb0swcjhzbm5r?=
 =?utf-8?B?T2dPWjA0YTl3dTliOUl2c2FCOGNGU2dyVk1Sd2pLbm1zTmtvbG9aam5PUHh3?=
 =?utf-8?B?N2tJQ0tyVVRCWFpkdERSOEhqdnE1RlZ3clVZbWtZV1BGTDEyZjFJS2ZKZzh4?=
 =?utf-8?B?RFVjb3VBRVkvSVNNMFRXZVhtUjJkdUoxYkRETzhualEyWFhYR1IrQytwbHhS?=
 =?utf-8?B?MWFYYjZzamZsSjZDcThiS2dBZ1I3L2dDblhxSjZkMmtjeVJqajh3aUFzd2Fl?=
 =?utf-8?B?Y1ljWkVSdzVEVTRtQng0UGRIZlhrMHRzRGRjc3k1Tm91WGMrNHozdU9jUHdJ?=
 =?utf-8?B?dWF0b1YxUThxaVp3ODF5V2NhNTd6cms3YmFRcitZQ1d4cU1Jc2ZvUXhmaEt3?=
 =?utf-8?B?RWdwWnc1aGkvL1NjdGZTd2p6MFNLd25RRysvYnJCNDNYbTBVSGlsNnpKNU85?=
 =?utf-8?B?NGdjNnltY0ozOXVJZE5NTHRZV0NnMms0dWJuV0FHL1d4RTk2V04waTd3bEpW?=
 =?utf-8?B?Z3lBU2VWak1nWEw2REhndVMwc2E0NmxxbTFvTm8vN2g0K1N5c2pWVWdjRXlP?=
 =?utf-8?Q?S3qQXa4TpRPTGLZAaknohAsYy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9EBCE45C09E6646BDB278DD97263D86@EURP193.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8253c9bf-82c8-49cc-1267-08dcc1f37616
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 15:10:58.1654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6j/efXBMAKXkXVRNKfw70qUpYJoCJLa+Dg99brl3ml9T79v2Il90/BEoF2KCG9dsjsI/hvdTTEPSBLRLnjDQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1173

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEwOjQzICswMjAwLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90
ZToNCj4gT24gMTkuMDguMjAyNCAxNjoyMjo1NSwgTWFydGluIEpvY2ljIHdyb3RlOg0KPiA+IEVu
YWJsaW5nIDY0LWJpdCBhZGRyZXNzaW5nIGZvciBETUEgYnVmZmVycyB3aWxsIHByZXZlbnQgaXNz
dWVzDQo+ID4gb24gc29tZSBtZW1vcnkgY29uc3RyYWluZWQgcGxhdGZvcm1zIGxpa2UgZS5nLiBS
YXNwYmVycnkgUGkgNSwNCj4gPiB3aGVyZSB0aGUgZHJpdmVyIHdvbid0IGxvYWQgYmVjYXVzZSBp
dCBjYW5ub3QgYWxsb2NhdGUgZW5vdWdoDQo+ID4gY29udGludW91cyBtZW1vcnkgaW4gdGhlIGRl
ZmF1bHQgMzItYml0IG1lbW9yeSBhZGRyZXNzIHJhbmdlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hcnRpbiBKb2NpYyA8bWFydGluLmpvY2ljQGt2YXNlci5jb20+DQo+ID4gLS0tDQo+ID4g
wqBkcml2ZXJzL25ldC9jYW4va3Zhc2VyX3BjaWVmZC5jIHwgNSArKysrKw0KPiA+IMKgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9jYW4va3Zhc2VyX3BjaWVmZC5jDQo+ID4gYi9kcml2ZXJzL25ldC9jYW4va3Zhc2VyX3Bj
aWVmZC5jDQo+ID4gaW5kZXggYTYwZDllZmQ1ZjhkLi41ODg1ZjFjZTE4OWQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvY2FuL2t2YXNlcl9wY2llZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L2Nhbi9rdmFzZXJfcGNpZWZkLmMNCj4gPiBAQCAtMTEwNCw2ICsxMTA0LDExIEBAIHN0YXRp
YyBpbnQga3Zhc2VyX3BjaWVmZF9zZXR1cF9kbWEoc3RydWN0DQo+ID4ga3Zhc2VyX3BjaWVmZCAq
cGNpZSkNCj4gPiANCj4gPiDCoAkvKiBEaXNhYmxlIHRoZSBETUEgKi8NCj4gPiDCoAlpb3dyaXRl
MzIoMCwgS1ZBU0VSX1BDSUVGRF9TUkJfQUREUihwY2llKSArDQo+ID4gS1ZBU0VSX1BDSUVGRF9T
UkJfQ1RSTF9SRUcpOw0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19BUkNIX0RNQV9BRERSX1Rf
NjRCSVQNCj4gPiArCWRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBjaWUtPnBjaS0+ZGV2LCBE
TUFfQklUX01BU0soNjQpKTsNCj4gPiArI2VuZGlmDQo+ID4gKw0KPiANCj4gU2V2ZXJhbCBvdGhl
ciBkcml2ZXIgZmlyc3Qgc2V0IGEgNjQgYml0IG1hc2sgYW5kIGlmIHRoaXMgZmFpbHMgdGhleSBz
ZXQNCj4gYSAzMiBiaXQgbWFzayBhbmQgdGhlbiBiYWlsIG91dCwgZS5nLjoNCj4gDQo+IGh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEwLjYvc291cmNlL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMjTDE1NjEzDQo+IA0KPiANCj4gPiDCoAlmb3Ig
KGkgPSAwOyBpIDwgS1ZBU0VSX1BDSUVGRF9ETUFfQ09VTlQ7IGkrKykgew0KPiA+IMKgCQlwY2ll
LT5kbWFfZGF0YVtpXSA9IGRtYW1fYWxsb2NfY29oZXJlbnQoJnBjaWUtPnBjaS0+ZGV2LA0KPiA+
IMKgCQkJCQkJCUtWQVNFUl9QQ0lFRkRfRE1BX1MNCj4gPiBJWkUsDQo+ID4gLS0NCj4gPiAyLjQz
LjANCj4gPiANCj4gPiANCj4gPiANCj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4gDQpBcyBmYXIg
YXMgSSBjYW4gdGVsbCwgdGhlIGR5bmFtaWMgRE1BIG1hcHBpbmcgZ3VpZGUgb2YgdGhlIEtlcm5l
bCBkb2NzIHNlZW1zIHRvDQphZHZpc2UgYWdhaW5zdCB0aGlzOg0KDQpGcm9tIGh0dHBzOi8vd3d3
Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbmV4dC9jb3JlLWFwaS9kbWEtYXBpLWhvd3RvLmh0bWwNCg0K
PGJlZ2luIHF1b3RlPg0KVGhlIHN0YW5kYXJkIDY0LWJpdCBhZGRyZXNzaW5nIGRldmljZSB3b3Vs
ZCBkbyBzb21ldGhpbmcgbGlrZSB0aGlzOg0KDQpkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRl
diwgRE1BX0JJVF9NQVNLKDY0KSkNCg0KZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgpIG5ldmVy
IHJldHVybiBmYWlsIHdoZW4gRE1BX0JJVF9NQVNLKDY0KS4NClR5cGljYWwgZXJyb3IgY29kZSBs
aWtlOg0KDQovKiBXcm9uZyBjb2RlICovDQppZiAoZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudChk
ZXYsIERNQV9CSVRfTUFTSyg2NCkpKQ0KICAgICAgICBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50
KGRldiwgRE1BX0JJVF9NQVNLKDMyKSkNCg0KZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgpIHdp
bGwgbmV2ZXIgcmV0dXJuIGZhaWx1cmUgd2hlbiBiaWdnZXIgdGhhbiAzMi4NClNvIHR5cGljYWwg
Y29kZSBsaWtlOg0KDQovKiBSZWNvbW1lbmRlZCBjb2RlICovDQppZiAoc3VwcG9ydF82NGJpdCkN
CiAgICAgICAgZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudChkZXYsIERNQV9CSVRfTUFTSyg2NCkp
Ow0KZWxzZQ0KICAgICAgICBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwgRE1BX0JJVF9N
QVNLKDMyKSk7DQo8ZW5kIHF1b3RlPg0KDQpJbiBLdmFzZXIncyBjYXNlIGFsbCBDQU4gUENJZSBk
ZXZpY2VzIHN1cHBvcnQgNjQtYml0IGFkZHJlc3NpbmcuDQoNClNob3VsZCBJIHN0aWxsIGNoYW5n
ZSB0aGUgcGF0Y2ggYXMgcGVyIHlvdXIgc3VnZ2VzdGlvbj8NCg0KQmVzdCByZWdhcmRzDQoNCk1h
cnRpbiBKb2NpYw0KS3Zhc2VyIEFCDQoNCg==

