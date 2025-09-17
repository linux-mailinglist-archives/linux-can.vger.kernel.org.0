Return-Path: <linux-can+bounces-4722-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC442B7DD50
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EB55811AE
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 05:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41095264609;
	Wed, 17 Sep 2025 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cfitw200"
X-Original-To: linux-can@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010095.outbound.protection.outlook.com [52.103.10.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EC21578F;
	Wed, 17 Sep 2025 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087002; cv=fail; b=RuqSLWxQo56jPtfmW9h9q65dvAycTLiBBZWqlxpBDbesHp/9IuwnHKzEa0XMQK8fbUlaqGTPc4bO6hjJIq89sssBiTXfuaqE9du7LF6/f7TBeIN2U/8PKcVSA4zfinU4fCfBe3YKto/8aoKIrhSXllYr1c9TZR8YTJ/P+SwoxWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087002; c=relaxed/simple;
	bh=YtH8n9QdP0+DMmlNy8GyHh2RgAzR+JXVlDGLYKlH0fQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WkOohiOhcrMUBdlW1uGJqbKLxTA2Gx9S/wzGswoM5lyJ2Lzm+GjtnQ5lu81VRBlesSLKZy+5ayPu6odJ5j4/1MZ6/VHlGmCEOXQKcjt5wtbnu+bp9kjiuZ8H3XmDFp2ltGqq132lf7HIE6i8zgTbiV7rFLlc5NKgxvL4RU66Fsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=cfitw200; arc=fail smtp.client-ip=52.103.10.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5JPo2L026jA9qoK9FSSKijIau2cjB45yJYKDGldnrOSgiMfG9g+wk0XTAKhRVSTktmxxTdJjrZGaE9PSwzjDCZc30EhiAOCqWKrlijDYVK7X4Am7tUatYsreGU4TkaKC8vpxKtXCxEo3o+2b8C65P6Vl28sbUbf3Lnexmg3QO7pbwQmoe0Tic/F70620Ct+065mKfGpRICM4ZmLYKkZ4dm2dE9IOuR/f6ccHOZrSBJTidA/qNOLiX+0MDiiXgFhuGhVS+FIqCVq88PNDuLmCVS9H1IysRSYHYhWjpQS4a49/NtUC3mVjnY84zoCGzHTiSufnSugO5j/xejo3UOOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtH8n9QdP0+DMmlNy8GyHh2RgAzR+JXVlDGLYKlH0fQ=;
 b=CtBbnT4NkaAFXf8K+MkJHxdhFdBHc/q/+LRL4pwtLCIHfCAPyof1rGIVfxbgrgnNGrS+/u/wJGCfCyVfGNOKbRDAQD4zQMCNKUBf9adJCSLUZQrpPwScHE+lwxeg3XpAlaFGijWSdm2+hQwHRdubzfNbUAWMJUo2IUKbuN/vTO+H0LbkVw+3igDPRXOSDMIbW5QkhhUhg8ofxRfURSM1tetIhDyGmFqwZIJTt4rAdy4BBoLbIEO+Qoanm9glendJzAlJJxVD9OvOAfN4uKP9RMDYiVdooa266Djo52qO347JrVpVO5WOtW8TPyMCkLFhZOEDWjqZXFoZVwhJwhf1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtH8n9QdP0+DMmlNy8GyHh2RgAzR+JXVlDGLYKlH0fQ=;
 b=cfitw200uqr3hp58VLdBdtOy2eNkp/yUfuxnBcF32+WtshluEPySmHKFIIqQv3sqdyeDAtTD+Ui31jSsssY0GxYWlZrPu/t1QKoksHowfdq05F4XSdDJM08scyOGOF2tg62KSRRfBrQ4VM0sIG6I/39W7ZtnBXf3KpTpVXL8dq6TLxJE0nnWuOR4d1mVOACLXnq6LCNt2lfeh+9WkiI2Cu3XsisBhcYiL6g2iMy3L5GOBWpzlR5/vvqK+zELogSDyQWH+2kKgEARxjT9BNZhP5BTmbAIsFpg/RT5JRxYbvUbKCqtAdW7Ixc5EF9x2njASMD92VNDViD6EEtP5eSGZQ==
Received: from PH7PR10MB6531.namprd10.prod.outlook.com (2603:10b6:510:202::5)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 05:29:59 +0000
Received: from PH7PR10MB6531.namprd10.prod.outlook.com
 ([fe80::459d:2445:2e8b:26cd]) by PH7PR10MB6531.namprd10.prod.outlook.com
 ([fe80::459d:2445:2e8b:26cd%7]) with mapi id 15.20.9094.018; Wed, 17 Sep 2025
 05:29:58 +0000
From: Da Shi Cao <dscao999@hotmail.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Configure CAN port using NETLINK messages
Thread-Topic: Configure CAN port using NETLINK messages
Thread-Index: AQHcJ5PgVeyE9tTzzkWYcTIqTLk3Ug==
Date: Wed, 17 Sep 2025 05:29:58 +0000
Message-ID:
 <PH7PR10MB65312C84F0B6A652BB3A34178C17A@PH7PR10MB6531.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB6531:EE_|DS7PR10MB5022:EE_
x-ms-office365-filtering-correlation-id: b3525837-c90b-489d-bc0b-08ddf5ab3e1c
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|15030799006|8062599012|8060799015|461199028|31061999003|19110799012|102099032|39105399003|40105399003|51005399003|440099028|3412199025|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fihBeX+wRTRwcK6vSHSgtGraWNaRPFwaCU0oLcrOe9kreriY186NpGiq3O?=
 =?iso-8859-1?Q?b1WQ1Vyw/wLKx7YLmf+2CKOaAZJWLcHa2McrSpkWVEH1Rw0xS6PqJq8krI?=
 =?iso-8859-1?Q?bj+BcX2rJAO5LwGmj6j2yKjHhaFQF/LE3q8J7B3pxJpAwN1elgl1ox4MLN?=
 =?iso-8859-1?Q?xSN9I3IslJ0zylpPtUFWQQMbQ5fxgfvnFJsWzzUYHS8p8Aa/1SKIZIl/T6?=
 =?iso-8859-1?Q?W9IQ5iCY+i4lYl3wQtBYcuBXLo/F2/8cHEwUqRJvqwafQ7lXWJUWiVCNrW?=
 =?iso-8859-1?Q?40AKwTNI2ovq4UU2NySyYkABaWOxkmbBKtDj6C5jBIJYYe2dOgEd7uI0kh?=
 =?iso-8859-1?Q?DlHmkIgm+bz9CRS/Eg5VZ1QXCK/cJJEdUG66tHG8+1kYyIRCjfv/MnzmGs?=
 =?iso-8859-1?Q?/6lNYSBVJDDcm+2kdjxyKjzTpEYZq0I0ok2dcyGUCS23NwnLIoQMeMCLXE?=
 =?iso-8859-1?Q?HAgFid3tpEkUZ5W2y3kBx0IwLk9Gl/dkoC3tQcID7/SmZ92HYbu+8bv5Xc?=
 =?iso-8859-1?Q?m8COjPCbd7XP1GCG4cTlbZRPzE28E6SkyNmXafdov/Te1u2u7GEtM2m4qP?=
 =?iso-8859-1?Q?R57l7QKcUzWLlhGozzEPfsfV2wsXBNEqTwHj83kPRlKhfIUDe0gnl4w2t+?=
 =?iso-8859-1?Q?ivUu4rJ6r/8mrOKGit/bl9Fs2eptoUlUsQNPYvRrdx0Wq3XCJwtcRlF6WF?=
 =?iso-8859-1?Q?xMUyrG0FZL2MsoyXAat2nKSDeRRs4mCx/1ipT6WLIeyUE1WGLTaNpC+rwC?=
 =?iso-8859-1?Q?oH/g04MHxnVW8vAVpWu+pgTDeV1/7w/aQYPODgilG1BZrNjSzw820Mt3UJ?=
 =?iso-8859-1?Q?JtnmuiA/kM+uWVO/9+wpVupHrPfg/NzwOwyq+YkDNrea1oid0K5r1RBd2w?=
 =?iso-8859-1?Q?qSTcryZzNGYi9FqnGH2oXvh4lIBPR5Nn9W09A6Dm5sAb0fF4Shx2+9JjJO?=
 =?iso-8859-1?Q?9fELRt5MpdK/bCgQoIFErDXMxCtEeRD4xoxwJxoGYh+ckiVgfNIjxWyfu9?=
 =?iso-8859-1?Q?gaJfRDMAVrd+DewURNy8j+g82EIRsikB6ptu/OU/JjxOblh+qWKYCxt0Id?=
 =?iso-8859-1?Q?vnE4Mqw6UQbkfNuA9jDtBScEplZdL9drpgwtTN8c0MnxL/boAE2Ze6wETa?=
 =?iso-8859-1?Q?8vYy4kAQC9/NFryHSETulNR/xAQ/SXH61IfPLKEm/niZaN3nwxCtmyzu2K?=
 =?iso-8859-1?Q?w2IOKuZXoy3oWk03gIBQihdlKTchpiA+7dwVT2XI8tTB8P+/kftHmScj/t?=
 =?iso-8859-1?Q?kdbXI+EObAb77mYJzAE39wY8TeP3YYRdstyb7DfHT3VNxyi+5iS0sv2uES?=
 =?iso-8859-1?Q?/+yESzJM4PPqh/qK5aoBA+D3gw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?b7QVqBw8B1Yg38sRWqD+8D6VmY7x/QIFgZaIdRuVtIrvnCg5gRu1lwyhiC?=
 =?iso-8859-1?Q?CsgJ7GAvCe/zJ98dajjjIMHVnU7OODFrf4oLEegSwMLL8oQ/O8xTly3QJV?=
 =?iso-8859-1?Q?Fp8DB6u+CMTVgLM99bZqrpfc32N4JyVsJaOM9O7vZdoRkqlExOaKiztrL0?=
 =?iso-8859-1?Q?Xsf8EIBQAGwttu8gQs5XJQeZuxbfUHQLy2t7HsjycfaWUg+eU9KOwPt+TC?=
 =?iso-8859-1?Q?wAXoMuG6/flMPs0eD3veBdjlKOH9jb/hsFFhFx8JOuwIAzXqse+vuco4A4?=
 =?iso-8859-1?Q?pkuhzVgpCzFnmUbFcvA0R9/xa/vig72frHiW2BxhmXEXZfZ18JE1utmvwY?=
 =?iso-8859-1?Q?r3Ri1O0nJm0q0SvQv2hM8Im87ze4a2jv7x4tOJdbyARR2/brv8EPX+6Fuv?=
 =?iso-8859-1?Q?iKqS2gqA37xvOZ5zIv+ih5VLsO8/oBdFSOeSRAjr6jVfRHW+Cqym3JErKZ?=
 =?iso-8859-1?Q?xG6tgaVCqiUrxJac7wqHeq5Cbn1wxn3Rsbfa6FMJsLqB2Iw0JVuPKEAEg+?=
 =?iso-8859-1?Q?Z50DVlyKbZ+AlJ/JOhX1lrVLPvm/MfiOjd7I3FvEKV4OV/eP6ir03chvrt?=
 =?iso-8859-1?Q?P4XU7686e2vWs7zyG7Fcf1uGECn6gxdfRBEebDnzcu6XicFNUDwAosrfqY?=
 =?iso-8859-1?Q?nq5fPjWQVgE7qheWJ68CSMgB2JELweSuvYIe6uYmZNXZkDozdhIPaHH9lY?=
 =?iso-8859-1?Q?JSGa9NFdHYzF8UZ43AsBRKicoMrdSXV7WRv0lxpML8hWERfZDdj+6kz9ol?=
 =?iso-8859-1?Q?VwB9vvbfCWyhu8HHuUsrGgnChLxTIopF8daVY9mIZXuytwp42UieuB8DdN?=
 =?iso-8859-1?Q?vF1xrb+6VZlUHQhoWuSGIInDzTqLaf4FlAsKevEZGfV2JH9qBHtonBWTrA?=
 =?iso-8859-1?Q?UGGS1C9NeWFOulnQPyMBidaRV1BGLi3HG2Ca3F63oYn3av8yqvK5espfFg?=
 =?iso-8859-1?Q?hrLrvLDTWV3yJ8bR5msex8ukgrCrYdoCemyCMDj5SC92vDU0YljG2b/35g?=
 =?iso-8859-1?Q?O1JYUVdd5FC4xqIjQ+4Dx1ixeM/4kQLEaYaQ+L92SaYrQ4eQq1pZSc8Pbl?=
 =?iso-8859-1?Q?2IexmLwVS0AqLS8C1+JBkXSrMEMoFM+4T9ixX5NHsGdR2ImNmasKYTsLQF?=
 =?iso-8859-1?Q?tU2jlg0bFINW++Rir9Sp91glI4HqgbCFUYZnQfgTteXaEJZN9F9E2bzQz2?=
 =?iso-8859-1?Q?pLVuH8Ct6Jb6LEmimQKlOHCXljRNm/fXYQ2zuXwe4SfP12jEfBobBI5cvu?=
 =?iso-8859-1?Q?GgmrfCnshHFMUZCBp9JQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-1700c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b3525837-c90b-489d-bc0b-08ddf5ab3e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 05:29:58.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022

Dear all,=0A=
To set CAN port attributes, command RTM_NEWLINK must be used. RTM_SETLINK w=
ill not do the job.=0A=
Why?=0A=
=0A=
Thanks,=0A=
Dashi Cao=

