Return-Path: <linux-can+bounces-7902-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CBjINDAqPmr2AgkAu9opvQ
	(envelope-from <linux-can+bounces-7902-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 09:28:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 361516CAF11
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 09:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bp.renesas.com header.s=selector1 header.b=b2X13c5P;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7902-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7902-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=renesas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A32301E953
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58E3DEAD7;
	Fri, 26 Jun 2026 07:28:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A33D3001;
	Fri, 26 Jun 2026 07:28:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458925; cv=fail; b=gs6Ga0YfE/vfU6IMwVggLXebf/mZMIlK3+1QUOOj0Net4SFmhbRikiKlpzqeKWeUaDDTaCKR7MT/pMWKrSYyBOGvAv8p802cQd0+mrluwgjHpLUNvHZiDdNeNaOW4+FUEI1XBxRDTQAE0gZCCYltHwrJ2A/sOiyYqJpUvc1eSAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458925; c=relaxed/simple;
	bh=G4IbDwUIwUSyPFvHLpP54Zqp8hZRH1WCVR1ifeLUT8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u05WkS71Ij375JnkNcdTFv3gyrh8D/pH9+g4tTMO9jTGkDRNCOV6hlve3npPjUwdi5rh+jZJsCK9tU3g7zmQYFtAzFJL8f91VlOuqJBCo6KRGf4imnVh2NptmWardIdtZ44FVfSwcsoqNGAZ4JG98V0Afxt6tKhmgT/v5eINhac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=b2X13c5P; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDRkFjgpIJAmOxk746Oau2MyEv0FWMpgsOIlWjM+xCxAx/CaEB4GvibbCE9aOCw4mB7WZkLdYECUQcfY8vYXE3Qjt9dW4XiARAIgXN/W4kFpxLavEv3Qv1TMLK8t0eAIroc3tNPzpQ+123CBuMsvBu9CWmG6+DoawHZDKH1HuSX/VeVwvzhBBSsFhJxAlwVrwSAcL+5YATi3bj7gRiqXvQwInTRzeafRgAbExMJmm+TXIJCxU2FXy8IdsLbGNB03hd8v1mCnWeM0911sIbiEPKBI3bwIWft/TGZaztMb+KpiL+9eNv7M/uCA6QjpUcJ7702PKXtVqcm+tiZxWKBeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4IbDwUIwUSyPFvHLpP54Zqp8hZRH1WCVR1ifeLUT8I=;
 b=Ic3ZSKMDflZrMCW5YzzA7e7YTtXXHskg7uIaMnldGrnOG2eVs1dlwiso/DyrR3f6pwowzIY052JSZ4xqicrozWWALxmBOMKNTOH0x7cg9FCj8VN5VBSM2UMns3Jz2J6K+Hjn/irtsvWybYxTW/OCRm0KjHia7g0fIUzyRPR4uUgD8GYcVJ0hqHlNiZ/xNxYyIJctUg/04ct6bLkljpXS4Qul0/zXz9HmpdrmuWUdMyua+Sldt2HccSta0P8CSU+XPvFqw3nyRQnJOmdm3eFDLlG/bPaOtyPaoPcJti0man839b+NC0mQg0diYFqb6jj1b3Mq93768joNwkkT06g9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4IbDwUIwUSyPFvHLpP54Zqp8hZRH1WCVR1ifeLUT8I=;
 b=b2X13c5PsubqS8pfp0vd8RLcJfqwW31U3D35Z4XrZjHlOWANc3ed3O7xCwEaTt0D0Y6i9YOb2jRnSW41JztFUp0BSu0wl0Xj+uP0rJd1kGx8IZFH/tM/GUJgUiRTved1YS8bIajWn6Hqp2qyfgCbjqO3mZQHy4edF++5c60AknI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB13524.jpnprd01.prod.outlook.com (2603:1096:405:1db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 07:28:40 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 07:28:40 +0000
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
Thread-Index: AQHdBKnahRscR7xhqUa4HQBpTADRvbZPuI8AgAC31ZA=
Date: Fri, 26 Jun 2026 07:28:40 +0000
Message-ID:
 <TY3PR01MB11346929DDB3C3CF94A7C20AE86EB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
 <aj2PBvZYaVs0G-be@shikoro>
In-Reply-To: <aj2PBvZYaVs0G-be@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB13524:EE_
x-ms-office365-filtering-correlation-id: 16a39b31-bf6a-481d-f3ec-08ded3548b7d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|38070700021|18002099003|22082099003|6133799003|11063799006|5023799004|56012099006|4143699003;
x-microsoft-antispam-message-info:
 dj1j4hGD0OJazyOk46Tx1t42JiCGM2G+V1H2BCHz0NYTKIwBmPWra1cOWvUat+OsUUFyQcJnOJZrblwGuzY3f1wkkAwIfi2Z+TujmIxZ9wI5qfj7LoE/ct/rMJzMqPYz3nAOIClzeHg7eNDz1IBT2WSiOVuMOAthCFB+BM16sMYnb8hgtb9ogciRWJhAVCPVw7lO7Yo3HE4c+Xvv3EldkDxqcY5g1hD5PHTaZyyuIE/RGbHcz2nI8J+BCBx/LzfDLXfJJ+7e/v/74DIixrZrk7Gg4EUAPfoI0V9zWa2FZiOBlfpO8uhwKHP43RYtb8EPxe1R9rDBNFxssbyLKE8SyLIOcfUy8AZ4SpNblGm31PNhZFdD0QYOYj/a4rzkL70X9mq7X53QUGP2lxB3McPCkVevXO+gPgIdw3LaSksUR4gguGUpVM2taXNxLTFfXCsJ9BvVwNFh95eUdoiinmvOw89QZ3r+U7ksb0TcbHM5PoqH+BaHZkgQWkvnMDTqT3qsRNtNKgNIDZIt5D+Q02T/pmVyU5Ijr1IGG3taoiOrAvh0wRSz4G2KnNXEnmZQNGwBz3a0MB6l9w5m9/b6zAyiSQjfxgkCH90CVSK17JrlU0pg5WpGRCjok3aYQcBJfYRFr8bUfiPGfsGvPSmuKv1sX8T034vMZX1tBP1so1OYEic=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlNBYzl2Y01IaFUya0t1SGtkbWRzTTVYU2UyVXZ3d2IxTTBRSmxHbTR2UHBZ?=
 =?utf-8?B?THZFZ1dLQzN6T0c3YU5lcEFKL0Q4ZVkwa0NhcU9qOVJwaFVCd3lSQWd3OGU5?=
 =?utf-8?B?d1d4bU11eitLVXZkRm54cWNucnVXbTUrNFo2alJsMU04aElGTlNLc3FFUWdX?=
 =?utf-8?B?NXdHSGxvYXl6SE9WdHB0cjRuSElHNHJ1NWd2WC9VSWNsUU94cTh4cVNBODd0?=
 =?utf-8?B?ZkFWb3hyZVFQU1FNbC9NTkVmMEpwSWE1c1psMWZadk01OW5nczQyMTVmZHdH?=
 =?utf-8?B?TElNN0R3V2RVeXJNNlRqSkx6dWxaZ1p3U1ozUWdTSUxzR05XZmFoUkQxeUlH?=
 =?utf-8?B?YVJKemM1a25rd3ZkTXJpaDNqV2ZZc1kzYmdKbEdBd05jTUpoMG44elF0S1ZH?=
 =?utf-8?B?eXhGMmY0L0VET1ZxNFI5QldxSTN3Y0V5UWROMFp1TG1uV1VyOEtLdFE5aWIy?=
 =?utf-8?B?L2xMaDNZci9QMWtQcUJZV1R0dndNS0VlK3BvRDNEOThqMGlIZ3BuS0lBVTBU?=
 =?utf-8?B?UDJFSFNES2dMUlVySXQ3ZEtURWVDRHN5N0Z4Skp1TnQzc3lFaGtVL0RxNnF5?=
 =?utf-8?B?SnBnTnM2eCswbHBxdmdTSXMxSEVGYk9KRjR0RXJLQWR6OVFyZHpxT2MyQkNY?=
 =?utf-8?B?Y1RkNlk5emtJOWJrSUIrc2RXK2FiR0tjazZTb2poYkE1amdzQTAvSFVNMCtr?=
 =?utf-8?B?RjVybkE3MUI1L1dyLzZidlZZYmxld1RuTFJBZkZoaFJwYmhmdzROU2dhQTJJ?=
 =?utf-8?B?dFNJR2RSSTZlMUUxZUdSNit3ajU1NDRnREFyZDh0RnJjVUQxbXl4c1FZdVE0?=
 =?utf-8?B?TnVvUkNMZjJFTFZHZWpKWml5SkZSMnBZUnVSNnhhSkpJVlJ4N3RKSFc2cjJa?=
 =?utf-8?B?ZXNJMjV1N0xud3NsMWNYS29TOTljSTNrTlAwdDJnMm1aTXp4Um92SUNDSFNL?=
 =?utf-8?B?Tk9qK1pXNmZWTHV4SW9QMXhYNXhjejJrUTNCdnlGcnBSbXp0VDhwSXVzQzlp?=
 =?utf-8?B?Ukx5eXBzd2lnS0tqRGphQS9xVWJYaGRkOFg1bHd2TG5rUXRZcHZVd1ZwV3Fw?=
 =?utf-8?B?Zzc0WFpxeE5NUFBrTmZhM2llWlFhU2o0bEt2YXVCSzVoaEdZNEdSNWZLRW5p?=
 =?utf-8?B?ZElILzA3WUlnaXl0cEFuejJtM1FmVkthWmFWNCt4eWtOT2RuUE9acEppeGE3?=
 =?utf-8?B?a1NoblJrS3k2RUZBY0h4Mm9CWFg4VXRzelR0NTJFUXloOWtYWVpvSHB4TzM3?=
 =?utf-8?B?MHo0MXEyakZqYi96aDhTc0g3dWRsREx0MVlPMXY3RFBWNkxvSDNIYkRhWjhq?=
 =?utf-8?B?UjVsNlVQZDBmVStpZFZDMjdDL081S3ZLcFVVRU1OQ3M1UmlGY2hyM0VmZ3gw?=
 =?utf-8?B?a09wNU0yRGprcGV3cUd0UXFvckFLRGxkeXc5NkN6L3psbHhUd0hYOXpxbjhz?=
 =?utf-8?B?SU02bmxVdTZpUktSaVIrVjVDSlg2VmIzVGtGcnY4eE5ndWMranFTeGZ2S0lD?=
 =?utf-8?B?T2FXbEdTTUk4T0x6MmxYejh0clgzTHd4S0FrdURSNzIwamJmNlFJY1crNGNp?=
 =?utf-8?B?R0w3NS8zVnY3YzQxWWI0eTZGMWhpcHdHbXZTbUw5NXVhdkU3OUdBbFBZOTNz?=
 =?utf-8?B?WlJmcmE3enFaNm9VZDFqVGx6LzNkNjhCSzIyNGtRMWhRczlVaEJJeHZkK2JT?=
 =?utf-8?B?dE5rS3FxZzBpY2RXTDhIODU2SmdVNTlxL2FIYmR3dStTRk9iU1RteDV6b2o5?=
 =?utf-8?B?bGN2UjJEOUltWGdlWUF6RDRMdDhITGt6ZVFxbUo3UTNmMktkb2VtM01Md2NK?=
 =?utf-8?B?UmNQK0ZId2doYStEaEpiU3pJdVg2RFQzZWE5K2c5aG1qWm93QTJkc1Fwc1VW?=
 =?utf-8?B?eE1oSUNTL0krcUsvOTh0TEhNei8wa3NoZmFjYWp3dnVZamYrcmoyVGJDanpF?=
 =?utf-8?B?RlAvUmZnSVFQUjJaTkx5REowcy9xUzYra1pvTlhudStvdmZIT2VYdTlsYVg1?=
 =?utf-8?B?VURwMlh2d2NtcjRUNkE1ZWtmeWZSVUZWY1M3WWNpL2k2N1lzWGI1NjY1dEN2?=
 =?utf-8?B?QWI2RjQ0VFlpMmduc1NvL0xUUTlYbVJlY0ZPdHI0b0FUNUkrc3g4dW9aM3Nh?=
 =?utf-8?B?SVhicXJGM1Bia2YraTNrVDRLeWJHL28xYzU3WTFJVW5WWG4vU1U3RkRxSWpC?=
 =?utf-8?B?cDJQdWxDZXR6VmJYWWYyM0s4SDNVT0tvSWRmd0QxMDFxZWpRM0g5aW9iT291?=
 =?utf-8?B?Q3oyVzBEanZUWDNlR2MrQkZFSXJzWmtZNmNRbE1aTC8zR0xGUitaa0VhMlh6?=
 =?utf-8?B?MEFHdi9xZlR0cGgrc1R1dDMyZnJ6K0syL3IvSFJpbVI3ZEQxZmx2Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a39b31-bf6a-481d-f3ec-08ded3548b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 07:28:40.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSjdE7KU6oU/0mNbUaTNBQ8zf1v27jPwa2YQFnDvodYKYZI/yOlt3AYvs8WEYpFb6ajW/frZWejPe1n2MS9sLFlCcYuGnaXLXlMB0Mv8QsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13524
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7902-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:biju.das.au@gmail.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wsa@sang-engineering.com,m:bijudasau@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[sang-engineering.com,gmail.com];
	FORGED_SENDER(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	TO_DN_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sang-engineering.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 361516CAF11

SGkgV29sZnJhbSBTYW5nLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmluZy5jb20+DQo+IFNlbnQ6
IDI1IEp1bmUgMjAyNiAyMToyNw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjYW46IHJjYXJfY2Fu
ZmQ6IENoYW5nZSB0aGUgaW5pdGlhbGl6aW5nIGZsb3cgZm9yIGNsb2NrcyBhbmQgcmVzZXRzDQo+
IA0KPiBIaSBCaWp1LA0KPiANCj4gU2FzaGlrbyBmb3VuZCBpc3N1ZXMgd2l0aCB5b3VyIHBhdGNo
LiBJIGN1cmF0ZWQgdGhlIGxpc3QgYW5kIGxlZnQgdGhvc2Ugd2hpY2ggSSBzZWUgYXMgcmVhc29u
YWJsZS4gSSBrbm93DQo+IHRoYXQgYmVpbmcgcG9pbnRlZCB0byBwcmUtZXhpc3RpbmcgaXNzdWVz
IGlzIGFubm95aW5nLCBidXQgbWF5YmUgeW91IGhhdmUgaW50ZXJlc3QgdG8gbG9vayBhdCB0aGVz
ZQ0KPiBpc3N1ZXM/DQoNClRoYW5rcywgV2lsbCBzZW5kIHBhdGNoZXMgZm9yIGZpeGluZyB0aGUg
cHJlLWV4aXN0aW5nIGlzc3VlcyByZXBvcnRlZCBiZWxvdy4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+
IA0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3
IGZvdW5kIDQgcG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KPiA+DQo+ID4gUHJlLWV4
aXN0aW5nIGlzc3VlczoNCj4gPiAtIFtIaWdoXSBEb3VibGUtY2xlYW51cCBhbmQgdW5jbG9ja2Vk
IHJlZ2lzdGVyIGFjY2VzcyBvbiBpbml0aWFsaXphdGlvbiBmYWlsdXJlIGluDQo+IGByY2FyX2Nh
bmZkX3Byb2JlKClgLg0KPiA+IC0gW0hpZ2hdIFByZW1hdHVyZSByZWdpc3RyYXRpb24gb2YgZ2xv
YmFsIGludGVycnVwdCBoYW5kbGVycyBjYXVzZXMgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGFu
ZA0KPiB1bmNsb2NrZWQgcmVnaXN0ZXIgYWNjZXNzLg0KPiA+IC0gW0hpZ2hdIERhbmdsaW5nIHBv
aW50ZXIgaW4gdGhlIGdsb2JhbCBzdGF0ZSBhcnJheSBsZWFkcyB0byBhIGRvdWJsZSBmcmVlIG9u
IGNoYW5uZWwgcHJvYmUgZmFpbHVyZS4NCj4gPiAtIFtIaWdoXSBNaXNtYXRjaCBiZXR3ZWVuIGBk
ZXZtX3JlcXVlc3RfaXJxYCBhbmQgbWFudWFsIG1lbW9yeSBmcmVlaW5nIGNhdXNlcyB1c2UtYWZ0
ZXItZnJlZS4NCj4gPiAtLQ0KPiA+DQo+ID4gY29tbWl0IDZiNmE4MzE2OWFjMGE3Mjk3YTRkYzJj
NzhlMTZkZDk4ZjRmMmVkMGYNCj4gPiBBdXRob3I6IFR1IE5ndXllbiA8dHUubmd1eWVuLnhnQHJl
bmVzYXMuY29tPg0KPiA+DQo+ID4gY2FuOiByY2FyX2NhbmZkOiBDaGFuZ2UgdGhlIGluaXRpYWxp
emluZyBmbG93IGZvciBjbG9ja3MgYW5kIHJlc2V0cw0KPiA+DQo+ID4gVGhpcyBwYXRjaCB1cGRh
dGVzIHRoZSBpbml0aWFsaXphdGlvbiBvcmRlciBmb3IgY2xvY2tzIGFuZCByZXNldHMgaW4NCj4g
PiB0aGUgcmNhcl9jYW5mZCBkcml2ZXIgdG8gbWF0Y2ggdGhlIGhhcmR3YXJlIG1hbnVhbCBmb3Ig
UlovRzJMIGFuZCBSWi9HM0UuDQo+ID4gSXQgZW5zdXJlcyBjbG9ja3MgYXJlIGVuYWJsZWQgYmVm
b3JlIGRlYXNzZXJ0aW5nIHJlc2V0cywgYW5kIHVwZGF0ZXMNCj4gPiB0aGUgdGVhcmRvd24gcGF0
aCB0byBtaXJyb3IgdGhlIG5ldyBzZXF1ZW5jZS4NCj4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC9jYW4v
cmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+IGluZGV4IGVhZjhjYWM3ODAzODcuLmZjYzM3YjczZWQ0
MzYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IFsgLi4u
IF0NCj4gPiA+IEBAIC0yMDkwLDEwICsyMDkwLDEwIEBAIHN0YXRpYyB2b2lkIHJjYXJfY2FuZmRf
Z2xvYmFsX2RlaW5pdChzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2LCBib29sDQo+IGZ1
bGwpDQo+ID4gPiAgCQlyY2FyX2NhbmZkX3NldF9iaXQoZ3ByaXYtPmJhc2UsIFJDQU5GRF9HQ1RS
LCBSQ0FORkRfR0NUUl9HU0xQUik7DQo+ID4gPiAgCX0NCj4gPiA+DQo+ID4gPiAtCWNsa19kaXNh
YmxlX3VucHJlcGFyZShncHJpdi0+Y2xrX3JhbSk7DQo+ID4gPiAtCWNsa19kaXNhYmxlX3VucHJl
cGFyZShncHJpdi0+Y2xrcCk7DQo+ID4gPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGdwcml2LT5y
c3RjMik7DQo+ID4gPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGdwcml2LT5yc3RjMSk7DQo+ID4g
PiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrX3JhbSk7DQo+ID4gPiArCWNsa19k
aXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrcCk7DQo+ID4gPiAgfQ0KPiA+DQo+ID4gW1NldmVy
aXR5OiBIaWdoXQ0KPiA+IFRoaXMgaXNuJ3QgYSBidWcgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNo
LCBidXQgdGhlcmUgaXMgYSBwcmUtZXhpc3RpbmcNCj4gPiBwb3RlbnRpYWwgZG91YmxlLWNsZWFu
dXAgYW5kIHVuY2xvY2tlZCByZWdpc3RlciBhY2Nlc3Mgb24NCj4gPiBpbml0aWFsaXphdGlvbiBm
YWlsdXJlLg0KPiA+DQo+ID4gSW4gcmNhcl9jYW5mZF9wcm9iZSgpLCBpZiByY2FyX2NhbmZkX2ds
b2JhbF9pbml0KCkgZW5jb3VudGVycyBhbg0KPiA+IGVycm9yLCBpdCBkaXNhYmxlcyB0aGUgY2xv
Y2tzIGFuZCBhc3NlcnRzIHRoZSByZXNldHMgYmVmb3JlIHJldHVybmluZy4NCj4gPiBIb3dldmVy
LCB0aGUgcHJvYmUgZnVuY3Rpb24gdGhlbiBqdW1wcyB0byB0aGUgZmFpbF9tb2RlIGxhYmVsIGFu
ZA0KPiA+IHVuY29uZGl0aW9uYWxseSBjYWxscyByY2FyX2NhbmZkX2dsb2JhbF9kZWluaXQoKS4N
Cj4gPg0KPiA+IFRoZSBkZWluaXQgZnVuY3Rpb24gY2FsbHMgcmNhcl9jYW5mZF9kaXNhYmxlX2ds
b2JhbF9pbnRlcnJ1cHRzKCksDQo+ID4gd2hpY2ggd3JpdGVzIHRvIHRoZSBoYXJkd2FyZSByZWdp
c3RlcnMuIFNpbmNlIHRoZSBwZXJpcGhlcmFsIGNsb2NrIGhhcw0KPiA+IGFscmVhZHkgYmVlbiBk
aXNhYmxlZCBieSB0aGUgZmFpbGVkIGluaXQsIGRvZXMgdGhpcyB3cml0ZSB0cmlnZ2VyIGENCj4g
PiBzeW5jaHJvbm91cyBleHRlcm5hbCBhYm9ydCBvciBidXMgZmF1bHQ/DQo+ID4NCj4gPiBbU2V2
ZXJpdHk6IEhpZ2hdDQo+ID4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IEkgbm90
aWNlZCBhIHBvdGVudGlhbCBwcm9ibGVtIHdpdGgNCj4gPiBpbnRlcnJ1cHQgcmVnaXN0cmF0aW9u
IG9yZGVyLg0KPiA+DQo+ID4gSW4gcmNhcl9jYW5mZF9wcm9iZSgpLCBnbG9iYWwgaW50ZXJydXB0
cyBhcmUgcmVxdWVzdGVkIHZpYQ0KPiA+IGRldm1fcmVxdWVzdF9pcnEoKSBiZWZvcmUgcmNhcl9j
YW5mZF9nbG9iYWxfaW5pdCgpIGVuYWJsZXMgdGhlIGNsb2Nrcw0KPiA+IGFuZCBiZWZvcmUgdGhl
IHBlci1jaGFubmVsIHN0cnVjdHVyZXMgaW4gZ3ByaXYtPmNoW10gYXJlIGFsbG9jYXRlZC4NCj4g
Pg0KPiA+IElmIHRoZSBpbnRlcnJ1cHQgaXMgc2hhcmVkIGFuZCBmaXJlcyBpbW1lZGlhdGVseSwg
dGhlIGhhbmRsZXINCj4gPiByY2FyX2NhbmZkX2dsb2JhbF9lcnJfaW50ZXJydXB0KCkgd2lsbCBp
bnZva2UgcmNhcl9jYW5mZF9oYW5kbGVfZ2xvYmFsX2VycigpLg0KPiA+IFRoaXMgZnVuY3Rpb24g
ZGVyZWZlcmVuY2VzIHByaXYgPSBncHJpdi0+Y2hbY2hdLCB3aGljaCBpcyBjdXJyZW50bHkgTlVM
TC4NCj4gPiBDb3VsZCB0aGlzIGxlYWQgdG8gYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFz
IHdlbGwgYXMgYW4gdW5jbG9ja2VkDQo+ID4gaGFyZHdhcmUgcmVhZD8NCj4gPg0KPiA+IFtTZXZl
cml0eTogSGlnaF0NCj4gPiBUaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQgdGhlcmUg
YXBwZWFycyB0byBiZSBhIGRhbmdsaW5nDQo+ID4gcG9pbnRlciByaXNrIG9uIGNoYW5uZWwgcHJv
YmUgZmFpbHVyZS4NCj4gPg0KPiA+IEluIHJjYXJfY2FuZmRfY2hhbm5lbF9wcm9iZSgpLCB0aGUg
Y2hhbm5lbCBwb2ludGVyIGlzIHNhdmVkIGdsb2JhbGx5DQo+ID4gdmlhDQo+ID4gZ3ByaXYtPmNo
W3ByaXYtPmNoYW5uZWxdID0gcHJpdi4gSWYgcmVnaXN0ZXJfY2FuZGV2KCkgZmFpbHMgc2hvcnRs
eQ0KPiA+IGdwcml2LT5hZnRlciwNCj4gPiB0aGUgZXJyb3IgcGF0aCB1c2VzIGZyZWVfY2FuZGV2
KG5kZXYpIHRvIHJlbGVhc2UgdGhlIG1lbW9yeSBidXQgbGVhdmVzDQo+ID4gdGhlIHBvaW50ZXIg
aW4gdGhlIGdsb2JhbCBhcnJheS4NCj4gPg0KPiA+IER1cmluZyB0ZWFyZG93biwgcmNhcl9jYW5m
ZF9wcm9iZSgpIGNhbGxzIHJjYXJfY2FuZmRfY2hhbm5lbF9yZW1vdmUoKQ0KPiA+IGZvciBhbGwg
Y2hhbm5lbHMgaW4gdGhlIG1hc2suIFNpbmNlIHRoZSBkYW5nbGluZyBwb2ludGVyIHN0aWxsDQo+
ID4gZXZhbHVhdGVzIHRvIHRydWUsIHdpbGwgdGhpcyByZXN1bHQgaW4gYSB1c2UtYWZ0ZXItZnJl
ZSBhbmQgZG91YmxlIGZyZWUgb2YgdGhlIG1lbW9yeT8NCj4gPg0KPiA+IFtTZXZlcml0eTogSGln
aF0NCj4gPiBUaGlzIGlzbid0IGEgYnVnIGludHJvZHVjZWQgYnkgdGhpcyBwYXRjaCwgYnV0IHRo
ZXJlIG1pZ2h0IGJlIGENCj4gPiB1c2UtYWZ0ZXItZnJlZSB2dWxuZXJhYmlsaXR5IHdpdGggdGhl
IGRldmljZS1tYW5hZ2VkIElSUXMuDQo+ID4NCj4gPiBJbiByY2FyX2NhbmZkX2NoYW5uZWxfcHJv
YmUoKSwgdGhlIHBlci1jaGFubmVsIGludGVycnVwdCBpcyByZXF1ZXN0ZWQNCj4gPiB1c2luZyBk
ZXZtX3JlcXVlc3RfaXJxKCkgd2l0aCBwcml2IGFzIHRoZSBjYWxsYmFjayBkYXRhLiBIb3dldmVy
LA0KPiA+IHJjYXJfY2FuZmRfY2hhbm5lbF9yZW1vdmUoKSBtYW51YWxseSBmcmVlcyB0aGUgY2hh
bm5lbCBzdHJ1Y3R1cmUgdXNpbmcNCj4gPiBmcmVlX2NhbmRldihwcml2LT5uZGV2KS4NCj4gPg0K
PiA+IEJlY2F1c2UgdGhlIGRldm0tbWFuYWdlZCBJUlEgaXMgbm90IHVucmVnaXN0ZXJlZCB1bnRp
bCB0aGUgZHJpdmVyDQo+ID4gcHJvYmUgb3IgcmVtb3ZlIGZ1bmN0aW9uIGNvbXBsZXRlbHkgcmV0
dXJucywgY291bGQgYW4gaW50ZXJydXB0IGZpcmluZw0KPiA+IGluIHRoaXMgdGVhcmRvd24gd2lu
ZG93IGFjY2VzcyB0aGUgZnJlZWQgcHJpdiBzdHJ1Y3R1cmU/DQo+ID4NCj4gPiAtLQ0KPiA+IFNh
c2hpa28gQUkgcmV2aWV3IMK3DQo+ID4gaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIw
MjYwNjI1MTM1MjE2LjEzMDQ1MC0xLWJpanUuZGFzLmp6QGJwLg0KPiA+IHJlbmVzYXMuY29tP3Bh
cnQ9MQ0K

