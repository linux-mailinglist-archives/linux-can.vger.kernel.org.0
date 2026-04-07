Return-Path: <linux-can+bounces-7342-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEwINKDn1GmeygcAu9opvQ
	(envelope-from <linux-can+bounces-7342-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 13:16:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 297303AD918
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE90300D845
	for <lists+linux-can@lfdr.de>; Tue,  7 Apr 2026 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8F3A8753;
	Tue,  7 Apr 2026 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IV7xL/AN"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42238A737;
	Tue,  7 Apr 2026 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560342; cv=fail; b=O1NUscA5UQNVhvx0kJ83LzJsc5UsKZPnEb8PbufEywJti0pAJ1ziGCyb5a41/ozTqp6jklkf8XutLu1bxYv8xeWc0QM+TDUK/nGeDRtaJ79l0KDvZ20rgxw8G6/2smCJpQcin5aR5InmTpLMPnfUcw6MhiSilNIFG9kO4BPu6S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560342; c=relaxed/simple;
	bh=XLvtnvJFQ+hUOxZ9NmajWTcqaTPRjI6mFWdfuDDaojU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQmaRSYrpmwBEj5eDT2p6FKKVlBq+TZRCQc9SeJqpO8ZIxdTcxigPCDA2uzSWZ+t924V+bVYa0usfaCCl7LKtKOSEhMNtsxJW6cNxSGvh8RORXTHiEkoSREs28Gz80MW2if+5IlpOE7mHdOiuaXzZcMAnBiSRNVYIKKidwRx4FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IV7xL/AN; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x90FDH9LYuWS+mSa2jLG+6JqAbZaqwJ4Goety6pRxngOkK/yqwnDA3oZg7I7cgAh7cOhWBOZqLHvChFLM0w9QjDxNBFNS4i0lolH4hNiI6EKBBBOqdOkWjvIZuySYWYnIaOgNENmKHv45S69kTrZKMaikkg4M6uGaK4kOolCrk6c0obL3KDKiPQw7BbNagmMcr2jUXl2irvJPEu6f1mFf68xfyvzpQpjf3ZZDwhaJhGzCwFTuI1u+aVpB1z9gJ63NP1caVNS+/QACceCYLyqSyQzu+qsM6Wf5fQQHiFD4GjeIz/qdeeMkoCKr86gSUC2sVrZuxbnEHFiQCfzWEaZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLvtnvJFQ+hUOxZ9NmajWTcqaTPRjI6mFWdfuDDaojU=;
 b=mtNywx18mXmQjTzzn7yL1UoJEnU5xXngmjiNU1BjdsHhZNT8cwxp10vvGFz/nMXA4q2LHlnIayy2pGxuzBEqitnengr1S8dJDCFgHMjOYaieS2Mt8pgtIgaNP52mk9arn9oQoKFQU1LQ0Ef1F42PEZjH1etFhuAK0tgj+uxOD6TgzWcQWyBcpR42k7coDMuQTAM8rdumhQyewluSymdlwOORR+X0aSyzx6lEU/GMWvJ3o4btNibQGw3tXByHJDEP0Q3DOZbOZ0SiKlQh6uam16jiSus+APfLPX24npbQFivXQkjA5bV23v7auhpeB0WYtGfzgkkSatSZh5DEZ5WBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLvtnvJFQ+hUOxZ9NmajWTcqaTPRjI6mFWdfuDDaojU=;
 b=IV7xL/ANiwbWdwjDbOz014f2mSzp/qXJTYPebmeBdadQQoB0yu1BS2Gic9WsziOk1ftM3VOBWp19w4xYtcNwBZx555f4/0r2R1uaRo4R7y6NkpKUXZy5fCRrZ+VKFj0POwe1C6nFvU7OwzxEDmVTCJt4+Sv7brY3pmDX6pZknOk=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYYPR01MB14231.jpnprd01.prod.outlook.com (2603:1096:405:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 11:12:17 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%5]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 11:12:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, biju.das.au
	<biju.das.au@gmail.com>
CC: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 0/3] Add support for Renesas CAN-FD Bus-Off recovery mode
 selection
Thread-Topic: [PATCH 0/3] Add support for Renesas CAN-FD Bus-Off recovery mode
 selection
Thread-Index: AQHcw09Ev5ct3x/nM0OumdjMeeQLJbXN34OAgAWMM4A=
Date: Tue, 7 Apr 2026 11:12:17 +0000
Message-ID:
 <TYCPR01MB1133243B5501A2359CA63648C865AA@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
 <20260403-camouflaged-original-tortoise-ec0f7b-mkl@pengutronix.de>
In-Reply-To:
 <20260403-camouflaged-original-tortoise-ec0f7b-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYYPR01MB14231:EE_
x-ms-office365-filtering-correlation-id: 407e5f72-e66d-44f2-1f9b-08de94968791
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|18092099006|56012099003|22082099003;
x-microsoft-antispam-message-info:
 6MI6v95Tjv2X2P9i+Gt56VgpV34u3gT6k6ZNwAaI+61gZedm2DuyBEGppJ5DVbO8pH1d5pCqvw4h+NzOflgS00NYsEKzyEzqJbKXa9537qSdjLcfwv66uio2JmUn7IJlMkaNmzMGXJGonErniO8ZubyQaYk3Keu4VLTQA7bdIdzs5v8LJk1hvlw/Qzx1sGu5OFpKXrY6W7kSQWqn94lGOADoI/Soi/kpgUqEFbtNFK8j+pAoQBTO+axBS4b0v0Y2p7URrH+w0Jj7g8IFYfoHRjquPt5jZZxt0yL6YvZPGaDEA57mavAuptjwzFmrcq467wBSgPyvx/EDrGQcdafE7Vl44UDZtPaWsW3dHlxn6IMGpVnu0SUK90eYSHHyCJKpr37A7N/yYIgnlmN24Z7ma3bjBqLcJ6wMGSqZCNCLusSJ6fC+xpYTS2u2E8IlPg32yok/j8cB8sLsmlnAgzNNboBavNrpS2O5BR315U9raNiAJIcw4p72JKON9QxIKbNWuaH/BhuhuM1bw+9ny6JQBafOygZIy8xZ6BGvFCLNDiUNlhuUKtbUujKfd3oplYndhaLjHA7fmlzw6vGtKZv9MaGzEmNqSxssaCRzqyftvse12LjWwivB0GsZ+PAqvjzHci8qR1+AVyRpDz5CuIi343o6fY49clM7lFD4PyrIxXgKpmyMJT1CXFEztrG0BI0Z8y/bEFHzOng7K9hFB8thxgAhHJiA0BsAZu8tuDS0ktUnZ4PKLZYSHqonMHkBD9rzJj+McRmvaxQOAW7J0buJb33UW1JLzb2RAC36eAjoqFY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(18092099006)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bERQVmljWktSNHE1dVNsUGhPL2VleUx6cENTd0ZMbXh2VmVGUm1yekM4TDE3?=
 =?utf-8?B?QldzSzZYL0JnWFAxZ2pHQ1dwd2hoc3FocDZtTGRUZkZFZmh2enArUFJlTEN6?=
 =?utf-8?B?THdVZ21sUWJFUjBoK24va01kdklyN2FxM0oxVUI3UnRLelRrVzdQaWtLUzZO?=
 =?utf-8?B?T1o1TUtvWmpkVE8veHd1RUVmQkZjQ24wRHlLdjdtR2UxS21QK2tiOHRNaGhX?=
 =?utf-8?B?TS9nWTdJOUxEMFJNeVZmdDliY1pBZC85VzRDRkRYeTl2NDh6anF2TnFNWU10?=
 =?utf-8?B?NkQ1Mzc1SGRoOXp3UC8vL3JLUi8rWFgrYmRGcVdPaDJkaXBIYlkyODdEZDBX?=
 =?utf-8?B?Qk5sL05JVVVtSlRQNXF2TUI5TVZJM1FWRE11UGVhODVSZW9ISTF2aWhlc1NX?=
 =?utf-8?B?ODA2a0t0SlF4SDZweUQzWjNVRk1ibGdib0hueUdtSzlmWElrb01NOVVaQURm?=
 =?utf-8?B?VzJrUVZOV2Q2Q1QzRGVyQlJSMFdiRmhXOGZxL1hrSGlVV0lpY1ZaRDU3Tzll?=
 =?utf-8?B?RUdYYzJPekhsU0pPK2owQzIyZnZVSndmYVNtQzc4UWFOSGw5M2JJYThWK2xZ?=
 =?utf-8?B?RjNFSHBMVmNFOXNnNHorSUhZWHFLUVdjZzZkS2dmK1ZBTmhwS0VLS2lZejlE?=
 =?utf-8?B?M2kvYUl2ZWVNd1lZN2RlVzFiYmV3VWJRSERDdFd4eWxrdC8vNm9yQnc2dko3?=
 =?utf-8?B?a0IwWEQ5ajdibXNqc1pjeVlSL09OekJjcFp3ODlLVU1oOUhucjd4OUs0dHJ3?=
 =?utf-8?B?MENvSTFwb3hEWXYyajQ5R0F3UForVVlyb09TNnFKWDlwbGxhYUFHZ0pRMkhF?=
 =?utf-8?B?Qmw1K0hiK2Era3JXdnArdmRyV0ZsejVSTVFndy9nYm54Nm9MN2t4TzRKUjVX?=
 =?utf-8?B?MktOUFozNnBDYzZITG93bWJhWGhlNnBTcy9SQkhaTytVTkp1UnlRMllYa0tR?=
 =?utf-8?B?dlI4VFgvb2ZsZW1lbDgybWxjYTAyZ000WGYzemdUUzJ4VEtSNlpPQ09HcEFL?=
 =?utf-8?B?aGliL0xPNGthbFpzU3J4SXhuR1llSnZHTE84ZUZxc3BSWHJPenhkTVRCQWlt?=
 =?utf-8?B?UDJmNERmd1JBb1dMSitYQ1JHTXNyS0hPZXRLcUx5SVhrdmNoYnpyTy93TzRr?=
 =?utf-8?B?WGVBdWZvVHlHZk4zWkEwcEs5R3FEK3U1UWNnUWw1eUIwa01UREJydXQwbDFI?=
 =?utf-8?B?OEpnaDNJVjE4ZUZGK0R1Z0NzbGtmaUI1UC9IakRPMWlLQ2kxOHIvM3F3VWJv?=
 =?utf-8?B?clpYek5uak1sSzQ2a01ZaXE0MFZRVHJCWEp0MVNodHpoQk14b3RrbUdLTC92?=
 =?utf-8?B?MkJWVFhxK2hidlpOd2VxTHB2YXBZNnJaazU2YVdpbnJzSXdyb3ViNFdVd0VV?=
 =?utf-8?B?d3c3RE55KzJJMkNXQVNnSm11TGs4RnZ5S0JsVFZ4VmlZRXBHY2VtYS9jVVhv?=
 =?utf-8?B?V21yanhmcWNQbytrY00yd2ZSbXFadk5teXpnRXQ4a0xUWGdQaFBDa20rcDJz?=
 =?utf-8?B?TzUzRlk5OEJCUWl0UDN1U2poTXBDRnRsMi8vbi9scFF5clMyQ3hRZEhaSVIz?=
 =?utf-8?B?QUxudTQ0NzFsQ0pXRExWT0VYNWNIeVRYZm9JNTEwdy9qUXVCcGtnY3ZLaVpL?=
 =?utf-8?B?ajdQSTFLZ3M2WHE4OVNyeFh1UXA5ZzhoM2IxTlVXUzMvVHNqYTRpem4wVmlY?=
 =?utf-8?B?UitoMzhMQ1o4eDkzVTkwSW5lcDcvWXp3L21DMjhudEdxV1lKOFJDZ0hsVTdI?=
 =?utf-8?B?dGVTaE1qMDF2U1RoT1I3VjZxVFhobWdMMCtxcjdBWHNUaWtOZnZ3cE1ndDJy?=
 =?utf-8?B?REkxVkFQOUJaOW1EdmdneVM1Umd2Q3JFMjJzSUdlZlRGSWF5VkluOXJVS3lv?=
 =?utf-8?B?N3NraWk3bVhNanJxZHViVTFCNUt4WE1xSDVpZEEzcjZJV1RHMXhXS3hxNzZM?=
 =?utf-8?B?WkFZaXdhTGN0bHk0TXhsTTJTOE9MT3QwWHRQeS9CMVN5bmc1OXpFNlplUG1h?=
 =?utf-8?B?aU9iM1pqb3g3Z1RKVmNCY3g4aVlvcWZIUHNnMVZMYWkxQkozaUpoeG50cWUy?=
 =?utf-8?B?WURhWjk1RDkzdVpRTFJvRHMxUnFtTHZGZldtLzNuVnVsUlEzWDlJc1E2U1Na?=
 =?utf-8?B?VjBaakZ2STJrczlDWWlCeDF6andTTFJHZjg3c0gxRDdGYkU4c3ZURzZUKzVu?=
 =?utf-8?B?VDkwbTlZTjhsaE1ycHd0ckh6MWVKZG8ySFhFZ3pqbjN5TVBxZmFwMUNPaU1Q?=
 =?utf-8?B?N1Y0MmkwdkxyaEhkSlNpQWFEdDFNOVExZmtyKzZjZWFjUnRtNGhmNGdWODlk?=
 =?utf-8?B?V2kvZkZPVTIvWm5Eb1hqKzNMRy9pWnFkcHZqdmhhWkJXdGsyZHAxZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407e5f72-e66d-44f2-1f9b-08de94968791
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 11:12:17.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQXMn8AN4VBVDDIau4KnZ2XMqWhWea2qa3pfzATcVmLpNZh+Zx+3RYSCOJaIn2gCidbg/4+WaOBdOArKJ1TtrcG7bBdDvkqD/JhXrqfRUnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14231
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7342-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,renesas.com,vger.kernel.org,bp.renesas.com];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,pengutronix.de:email,TYCPR01MB11332.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 297303AD918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgTWFyYyBLbGVpbmUtQnVkZGUsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xA
cGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDAzIEFwcmlsIDIwMjYgMjI6NDUNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwLzNdIEFkZCBzdXBwb3J0IGZvciBSZW5lc2FzIENBTi1GRCBCdXMtT2ZmIHJl
Y292ZXJ5IG1vZGUgc2VsZWN0aW9uDQo+IA0KPiBPbiAwMy4wNC4yMDI2IDEwOjQ5OjU3LCBCaWp1
IHdyb3RlOg0KPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gPg0KPiA+IFRoZSBDQU4tRkQgSVAgc3VwcG9ydHMgdGhlIGJlbG93IEJ1cy1PZmYgcmVjb3Zl
cnkgbW9kZXM6DQo+ID4gMSkgSVNPMTE4OTgtMSBjb21wbGlhbnQNCj4gPiAyKSBFbnRyeSB0byBD
aGFubmVsIEhhbHQgbW9kZSBhdXRvbWF0aWNhbGx5IGF0IGJ1cy1vZmYgZW50cnkNCj4gPiAzKSBF
bnRyeSB0byBDaGFubmVsIEhhbHQgbW9kZSBhdXRvbWF0aWNhbGx5IGF0IGJ1cy1vZmYgZW5kDQo+
ID4gNCkgRW50cnkgdG8gQ2hhbm5lbCBIYWx0IG1vZGUgKGluIGJ1cy1vZmYgc3RhdGUpIGJ5IHBy
b2dyYW0gcmVxdWVzdA0KPiA+DQo+ID4gQWRkIHN1cHBvcnQgZm9yIEJ1cy1PZmYgcmVjb3Zlcnkg
bW9kZSBzZWxlY3Rpb24gdmlhIHRoZQ0KPiA+IHJlbmVzYXMsYnVzLW9mZi1yZWNvdmVyeS1tb2Rl
IGRldmljZSB0cmVlIHByb3BlcnR5LiBJZiB0aGUgcHJvcGVydHkgaXMNCj4gPiBhYnNlbnQsIGl0
IGRlZmF1bHRzIHRvIFJDQU5GRF9DQ1RSX0JPTV9CRU5UUlkgKGVudHJ5IHRvIENoYW5uZWwgSGFs
dA0KPiA+IG1vZGUgYXV0b21hdGljYWxseSBhdCBidXMtb2ZmIGVudHJ5KSBmb3IgYmFja3dhcmQg
Y29tcGF0aWJpbGl0eS4NCj4gDQo+IFVzaW5nIERUIHByb3BlcnRpZXMgZm9yIGNvbmZpZ3VyYXRp
b24gaXMgbm90IHRoZSBiZXN0IHdheSB0byBnby4NCg0KRnJvbSBhIHByb2R1Y3QgcGVyc3BlY3Rp
dmUsIGhvdyBjYW4gd2Ugc2F0aXNmeSB0aGUgYmVsb3cgcmVxdWlyZW1lbnRzLA0KZ2l2ZW4gdGhh
dCB0aGlzIGlzIHRvIGJlIGRvbmUgc3RhdGljYWxseT8NCg0KU29tZSBjdXN0b21lcnMgd2FudCBC
dXMtT2ZmIHJlY292ZXJ5IHRvIGJlIGNvbXBsaWFudCB3aXRoIElTTyAxMTg5OC0xLA0KY29tcGFy
ZWQgdG8gdGhlIGV4aXN0aW5nIGJlaGF2aW9yIG9mIHN3aXRjaGluZyB0byBoYWx0IG1vZGUgYXV0
b21hdGljYWxseQ0KYWZ0ZXIgZW50ZXJpbmcgdGhlIGJ1cy1vZmYgc3RhdGUuDQoNCkluIENoYW5u
ZWwgSGFsdCBtb2RlLCBhbGwgY2hhbm5lbCBDQU4gY29tbXVuaWNhdGlvbiBpcyBzdXNwZW5kZWQs
IGJ1dCBhbGwNCnN0YXR1cyBhbmQgZmxhZyByZWdpc3RlcnMgcmVtYWluIHVuY2hhbmdlZCBkdXJp
bmcgQ2hhbm5lbCBIYWx0IG1vZGUgZW50cnkuDQoNCj4gDQo+IENhbiB5b3UgZXhwbGFpbiBhIGJp
dCBtb3JlIHdoYXQgdGhlIGNvbnRyb2xsZXIgZG9lcyBpbiB0aGUgZGlmZmVyZW50IG1vZGVzPw0K
DQril48gQ0ZEQ25DVFIuQk9NWzE6MF0gPSAwMGI6DQpCdXMtT2ZmIHJlY292ZXJ5IGlzIGNvbXBs
aWFudCB0byBJU08gMTE4OTgtMSwgbmFtZWx5IHRoZSBDQU4gY2hhbm5lbCByZS1lbnRlcnMNCkNB
TiBjb21tdW5pY2F0aW9uIChlcnJvciBhY3RpdmVzdGF0ZSkgYWZ0ZXIgMTEgY29uc2VjdXRpdmUg
cmVjZXNzaXZlIGJpdHMgYXJlDQpkZXRlY3RlZCAxMjggdGltZXMuIFRFQyBhbmQgUkVDIGNvdW50
ZXJzIGFyZSBpbml0aWFsaXplZCB0byAwLiBUaGUgQnVzLQ0KT2ZmIFJlY292ZXJ5IEZsYWcgQ0ZE
Q25FUkZMLkJPUkYgaXMgc2V0IGluIHRoaXMgY2FzZS4NCg0K4pePIENGRENuQ1RSLkJPTVsxOjBd
ID0gMDFiOiAgICBFeGlzdGluZyBjYXNlDQpUaGUgQ0FOIGNoYW5uZWwgY2hhbmdlcyB0aGUgdmFs
dWUgb2YgdGhlIENGRENuQ1RSLkNITURDWzE6MF0gYml0cyB3aXRoaW4gdGhlDQpDQU4gQ2hhbm5l
bCBDb250cm9sIFJlZ2lzdGVyIHRvIDEwYiBhbmQgc3dpdGNoZXMgaW1tZWRpYXRlbHkgdG8gQ2hh
bm5lbCBIYWx0DQptb2RlIGF1dG9tYXRpY2FsbHkgYWZ0ZXIgZW50ZXJpbmcgYnVzLW9mZiBzdGF0
ZS4gVEVDIGFuZCBSRUMgY291bnRlcnMgYXJlDQppbml0aWFsaXplZCB0byAwIGFuZCB0aGUgQnVz
LU9mZiBSZWNvdmVyeSBGbGFnIENGRENuRVJGTC5CT1JGIGlzIG5vdCBzZXQNCmluIHRoaXMgY2Fz
ZS4NCg0K4pePIENGRENuQ1RSLkJPTVsxOjBdID0gMTBiOg0KVGhlIENBTiBjaGFubmVsIGNoYW5n
ZXMgdGhlIHZhbHVlIG9mIHRoZSBDRkRDbkNUUi5DSE1EQ1sxOjBdIGJpdHMgd2l0aGluIHRoZQ0K
Q0FOIENoYW5uZWwgQ29udHJvbCBSZWdpc3RlciB0byAxMGIgYXMgc29vbiBhcyBpdCByZWFjaGVz
IGJ1cy1vZmYgc3RhdGUgYW5kDQplbnRlcnMgQ2hhbm5lbCBIYWx0IG1vZGUgYXV0b21hdGljYWxs
eSBhZnRlciB0aGUgQ0FOIGNoYW5uZWwgaGFzIGNvbXBsZXRlZA0KdGhlIGJ1cy1vZmYgcmVjb3Zl
cnkgc2VxdWVuY2UgKGFmdGVyIDExIGNvbnNlY3V0aXZlIHJlY2Vzc2l2ZSBiaXRzIGFyZSANCmRl
dGVjdGVkIDEyOCB0aW1lcykuIFRFQyBhbmQgUkVDIGNvdW50ZXJzIGFyZSBpbml0aWFsaXplZCB0
byAwIGFuZCB0aGUgQnVzLU9mZg0KUmVjb3ZlcnkgRmxhZyBDRkRDbkVSRkwuQk9SRiBpcyBzZXQg
aW4gdGhpcyBjYXNlLg0KDQril48gQ0ZEQ25DVFIuQk9NWzE6MF0gPSAxMWI6DQpCdXMtb2ZmIHJl
Y292ZXJ5IGlzIGluaXRpYXRlZCBidXQgQ0FOIGNoYW5uZWwgY2FuIGltbWVkaWF0ZWx5IGVudGVy
IENoYW5uZWwNCkhhbHQgbW9kZSB3aGVuIHN0aWxsIGluIGJ1cy1vZmYgc3RhdGUgaWYgYSByZXF1
ZXN0IGlzIG1hZGUgdG8gZW50ZXIgQ2hhbm5lbA0KSGFsdCBtb2RlLiBURUMgYW5kIFJFQyBjb3Vu
dGVycyBhcmUgaW5pdGlhbGl6ZWQgdG8gMCBhbmQgdGhlIEJ1cy1PZmYgUmVjb3ZlcnkNCkZsYWcg
Q0ZEQ25FUkZMLkJPUkYgaXMgbm90IHNldC4gV2l0aG91dCBzZXR0aW5nIENGRENuQ1RSLkNITURD
WzE6MF0gPSAxMGIgYW5kDQp3aGVuIDExIHJlY2Vzc2l2ZSBiaXRzIGlzIGRldGVjdGVkIDEyOCB0
aW1lcyBjb250aW51b3VzbHksIHRyYW5zaXRpb24NCmNvbmRpdGlvbnMgYmVjb21lIHRoZSBzYW1l
IGFzIENGRENuQ1RSLkJPTVsxOjBdID0gMDBiLg0KDQo+IA0KPiBJbiB0aGUgY3VycmVudCBkcml2
ZXIgd2hlbiB0aGUgYnVzIG9mZiBJUlEgKFJDQU5GRF9DRVJGTF9CT0VGKSBmaXJlcywgdGhlIGRy
aXZlciBjYWxscyBjYW5fYnVzX29mZigpLA0KPiB3aGljaCB0cmlnZ2VycyB0aGUgY29uZmlndXJl
ZCBidXMgb2ZmIGhhbmRsaW5nLg0KDQpBZ3JlZWQuDQoNCj4gDQo+IFdoYXQgdGhlIExpbnV4IGRy
aXZlciBzaG91bGQgZG8gaXMgb25jZSB0aGUgSFcgaXMgaW4gYnVzIG9mZiBtb2RlLCBzd2l0Y2gg
b2ZmIHRoZSBIVyBhbmQgbGV0DQo+IHRoZSAuZG9fc2V0X21vZGUoQ0FOX01PREVfU1RBUlQpIGNh
bGxiYWNrIHJlc3RhcnQgdGhlIGhhcmR3YXJlLg0KDQpXZSBkbyBoYXZlIC5kb19zZXRfbW9kZSwg
d2hpY2ggcmVzdGFydHMgdGhlIGhhcmR3YXJlIGlmIHJlc3RhcnRfbXMgaXMgc2V0Lg0KDQpCT00g
Y2FzZSAwMGI6DQpBZnRlciBlbnRlcmluZyB0aGUgYnVzLW9mZiBzdGF0ZSwgd2hlbiAxMSBzdWNj
ZXNzaXZlIHJlY2Vzc2l2ZSBiaXRzIGFyZSBkZXRlY3RlZCAxMjggdGltZXMsIGFuZA0KaWYgd2Ug
c3RhcnQgdGhlIHRyYW5zbWlzc2lvbiwgaXQgZW50ZXJzIHRoZSB0cmFuc21pdCBzdGF0ZS4NCg0K
Qk9NIGNhc2VzIHswMWIsIDEwYn06IEl0IGF1dG9tYXRpY2FsbHkgZW50ZXJzIGhhbHQgbW9kZS4N
Cg0KQk9NIGNhc2UgMTFiOg0KVGhlIENBTiBjaGFubmVsIHRyYW5zaXRpb25zIHRvIENoYW5uZWwg
SGFsdCBtb2RlIGFzIHNvb24gYXMgQ2hhbm5lbCBIYWx0IG1vZGUgaXMgcmVxdWVzdGVkIGJ5DQp0
aGUgQ1BVICh3aXRob3V0IHdhaXRpbmcgZm9yIHRoZSBjb21wbGV0aW9uIG9mIHRoZSBidXMtb2Zm
IHJlY292ZXJ5KS4NCg0KSWYgdGhlIENQVSBkb2VzIG5vdCBzZXQgQ2hhbm5lbCBIYWx0IG1vZGUs
IHRoZW4gaXQgYmVoYXZlcyB0aGUgc2FtZSBhcyBCT00gY2FzZSAwMGIuDQoNCkNoZWVycywNCkJp
anUNCg0K

