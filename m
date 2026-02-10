Return-Path: <linux-can+bounces-6534-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGOWBQdEi2mfRwAAu9opvQ
	(envelope-from <linux-can+bounces-6534-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 15:43:19 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2311C033
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 15:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFDD13019F0F
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED5C3803C2;
	Tue, 10 Feb 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="IV/muIox"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022112.outbound.protection.outlook.com [52.101.66.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091716F2F2;
	Tue, 10 Feb 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734534; cv=fail; b=ZnoAIp8w5Uo8qCnbdCh6iezp+ZTL4tN/yaMJAjGRwPhoM2thfo6njz2HUbYnxNPdNTo3jUkHw9ZElSrFQf3AqJA98yA4GBGCivYxiUwsNq77BSWdEXQE8hlY+JGV4eZ3rdYKYfwS7AkxIOgcOFYtq7lykSzGeoCSRsmpoLFLAyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734534; c=relaxed/simple;
	bh=PN/l9gqTIOQ7qDr3vzykRLgkf7C8OSGeOE3+KIUAqGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lk6lLt83i4mU8FwsrGZrz8rVhRFyhArRtGZWflIf8xp5UITpMFxwzbUFhp1azUgOiUPTHDd55dIdEAk06XK0VN/GGP7zsP2UQJiu4CS7TCiKacTHIZysOjm20/IkgjrRI+zFDoAdq++9hae/oOHdMH2kQEhhifPk0rgWXGafWj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=IV/muIox; arc=fail smtp.client-ip=52.101.66.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5WNnIhwJ2MjgbF2FaEPP5nOTAtAVjb4XIIPw6R6x0NnEbYsq+B+0KSH7VK5shC6fLhWO/Up3zQvX7IYNgTrP3CqOZ0TD0Z8Uv6AA41jog08HY5DzOyZgaAPGlNRxzHM8H9QIeG8oPMQGj6aisEIF8b6iio4LZa9SsDvz0fBoXIS+Xh4AUV9rohY4VMYw/toNM4O4lCScEkkl86YKzzIoF1l0ZD6M8K8t5ZofdT/Rm353pOuc/YYKU0VhVoZTEDbSMcIeXT8Eka61aygHxjKuUJCxeWQo+oacoFo+QHHteWag6Ey/XhI+g+hrNBauZqpnThtVM94bve0xQ4pMqoCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN/l9gqTIOQ7qDr3vzykRLgkf7C8OSGeOE3+KIUAqGY=;
 b=RO7/8jWMPdXiJCqjjyK6IxeySLNcfIAbiT+Ix6/9UDaLD1yajBd60BYoZuAiXuSizLOTznV0w0xvqngdqaV3eiNxtLVnZGctPnxlmQlAMoopm3HH67Nvoo6ZJWIN8l1DJmrJJfTu+E5JhbNoTy0xvqLT6KJ+16VJjqlX8ifvDCgb8FfNrI5OnexnUkUYL+r1lTnD+ILECsLHc2YGeZ3ofkCNSIxja2efHMe6oz5gIjMNxg0ysdjFJRoTiQzqTv7y64mfQiUVt5o2ktX7sjO80j29/T3Vm7WyAJfL2eWAsVch9xRWeCDbnuiwFtU1+vxG4CCNOwBoND3utzpgr0hBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN/l9gqTIOQ7qDr3vzykRLgkf7C8OSGeOE3+KIUAqGY=;
 b=IV/muIoxTsUY3I2DXFP3wjWL970nxz38xlCrPdPgW+ghRWLKl8gWAh6hDAZZpNWkEj73zn6HXhGr7Hs4iQNwQQdaDeAjk4U+kuG358D80wMOt4spDWXAVcvSpt6s/FyXZPF6zyeQvunqCECWMt4PdhZMDZNsTPSnJGGc6UejuCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by AS8PR02MB10171.eurprd02.prod.outlook.com (2603:10a6:20b:628::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:42:09 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 14:42:09 +0000
Message-ID: <d1cdbe29-ef1e-bc82-8ac9-1716cc8bddd2@axentia.se>
Date: Tue, 10 Feb 2026 15:42:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Content-Language: sv-SE
To: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
 <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
 <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com>
 <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
 <9d7bda92-e520-466a-a0be-d01686af1d56@solid-run.com>
 <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
 <de20903c-cae3-4f2e-8784-5b04421fdf4e@solid-run.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <de20903c-cae3-4f2e-8784-5b04421fdf4e@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::6) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|AS8PR02MB10171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3456d8-b287-48a0-b474-08de68b29183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHN3NUMyeEJYaDZpelVMWEdQTjlWSVBYUGxneXVaTVYzWVNKaTFpaWttajZr?=
 =?utf-8?B?SzFOZk9NZUhyeXk4cWxoMGJseGpTaU9rdFpISlA0OGMrZThMbm9sL25acm9x?=
 =?utf-8?B?bGdSUzVSY1JNQ0xtM005bGRQZ2Z4aUVLY1lHTkRpb0E3L1B2T2JyMG4veDRU?=
 =?utf-8?B?N0NjakVVUGdEY2dKRk5KcGpVaDhqMkRTSGtRVDRYMlYrenNad21tVXpYNVVo?=
 =?utf-8?B?MTJqaVdLR0JxblFHOEp6MW0xQy9kSDBrdUh6TjBmUmFndnpaMUcwUXdoNUhr?=
 =?utf-8?B?ZmFHZXd4Y1E1K1ZXZnB3eEVNS2pGMDJ0eGpBbGJuQkg2RzZleU96R2R1elVE?=
 =?utf-8?B?akdzTFdPakxXdXNGSzJnVkN1VTBhRm55NTRiWm01bTc1YTNUSlZNZm14RVFn?=
 =?utf-8?B?ZmdSbXBRT0dCRXpJZWFzUEJKS3ZkaWVBOFYvWHpaU2E2b09waElkSzEyaTlC?=
 =?utf-8?B?WU1EekV6K1JOT0ZEcE9HKzBIN1V4RGErd0tJM1Z0YUlMWEF1bGIydTZRaHRa?=
 =?utf-8?B?c1Q3OFNiTm9OVWk3Mk51QUhLREJzKzh5V2VRay9pNCtncHNrNldWT2dpN3pw?=
 =?utf-8?B?OVZEUkhVREo4WmVyeDQ0OVcxWnM4Q0ZpbVMrMmM2dEhYVy8xK09qK3RzRFVu?=
 =?utf-8?B?VzNlQTkveTByMEEvdGFncDkwVGoyRmhBbDNQbHFlMHhidjRsckRUREJUU1h4?=
 =?utf-8?B?VURNU0c0cTJlY25iRitXcjB1Mk5VMHh0dTRpeS9IRjJ4VUhHYmk5SVNLTTdw?=
 =?utf-8?B?K3dJREJFeDA2bHhPRUpSTDlPM09hNW9GWmliaEtsMlhjQkYrWWlXSFVZWDNv?=
 =?utf-8?B?Vnh4RlpEdm9oKy80a3E3TCtPSkR5enJyMnptYkNaMUpDWW9TcUxOakJFM1hV?=
 =?utf-8?B?RHhXS2pOb1pzT0MwWU9NMFBRRkRDM2ZMc1pOWkZUNU5FZVc0RzVEazlqMFVJ?=
 =?utf-8?B?TGpkRWlKN2d4U0FCQy9lTjFJK3phcmZ0Wk9kMklFZ0Qza05BekpvOXZZSEIz?=
 =?utf-8?B?ZVo3VTdtaHJQVWlaTW50S2NHTEhkaGo2N3M2cmdqeGxSZlc3MDRKUlVaNHg4?=
 =?utf-8?B?dmlVNXd4eG1jblp5ZnJLWWZnMUttOC9KcDNTYUdHblkwbWN3NzkyNE9kSzFQ?=
 =?utf-8?B?MGVJeWxSR3pzQmt6S3lGbTkrZDBaV2t6cVkxMk52cmdMZWxSVHdhN3BNZE85?=
 =?utf-8?B?L0VzeHZHano1cHZ5RzJ4KytDSkpneFdsOHRlRitHV3RTdFUwaW14RnZhUFZO?=
 =?utf-8?B?cWIxbHdhbkdJZisycTZYeXN4UGMzQXd5bXFObGlmWjVqZG1wSnlSdmp2QlMx?=
 =?utf-8?B?ZzNsN2JIRXZLTlE1K3JDMXF1SlZ0cGZzcWk4U0wwNU85ZjQ3K3FhcEI5RmR0?=
 =?utf-8?B?eTJ0S1c2TnlFWGhJb3VadWFkNWxUWUhZNHd4amVERmpFZ1hhbE00Rko4cWhG?=
 =?utf-8?B?SUdWcHZlSFlVTkV5eDFSc3l3Zk5BbitoSkJWS3lzZDUyY0JYNy9TeHdVTnpS?=
 =?utf-8?B?czd1Z1YyeHpDdHh4S0JYUzlqYytKcFE2S0srVTJBRTJTc25Pd0RLWmxWZnZk?=
 =?utf-8?B?Zkg5cThFNHFtaGg5bXUxb0lyTUNOTTBZeDAvNkhMaDJrWGIxN3FUN3NNVGJY?=
 =?utf-8?B?RW9CRFZuUlAxaDQ2RU1HZGRaZFZJdlV0RkJmcFY4MjJ4NHhPaWRsbUY4bC9i?=
 =?utf-8?B?M3NieEtxZVZDL3dzcFhtb1hVREQ4cVVjeGpMZWMxQzdLV2VrRGdpMUlCODJP?=
 =?utf-8?B?S3pNWTV4UkVlT0ttS1NNOEJTekdtcms3eklLNjlUQTFJZThLdTZ1TEkydXJF?=
 =?utf-8?B?Mk1KTW91Sm55QnhjbmNsbW9DbGU0RVhEdGIxbThybTZxQ0tzaGp5UTkzR3hl?=
 =?utf-8?B?TTBHOEZKTnZRenJZUWcvbVpVekdoZHcrK2dMUVZPU2k2WSswUzhwcWtEMmJ0?=
 =?utf-8?B?UGVyZTF0Uys1c0l2dThFUkVHbHRHM0pQSk5mbW5vUnR0ZWo2eXJrQWVXVDRp?=
 =?utf-8?B?L2FESUdGQkJERUZuOGkzT1BPajFMbHB5cnVNblE1SkkwR2dWVGVXVHhQVHJS?=
 =?utf-8?B?dUdFYnRMYXJqMkVjUndPZlJlQi9yemllTlB3cnBuQ08yVzh4QkpzWlJINjk0?=
 =?utf-8?B?dzZvVjJsMng1YjlPWkRuRWJFSnFyQkZCdGxseXN0Z1Jnbm1tVnJxV0N5WTFz?=
 =?utf-8?B?dXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVZGZjRHaWZ1aVBMNVZDZnJJLy9KcVBvZWNjOC9LNEovWWNvUUlTK1ltZTJl?=
 =?utf-8?B?SVA0UHVFZGlvMmNra0hsdTZ6aEVzaTB2RkNwRWhjUGk5bzlxNWpqakVyaUJG?=
 =?utf-8?B?WFBIMUhlejJkR2ttdjgxektGQVhpc1FRQ3cxbnhGc2NXN3VuS082ZS9aQjJM?=
 =?utf-8?B?bUV6OTVSclJDaExVaXdod2Npa3BsQmdLa2NMeWozUzhEVkEyZGNvVitqQW42?=
 =?utf-8?B?M29QNUFLVG82WkU4dzdDd1lBRTRYRHFQWHY1RkkzQXlkMkFnTTBUelZta1F0?=
 =?utf-8?B?anVBR1dhQXdoL3JtbW1YNHpVRlI0NTNHNHgyRCtEL3NKMWhLWmpmWUVmSGs1?=
 =?utf-8?B?VTlxL3c3emxQc3VGM091Y2Z0ZXpkQUJXSFJldUNqQWx1Z1RvR1MxanVnMm1D?=
 =?utf-8?B?dndkWmpJSUNnQS9NQWVuMEhXMW1Ua2YyNXlkWm94SWcxcDZLY2pQSkNVZ2hm?=
 =?utf-8?B?SFZXZjg5KzE3dDArTDNTSmRKRWRVQWFtUmJMejNiaW5UWHhmTFg5ZGU4VXB4?=
 =?utf-8?B?MDhXd0RYOVRBUDFlK0N1YWJDR3VlY1FzMThTc1FRLzdRWi8zVDFvYmw2UnNs?=
 =?utf-8?B?OEU5UldIU0t4dms2UjcxbTkveGtNVlZTZ3FNUGtIUVNZY0FNTy9uZWdnSnc3?=
 =?utf-8?B?OG5jV2FNb0xNc3J2OGRrYlVVUFVPSWNKNXpSMU93cTZiMGRvVVgwQ1IxdENn?=
 =?utf-8?B?U0YwdkdGem5wZ2FQZVNPbkJKYlVCYytuT0Y2eUhlSU5GdkRxeVg0cnVQcnc5?=
 =?utf-8?B?a0NPWGJtNkVzSXNNTEJSY2dMNHg1UmFDT0o0NFVMamR5OER4N1c5STlNU2JC?=
 =?utf-8?B?YmJyMkg4ZXlYZEhJQ09qbDZOd255TEs4T1hJcDA3YVVTbUd1ekhQR1g3Z292?=
 =?utf-8?B?cENLc3JDSXFydmRkTWRkRjBNM3VjSWYzN29yNkFBZ2ZXM2hvZ2xwdUJ2T2dS?=
 =?utf-8?B?N3dWa0tSWHVnN0VXZnZoU1Y5UklWRkF3QmtFdENHYnp2anVtaDVUbnB0ZkFl?=
 =?utf-8?B?bHR2UVo5d29oS2tiVjNMU05SSVp0TnNVMkcvY3FDVU1kUlBVMGZaS1pZNmVH?=
 =?utf-8?B?SCtRM0FtekJPa01KaHFiemdpVXhvKzJ2NWFWeC9YRG1CdStwNVFreE9lb1k2?=
 =?utf-8?B?bmdYekQ5WG43NWxrVVR6aUFtUUM1bUdyWndIV0VUang1QzZjYlVHZG1IMWRF?=
 =?utf-8?B?U04xMUFTcXFmK3oxRy9hNmtud25zcXNWNWl1NTA0UDBlcE9BTFo4a0RGQzha?=
 =?utf-8?B?Y2F4RVViYVFjNFNyWDdoVnlGYWtpYTh3L29VYkt2akFncEg2dVdLTzNYaGtT?=
 =?utf-8?B?cE4xTWNvZGZjRUdoZ2RuM1VNVDZUYjNWUzB1dkw2WTl2UUFKWUJ3dUJqVFhl?=
 =?utf-8?B?YnUvRlY3RXZKbXdZN2RxSG1Kd1RZaUJVN0pCanB1TUtiZ1MraDBYZ2hodXFK?=
 =?utf-8?B?QmtnNW1QV0c1aUhYUDFGTVpwdXhzV0JINlNZbU1wVDdaaE5hRHphN3YxYW1E?=
 =?utf-8?B?Z3YxVlNJMFRpcHpvd3NTaC9Vbm01VlBPRDdwZTZFbTVSVEhEQWtoZlhKNWtU?=
 =?utf-8?B?TTg5cXpGa1lFNU96d3IyL0p4WWNGaTdEdW5mem1hZnp5S3ZBcUVJVU5KMkJX?=
 =?utf-8?B?Si8yNFRtUGRQMDl5OFhBWjBBdi90MzdnWWNybDhtWDNIVzhwVmNRaDhHdC9Q?=
 =?utf-8?B?R3BlbGlCUHNPTUt6RmtPQUJQMzhBcWFYZXVUUlZkZW9VRzhwa2JXekUyUXcx?=
 =?utf-8?B?U0ZQVkx4R1JzZWZFZFlOYkN6UzVibGhGVGRqZkFSc01NYUZwR0RSRkc1MjZr?=
 =?utf-8?B?NW01c1ppVlhUOVJFbE9Qck00MXNpRVhoNnNMSXVsdkYrOWJVTHU2K3BjaVJv?=
 =?utf-8?B?OU1oeGFJWWRlMmdLc3RtMlVZMVVhSCtNald1MWxuTGRpOStTTnkrRlNwMGcv?=
 =?utf-8?B?bFBJU2VTTVd4OStOT1g5dUZRU3A4d2ZBVXRFdE5FeDJyOEdvU0MxdWdnMk1y?=
 =?utf-8?B?cCtkQ05VRFJXRmhTbGdSMTZhbDEzTlIrT2F2eklNSGZLMzZldUdMckZOSXhu?=
 =?utf-8?B?UG9kcGJKNlZtZ2cyajUwR09OSzdydEVjRFBMUTVNYnBXdHZWRERjQ1pZaWlH?=
 =?utf-8?B?cHorTDA0VkVRTHlWeVZSd2FUL21nS05rQTl4dDBXY041cDF1YVkvWW1pMjZk?=
 =?utf-8?B?UjBXTThtaHcvS2xYV3VETTdEZWxQWU1mS0ZSRXF3R3VCTWMxZGxDczRMZGow?=
 =?utf-8?B?YjNyNmNaWnpUVzdrUEc5Kyt0cW5JTUJWYWtoK2hNZFBWNlFpYi8vOGplcTZW?=
 =?utf-8?Q?U0tFP2LM0ap9VD95du?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3456d8-b287-48a0-b474-08de68b29183
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:42:09.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq4eUdg5LtmIL13TH7WMkzCobN6Ka03PO935VjX0ka0uCPLge39rIFTXHmzOVXYE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axentia.se,none];
	R_DKIM_ALLOW(-0.20)[axentia.se:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6534-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peda@axentia.se,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axentia.se:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DB2311C033
X-Rspamd-Action: no action

Hi!

2026-02-09 at 21:02, Josua Mayer wrote:
> Any suggestion how to name the new config symbol that can have
> a visible prompt?

MULTIPLEXER_CORE perhaps? Or maybe just MUX_CORE?

Cheers,
Peter

