Return-Path: <linux-can+bounces-914-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C491D385
	for <lists+linux-can@lfdr.de>; Sun, 30 Jun 2024 21:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53FD1F21131
	for <lists+linux-can@lfdr.de>; Sun, 30 Jun 2024 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333542C859;
	Sun, 30 Jun 2024 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=psu.edu header.i=@psu.edu header.b="Su+hqqih"
X-Original-To: linux-can@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309F2C1BA
	for <linux-can@vger.kernel.org>; Sun, 30 Jun 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719776710; cv=fail; b=Dt6J2UUHGj1zyRVJ4/WiCMdqZtafc3BSLJsHNvPJm/Ugn+sjCC8HhRhx9/DKMFD6JfG/x8iXKBWVdvKwPHtsj3XfHmkRE93goFtDz/aiY+QFjuthEiuPoyqp4BAfFpzozyVscW21hxddt82tQ8HBPJ0GnXsQO5FOPn2PhuDNT9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719776710; c=relaxed/simple;
	bh=AM9wSu/qY2ovjqWwc1SLlSvbWPNL8iSTeuGENWCEwNg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QY+7VNpZ4VhlgGDuwGA6YK4EOylNPVhi8rnAK8+iFDNN0vcxHJTKnsnApIl3tgc98Ipk97eRc/cT0cJZ518VJjTlJMapGhCjQwYPUt0s/C7ewZhNmUiGfif7EuDnnsd05YPLg7UjfRJTR9CWgdyIz7GBHqvODIUEwWRsNDJq0B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU; spf=pass smtp.mailfrom=PSU.EDU; dkim=pass (1024-bit key) header.d=psu.edu header.i=@psu.edu header.b=Su+hqqih; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=PSU.EDU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3xHC09mLA8d2Hy76CCiTuzI+y8L1I5aW458i6PgWhX3d0vCHUqw83cfbR4exAyLgVG+hlsq4xb78+9s0xf13yNnlaB9KxQHp3Huo8pYuJMEq0Z2/vbkBWVuxssp+gKqyxIqhcR8Eaqo22Sx4BSD7GtK7iL0ieYIL3gF5iCXbRvioiOSyUemU+5D6tW95FXu+DF0ZcRkmuQ/raJpHK3hQE23OpS7bQbqDA5uun6BxXIYfOeR3m9bb6lQjHtRjFdtYh8r6QE2sSA9yJkNVCOdaZZMO5FJu4zdb3vxaxOiYvi4X0N2VEcuy1zfTk3ZpCin4Ho6I7FWAKqKC53Z2RU7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYdKT+vQiGOwfhoeQrEfgDzriUSViajvT8gMYQot1v0=;
 b=QQFRlYicPuSALdwVPXbZpvSrDo9XWfYWRxw+RoYSpLKuMFp8opR8U1HZtt/YCtl8QxxhscGWHspzBE5ohF4nWeTWOxlKb0xsQIBBLVe4Jl58GNK9kCvYJLUfmgcUrfv1iY24igIqZ5xRW67SaTm+ykI3ceGyz5Uecz9DcGlFikcgt+fevT25G5G4N1O2sndyTxqzoAVm1UhrSeKTH3qQGjpfhdXMNoo92qdhowrDRXPoMpO/hTokHhAmpP/NSx9Cvhq8g5N7u7f+hyudcbTfbj6p0Ej6DsMnWcMk/DD10OdDqt5zyCz2VoLpZPhmi0cVTzgNDLnZS6Mkis9ZKbZtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYdKT+vQiGOwfhoeQrEfgDzriUSViajvT8gMYQot1v0=;
 b=Su+hqqihB2MON36nmBjrgfuamIz1SMV4bzgauoWNHyIG7jC+rAq4vBo1lrSx+o5yeq9luwzJvAfcCNn/B4SEhvQoVkipTgipbbGOf+yDBE+OJrhWL0sXesaZab8ShqWfH12vzUEO+RYiNpivU8q2fj6IIebz4t2xasXPKaUWmCM=
Received: from SA0PR02MB7276.namprd02.prod.outlook.com (2603:10b6:806:e6::17)
 by SA1PR02MB8573.namprd02.prod.outlook.com (2603:10b6:806:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 19:44:55 +0000
Received: from SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::e6ab:3830:2755:fa66]) by SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::e6ab:3830:2755:fa66%3]) with mapi id 15.20.7719.022; Sun, 30 Jun 2024
 19:44:49 +0000
From: "Bai, Shuangpeng" <SJB7183@PSU.EDU>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Questions of kref usages for j1939_priv objects. 
Thread-Topic: Questions of kref usages for j1939_priv objects. 
Thread-Index: AQHayyX39Pt62Tgi60S6i2An+7ic1w==
Date: Sun, 30 Jun 2024 19:44:49 +0000
Message-ID: <B009CBCA-3F21-42A6-B66B-A83EA730F375@psu.edu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=PSU.EDU;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR02MB7276:EE_|SA1PR02MB8573:EE_
x-ms-office365-filtering-correlation-id: e6e600ff-1a5c-415d-b11b-08dc993d1a31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LJL6mvgBVwttf2uRKwXKZfvCQ3aGZltphOcgKQf6QSQNvyBM605orMJs8ND+?=
 =?us-ascii?Q?kIk0ABgbr8Zl5ZpbK374khwHyJUpD/U+DQ5L7FgCQrXGa0CsX2DYQJ2Wv+6X?=
 =?us-ascii?Q?xgcxg6bb8Ls/Ig6qnc2MzCikLBy2BcrpAsdQXZl+ez4OgjFytbomxhTHRZYE?=
 =?us-ascii?Q?XDSgcD/+dWkjed/k50uz4lLdaVtOYp/qcOP7hiIacIzMwsYw6MOBDWjG43KP?=
 =?us-ascii?Q?rWdtjDPDW5cGjrvOHMZVFcpIsr2BW5odR2uT4Mmf8c5+IHXvz/ElGlcGMRgK?=
 =?us-ascii?Q?+KDlkmto2y95vnEvKGNL8FELz55hsXAaq0IY3w7jkgvUKpI7qej6JFE4XvmG?=
 =?us-ascii?Q?LKrAefKEST5JqyMYyl4jcD9SIIs2uZNLGdyl6DSuCxd4JC42GmAG2y4e027P?=
 =?us-ascii?Q?NmqU86mRzJhvCtT/VgabKnpWlETsnZ8KC0RU2hpu5rwGCTP8QZsE1JoROfwR?=
 =?us-ascii?Q?qc1XJ6xwr4Eb/GEhWM6HYYgNKwoF6EiicqWSQIP/LbRlFHw4KQEAhM/hLcbu?=
 =?us-ascii?Q?IjNX3uf5OmGv012vTIqRwJ8j76jvzzbZtzFWcy+OJIjI8eP0AajyLW0bYUel?=
 =?us-ascii?Q?N6S+mPJm6ng0sxkoodAVWPC6euA2mnZw6J4ExpGniXYPz86wBbGXll8W6nfp?=
 =?us-ascii?Q?ghsCo79zE68J0iatmfxMgBDumu//UNzXlYVAEYerJZ8t3p8qsUYrDMgg6uXl?=
 =?us-ascii?Q?XHKLNcEQ2ZzEH91Z+JSadS+NcuaROx4hslrekQFY2CQ7YOSzYLuaIACtmdLF?=
 =?us-ascii?Q?n0N+Mqet++x+OJlBQY6hYtrWP5uXo4OSYsk9dsCW+lRTZcycCN0XaXB7Cmr4?=
 =?us-ascii?Q?Wft3MFWJbpvyq5iMVLOeA3LTKnlDXWYGl1SXqa3gJFvGjiSmdAB6FCmHSFgU?=
 =?us-ascii?Q?G+B3ASQHjIbF5cPeoPix6aXvhdB/QOnj5J4dFoL2aug+YN6FgtYnVGiVpCQu?=
 =?us-ascii?Q?/n7dOWBnV+GbW/Cx1jO1BKVQqInDRX++mj96TzmssVr3u8vzsLcQJdWKVKjf?=
 =?us-ascii?Q?L6qCGpupxuYIH3UrHyQo3pLkKtWekDDovykePWHDEcWY7kxgla9uxQyvH0zM?=
 =?us-ascii?Q?eN0RZtSTim8XJV8OwaT9pclyzpm52ndlMObNbTraZ+Y8D/7TIktVpW25b8/9?=
 =?us-ascii?Q?V45YOT45XLn5PxaLUDMLupL9+0mKUHDKWiCKnZ7oCvp5k89d8mK7xvshWo6d?=
 =?us-ascii?Q?A59AsqVgRibvJYVXqU6ZhRLU5/9L3DhHQu6WQb2s1UdX5FZ+N3ZtpiB/plIZ?=
 =?us-ascii?Q?GCx10r4+QHF42NmqaJ7l0AWvOA/d96RhNlg2RdgVtSI43xI0Cm1LVGk7qDAd?=
 =?us-ascii?Q?4rr71u0nUQKFTu8+/pSdv1Cx8CNRTSvZMHhDwmJlytscJpKbzskv+h5WeqMe?=
 =?us-ascii?Q?FqXUzXaZquXtlFrpMeBnsfgbYxXxj+hGDk8aknpsOWcMBOYy2Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR02MB7276.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SBQFyiyTRLkhTTB3NfDlQHlwIPSpyEN3zIJgg0xdMc4fpmr3toAKWHKKhl4M?=
 =?us-ascii?Q?ccEbnsD3W6hAldb6hWa2mgaj31BatdW3j8VAesV6cnMaG4uE6NACxQ3+5/Bg?=
 =?us-ascii?Q?eSTwq938dHXMUWyQ+XvBGNVWZyGyMgr/MT+5LHe0FkEZYXKU+3ZPm2Z90ixI?=
 =?us-ascii?Q?bMngRcks1FCo/G0FqaU7nM1kR/esvNuYAzp+MIh9D7PuY5vpcV0OZv92HYN2?=
 =?us-ascii?Q?F9S2S/rUiXXkWSNG2PA87UJvNLDkiht1K1Hhayuaae/r5tsGlBXUG3AXkxen?=
 =?us-ascii?Q?XJmhTkeACrNc8WN5YcOpHYgJazLjnLJe28roZZTAGMksf4YCXYtju4EvSNZx?=
 =?us-ascii?Q?WesnAOY5LeseELTTIokEO5sOzF8zc5b7f+FYKMyOpJbyDPmHp9mJ9kQ1jzz1?=
 =?us-ascii?Q?0yXClu9I+vChZOELV2DCi8KhQB3wItkKiFfMh/cl+LMqKl/4/EA/E36fAcW8?=
 =?us-ascii?Q?V27JqXuLeII9B/IOG9KsTgxtmW3O9JZqEc4KMHuTsNPbIyfwF1B8TQgNibzn?=
 =?us-ascii?Q?wP4aYLyx5JVbbgoWEocK1+k+zXNqu32szFMs3Mi3liD8p1ap1vao52H7UIvU?=
 =?us-ascii?Q?V0lje71T37Gqk+RNc46TohIcJjtJ+PQwe70jRYRHpboW8/xcQPpP4TNHSXlh?=
 =?us-ascii?Q?VDOMmukW4iU1ChJ9qB39TJ7T9l3rCsE2JSvfVO/YWcB+hYvw5lUs/yx3nRNp?=
 =?us-ascii?Q?I27RTld/kVcWBV0tNf4c/Uj60sFNw8uhrk5xkyosYPjgU/PYpN9XK7X/MKhW?=
 =?us-ascii?Q?VrTZDk88oSBjjfr1UvssUyMqmj+/+7aJXyZIm83D0mUehYJdTv/OPHYUUBYG?=
 =?us-ascii?Q?IsJJm1/lZvagvM6M5Vj1uXy4ueou0Iq6+CyPAbGuKCv8aA3hxHa0hchNXJyw?=
 =?us-ascii?Q?m5bFLC6/CMc2L7wxBpyCEf0L/VZkWtRZYsLa+VnDMJtcLEvTZxE5mV+OZ5qb?=
 =?us-ascii?Q?p/MVcRgeRXfBO6x2oCTJsWhXprYRcDzBSMQUO47i3IcyKG03XCzKVJOWvqWm?=
 =?us-ascii?Q?IB4PPRZfnHjhOS+pHFcv9ObwDf1aJl214cuHOZ8ps8nX42RUDZqNBDanznDH?=
 =?us-ascii?Q?jKIVN87t9GhKV1fZ4ih1xcCh4jEPy5vY2wjurkDGc2SAv0f8QWHpYi8pH3u3?=
 =?us-ascii?Q?Ah6R8HLgGieOOBZGyfcfKDBA4WtSgUFyn4uFLt2gj9o3nqmLf8PEav91PqqU?=
 =?us-ascii?Q?+IjbJVuSQ0xZil2/MGiPBzp4Kq5fWiSxnynZMGz5lxejiZjsbLn9av/Y5Axd?=
 =?us-ascii?Q?6s7HvJplJad9QIgTJXj6ai/8F+IlwHas1YXGQxRN/SC/+gMZQ1qbThk3q0g1?=
 =?us-ascii?Q?b/2QQQDOFPp0m2JYjSA8+beu7zQ2qeFTB+zytnsb5iMSQVH9TPbPQRTiPaLm?=
 =?us-ascii?Q?CRafZWUIc460hp6M6b5uhjrI66T0cQXsc6seNXki4N7Tu0dOIfJog6pqMjtQ?=
 =?us-ascii?Q?qPcnMtQCRG3YosPjL4rVY8i0MhLitr7TX4D60ht+ucr+lf3FylCgv7iqKUxO?=
 =?us-ascii?Q?ak/Hu+7nhY00IyrOyI3x4FAoixyRW0Yg8Pp9378lAHWBsc9TINKBOpqwlM6P?=
 =?us-ascii?Q?NkuPk9GP0FxhwJ0ttY6ZbUhxnWe+lpR/4cIfJJpibJzoeHf/KLyCXEBu+/XL?=
 =?us-ascii?Q?J0YCSauYDjZHdYb/Vr3gEBz+p6HwqLpDUCwml/zF8hwW?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CCB09F4FD526A44B37920C135FA7985@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7276.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e600ff-1a5c-415d-b11b-08dc993d1a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 19:44:49.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmBwy5OSpNNdgWE17qQ9tMoJdqiojlRFAvv6ABML5l4PVbbwv8hO8p3O/kpkjWFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8573

Dear Kernel Maintainers,

I hope this message finds you well.

I am currently studying the reference count usage for j1939_priv objects in=
 the kernel, and I have encountered a few questions that I hope you might b=
e able to help me with.

Q1: Is the member kref of j1939_priv objects used for tracking the number o=
f references? It seems so, as when kref reaches zero, the object is freed b=
y the __j1939_priv_release function.

Q2:  If kref is indeed used for tracking references, could you kindly help =
me understand where the reference operations occur? The function j1939_netd=
ev_stop calls j1939_priv_put to decrease the reference count, and the funct=
ions j1939_jsk_add and j1939_jsk_del manipulate the reference counts. Howev=
er, I have been unable to find the corresponding reference copy or destroy.

I understand that you have a busy schedule, and I am very grateful for any =
time you can take to help me with these questions. Your insights would grea=
tly enhance my understanding of this topic.=20

Thank you so much for your time, assistance, and significant contributions =
to the kernel.

Best regards,
Shuangpeng Bai=

