Return-Path: <linux-can+bounces-6520-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TxnPKE/YiWn3CQAAu9opvQ
	(envelope-from <linux-can+bounces-6520-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 13:51:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471B10F0A9
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 13:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E262300876F
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF536EAB6;
	Mon,  9 Feb 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="kAS48+zZ";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="kAS48+zZ"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022140.outbound.protection.outlook.com [52.101.66.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE0309F13;
	Mon,  9 Feb 2026 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.140
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636705; cv=fail; b=IFXIbcGHG5pLTJTrEU62nSXdgsNpzoCfCV2quS4b4b5XTbuhiDXW9GGQ68Ju+Rxcy+Y1Mn6wTH78oe5U2HK8mGPKjtJADwa+UAwUhdNJEfZDgTtRxgaxacnn2k60PFZB5indnrYeNHm60tr6ZmMvZ1getQ0tiv6vwvF0pdfpoxo=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636705; c=relaxed/simple;
	bh=FbstfXExQ22fn02QjEeBqkOqLdEEgZcxfX20JGmyXrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nb5iOSxXDdMxClwc5d0sRiNLwG2hxr5X1hq+VkjmXM15lqNcXX0KI1vGQuR/iPwkEjxe8PNtlfeL4ntSOgx/rcvtwE/wLYQSJgfglZTliBG7zYU2z6J6xpiETGzMk0Gwa7SGUkOSC4vyZs4SXNu54EzyGcDHEjgldiDW5SM9YMM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=kAS48+zZ; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=kAS48+zZ; arc=fail smtp.client-ip=52.101.66.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZqkiOWnnGr26ZgWqAEtMcodXN31CMr3i86an5iovrWV4gv2VjpkojM++5YYbklj9DYZOwoGNiFK4+q5LSd0ZpkCwBOxRJwefGUqPOOABY/kmb2FkSbJnILQhcdyUiaXOuiuCSrQjk/4DD+Tm4WaLsDwoCJuA/9YMbdXTdRVNgd705zdcODrN8sc+cd2i+FOG3xaa0C/w+WndMD6fxij78KACkykNGRas6iYY5w7ESScopqDVGRsG7YjIuNEyhMEqdtIUnwKvr9NVPBanZp6UQ/maOHR02e/jqeYYGFLALRnMDTbVE3hj31cH5DZJdQGAS8U/fWhywH1hmR9F9R83Og==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbstfXExQ22fn02QjEeBqkOqLdEEgZcxfX20JGmyXrk=;
 b=N4aRdjWHkubt+IR2R0t/8vzZ1fgknWNuTi4FZAe4iuJXgQpaGHiy/7nQP0ldYCR4muUSp82hrdYTL01MbVOFsOkzL/fR6+guBcnyLxkrmgMfcna74tq+8cZTXaaCIHDLNoYbsIEqAjfItoCR9HQGu3OZEezj0qknnxjXU0td4esME3WYWW2OBwXzwQSrF9ZNlYaaS3oyBVQJBvTloeE8qVxjvPZWFvNQC64M0SbrgVZtWmHzJ4TL/xG1Kgk2589gKgW7wzlCoOAuzlT01QkFcgK81FOhFwG4rhqhnBrOlB9oWzOiQxEmWc18AvTOk2SsNnyzxu0jz4y4d6MTLDuo3g==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbstfXExQ22fn02QjEeBqkOqLdEEgZcxfX20JGmyXrk=;
 b=kAS48+zZ/dAUneAQe78DTxeGThwy5S5Ruv6lBpYmU4Afhvc3but/58ra0NfJKHjFpvAyMFhIXa9f7wkzq7n1rj+Tg6hJVXuUYMsXGtPN6Bo2mqLyplTSFDAkuKJaPMZWkUp/itJbEcfJ7OlicSqRtVEUq2tIQXVrvQwYKP1SuW8=
Received: from AM9P193CA0002.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::7)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 11:31:41 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::b5) by AM9P193CA0002.outlook.office365.com
 (2603:10a6:20b:21e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 11:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 11:31:40 +0000
Received: from emails-4008417-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-189.eu-west-1.compute.internal [10.20.6.189])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 5AD5F8032E;
	Mon,  9 Feb 2026 11:31:40 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770636700; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=FbstfXExQ22fn02QjEeBqkOqLdEEgZcxfX20JGmyXrk=;
 b=lIRPZYlE8cby4oQoLn8D75T1kKTfdI2iKgPnaB6QuXs1YEcysbNU4O8vqZv7d5oBlUhJ4
 eKEjCd2ZgL0VMkaKoUoSJQ9pEB/jF+DA9Jo/JxmHS8eTf92XvMO1W06h+t39PSeRPnedgZh
 ZirtqfRQKiyjAgW4C5N7dKWL1XpVM5c=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770636700;
 b=LXsJcJ9mRSDP3lZ9JC5wiMRWGYyHwFfpp4RrPFqcwU+1Vt2/Jth8gDPy9m70uShThO2C8
 4wCEG0uhIt6+HXE5l2QaKDFLmoNlFA0P8kf8IM6NxMTULDBY8W7fudKQgM7x2vUySAdO+qz
 IA/AUoecrdq4P/Jw/XImmqvezC1pGJM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBh9YJYZkbHPuMc/g11bU50kAAwtBkN4nGc2n3elN5gfPgzE5miVh0GaO4ZNbaIND0pAOZQiW8njUnOZTu91/c4ffWjJ0l984OI/e3UrOYiqwHlg30vo0rBLzDTNY7mOC+L5YhfLuq6TYAMzAzQ/GU0+a9O/HxvlV9LaP+dfqfnhcc5UYrbDC7lcgpO+zDhyUYh3Y0/wjnb4xepsM5Ax04cnbB493B3c+5n/0Dqq97Z8CoGAOtwVJQ4SLfyTbtFMw582TYT8ovTsT9aHo+jMg0yKQSVeoN3CeQWN34y4HqhNoORDJhITagxCKU52Aqjoshky+1xQG3+kJ6SOABKzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbstfXExQ22fn02QjEeBqkOqLdEEgZcxfX20JGmyXrk=;
 b=tJPAVjJIOrNtPyNDM1wlmyg+Krjc+fpilbqfwpeRSLw3okX9S8S/ZXDnIcWyfaHpdeDPXagbSnBDfZZDnVpcp/OngVQcc4ZL+9Ak9jZg3+6E3ecXA+d3bEbxbAeGAE9BbncPty/hygZy5jsxRwlEvhpQFHjQl9Xl/bpLm6OpMcvtS6lcG+itd92nS9TLt7iLjK66okEWPgt7MIdRxoesC+j8ltbvQB2qJF69BlaFbNhTcJSFLr1UZtWrNLVrEu7/7CPBiXJuKQzwKMxFGRtu+dC+ue7xqaA7WBTlzgXZn13eVL+zfIel7v1x5yiQDPXxipKG5FJOKLhgh3iiobjdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbstfXExQ22fn02QjEeBqkOqLdEEgZcxfX20JGmyXrk=;
 b=kAS48+zZ/dAUneAQe78DTxeGThwy5S5Ruv6lBpYmU4Afhvc3but/58ra0NfJKHjFpvAyMFhIXa9f7wkzq7n1rj+Tg6hJVXuUYMsXGtPN6Bo2mqLyplTSFDAkuKJaPMZWkUp/itJbEcfJ7OlicSqRtVEUq2tIQXVrvQwYKP1SuW8=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM9PR04MB8844.eurprd04.prod.outlook.com (2603:10a6:20b:40b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 11:31:31 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 11:31:31 +0000
From: Josua Mayer <josua@solid-run.com>
To: Peter Rosin <peda@axentia.se>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Janusz
 Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, Andi Shyti
	<andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Thread-Topic: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Thread-Index: AQHcmRESUG4499YSf0mIlO8cui8aobV6NzeAgAAF7AA=
Date: Mon, 9 Feb 2026 11:31:31 +0000
Message-ID: <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
 <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
In-Reply-To: <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AM9PR04MB8844:EE_|AM3PEPF00009BA0:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: cda0e617-d5bb-4e58-42ce-08de67cecb7e
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZEtxU0hPdnJaVHlQZThTTXVxQVR6d1lPdTE0K05PdDdldFFaOVVqZXc3MEpZ?=
 =?utf-8?B?cjNMRVdFZGdxK0RPQTV2dE9lNnVhRUhHbmFIckRSSnY5YUxXZU03Z2daL3Iw?=
 =?utf-8?B?UU11VlRtMms4TjZuTm9nb29ZM1hXOWRKSjBqSGlWTlNwNFRGZzV4V0N0dWFV?=
 =?utf-8?B?ZXp1SWl3WHRZRDlBTG51c0ZncTdFQUUzTkIwK1pCRlNPT2N0ZFVOT0tFZXNp?=
 =?utf-8?B?NHU5QzBBeHhMWkZKQkVtR3YwT0FGbm9PdVVnSnMwTTNYUzQ4N3QxQ3A0WXpN?=
 =?utf-8?B?bUIwVFp4MS94Q2RrMi9ROUx1T2IwK05Ma0RqNnQ3SVJQV1o0ekFWeGdMWEFC?=
 =?utf-8?B?bEhpOTQ0Rk5NdVU3cm5mRDJqQlBKeE12bUdad0pRL2ltcTYwMjNDWVVSVWNG?=
 =?utf-8?B?NENXaXNsdWxxQmJOL1c2dTZoZFRoVGVOOS8vRDhCN2hMcGUxaStKc3ZheHVG?=
 =?utf-8?B?TFROQVplVzBvMjRuUU1tSHMzT2NYRVRIQ0lyRjhsVEZUaXpLTkxOZ3V4bm9N?=
 =?utf-8?B?cW5zM3ljcDRqRFh3eCtObmd3MWxGK0Q3ajRxOXdKNTFRaVdYVWNZZjBCQWM1?=
 =?utf-8?B?L05vSzZEY2QxSHNTUTdNOXN0NVdkSFNQbzUvaWxaVUQwZUlkaG9POWd6djlQ?=
 =?utf-8?B?ZitZL0NWYXRqLy95b2hscEVBdVcrSk9nVWFlVGNXb0VoclVFMGhMVVJFQVV4?=
 =?utf-8?B?R1dIamNDSjZKY1ZkbGVhZXJmcTdnSDk1WkpqK1hzNkczUk80c0wvWDRSTWcw?=
 =?utf-8?B?b1FtQmFZSld2VEt5NlJYa1VNUVdBRDFiWUhFbWhPQUFnaHIwRlU4U1RzYXpJ?=
 =?utf-8?B?em9sWVVkdmtwdFhwaFhrd1J0ZmJZY2NOeHZvMWUvZkJJdW9ESGxlYkRrUE5I?=
 =?utf-8?B?SmV4U0J0ZUEzQ2JCNk55UWdrcjExSG1zb0hrek1yYWxFN1BudEt6b2hvRHNn?=
 =?utf-8?B?bTY3OVZqMERyUjhCNytqWUJYRFBpSGFYQ2d2RnU0c05iYTVkcWJNMkkvVE9u?=
 =?utf-8?B?THJINnpsOWtoOURzRDBYVTEvanJPMDJrbDVYYnZYOHdmMXFWRXVlOWZ0akJY?=
 =?utf-8?B?M0NNeWhkYWtFRFpuR1J0bitIcndLY0RoN2pzdTFGT1NYZ1BQZ2pHeTl2VGVo?=
 =?utf-8?B?bVBBWjYzQkhwZko1RWZKb1JHS2xyMTIvbXZhS3NnbS9VSC82bnFjWndNcUtm?=
 =?utf-8?B?T0xta0hSSXVldzRvSklGZ2NhREhLcEwzSjBiTEtpVGwyaE15azFRcHZMZXVy?=
 =?utf-8?B?S3VRdlZXUVF2MHYrbVBDZUE0aVhPOXpKQXZEb3FSdUlLMGo3QytSSk1yOTl2?=
 =?utf-8?B?NHFoU2x1OFhjajE5dDNvMWtmaS9yblpuQ0NYQXRsbUZsOFVxdnBhZVNnQUx4?=
 =?utf-8?B?RThmRTh5ak0yMkdvUW9LQThzcjR1azRkZTBadERKUDBubWtoU3c3RFYrcmFa?=
 =?utf-8?B?c3hHNlAvU2tTSW9VVjBiRFJKMnZ4V3hOd1NxTzYyZlZ2WHF1N3pvMXBjenhx?=
 =?utf-8?B?V3dQRjJKWnI1NVpXUlhlbjczYUEwMkQwcytIUEFaV3F6K0gzTjNza1RiNHZT?=
 =?utf-8?B?RzZuU1NOaUZ0NVJOSHcyOGQ2TmNKK3NMdGF0ZUlacG5xSzNUUEFtbCtpNmhG?=
 =?utf-8?B?LzRzVHhRdzRCQkJXekJxMWxjZi9Zdkxhb3N2Yng5SkQySThhMVNZSnBnd21E?=
 =?utf-8?B?RjQ3eEdqSVpIYjBTbHlYTUEwRzhMU0h4cUs2UnJyMFdHb3JyK1lpRXJDQW1q?=
 =?utf-8?B?S3Qzc1V2eGtZakJHMndrZnp5UmM3Yzd1Uy93VnRLVGhkZlRWcStySVA2QWhW?=
 =?utf-8?B?Vmg5RXNJeHhKdUhjeXFxcTkwbHJQazJ0eXkrajJoVlZBcUY4VUlXVnVRcjZ0?=
 =?utf-8?B?YzRncFM5aDc1REI5bjZVeTh0TlBNZVJma0licGM5QW9EdnRLZm1LVWRldThU?=
 =?utf-8?B?UzJ0Tit5R01nZmgyYmU5cjRDanB0ME1ZaXc3NzFET3kvTkhMdGVpdkI0a0RE?=
 =?utf-8?B?cFR3S0tTV2tpVlpLbnAwMXRxa2NhNXpmSkFVTDRCdGRVK2hTQmFlUGRmY01V?=
 =?utf-8?B?N2wvUTdOcndjVGIvTTFidTRHeElPdXNKV1QwK3k2cmZuSlU3aUlhQXREajJW?=
 =?utf-8?B?WEU0Z3RjY2cwUm5aU0ZLOUpmSTdJUHVBcnhPbUdGV3kzeTU3ZC90T3o4aWNn?=
 =?utf-8?Q?+MBngZlY12uza5OPB5Tfzf748USbP4Ocr7tCKYVY89nG?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DD174C42871604F9FB4E6FC98B45533@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8844
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 72b83bab9b9645c7a5b54edfa88130b1:solidrun,office365_emails,sent,inline:7299f935d81ea421dfac3c9fa9405b59
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ef2e589d-ca62-4c31-b7c7-08de67cec5b1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|7416014|376014|36860700013|14060799003|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ujh0SzRBZVJ6WlNvY0M0MkNjUkFqWG9nY2lXRkh3UU1YTGR2Wk43U2llRXBC?=
 =?utf-8?B?UHE2UDg3b0VOZEkzbWVLeHBoS3FYWTNHbklIdyt6aTBvb1dlUG51a1RWMkRt?=
 =?utf-8?B?TFIxcEhtWk5yVFZEMDg3QUJvb1BLRE1kQXBLcjJSRDdYeUMwSUgrWWpIUWNT?=
 =?utf-8?B?UjJUY1AxSUljcFNsYVdhTzQwd3l1YXBzWmN2dVdXai85bmhJeDZuSWVFWWdC?=
 =?utf-8?B?V1RkVGdKZU0yYk9CVVMrYlpqOHpoYUVNY1hONlI4b1BPV3ZEV1RrWkFJcVpi?=
 =?utf-8?B?UTZsaDVDbE9oMHUvZXpqdGV2R3BZQTZnR3dLdjA1RFR6YmI4YVovN1Ywdy9I?=
 =?utf-8?B?ZDdvUUlWL2hjUVhZeGNJa0RQYks5YlJ0ZWE2cGpXdFZrRjJ6Q3U4U3VGSUhh?=
 =?utf-8?B?aE1jWW5rVVZFUjRyNkNyUmR6N1pqYW1PQmZGVFdzY25vdzFTTWVNNmV3cjd5?=
 =?utf-8?B?ZjBqdU1hUjdnM2pVdS8rQkMrRGJOWjArOHFTUUtHZTBxNmlsZnlZUEl5OGRL?=
 =?utf-8?B?Z0ZuRW51c3JOSGF6dUJUU0N1QVdHeVhNYzVzSnVBVFpuMWJmTEh2UGhqaldJ?=
 =?utf-8?B?K3hEUVBWMG1RTnBCamxtaUUzMWlZNklRbEEzYVNvT1lTbXl6WGlTTVlLUml0?=
 =?utf-8?B?NHNuYnpZSTZFQjlBcTFFV0IyOWw4bDNEVlpUNWNGQlRNTVQ4MFlPeTUra3NB?=
 =?utf-8?B?WG1HT3NSU1ZtOUV4MG1NdkpXeDF6d3REQWt4RTVxRno2VkplL2R0UXRCd0lH?=
 =?utf-8?B?NUNnQ01leUU0QXRQbVlSb1BYeWZZMll0TkFZT0YxVHo0QmxESVNOZjB1VU5o?=
 =?utf-8?B?K3FCWVQwdHFLeE44TVQ4VDNqMXFybmNpcm1UVkZzL05qYmNScUUyNDBLY3hR?=
 =?utf-8?B?ZnVzQTV5bnkwMU91aFh0N29yUjFjemlVbGNIaThUaEFaNjJSRC8wb3hOU281?=
 =?utf-8?B?U3B6eFFWd2prcFNYZmRiTTBJQWZCVkRNWG5lWGs3MzdNd05LN3creU5sZ2dK?=
 =?utf-8?B?R0VDdXViVXkrMXhJOHh0YTMydVJWRFgyREwxbm0yWmVHblV0UXdUSVVaenhW?=
 =?utf-8?B?cTN0SlpGRldhS1ppUTFwU0xScW9BSDhWTVF5cWwrUzloK3g0KzJWRXZ2a2Rm?=
 =?utf-8?B?MFg4SEJOek9WS1NTQ0VDTXlkVlgyTGVjSktRN2ZzV3ZCMExXaHYzWDAzOFVj?=
 =?utf-8?B?S2dEUXNKdDF5dHFIcWZHMU5tSTJJKytJR1BTQnNMZ2xYKzdpeHMxd3FPWXJ0?=
 =?utf-8?B?emFNTkU2Rjg0Y0xjaVFMSVdEYzdmckZranZWTlNLbnM0OTFIdG1oS1d6VWpQ?=
 =?utf-8?B?amFieEluUERESTR1YUVBMDc5SXZIazd2K21OdEVJUzBBcXF0c2oveHJZNktY?=
 =?utf-8?B?MjVMMm1PVlFYaUZjRTZZMFJuUDA0ZUppb0NzOWtPa3NYYjhGa05uSzlUY1hD?=
 =?utf-8?B?aWJ2YTRJTERpN0prZTh6QnY1eEJINEhOblpTb3BvWU5BcU0wZFVoNEZBb3ov?=
 =?utf-8?B?eDdTM29NRW5iM3RsOEdDWEZZTFdHa1ZxQURhalJNMThlQ3FFUnNHSEl0L1VG?=
 =?utf-8?B?bXNHdzJ6elJKeHlIUVZFVHBXekw1eXAwT3RNenpOcUZxWU1kZ1Jlb3NBWjJr?=
 =?utf-8?B?QTVwaEt4SkFsQTN2NGx6cmFoUW40TndWYVFBQ1BINVo2UFB1K2lnVVBqU0lx?=
 =?utf-8?B?YXJmd1VaWFZKSkxMcnYyL2xCQVl2ZWc1SEZvV29WTmFST3R2a2E0ZTJGQTFI?=
 =?utf-8?B?ZHBTY3hVbHJKZGp6S0owaGFSMEo2aU1MNXZtc2hTanBUTXY3VkpMWm1JLzh2?=
 =?utf-8?B?SUhiOGtYYTB0dWtsTWtMV2ZXcXhVWnMwblpuckQrRVpxV2JCUWtLZksxODVZ?=
 =?utf-8?B?ZXpDTEVqTkw5SVQ0S2EvMytVU0w0V2VwQkkzdEsxZE85dExtUmc3eDk0eDRS?=
 =?utf-8?B?U0h2ck5xSURXd0IxVVVaVFVob053bTdmb0ExNHNuTi9OSVFUVGtKdjVqTEo1?=
 =?utf-8?B?c0lPQVMveWNuUDVuRDFodWJNZkFDblRiOEhWU0xTbnJBWXc3czB4N3c1Q3ZL?=
 =?utf-8?B?WHZxWjFLV2srRjYvZi9oemUyS2l2VmhFaUFzT3AvVXdxRnBmOG1xZEt2N0s4?=
 =?utf-8?B?VngxUC8xcTM1dWp3VGc4OXQrQm03Vk8wekd5T2YwL05sTTdHZ3RJSExJaTZC?=
 =?utf-8?B?Y0JkR2FFSUhnakNhZUorRnErLzgraEZ2eTdqM2Y0eUVzSG55OWRCYkJFNXhM?=
 =?utf-8?Q?4h6qjzIy8tUd7I+kUXWHj/kOLw/qbLaX5R3V5y4TaI=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(7416014)(376014)(36860700013)(14060799003)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SQfv+ZKRMFInoNJyTtw553Q/IHxWdmAwj2blhWME+ZTqwGWwPq8dZw3DyY/pYCgqkyfHKW8m5joXk/iZ+fJSqT8j677dJY15RL17Sou5qAkSmPBqWWlJosLNF7qyhlWzz29CwCqlkmuNekfaeg1tGXOncRpm0ubweFyuBtC30q9dLo18qMTTw5mQ44oPzyP8Fq+PIeWZNNbR00XfjeGbk89sbhTinvLVs8DZ2kWHl560LBDTUVrR26v33Bce7AvybZv6mKP6fQqIYe3AJi97a0rn3yJhs4416FLGt6bLCUtcfuJVSrFO+Iy0bERERqnrjxzm7GA1fcJggldpJmeMdH/ioaZeTwwAGGaXUpHXXtNpe1QpkOY69j9WNTqdHpboMgcQbjZwdFC+qVFOoYzQX82uU3dQBHwoZX3RGd3LbEZQNTUyjrR82Q3KQwbMPY6Y
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:31:40.7109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda0e617-d5bb-4e58-42ce-08de67cecb7e
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6520-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[axentia.se,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3471B10F0A9
X-Rspamd-Action: no action

SGkgUGV0ZXIsDQoNCk9uIDA5LzAyLzIwMjYgMTM6MTAsIFBldGVyIFJvc2luIHdyb3RlOg0KPiBI
aSENCj4NCj4gMjAyNi0wMi0wOCBhdCAxNjozOCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBBZGQg
cHJvbXB0IGFuZCBoZWxwIHRleHQgZm9yIENPTkZJR19NVUxUSVBMRVhFUiB0byBhbGxvdyBlbmFi
bGluZyB0aGlzDQo+PiBvcHRpb24gdGhvcnVnaCB0aGUga2VybmVsIGNvbmZpZ3VyYXRpb24gd2l0
aG91dCBleHBsaWNpdCAic2VsZWN0IiBkcml2ZXINCj4+IGRlcGVuZGVuY2llcy4NCj4+DQo+PiBT
ZWxlY3QgaXQgYnkgZGVmYXVsdCB3aGVuIENPTVBJTEVfVEVTVCBpcyBzZXQgZm9yIGJldHRlciBj
b3ZlcmFnZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQt
cnVuLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL211eC9LY29uZmlnIHwgOSArKysrKysrKy0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL211eC9LY29uZmlnIGIvZHJpdmVycy9tdXgvS2NvbmZp
Zw0KPj4gaW5kZXggYzY4MTMyZTM4MTM4Li40ZjdjNmJiODZmYzYgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL211eC9LY29uZmlnDQo+PiArKysgYi9kcml2ZXJzL211eC9LY29uZmlnDQo+PiBAQCAt
NCw3ICs0LDE0IEBADQo+PiAgICMNCj4+ICAgDQo+PiAgIGNvbmZpZyBNVUxUSVBMRVhFUg0KPj4g
LQl0cmlzdGF0ZQ0KPj4gKwl0cmlzdGF0ZSAiR2VuZXJpYyBNdWx0aXBsZXhlciBTdXBwb3J0Ig0K
Pj4gKwlkZWZhdWx0IG0gaWYgQ09NUElMRV9URVNUDQo+PiArCWhlbHANCj4+ICsJICBUaGlzIGZy
YW1ld29yayBpcyBkZXNpZ25lZCB0byBhYnN0cmFjdCBtdWx0aXBsZXhlciBoYW5kbGluZyBmb3IN
Cj4+ICsJICBkZXZpY2VzIHZpYSB2YXJpb3VzIEdQSU8tLCBNTUlPL1JlZ21hcCBvciBzcGVjaWZp
YyBtdWx0aXBsZXhlcg0KPj4gKwkgIGNvbnRyb2xsZXIgY2hpcHMuDQo+PiArDQo+PiArCSAgSWYg
dW5zdXJlLCBzYXkgbm8uDQo+PiAgIA0KPj4gICBtZW51ICJNdWx0aXBsZXhlciBkcml2ZXJzIg0K
Pj4gICAJZGVwZW5kcyBvbiBNVUxUSVBMRVhFUg0KPj4NCj4gSSdtIG5vdCBjb21mb3J0YWJsZSB3
aXRoIG1ha2luZyBNVUxUSVBMRVhFUiBhIHZpc2libGUgc3ltYm9sLiBJdCBpcyBtZWFudCB0bw0K
PiBiZSBzZWxlY3RlZCB3aGVuIG5lZWRlZCAoYW5kIHRoZXJlIGFyZSBhIGRvemVuIG9yIHNvIGlu
c3RhbmNlcykuIFRoZSBrYnVpbGQNCj4gZG9jcyBoYXMgdGhpcyBvbiB0aGUgc3ViamVjdDoNCj4N
Cj4gCSJJbiBnZW5lcmFsIHVzZSBzZWxlY3Qgb25seSBmb3Igbm9uLXZpc2libGUgc3ltYm9scyAo
bm8gcHJvbXB0cw0KPiAJIGFueXdoZXJlKSBhbmQgZm9yIHN5bWJvbHMgd2l0aCBubyBkZXBlbmRl
bmNpZXMuIg0KVGhlIHBhdGNoIGRlc2NyaXB0aW9uIGRpZG4ndCBtYWtlIHRoZSBkZWNpc2lvbiBs
b2dpYyBjbGVhciwNCmFuZCBJIHBsYW4gdG8gc3VibWl0IGEgc3RhbmRhbG9uZSBwYXRjaCBmb3Ig
dGhpcyBhZnRlciB2Ny4wLXJjMS4NCg0KQmFzaWNhbGx5IGV4aXN0aW5nIGRyaXZlcnMgdXNpbmcg
bXV4IGNvcmUgdXNlZCAic2VsZWN0IiB0byBlbmFibGUgaXQsDQpldmVuIHRob3VnaCB0aGUgY29y
ZSBjYW4gZnVuY3Rpb24gc3RhbmRhbG9uZSB3aXRoIGRldmljZS10cmVlLg0KDQpTb21lIG9mIHRo
ZXNlIHVzZXJzIChwaHktY2FuLXRyYW5zY2VpdmVyKSBmdW5jdGlvbiBwZXJmZWN0bHkNCnBlcmZl
Y3RseSBmaW5lIHdpdGhvdXQgbXV4LCBhbmQgdXNlIGl0IGFzIGFuIG9wdGlvbmFsIGZlYXR1cmUu
DQoNCkxpa2VseSBkcml2ZXJzIG9ubHkgdXNlZCAic2VsZWN0IiB0byBhdm9pZCB3cml0aW5nIGhl
bHBlciBmdW5jdGlvbnMsDQpwcm9tcHQsIGtjb25maWcgZGVzY3JpcHRpb24gYW5kIHN0dWJzIC0g
d2hpY2ggdGhpcyBwYXRjaC1zZXQgYWRkZWQuDQoNClNvIEkgd2lsbCBhcmd1ZSB0aGF0IHNvbWUg
ZXhpc3RpbmcgdXNlcnMgcmVseWluZyBvbiAic2VsZWN0IiB3YXMgd3JvbmcsDQphbmQgdGhhdCB0
aGUgbXV4IGZyYW1ld29yayBpcyBnZW5lcmFsbHkgdXNlZnVsIG9uIGl0cyBvd24uDQoNCg==


