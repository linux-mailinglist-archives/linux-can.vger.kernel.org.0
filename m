Return-Path: <linux-can+bounces-7904-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8WxzHS5OPmpjDAkAu9opvQ
	(envelope-from <linux-can+bounces-7904-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 12:02:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D36CBE69
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 12:02:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bp.renesas.com header.s=selector1 header.b=uIOxC5ep;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7904-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7904-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=renesas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44CF13014E5A
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950953E959A;
	Fri, 26 Jun 2026 10:02:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011047.outbound.protection.outlook.com [40.107.74.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE55286415;
	Fri, 26 Jun 2026 10:02:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468130; cv=fail; b=WNW2elrQZuBnHF/5ukB8TxVWL5Wpv5T+rUaPU52l3DRtdUYt4bSwe3ukwBTB3Yc3AiZHtdzT4uNyaNo4nVsstHsUnUCcMmuQM0sFeeJzLBHnCuXlrWSERYNhuIfEa9HhhhMKXZN6d22uYF1TRiRKPUNG8+ts5amhBBkXmbCdEGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468130; c=relaxed/simple;
	bh=2BXyykeHAhsS0UnKww3tX6bzTOQbQPUtWjCFoaRTyoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PTVJ7oCjiLkO6ScAWKCtNKBApoOsQJxxiswy77amO/lliTHXui+ZJb0tExw8O+H4z+h9VOf4T47XGHVdenclLGvxgdC1L7qcI2R8G6ES4RBgvPelSgHQK3VpZWRCFXLOHkV720LK9zk9hD9HiiKtu/ZWmWbuAqQTKJlMgv6r0us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=uIOxC5ep; arc=fail smtp.client-ip=40.107.74.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkMe1PzPYqEk3tXqmvwF6igvn6AErYUShX45cgX+QL3AhopcjkBKqxX0ETE1qhDMOs5gL5ZT9NtEGGi7meH0Z1HUh1WyOraaRehdbmt8oEwmZMTIog8PpFTw7DkZsWphrQl1ZrHpTiiCdC0q9KgPmswvsa1icki5Fu2XB/kTcfVkL2pfD06ifzNeTln97fT+qgTzw7oqcG+OqoTrAQxsB5BjPplD4oIdZDBXIsMwX/4EU+OftHa3o4nnlP7G/AlwYJW2GUKUuVShXSwkuH/8lU6fkIXdFsGfwwHrFzjAgt2JgpJnDSDjgA/wJehJA6+LbP/JuTZMf8+75Y0GaBd67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BXyykeHAhsS0UnKww3tX6bzTOQbQPUtWjCFoaRTyoY=;
 b=V5Jf40e4lsyReugkyZEKn6BY3dDW4dLj/N9jZU+Dsz9nxnUTo3Y9G8ZtAjJ7GJi9c+tsoitoxeRbhQGlXi7STh/rLJINr3f5rzDusCHkKQ3LCyeUFbiSH6Kwh9vnVtBKIAaJ5an6x2i7U+IrTmTJKG7he8xDlti5SZmj0WsPay2KZOXPw9/CR3QPQ/WRRThwdTp5p6cVyQvrs1K1sdR3isoRZgekIy+V+KAmJ0MFDbkaVXVeJRSPZbf+r61VubqFrZrn/WCLTSkceEKQIhbPkUPVjxAKjqmxOWnSbTRmke+0xqGDiWovceP+kZo1OBbmKmZP0cjhYBvFbagVf6eOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BXyykeHAhsS0UnKww3tX6bzTOQbQPUtWjCFoaRTyoY=;
 b=uIOxC5ep1Tlwm/485aAXc6mOq9sP/uXRCmTdWu+OAPi1QOFVwE0AW7sPqyfu6iqkfUf0TdCZoPELJ2WUO7WaBDzpcyAtQqpQyaBUCxwFrHw9ltPHzyV4CV4ZFFRYWTC3NaSE1orIEEcJngJ/DJhfJEiEkrHFSdwk/FBd4HqU+Sc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12381.jpnprd01.prod.outlook.com (2603:1096:405:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 10:02:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 10:02:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, biju.das.au
	<biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Topic: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Index: AQHdBKnahRscR7xhqUa4HQBpTADRvbZPuI8AgADhpiA=
Date: Fri, 26 Jun 2026 10:02:05 +0000
Message-ID:
 <TY3PR01MB113462FDD15BB00C0C41D9C6286EB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
 <aj2PBvZYaVs0G-be@shikoro>
In-Reply-To: <aj2PBvZYaVs0G-be@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12381:EE_
x-ms-office365-filtering-correlation-id: 8c416199-4162-4e57-c9f1-08ded369fa22
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|18002099003|22082099003|38070700021|5023799004|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info:
 wEuBA2pekH6Abtjv8Is1f1M++P6v0lP2tT6gUheG7E6Cl62Otu2b4aBAzGxSURBGY7gcJ0BMlZDmwEpmInsH9zSMRTMdNfYz3GfLG/GEQYbXzA5REpChPbMiMgKB41YpKuKHR1hdjh6HWDi/je5aeMRuvA9qliJyLJQ0W2w3JSyBKDiqIVGt5xeVQ2sdrMkcNAB8tDPmI8ouZcabDjYunwxkvpZY7j0HjCBC/xpkx9BumYnmk7BnMKKb/dZ+lvDtnfTxSBk8HmDa5m4EM2z9yRMN9xQB1KECZfLtmROKGo3AUMQSnTdHLQ0zCzTL9VXgEb7yHrFSyMr6z9G68e+4SZJbJohVfhhE09YWaRn+BYWrWa4a9DRzvqTLjYuadrNJADsiLCdQ7a+TdZU7QNkhj3adoI9TQAa3xHCY9fBHVOq5Fgwh3wepPdQSjv4Fo1uIkIG0je4T200c4saw+5RFEh/ZmQkLIcICC5Umh696zEGrsq8fo2gQIGICqNDpUazSb5J0/Vvt93sytObxOCUg+9Oot0ZfNCIuPwBA6z0xf2ozGe2bNW835KFp0/FpBzL6RMLZFVYG9ZnRr7fYZ4DL9i+fWwY2+NqH1Si4qWOR8yrEO5OAckiefubV4UJJ89jS3ognEKqqr06uG75tOVeHMA5sRApFQpjENwhf3ruJWjguyb3ELGtDv9SVd1WCoqr8avG0G0UJG4thqhg3BUvX6wEPRmzKZUVHSlv80cNMrxQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(18002099003)(22082099003)(38070700021)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djV4ajJnYVNYQkwrUFZrU2dCT3NZMGtrSi9Jc00rWTRtZUloQUgyeVIzb01Y?=
 =?utf-8?B?c2Z2OE9VakZQRExkMjNRSmhTTCtWN1FiODhjbnBrSXpLcXk4cEs2cWV1QzFQ?=
 =?utf-8?B?Y0UzMTlxTElWY3FkUjVqQUNUbDRENitRZFppTjh4UTVVbEpsa3RPTk05MmND?=
 =?utf-8?B?MzJEUVBuaEQwdENqcHlaQjJMSTFzNjRoUUxQK0xtMit2ME4yTk5Ib0dORmQ1?=
 =?utf-8?B?MTNiNmswaCsxYVUrdUp6a1huYzZ1MUZRc1hLR1JheG9HdU1GbUF6VjFtcWU1?=
 =?utf-8?B?YTVyMFJxMjJ4WEtrR3MxZUNjOS9yMk9laStlenc5R29CUVdTci9weE5kZm95?=
 =?utf-8?B?V0Ewelp0eFpVYmdyZmZWZ3l6MCtDTDdDM0hDa3FsZjJMRHVQc1BNWXlyb25Z?=
 =?utf-8?B?N2hFNnN3eXNoSHZoQWVOd0tEdmNtQ3VZOUs3aGFvb2dtYUx1RENhYWxQNjJO?=
 =?utf-8?B?ZHlyd05zb1dObHdFWklKWGJVYm9wVERYZURMZ0hvOGNjcFFESGNTaWw4MDli?=
 =?utf-8?B?TGZlUlJBUGwrRU5WdHgwaXlJVThnNFpIUHVPVkRyaEI4VEVLckFKM2dWR3h2?=
 =?utf-8?B?ZHRZNXRrczlCOW1XeTZjaDIvL05NTEZCOVlIWTlVWS9LallJaVJDTTVBaDNk?=
 =?utf-8?B?N2RHUEVlTmJkZmVCVC9XQzZUdldFTFVNU3M0dDVlV0p0eTA1SkVLa0psaUR2?=
 =?utf-8?B?WXA3TkxjeUtMSC9MVFdYVGptYy9KRVNvYWJsQVdnYklBc3djOWttWWdEdHFj?=
 =?utf-8?B?Y1BodUMyaWhQdU8rZ09PUGFFTi8rRk5FSGVhby8vTVV1WHpNUFpCTXpjWHJN?=
 =?utf-8?B?NEsxNWh6cWlRd0RRU1Q3YTlCcUxxdjczbmp2cGwrVXRrNFhCcE9vdVNvb2JT?=
 =?utf-8?B?cDE0OGJzWUwwTysvbkkvL1g5TTVyQnlid211RjU3VGVUdW8yQmJOZ1lFTE5s?=
 =?utf-8?B?QjNrT21rTXFlVGd1QUlGQk1hK1B3bXRZK3pvaDBhMmZlS0Y0ZUJ2bnp2M2FJ?=
 =?utf-8?B?K1lzSHFNbm9IMWlKZkZneGNHbmU4YUt5NlkzVFJURnkyMVdHNlVCSEoyYkJF?=
 =?utf-8?B?UHRucU8vcHhha1RZcDBReWpjTUtOcm1vbjV0aGNCT0dwL3ZZNzVKNEZHYlJS?=
 =?utf-8?B?Y2g1cktKTnJCbk9tVWVPczVLN3VwTGJqYmZRWTNpcVlrUlhmMC9EY2xhOHc2?=
 =?utf-8?B?R0ZGOE1xUUtMRWVWRldZN2NTYTNTZnErZkxVVU01UWdXOWgzUGo0aDl2bVdp?=
 =?utf-8?B?NThYWVkzWmZldjZsMmt2TEpjR0JwWUwvOXdYOUdpTCsvVHNkNzdmOEFSRmIz?=
 =?utf-8?B?blVrU09EUDN0VTg4MHY1RkFYT0VGRmY2QitFLzFMUW5zSTVSdG93bTlFZ2JH?=
 =?utf-8?B?NmprZTYvenNTQkhudWRvRGVjYml3dUNqUVZ5QVhEMmR6TllXbmplSVRacjEx?=
 =?utf-8?B?YTdJZUVJckFaTjI0bTRyWk5PeEplTnZSQzVQazQ2dVkyWjY4ZzIrZDZUM1c5?=
 =?utf-8?B?S3Jod3BPazdqMDIyaDVKUE1BbzMzQkhrakg2N1VIQnA4WWIvL01GdlZibXpF?=
 =?utf-8?B?bWpTMFpLZktuL0ZUY0dtTmVpZml2NkhWV05xRUhuSXI3Ym4wem1lVVpWRGxx?=
 =?utf-8?B?Uk9UVEt6SUp2cHhyS3NOZSswSFp2MS9qK2V5UjJkdDl5Wk5yd3dUVWNuZmZi?=
 =?utf-8?B?TnE5SXJlWVV3bG5sdzh6dldJb0dTVmRISExESUNrNW0yQzZ5Vy9wUVAyZ2Rw?=
 =?utf-8?B?cXdhb0txODFUd1RsQzY1SXJoYzBjT2dnTHJNM1FtTkJZOXhvai9vM29hbDBX?=
 =?utf-8?B?T3BqL21iVjBldEN3K2dCK0RYMy9aUUhOWG5OQmlXNUlFL1lRaGJMdFh2NER5?=
 =?utf-8?B?bHBnYlBubzM3cmtETzBaa2h3MG1lSFN0V09mZnoxUTRadmhuVHVIUlNqU0lY?=
 =?utf-8?B?aWdzbHJwdndJLzAwRFNMZm9YYUd2K3FLYTlNVlVnZFpqREdOcVU0TWt2K3NX?=
 =?utf-8?B?V0lUZTlZVWM4OHljeXVDM0RRbFJMK3lDeXd0b2JHZHE1REZWNkxLdnc1bE0x?=
 =?utf-8?B?RnZZalByNklnMldhZWFvU0t5c3RET21rdVU4OW13STZuYStYQTZ0Z2VrbVF4?=
 =?utf-8?B?WXNXNWUvZ0d3RkEvZm5haEdJQUVPUTAwSElNRENOeUIrVjVTRTZTVEdocGpJ?=
 =?utf-8?B?NEdNTXVTZHVKRndKT2lIamljOHBINXZXYU1yNUcyLzNlaUt3enBFbjNqcENz?=
 =?utf-8?B?WmR4V1VoRmRvdFFMaUh4UE4rUE5jZG1lTjZJYTY5aldRTTNac1RzWng3cjBV?=
 =?utf-8?B?d2tPRFo5WW9RYXhoRkVZSnZacWlrNmYwVG1CSmJpVXl3T3dkd3RUdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c416199-4162-4e57-c9f1-08ded369fa22
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 10:02:05.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hU4uyIR92TkmLUC4E49WoGR+BWuYaB+btnoA1YX+h/St0vGbXCUsdhWRu2mINQQ5NvxjFye8qTE6UgjtWKE/Tc2iJblXhHBgRhs2kPWgVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12381
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7904-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[sang-engineering.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:biju.das.au@gmail.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wsa@sang-engineering.com,m:bijudasau@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,renesas.com,bp.renesas.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 759D36CBE69

SGkgV29sZnJhbSBTYW5nLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmluZy5jb20+DQo+IFNlbnQ6
IDI1IEp1bmUgMjAyNiAyMToyNw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjYW46IHJjYXJfY2Fu
ZmQ6IENoYW5nZSB0aGUgaW5pdGlhbGl6aW5nIGZsb3cgZm9yIGNsb2NrcyBhbmQgcmVzZXRzDQo+
IA0KPiBIaSBCaWp1LA0KPiANCj4gU2FzaGlrbyBmb3VuZCBpc3N1ZXMgd2l0aCB5b3VyIHBhdGNo
LiBJIGN1cmF0ZWQgdGhlIGxpc3QgYW5kIGxlZnQgdGhvc2Ugd2hpY2ggSSBzZWUgYXMgcmVhc29u
YWJsZS4gSSBrbm93DQo+IHRoYXQgYmVpbmcgcG9pbnRlZCB0byBwcmUtZXhpc3RpbmcgaXNzdWVz
IGlzIGFubm95aW5nLCBidXQgbWF5YmUgeW91IGhhdmUgaW50ZXJlc3QgdG8gbG9vayBhdCB0aGVz
ZQ0KPiBpc3N1ZXM/DQo+IA0KPiBUaGFuayB5b3UgYW5kIGhhcHB5IGhhY2tpbmcsDQo+IA0KPiAg
ICBXb2xmcmFtDQo+IA0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hp
a28gQUkgcmV2aWV3IGZvdW5kIDQgcG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KPiA+
DQo+ID4gUHJlLWV4aXN0aW5nIGlzc3VlczoNCj4gPiAtIFtIaWdoXSBEb3VibGUtY2xlYW51cCBh
bmQgdW5jbG9ja2VkIHJlZ2lzdGVyIGFjY2VzcyBvbiBpbml0aWFsaXphdGlvbiBmYWlsdXJlIGlu
DQo+IGByY2FyX2NhbmZkX3Byb2JlKClgLg0KPiA+IC0gW0hpZ2hdIFByZW1hdHVyZSByZWdpc3Ry
YXRpb24gb2YgZ2xvYmFsIGludGVycnVwdCBoYW5kbGVycyBjYXVzZXMgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGFuZA0KPiB1bmNsb2NrZWQgcmVnaXN0ZXIgYWNjZXNzLg0KPiA+IC0gW0hpZ2hd
IERhbmdsaW5nIHBvaW50ZXIgaW4gdGhlIGdsb2JhbCBzdGF0ZSBhcnJheSBsZWFkcyB0byBhIGRv
dWJsZSBmcmVlIG9uIGNoYW5uZWwgcHJvYmUgZmFpbHVyZS4NCj4gPiAtIFtIaWdoXSBNaXNtYXRj
aCBiZXR3ZWVuIGBkZXZtX3JlcXVlc3RfaXJxYCBhbmQgbWFudWFsIG1lbW9yeSBmcmVlaW5nIGNh
dXNlcyB1c2UtYWZ0ZXItZnJlZS4NCj4gPiAtLQ0KPiA+DQo+ID4gY29tbWl0IDZiNmE4MzE2OWFj
MGE3Mjk3YTRkYzJjNzhlMTZkZDk4ZjRmMmVkMGYNCj4gPiBBdXRob3I6IFR1IE5ndXllbiA8dHUu
bmd1eWVuLnhnQHJlbmVzYXMuY29tPg0KPiA+DQo+ID4gY2FuOiByY2FyX2NhbmZkOiBDaGFuZ2Ug
dGhlIGluaXRpYWxpemluZyBmbG93IGZvciBjbG9ja3MgYW5kIHJlc2V0cw0KPiA+DQo+ID4gVGhp
cyBwYXRjaCB1cGRhdGVzIHRoZSBpbml0aWFsaXphdGlvbiBvcmRlciBmb3IgY2xvY2tzIGFuZCBy
ZXNldHMgaW4NCj4gPiB0aGUgcmNhcl9jYW5mZCBkcml2ZXIgdG8gbWF0Y2ggdGhlIGhhcmR3YXJl
IG1hbnVhbCBmb3IgUlovRzJMIGFuZCBSWi9HM0UuDQo+ID4gSXQgZW5zdXJlcyBjbG9ja3MgYXJl
IGVuYWJsZWQgYmVmb3JlIGRlYXNzZXJ0aW5nIHJlc2V0cywgYW5kIHVwZGF0ZXMNCj4gPiB0aGUg
dGVhcmRvd24gcGF0aCB0byBtaXJyb3IgdGhlIG5ldyBzZXF1ZW5jZS4NCj4gPg0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gYi9kcml2
ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+IGluZGV4IGVhZjhjYWM3ODAzODcu
LmZjYzM3YjczZWQ0MzYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9y
Y2FyX2NhbmZkLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQu
Yw0KPiA+IFsgLi4uIF0NCj4gPiA+IEBAIC0yMDkwLDEwICsyMDkwLDEwIEBAIHN0YXRpYyB2b2lk
IHJjYXJfY2FuZmRfZ2xvYmFsX2RlaW5pdChzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2
LCBib29sDQo+IGZ1bGwpDQo+ID4gPiAgCQlyY2FyX2NhbmZkX3NldF9iaXQoZ3ByaXYtPmJhc2Us
IFJDQU5GRF9HQ1RSLCBSQ0FORkRfR0NUUl9HU0xQUik7DQo+ID4gPiAgCX0NCj4gPiA+DQo+ID4g
PiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrX3JhbSk7DQo+ID4gPiAtCWNsa19k
aXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrcCk7DQo+ID4gPiAgCXJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KGdwcml2LT5yc3RjMik7DQo+ID4gPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGdwcml2LT5y
c3RjMSk7DQo+ID4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrX3JhbSk7DQo+
ID4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrcCk7DQo+ID4gPiAgfQ0KPiA+
ID4NCj4gPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+ID4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1
ZSwgYnV0IEkgbm90aWNlZCBhIHBvdGVudGlhbCBwcm9ibGVtIHdpdGgNCj4gPiBpbnRlcnJ1cHQg
cmVnaXN0cmF0aW9uIG9yZGVyLg0KPiA+DQo+ID4gSW4gcmNhcl9jYW5mZF9wcm9iZSgpLCBnbG9i
YWwgaW50ZXJydXB0cyBhcmUgcmVxdWVzdGVkIHZpYQ0KPiA+IGRldm1fcmVxdWVzdF9pcnEoKSBi
ZWZvcmUgcmNhcl9jYW5mZF9nbG9iYWxfaW5pdCgpIGVuYWJsZXMgdGhlIGNsb2Nrcw0KPiA+IGFu
ZCBiZWZvcmUgdGhlIHBlci1jaGFubmVsIHN0cnVjdHVyZXMgaW4gZ3ByaXYtPmNoW10gYXJlIGFs
bG9jYXRlZC4NCg0KT0suIE9yZGVyaW5nIG5lZWRzIHRvIGJlIGNoYW5nZWQgb24gc2FmZXIgc2lk
ZS4gQWZ0ZXIgQ2hhbm5lbCBwcm9iZQ0KUmVnaXN0ZXIgZ2xvYmFsIGludGVycnVwdHMuDQoNCj4g
Pg0KPiA+IElmIHRoZSBpbnRlcnJ1cHQgaXMgc2hhcmVkIGFuZCBmaXJlcyBpbW1lZGlhdGVseSwg
dGhlIGhhbmRsZXINCj4gPiByY2FyX2NhbmZkX2dsb2JhbF9lcnJfaW50ZXJydXB0KCkgd2lsbCBp
bnZva2UgcmNhcl9jYW5mZF9oYW5kbGVfZ2xvYmFsX2VycigpLg0KDQpTaW5jZSByY2FyX2NhbmZk
X2dsb2JhbF9pbml0KCkgaXMgbm90IGNhbGxlZCBiZWZvcmUsIGJvb3Rsb2FkZXIgZW5hYmxpbmcg
dGhlDQppbnRlcnJ1cHQgZW5hYmxlIGNhbiBmaXJlIHRoZSBpbnRlcnJ1cHQuIFRoaXMgaXMgYSBy
ZWFsIGlzc3VlIG5lZWRzIHRvIGJlIGZpeGVkLg0KDQo+ID4gVGhpcyBmdW5jdGlvbiBkZXJlZmVy
ZW5jZXMgcHJpdiA9IGdwcml2LT5jaFtjaF0sIHdoaWNoIGlzIGN1cnJlbnRseSBOVUxMLg0KPiA+
IENvdWxkIHRoaXMgbGVhZCB0byBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgDQoNCk9LLg0K
DQo+ID4gYXMgd2VsbCBhcyBhbiB1bmNsb2NrZWQgaGFyZHdhcmUgcmVhZD8NCg0KV2l0aG91dCBh
IGNsb2NrIHJ1bm5pbmcgb24gdGhlIElQLCBEbyB5b3UgYWdyZWUgd2l0aCBzYXNoaWtvIHRoYXQN
CnRoZSBJUCB3aWxsIHRyaWdnZXIgYW4gaW50ZXJydXB0IGFuZCBkb2VzIHVuY2xvY2tlZCBoYXJk
d2FyZSByZWFkPw0KDQpDaGVlcnMsDQpCaWp1DQoNCg==

