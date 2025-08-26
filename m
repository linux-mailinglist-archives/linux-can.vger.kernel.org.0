Return-Path: <linux-can+bounces-4370-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42EAB3517F
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 04:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F72F683AA7
	for <lists+linux-can@lfdr.de>; Tue, 26 Aug 2025 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CCB1F874C;
	Tue, 26 Aug 2025 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f95o1uF9"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE21FC3;
	Tue, 26 Aug 2025 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174772; cv=fail; b=mY7xydy00OWuey3rDjwSa7eyYkoEhFO073LNYOfcoYCV38KmBX6lyR2VIPTm16OiPHSI3b3jlv/kWVRyy19ja5Ks+5qCvRzGZc+l+iclArtYxXqY7bD7shfCrLZgHwCA9fL9wQ3kqkvHArJvGnBSX26sIOw60C6RUBPRLNDwu6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174772; c=relaxed/simple;
	bh=ilv9rI3EEEHPjVZQKdL8pU9mncl9Jf1tJcqREG9H0hQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UV7DOfDC/VEXUYu9o55JhMhvcpxYM1IPoAvHDr4WlsgNrBH4AaN20bFii+gIsuApBTlE0nGvCd+Fm0tKueVPRcW6MPHx9erjv8u4fdSntzhwS7fZa+Bm0SaNkCh1jRYDTD26fNcEdMZ7gDVIjdMcGlskMUdEoQ5oDgbBonQJutc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f95o1uF9; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCfAiDGQeOHuK7EVwl9XdQNcEfXDGfoZNZK+nKqPUEvVXP93IkKw9RV+Nh3sU1e7gAf26ePJb6gmcyxPPnNUtKYHAsStomO+cDkcn/5mG4DJFTc8P0TNvfVkSwVOGGOH00HMg5YdQbLFNOSP4CKjcW9aVdFw80ToMRlaP0u+xevimLKWVBhWuq7/gPObMWKjFSva9WzKNCkcEDZuuvwQhfribz7PxOh9TC+iVOz5lYMo0B2K70nkckPXtErVfUwzYghHP0D7eXU1mFLfWAt1RSPmLZ+QNcr2VaafwlpFrkchXI/3S4QqKRe5Nq7i/rj5mVxyX8+AN9g0e9INGox4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilv9rI3EEEHPjVZQKdL8pU9mncl9Jf1tJcqREG9H0hQ=;
 b=M9UNMByH+RGDSAIOUwDq2McDwoGzSfljFbyAmfE0nip0CNd/dDeNred+JsuNMCKCjbdEzkW06bpL1qPhA6vtMsotBZNFCyDmpsvkZbglaUCg/ONdWUajh6dBBX+5URNr+eisHacpf0uNQ+TWlT/KFE0CSHs4u3mLSg+QZCVW1XEB/a2xScnRZxjJoVY850zSsXuFbDMW3MDR/fMA9MRmqTnRl5WUo3NAOOA8cIt2r71l6kW+vgxoIU8ngWkda7VLEu5o9fDZZpKkNTY4CrhofHymg7K6iTz6FvCDowibcoVh0AqJu2harkG4iZL/Q4VSuZAggiGqfUUzNyT+5f/nug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilv9rI3EEEHPjVZQKdL8pU9mncl9Jf1tJcqREG9H0hQ=;
 b=f95o1uF9PFQ0uiyg8ReUINV1UbH1M189y5LcyBhcNBjjV+f6nuL4XRoYZ/064kIcGYUP1E4GGB9UUT1WTQH+fKaS6tfYw3ECBfDtCL3nW/CsvQsmsqNwSR0hPmj6fXTfU885180M+zAaV+W5ZF7xtsLelZa1TM42etN+jsjf0rF5FPkK/4pcIRaTP2TNLvMjPNTJtcQAdIbwNKXa+/qnrfGBTriS0K6uu1or7a6UArxarar49y9fnE624CQocC9U3beCcfgYmdMtwrDk6NJ0K/Y8kGihWyR9YLMU7sSUfWkMe4Rk/103PMEh0E2BEbMPZTlfNH1mPx73PAmUocJWBQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI2PR04MB10190.eurprd04.prod.outlook.com (2603:10a6:800:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Tue, 26 Aug
 2025 02:19:27 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%4]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 02:19:27 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li
	<frank.li@nxp.com>, Bough Chen <haibo.chen@nxp.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v2 3/5] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Thread-Topic: [PATCH v2 3/5] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Thread-Index: AQHcFZwjfxf8EJF2vEmSC4iGG/IwkbR0M9Rw
Date: Tue, 26 Aug 2025 02:19:27 +0000
Message-ID:
 <DB9PR04MB8429631F164C8AE7571AE3CB9239A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
 <20250825-can-v2-3-c461e9fcbc14@nxp.com>
In-Reply-To: <20250825-can-v2-3-c461e9fcbc14@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI2PR04MB10190:EE_
x-ms-office365-filtering-correlation-id: 5b95f5f0-0ed5-46af-7d99-08dde446fb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2lGZERIQ0RQZ2o3OWxQdGlka3dHSnhKd2M2VUE0V05qei8zNXJLd0hhSDU0?=
 =?utf-8?B?WW5jVW1Kdi9RNWh1MkV0THZZdWFDTDd2UytGZyt2bjkzUVQ2ZVZIeWR4Q01k?=
 =?utf-8?B?czZMdDBqdmYrSXRrUFY4YnhVL3hGVnhyTlA4NlIvelFqNGR3OUpPVnV4TFFO?=
 =?utf-8?B?L0N5UVY2ckZ0Q0dNamZIMnpzcFI1OVRkaXNyajJlQkZTSGEyOFpPVFZUUVdp?=
 =?utf-8?B?QTlxaFVMV0RHTGtEanNBWVpMM0RhbTFCM1A0ZDl0bkpwMmljVXJOMG1nbytL?=
 =?utf-8?B?RG1iaThxWWhvdU5TNzh2aXZ6NTRWUXg4cHNtbjE3YzJacUpmMk5WRG1vVjZO?=
 =?utf-8?B?bHhib2VWVnF3WjR2ZUl0SmNQRk9Lc1J2azNIU1o3czZHRXE4bjgwRlMvSm4v?=
 =?utf-8?B?Wlc3ZHIvVnYrNElZbVBvUDlJNElOdVB3OHBHdXRURGh0WDZZL1dBTjRaYXRn?=
 =?utf-8?B?SU50T21lQ3VNL0o0ZHYxaGhEYlkwQU9MOUd4emp3TU5FRnk3Q1VxZjZTZkdU?=
 =?utf-8?B?ejM2c3pOaGl3bWlXbmlRTUlOb1RvY0dBUzdnbDFvRXJjTWVBa1A2RUR3RDdF?=
 =?utf-8?B?USs2czlBQ2JjaUtmcFVqMDdPVVMrUnBzU1hvZ2VpSXhvVlJhRDdwWDNCYjll?=
 =?utf-8?B?MXdlN1Fsd245U0NEcS8rd0hCTWVlVDJRa0J1MkduWnJ4OXk1N3lqRTdhdzEw?=
 =?utf-8?B?MzVZQzJVcGpjaklWSTh2KzRvekNiU1JDaWdwMXNpT2xOSllTOUozL2JBaEFW?=
 =?utf-8?B?Q1k0QTZod0Fmb0NqUE5CQ0FmK1lvN1dES2hzcnFscXpYb1NyS0o2UEdpcmdN?=
 =?utf-8?B?SUVLSEFlQzlXTVpUaGMzZk5RTmdXZ3ZScUlhb1JkaHk5dXZ1QktjS0wwQWlz?=
 =?utf-8?B?Y2kvRFJ1RlVtQ3pQSDVjWHVadmxGU1RZS1Joa0xXalRoUjdQMkROR2xGUmww?=
 =?utf-8?B?ZmlUUnpJR3BXTFN2SUxuOGtVOUhnSWt2bTlON2dOaXRIMS84Q3QxYmI2UEQ4?=
 =?utf-8?B?MUR6ck81VUlUTCsyWDdqWGxGTG5pZGs2V1NaVGN0ZzZNOWFuaGQxR3FEWUR0?=
 =?utf-8?B?ekN0N2Z5TEF1ejFqOElZNGJNYXhMMDhibEZtMkV1OGk2dlA2dG1VMnpjdU1p?=
 =?utf-8?B?QWRLMHVnOVJtREorS25XVm44RFUvcG4rL28ySS8vV3FZUlA2SVpGakM2b0tn?=
 =?utf-8?B?SjhaeUVnZGMyWDJoN0JGa2l4aHZZMDVKc1pIWEVyMlBhYUR6WHVGbjQxYjZi?=
 =?utf-8?B?OFJUc0lIY2M5Y2FBK21PSlVnTnZyL3RMbk5rcEdWR2I4bG1sYi9BZWdyWWE1?=
 =?utf-8?B?a0VvSFhTbGdDM3ZVNUp1QkZBNVVLUjV3alZQRTFnNkRFVStQcDg0Q3RJL2Jl?=
 =?utf-8?B?ajRJUVdQTVdtU1N4WVRUK1FKRFU2OUNDRjZGTFYrQXROYnhSaEtjRG9Jek54?=
 =?utf-8?B?ZkF0azVIZXVKTm9hOU9pVlRPTExQUS9rOVprcG1Lb2YwRUFIUFU4dWZuN3Nn?=
 =?utf-8?B?UjJWeStXWmluRTJhN215OExCV1R3YlBkQzhtS2NweFM5QWh0d0dvbjZzaW5L?=
 =?utf-8?B?UHdUZmFFQWYrNmFsUzJnY2hWSkQzdzd5VzFsWklQRHhXeEQ2RXdCVVh6anJB?=
 =?utf-8?B?WHZZckw4WTVHR2NPRTV5VGErK1Y4QkpOeVcxNk9NcjRFNDJBSnRERTR3U3Ny?=
 =?utf-8?B?N1kvSjhYRWd6ZEtUN3Z2TVA2Mlp4L2ZTaHhwRC9lVS9FRW5DRER4QkhWWFJZ?=
 =?utf-8?B?aEVoUGxuYjE5MU4yelF4d0hmWVdScm9mVmZFQlJQUXc3RjZINit4RHp6MjNB?=
 =?utf-8?B?SWJIV29CbEcyR2VqVlBUUGhYS2xQdjVjejhZeWNHdnhGL2IvZElFRGcxMkJD?=
 =?utf-8?B?Rjd6R3o4YytFcEtHVkZITXFYamZxcXRidUdBN0d3T3FtSmNiVWdhMExXNUUz?=
 =?utf-8?B?UkVsMmRHdDF0dERlZjBiOUY4MWRQM3FkZnBIUUdXdXF2d2Y0UCs2WGtzazVY?=
 =?utf-8?Q?lyJP3dDGCK6eplts7xo3OE5hlwq/44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlRlVVNYR3plNE4wcUlUN0t4YzFoVGpiVFZrTVZ2ZWZwWGx3VUxlbnNNdnhX?=
 =?utf-8?B?K2g0L2dhRlR0dDJrMzNxc0h5Z1hQdURaR0pwNzRtS1Vqa3ZIK2tFYklmNEZH?=
 =?utf-8?B?UEhVRWxlUmV6eFAwNkUvUjRSNUorZkpTQk1sZDZLY2hZejBqL0FhWHZZUFpj?=
 =?utf-8?B?cjVYVnVqT25uS0xudXBLZEdYUlg0NWFmaFRaM1pVMFBDNWdZUjMxdFVkTjB5?=
 =?utf-8?B?ZGZUeU5PRFZjdC9iRTVUWkIxa1g5U3gyRXJpTkZkRFNQQjZqaGJnL1Vna0F1?=
 =?utf-8?B?TE9qcUJPNnRnemxyRWFWZG50VDZ4SHNpUGdXcGtRdUh6MXFjdzJiamlmRmdx?=
 =?utf-8?B?MytPdk9aUFAyZHpUcy85Nm1SWWcrQ21uaCt0S0lZaElkTTh5bVJpQlZQSVBV?=
 =?utf-8?B?VWZxemV1V3UvVUpiUkdXdHhQVE8rc3owS3NpbWF2RjM2ZnpUUjJ4N2ZjY0F3?=
 =?utf-8?B?eVlZMlBTMTlLcGdLMUhELzZMcXkwN25HcUViSGU3OE5LVVFTNXZVNStpc1dt?=
 =?utf-8?B?TThieFZzcStxemIrbE5wbWcxdWZxN3pnSHN2TlBVa0dJdEdERWROVytVVTVY?=
 =?utf-8?B?VGl5YWFmK3dJeitRUUFOOHdTNHJaWU5ONC9rYk1XSk45dUFiMFMzVkVUdlRG?=
 =?utf-8?B?TGlCc2Z2QlpGdCt0bkY4d2l0MjhRTi81NWt5K0cyTUhUQWYxdnZ4WGhjT1RY?=
 =?utf-8?B?aWVRV1d5SFZlRDh2b1hHSitGWllLdVB2YXl2aVFwUjByc2tSZFFYcUdmbFNl?=
 =?utf-8?B?RDRqOUdVTUR4Rmw5VkczWTgvR0I1K09WS0h0QU55VjB4QzhrN3EvcGRsV21z?=
 =?utf-8?B?VVhiRDgrYTNtRGhHK1hzVXdrck5lVzAwUzBBWHNxNnFERGNyMytiOG13Y0o4?=
 =?utf-8?B?amIzaXJRRmJ4MHdiSXZWWHBhdVEzOExjTVZoSmIyQjdZR0tya0RzUVdlMVZr?=
 =?utf-8?B?WmtuekVIRkQ1UjNHQmNJUno3ZkFMaE5LSGFHbkZ3Nk5IOGpUSUx0Ui9KamVK?=
 =?utf-8?B?ODY5UDVOUzlvckhKcVZlT1BMUXg2RnorTWhoc3pDbWorczc4c1ZHOFhuY3M3?=
 =?utf-8?B?QnpFYytoWUJKZ1VKSVgvbEVqS3Bwd0VyY1pwaEZBNVEzZHJ6R2JEcWFESzk2?=
 =?utf-8?B?eXpQZlNndWdwUDRFcFZ2WkxLUzNXUmNXa1NRNnBzNU9wS1hudDVSQk9KTTky?=
 =?utf-8?B?eUZiWHRIanpVTUNLUWhTUUJUcTV1SERLeWZ3djR2S2xpWlJkTi9yWWtmVW5j?=
 =?utf-8?B?UW5JNDNFTzg1ck9KMVdkZFoyL1ZBSC9KL1doUC9CL1l1Q1ZWTEdkaEthVXNW?=
 =?utf-8?B?UFVUQWRNdWtMUmsxUmV5S0U2Wjl0RGJ2dzh0U1ovaTY5K1lqa3JoYVNqWmE1?=
 =?utf-8?B?dXZGbjNkWDhkZ0pYUjhWQlNiUFYzMVlSeXZvV3NjQ2UzSmFndVRnSjRIQlpM?=
 =?utf-8?B?RzIzUGMvUFJIbm9nWkYwN2cxRG1tK1hFU2k0VndZLzdoOW5qdXpjTXZxQXNw?=
 =?utf-8?B?SVBsYXZiV2NwWDVJbWUxTkVMalpZdFc5VFhXY2Zzb25uMll1RkE5bldlMCtT?=
 =?utf-8?B?c0FROGhSS096VU8zZEtoNXRZY3JoN0xrcG9pT3Irb1VlL2lzWVhsWUVPdWhi?=
 =?utf-8?B?MkNiVXd4RjhsUlhuWUVjTjZxTWt3d2dWbE5NbWNHbi9XSWtEb0hGbnNjNWVl?=
 =?utf-8?B?SVVlblE0M0RYZzBhdDMwaHAxS1VRcXlPVGtWTVVoZEhud0xGdzVxTjVGdStE?=
 =?utf-8?B?MUVDYnkyRTdCMFpFbWxoNS9LbU5rRUVjK0dyMWgrMXZDUURITThTMmE2NStm?=
 =?utf-8?B?Vnk5QXhPTGlvS0F6M1JqR1dpb2FDdTRIUVYxRVMyeFJORXlTMXFSQ3ZEZkky?=
 =?utf-8?B?bmI4ck5ESzhmaEhxV0FWU0pGeUZranZyaUl1eGJXVEV6ck54a2RYOEhmMmsr?=
 =?utf-8?B?bWZCUlZlQUpPak9WSzVnbE1rZ2Q4QStPQ2RjeFZ2UnlIWTJaYiswSG9KUTZu?=
 =?utf-8?B?TmFYMUV1dUtCTzhsaVAxODZ5dnkxL1BRQ3ludjlyS2ozdWk2aTEwMlJZdWd5?=
 =?utf-8?B?SlAyMVBlZk5mSXdGNklxb2E2RzlTVTI3OS81U2hTRWk2Q1MwMWkzUEtNeFN6?=
 =?utf-8?Q?YNS1hOTFbVkIMCW1dIsI4fkaB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b95f5f0-0ed5-46af-7d99-08dde446fb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 02:19:27.4208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiH/4JdQ3NyR1WCGG64gCTFWP7JDdpCtmb3VTrPf8StewwEPnkkrIc4zdG+WKce/RdoB9t2dDC61e0TYywOqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10190

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI1LCAyMDI1IDQ6MzcgUE0NCj4g
VG86IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+OyBWaW5jZW50IE1haWxo
b2wNCj4gPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPjsgVmlub2QgS291bCA8dmtvdWxAa2Vy
bmVsLm9yZz47IEtpc2hvbiBWaWpheQ0KPiBBYnJhaGFtIEkgPGtpc2hvbkBrZXJuZWwub3JnPjsg
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dza2kgPGty
emsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+
IEFzd2F0aCBHb3ZpbmRyYWp1IDxhLWdvdmluZHJhanVAdGkuY29tPjsgU2hhd24gR3VvDQo+IDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRl
PjsNCj4gUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgQm91Z2ggQ2hlbg0KPiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogbGludXgt
Y2FuQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIg
My81XSBhcm02NDogZHRzOiBpbXg5NS0xNXgxNS1ldms6IFVzZSBwaHlzIHRvIHJlcGxhY2UNCj4g
eGNlaXZlci1zdXBwbHkNCj4gDQo+IFRoZSBUSkExMDUxVC8zIHVzZWQgb24gaS5NWDk1LTE1eDE1
LUVWSyBpcyBhY3R1YWxseSBoaWdoLXNwZWVkIENBTg0KPiB0cmFuc2NlaXZlciwgbm90IGEgcmVn
dWxhdG9yIHN1cHBseS4gU28gdXNlIHBoeXMgdG8gcmVmbGVjdCB0aGUgdHJ1dGguDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgxNS1ldmsuZHRzIHwgMTMgKysrKysr
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5
NS0xNXgxNS1ldmsuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUt
MTV4MTUtZXZrLmR0cw0KPiBpbmRleA0KPiA0NmY2ZTBmYmYyYjA5MTA2ZTZlNzI2ZmY4YjYxNTIy
ZDEzNTljZmE0Li5mNjE5N2JhMzU2ZDQ5Yjk3YmY3Mjg3YzNmMA0KPiBmODZlZjg0Zjg5YmFjOSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtMTV4MTUt
ZXZrLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgx
NS1ldmsuZHRzDQo+IEBAIC04OSwxMiArODksMTEgQEAgcmVnX2F1ZGlvX3N3aXRjaDE6IHJlZ3Vs
YXRvci1hdWRpby1zd2l0Y2gxIHsNCj4gIAkJZ3BpbyA9IDwmcGNhbDY1MjQgMCBHUElPX0FDVElW
RV9MT1c+Ow0KPiAgCX07DQo+IA0KPiAtCXJlZ19jYW4yX3N0Ynk6IHJlZ3VsYXRvci1jYW4yLXN0
Ynkgew0KPiAtCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+IC0JCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiAtCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9s
dCA9IDwzMzAwMDAwPjsNCj4gLQkJcmVndWxhdG9yLW5hbWUgPSAiY2FuMi1zdGJ5IjsNCj4gLQkJ
Z3BpbyA9IDwmcGNhbDY1MjQgMTQgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwlmbGV4Y2FuMl9waHk6
IGNhbi1waHkgew0KPiArCQljb21wYXRpYmxlID0gIm54cCx0amExMDUxIiwgInRpLHRjYW4xMDQz
IjsNCj4gKwkJI3BoeS1jZWxscyA9IDwwPjsNCj4gKwkJbWF4LWJpdHJhdGUgPSA8MTAwMDAwMD47
DQoNCkhpIFBlbmcsIHNob3VsZG4ndCB0aGUgbWF4LWJpdHJhdGUgb2YgVEpBMTA1MSBiZSA1MDAw
MDAwPw0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQo+ICsJCXN0YW5kYnktZ3Bpb3MgPSA8JnBj
YWw2NTI0IDE0IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAgCX07DQo+IA0KPiAgCXJlZ19tMl9wd3I6
IHJlZ3VsYXRvci1tMi1wd3Igew0KPiBAQCAtMzAwLDcgKzI5OSw3IEBAICZlbmV0Y19wb3J0MSB7
DQo+ICAmZmxleGNhbjIgew0KPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbGV4Y2FuMj47DQo+
ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gLQl4Y2VpdmVyLXN1cHBseSA9IDwmcmVn
X2NhbjJfc3RieT47DQo+ICsJcGh5cyA9IDwmZmxleGNhbjJfcGh5PjsNCj4gIAlzdGF0dXMgPSAi
b2theSI7DQo+ICB9Ow0KPiANCj4gDQo+IC0tDQo+IDIuMzcuMQ0KPiANCg0K

