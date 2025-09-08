Return-Path: <linux-can+bounces-4523-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE969B4907F
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 15:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EC03A3929
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E530BBA4;
	Mon,  8 Sep 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UnLzb5gP"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010062.outbound.protection.outlook.com [52.101.229.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879191EE033;
	Mon,  8 Sep 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339796; cv=fail; b=iWVgwBv5Okh8cORgGhk6b5qqLEWmvGiqB3n7chNMIVuNyC1ltNrzvl6l1aIrkm2zLt0pQaipBY1uRGTmwnTLTo/CQ0/gHNLdajHjlKg8vMOPWyG2aCBl1/2+5AI2zwNN+LjDxht8YL3pIKAAatSzNvKRtJj0BAi56gTp0n5RUsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339796; c=relaxed/simple;
	bh=Ub3rImrBq1nBdj+mbV83jtxn924yx1GVr+8ODq036U8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pUOo6pZ0+9Amvv5SAFyIdlYeS8T+iizLS4YxkUoR/AjrjJrmkLKygrEBVusdomIG3nGULd2Rl7+C5nqvaCnA2JxwzoLrZ+dyxVc62edMEJ2vbXTA04/J34vcdqAWTQGN97uaNojEe0JeOROVdM7GUukEFysYZnG6Tb29lXDz5Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UnLzb5gP; arc=fail smtp.client-ip=52.101.229.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlJ0CP5Jkz+tMFdT9LEf9Ab5+cpjpfKS5CYTppay59Sw2D5kF/BzhuVjH8H3UZ65weCdIrTd4LVcmGs0m7k3E8BCZZN6QvEvSOdHknKq97seI32xbty0rmeei9AAJHUTXPha1AJJsYpnZqtVq0z5y46I4nvv7Rc7YXcmV7wiVO3dYbUtefdaFHXUVJ5UEC1RIWbE7etXB27eekpwkuWhHNSTqwvg77JomyNxHobCP19i//3p5xn4wltdgosvRij0ObPwnqPXlIzJ/NCHJQk8RCgLPUv5AQHdejx9kTKDUjeVK7/LYOC4VQCzd0fs5tSQ/IW5XuJVwj1prtTltVidoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub3rImrBq1nBdj+mbV83jtxn924yx1GVr+8ODq036U8=;
 b=Yu1FYSy6QSruu5myt6OPOlqtnsiDYmFsdl7rm+pjrEQNdlats8T5cz0bOc1XcpSUVyezhamP+nwiTjjFwUIjFRbshYFD6O12iEA0yG9fRYVECe300m2HjIj68Ojik78yeMrdImeAaZoVcCJ3bvsrI6715HxkqYCYy5ESTt6afrQxnuuc9k0Y12XYMVGzvblnYWfMI+AznA96moil0PhKYjFiMOLMjfA+209CX8lhuZy8PHj/bNnJ79CRBcgfeb835nc+oWOkO/ZyeltNhNO3ZRO1uV6k6f7yK/18weMqUsqXapm11lvcJKoWWHfsM4ubmzmVpnN/KNdTFSv2qLQyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub3rImrBq1nBdj+mbV83jtxn924yx1GVr+8ODq036U8=;
 b=UnLzb5gPyXMwL6e10d7JwdjZR7iq4kc19p8mc5/E9YyNaY+iw4/fQ7u3iN7Vr6onJn0b12Wu2lhivWvmL+6cuP1Pe7hQZboVjreYjr53W3qkWPyh95K6FfbX5HsxS0CiC70CJLBOEJGMUMAeawDEUcHDRAitwri4H47O1RcyeEI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11391.jpnprd01.prod.outlook.com (2603:1096:604:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 13:56:25 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 13:56:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, Minh Le <minh.le.aj@renesas.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Topic: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Index: AQHcE0pKZp7DWIl5uU6P5IZbLCRQZ7Ruq/zQgAAth8CAGo7mAIAAAFiw
Date: Mon, 8 Sep 2025 13:56:24 +0000
Message-ID:
 <TY3PR01MB1134626F5A623880365AFF246860CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB113463B58C2110A8BC108072A863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113463800F4EBB1762FE96DBF863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXJpJ7YOUJo1O9JqrQyevf=gZsFTbU9DZG8feHonuJ4LQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXJpJ7YOUJo1O9JqrQyevf=gZsFTbU9DZG8feHonuJ4LQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11391:EE_
x-ms-office365-filtering-correlation-id: f7cf981d-cfac-4542-f8ad-08ddeedf7fdf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tk9NRW9kNzZkQUpRcDd6UGpVMlBnZGpSQW9XMTZpSDdCSDQ0bFREUGhpSUZa?=
 =?utf-8?B?TEJnN1BUcGgzbFJEaHNDaStSbjZBOVpZMU5uSlMxaUFGbjdiZmp2cUw4SlAz?=
 =?utf-8?B?RnU4RXdHQURjYVJrUURtWGlZRTViT0hjUVV4ZGhsUTlyWG1oNzRqT2x6TFY0?=
 =?utf-8?B?VU1aU2V2NWdrNi9FQWZ5d1NaOE5Xbi81bWx1aWpzS2Q2aUtQdzl4V2VROHgr?=
 =?utf-8?B?Zlp5dVROSm1vdE1qVy9wSVNZb0RNdTRaMEFsV0dBODV2MFZTOFB1NU4rUkZK?=
 =?utf-8?B?SGszTFNkL0NBL0drYjJFSElRL1ptZ0xIbGJVWFZCOC9rcjI0V0M0ZkJJdGI5?=
 =?utf-8?B?V0NCOGgyMUJTK1QyZVAydTJDN3pZcm1PcW42eE1vQXNsZDNJSFlGU1RJejhZ?=
 =?utf-8?B?SytMUjg3RkYxeWNxZHRQREFPaWlKbm1xdkQ4NlQxZ0hzeEVKNEh1Q2FyOWU3?=
 =?utf-8?B?MEdKNDVUVDk2S2VRdW9JUjNwM2U1Wk9jTFBkWTN3bDYxZldsdERNbXpNN1FV?=
 =?utf-8?B?NTNPTW4rN2RBajNZY2ZSSzl3Sk9jSGYxNGNJYWxXUFNsajdlVTJTbjIwd2Uv?=
 =?utf-8?B?eG5CbVlQdmk4U3hoRVdhUzFDVkpZM2NMa2hyeVhxY0JIWXd0Ui9YdGFFZVhD?=
 =?utf-8?B?MmNCbGpraUpJenZnSlZiTDdDYUt6VkVORWhKdTJwaEtSUno1UjBTS2xQSVhw?=
 =?utf-8?B?cmZ3QmFGTWdDaGxEWkxqMXpIdkQyYy8yMXc5Y2M4c2NFSUVPZHh2My9BZ20z?=
 =?utf-8?B?OUpCUFVKL2NtRlZqU1Y3RCtKa1ZiMnhpOElzMzlDYVNPNHVIaVgwTVVXcFZt?=
 =?utf-8?B?QThKTzJwa2s2RmRXZUtJS09PaGRzRUx4L3NnWVZvRG1OU2RubExaMFFlSWUx?=
 =?utf-8?B?RHZOUlkvOGx2dDhQVW40N1RxZzF4ZXVmTG9hZ2pEY3Y1T1orUTZldDNOWEUr?=
 =?utf-8?B?NldyUWszV3RSeitRME0raVhsaXQybFZPNFVQYUw0a1RKemRRMXhvWjhRSFJm?=
 =?utf-8?B?STlTL2FwdkxYSEliWjRmdGV0V0JVQWNvREVHVStWREllUjVHMkY5KzZ6VnBi?=
 =?utf-8?B?c056c2Y2OXVLdUs4TWFublJ6UkFEbnRTYWFsQzM3ajV0NVRIZjhkS0tScUpV?=
 =?utf-8?B?bGRFcDlTL1AwNVhhMXdxWVRuSEt3a25tdGpQWHlXclR4QkFNSkVqM1FBYzBa?=
 =?utf-8?B?UVFmVDRvSEMxQUp2WGdCNXZPNTlWWkpTUmkwVCs4cXJBQ2FCU3lMdG9Hbjky?=
 =?utf-8?B?MFJBM1JCNnl1dzRqS21keld1Si8rWlZ4ZTZnZXI1UnlhbUYzOTNOK2czQ1hy?=
 =?utf-8?B?anZzK3NTa0RXeU1QMStHUHdGbU9zc2k0VVVjSjVublQxelllR0JTeXQ2eGtW?=
 =?utf-8?B?N1VUZ3k2NXlkUkFmV3FrUnplckJ4UFgzQWVEaGI3aGxqVDBSbGNhNUgxa3V6?=
 =?utf-8?B?MC8xYzkwQVVFNjJ2MEZUOWF0NFJsU2p6SzNSa2NNLzlLckhaa2Z3UUxtL0pw?=
 =?utf-8?B?cnVSdk9LVnlsbGQ1R0JNVkVYZ05WWkZqQlZEZVcxejZWM2NVKzBQMEkwUWZa?=
 =?utf-8?B?L29Zc25hYVhQZjlkYnNPbEVFVHNHSmErdnpoU3U2YnVLUmt2dE1TSExTUDk1?=
 =?utf-8?B?S2k4anU4Yk1paXlkSSsrOW5TaSsxcWx5SU4yTzhaZ1B5MExuYkM1Y1hWSmZL?=
 =?utf-8?B?SmhMYjArL0ZZU1I5VWpveHBpdkVBak1xOU1NR2UwbW4rMkdsZUxBY09leWhN?=
 =?utf-8?B?ZDc0REkveTFkUVV0QjJaWVYzL1V1b25VUm4ya0Mvc1Rvek1idU9zZVJLQ0FG?=
 =?utf-8?B?WVV1WUdaUEoxOXVpOExvR0xOV2xzN01aUzBOd3VnSjNjYzNucllWYzc2MnZa?=
 =?utf-8?B?UUZRRnFrQWlaemY4OXNvZ1d5NXRzMGlFMS9aZTl0a1UrRVB0STg3bXNnYnd0?=
 =?utf-8?B?dk5Yc1IwMy8zMFpxL2pyWjZtQnFJaWRRZzc2d1ZyN3B0YVVOaXJIdGQ0YU9s?=
 =?utf-8?B?WmZhWUVObVRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RG1CcENjWGxySGhXSWhranA1RFZoQW1IVzR2cTk5UU8rTms2c0huVEpnTWtY?=
 =?utf-8?B?TmRHNTdjT3VhaDlidWkzL2lUQU5LbWNDMlBHMklSM2RIa0wvbFJ5czFQaHVt?=
 =?utf-8?B?Q3RuVDQwdUdxVEU0WTNSeHFRUEJkcWpLemx6a2xtTG8zeGpKUTlmaEJmYlFr?=
 =?utf-8?B?eExZd0VCRUYxbE5yZGU3YWk0S1RyQ05uWTBxSWx6VzQ2ZFl2MGpzOTZOMGRq?=
 =?utf-8?B?WThDRXB1bDZad0h2YUhhN2FzL3RSMmlZSGtBU0RJZkZDdXNzeDNmOHc3S2Ru?=
 =?utf-8?B?amJhdXpoSzVkRFppVEd3RWcyTUFIZEhQazVIWDdpY2FuM0RFUnpmTmxoU3RO?=
 =?utf-8?B?ZExMZ0c3enAwaEowRVFaOExIWVlmMktRWjQ3U09qQVZVOFJkdFZOVWNxQ3N5?=
 =?utf-8?B?STFpeE5xN0dYU0FyT2h1aWk5K09PeGpaeTRmdFA0MFFEanF5WXNHMjIvTHVa?=
 =?utf-8?B?Y0lnMCtQOHJqRFlrcW91bzF5bGdSYjhoNXVUazdaNXZKRkxQV2ZIKys5bWJi?=
 =?utf-8?B?ZFgzSkVwTlovYWVvaHVLZVRsdDR1b3hMWmJRdlhhZWZqQ1ppN0FLMlBCTDcy?=
 =?utf-8?B?VTlXcjhUZ091ZU40bFN6bVZYSXp0V2VMaGpiZzFlZHBFYzFzeTF4cjFkTFNs?=
 =?utf-8?B?L0oyK2tYMjJpM2JtY1BLNWlQbm1zNDlvMG15RHhOZmlxWXhRU3VwcEZJejVj?=
 =?utf-8?B?MUFXUEF2M1VadUZUekt2cnpyREdaNkNPekIvbnkvVkVnY3YzUW5YTjdYTmFY?=
 =?utf-8?B?RmRIM0NSZWUrRDZCM21nTFA2U29acWJTM3hOQ1NOeklMN1FBcHBqZWlTSkI2?=
 =?utf-8?B?czNJTmNOMjZXejNUZ21sOFJQZkxSdW5reGlEN0tNUFhZS2d3Yis0bHlQSWJr?=
 =?utf-8?B?YWs2ajU3VGpmVG5FTkpGNUhqcmlyeUo3NVN4dVBxY1RJNVZ3YThTcFNBbE5P?=
 =?utf-8?B?N05xRmxtOEZxYTJnUTRpRk0waTExN2ZRc1RuSHBDbGRIN1BET2oxaCs5OGlJ?=
 =?utf-8?B?NWdyMUcyNzA1Z3UzT2JnU1ZJU01ZZ1RNK0s5M05oWWtnTkNEbDA4dWJ0blk3?=
 =?utf-8?B?a2hYbTMrbEluN0JERGhJRGh4aWl5aWtEUUNKZktIQ21hN2NZeWRpNU1uZ0lm?=
 =?utf-8?B?cFdmSWlPUnVtQkY0czN1Y0VWUjZwb3J2VUZGdm9UK0VYQjZZQ0N3M2VTTmVs?=
 =?utf-8?B?MDYzb1dkaXB6WG9FWW5ycURKQ05WdFpYZnhFK1NNSGoyTmdZa0k4anNpeVVi?=
 =?utf-8?B?T3REY3o4WEx5SnliZ08wNDhlSURZOHJjTDhUL3VNNzdsbmZEM1gzaXVoZ3BP?=
 =?utf-8?B?WFpqLzFvbS9WNGZnbHhDclBVQ3EvV1g4cDNXTCtDMFJSMWUvdDBJUUtLRmQ1?=
 =?utf-8?B?Y3c0b1pQYjU0UFJzK05OK2R6ay9XOFZPdXB3TjFpbnJtb00vRnlaZlo4cStI?=
 =?utf-8?B?MTVmeFFYZkxMaHJyOEk1U1RPamZTdXdPTU1ZSW9CL0FoMlVkQnVPOFBqWHFw?=
 =?utf-8?B?S0xqUUkyZDBVdEdiUWxoaEVyWWkzbytEYXdRNS96NFdKVVZwUXVUNnN4VlJm?=
 =?utf-8?B?YmNXRTBYcDJ4QXhYL2hRa2ZIQkxNd2hRdlVlN0RaNlpjZWZUTjh5cEExbHpo?=
 =?utf-8?B?eVVDdGsxVFdlWHZkaUllR0JlL2NQanoxcVkvdFIxNlA2USt1MG5LZGsweVcr?=
 =?utf-8?B?V0lZWHVEa0ZXL3g4VWhKY3kxOWYzRGtaUVI2dDg0bWw0cTFxYnZ0eE15RzB4?=
 =?utf-8?B?YStSdERqUE5FZDlKZDVYR3JIRTkvNEcrQzJ2S3g1eUxDaVc0QXlwdUNnR0VW?=
 =?utf-8?B?RStCZE40WERhTWZsNWYzcFlGam1XalJiWTFjV09nMUxka2hzT2hXQmZRK0xE?=
 =?utf-8?B?WWQ1UmtRSVBzNnRKcWRXRHh1M0V1T1ZYSTFHTDg1bklkWk84TXRIazFSWmVQ?=
 =?utf-8?B?Z0tmcTRHV1J6MU5hbzVHL3hDS3NiMmV3L1E1dXllOXo5b0tnMytLRXgvcVZF?=
 =?utf-8?B?ZzF1RkdTUkc0SWIzcEVaZ1g1M0N2WDFuUGxtZWRTNzY4NHNLVEtRRUVjTCtj?=
 =?utf-8?B?enp6WEtFd3BDRU9BdmcvT0VTdG5oSGw3dk5paG44am8zeTMvRTRxSHFZclZs?=
 =?utf-8?B?NWhya3hocjZ2T0FlZmNaYmZuR1lOWjkvR0dVVmI4cTBNbDkzTmNPYUovTzBF?=
 =?utf-8?B?a3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cf981d-cfac-4542-f8ad-08ddeedf7fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 13:56:24.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hz2+PGQoy7cm3q1IAdLDzRKBM7P1TUVEXZ2Fcek2CzFlrwDRCmPMv6/HsD+pQXhncOqOtbBSSu9vVNlE4ZGaicFiYp7rucw3hy5y6uVLgzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11391

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsu
b3JnPg0KPiBTZW50OiAwOCBTZXB0ZW1iZXIgMjAyNSAxNDo1MA0KPiBTdWJqZWN0OiBSZTogW1BB
VENIL1JGQyA2LzZdIGNhbjogcmNhcl9jYW5mZDogQWRkIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQN
Cj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBGcmksIDIyIEF1ZyAyMDI1IGF0IDE4OjE5LCBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogQmlq
dSBEYXMNCj4gPiA+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGds
aWRlci5iZT4NCj4gPiA+ID4gU2VudDogMjIgQXVndXN0IDIwMjUgMTA6NTENCj4gPiA+ID4gVG86
IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+OyBWaW5jZW50IE1haWxob2wN
Cj4gPiA+ID4gPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPjsgQmlqdSBEYXMNCj4gPiA+ID4g
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiBDYzogbGludXgtY2FuQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+ID4gPiBTdWJq
ZWN0OiBbUEFUQ0gvUkZDIDYvNl0gY2FuOiByY2FyX2NhbmZkOiBBZGQgc3VzcGVuZC9yZXN1bWUN
Cj4gPiA+ID4gc3VwcG9ydA0KPiA+ID4gPg0KPiA+ID4gPiBPbiBSLUNhciBHZW4zIHVzaW5nIFBT
Q0ksIHMycmFtIHBvd2VycyBkb3duIHRoZSBTb0MuICBBZnRlcg0KPiA+ID4gPiByZXN1bWUsIHRo
ZSBDQU4tRkQgaW50ZXJmYWNlIG5vIGxvbmdlciB3b3Jrcy4gIFRyeWluZyB0byBicmluZyBpdCB1
cCBhZ2FpbiBmYWlsczoNCj4gPiA+ID4NCj4gPiA+ID4gICAgICMgaXAgbGluayBzZXQgY2FuMCB1
cA0KPiA+ID4gPiAgICAgUlRORVRMSU5LIGFuc3dlcnM6IENvbm5lY3Rpb24gdGltZWQgb3V0DQo+
ID4gPiA+DQo+ID4gPiA+ICAgICAjIGRtZXNnDQo+ID4gPiA+ICAgICAuLi4NCj4gPiA+ID4gICAg
IGNoYW5uZWwgMCBjb21tdW5pY2F0aW9uIHN0YXRlIGZhaWxlZA0KPiA+ID4gPg0KPiA+ID4gPiBG
aXggdGhpcyBieSBwb3B1bGF0aW5nIHRoZSAoY3VycmVudGx5IGVtcHR5KSBzdXNwZW5kIGFuZCBy
ZXN1bWUNCj4gPiA+ID4gY2FsbGJhY2tzLCB0byBzdG9wL3N0YXJ0IHRoZSBpbmRpdmlkdWFsIENB
Ti1GRCBjaGFubmVscywgYW5kIChkZSlpbml0aWFsaXplIHRoZSBDQU4tRkQNCj4gY29udHJvbGxl
ci4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxn
ZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IFdoaWxlIHRoaXMg
Zml4ZXMgQ0FOLUZEIGFmdGVyIHJlc3VtZSBmcm9tIHMycmFtIG9uIFItQ2FyIEUzDQo+ID4gPiA+
IChFYmlzdS00RCksIGl0IGRvZXMgaW50cm9kdWNlIGEgcmVncmVzc2lvbiBvbiBSLUNhciBWNEgg
KFdoaXRlIEhhd2spOg0KPiA+ID4gPiBhZnRlciByZXN1bWUgZnJvbSBzMmlkbGUgKFdoaXRlIEhh
d2sgZG9lcyBub3Qgc3VwcG9ydCBzMnJhbSksIENBTg0KPiA+ID4gPiBmcmFtZXMgc2VudCBieSBv
dGhlciBkZXZpY2VzIGFyZSBubw0KPiA+ID4gbG9uZ2VyIHJlY2VpdmVkLCBhbmQgdGhlIG90aGVy
IHNpZGUgc29tZXRpbWVzIHJlcG9ydHMgYSAiYnVzLW9mZiIuDQo+ID4gPiA+DQo+ID4gPiA+IEhv
d2V2ZXIsIHRoZSB1bmRlcmx5aW5nIGlzc3VlIGlzIHByZS1leGlzdGluZywgYW5kIGNhbiBiZQ0K
PiA+ID4gPiByZXByb2R1Y2VkIHdpdGhvdXQgdGhpcyBwYXRjaDogdGhlIENBTi1GRCBjb250cm9s
bGVyIGZhaWxzIGluIHRoZQ0KPiA+ID4gPiBzYW1lIHdheSBhZnRlciBkcml2ZXIgdW5iaW5kL3Jl
YmluZC4gIFNvIHNvbWV0aGluZyBtdXN0IGJlIG1pc3NpbmcNCj4gPiA+ID4gaW4gdGhlIChkZSlp
bml0aWFsaXphdGlvbiBzZXF1ZW5jZSBmb3IgdGhlIFItQ2FyDQo+ID4gPiBHZW40IENBTi1GRCBy
ZWdpc3RlciBsYXlvdXQuDQo+ID4gPiA+IE5vdGUgdGhhdCBpdCBrZWVwcyBvbiB3b3JraW5nIGFm
dGVyIGlmZG93bi9pZnVwLCB3aGljaCBkb2VzIG5vdCByZWluaXRpYWxpemUgdGhlIGZ1bGwgY29u
dHJvbGxlci4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2Fy
X2NhbmZkLmMgfCA1Mw0KPiANCj4gPiBTVFIgaXMgbm93IHdvcmtpbmcgb24gRzNFIGJhc2VkIG9u
IEJTUCBjb2RlIHdpdGggdGhlIGZvbGxvd2luZw0KPiA+IG1vZGlmaWNhdGlvbnNbMV0NCj4gDQo+
IFRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMhDQo+IFVuZm9ydHVuYXRlbHkgeW91ciBjaGFu
Z2VzIGRvIG5vdCBmaXggczJpZGxlIG9uIFItQ2FyIFY0SC4NCg0KSXMgImJ1cy1vZmYiIGlzc3Vl
IHJlbGF0ZWQgdG8gY2FuIHRyYW5zY2VpdmVyLCBNYXliZSBhZnRlciBzMmlkbGUgdHJhbnNjZWl2
ZXIgbWF5IGJlIGRvd24/DQoNCkNoZWVycywNCkJpanUNCg0K

