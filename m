Return-Path: <linux-can+bounces-6535-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yORrBaVEi2nzTgAAu9opvQ
	(envelope-from <linux-can+bounces-6535-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 15:45:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A620211C098
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A491A30252A7
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67592DCC04;
	Tue, 10 Feb 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PW2qqo0O"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021139.outbound.protection.outlook.com [52.101.70.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45024886E;
	Tue, 10 Feb 2026 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734752; cv=fail; b=p2IpX5oJctFwZmxTK64nPjFfxlizBapkQumPU5PQtirWNqpIpCW9Ur8xtoc7R7oqnSB1JckSzjC1sLJJWNOGcQ9DqN7vxrY+4DC0L7wY9j613jjhYqcu4KsCWnTNRFT8HkUjdGIFSxO+20tUC1yLEtwQXOqFR0Ykd0rjJab2DzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734752; c=relaxed/simple;
	bh=KCnG8wJO4eBIxWnY5ishDAIs1V9HLTtDIxoqLWbV7zk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nEYZpMxWw3dsTg8DETd2H2tUmEdxlihXYighXiyb8LKGZBdymYqCH3f8EBmE/StwmjHMRcV4iLsOBqcwUgfBPCC7p5/DDTOcL+ZyQCfADnN+1y9tdeSu03RiMuK2NoWnpSEBumQuOf1EHeAT8qmr7FEbJOLd0kTWO47NVgeR198=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=PW2qqo0O; arc=fail smtp.client-ip=52.101.70.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZwNrr/YqtYH7jPwD0WaejOZMa3Nxbh/OnC4PsuPhAZZYZ85KwX+V+DeS++ttC3YOVq9qrhXkvdbAFwJYt4QwLjy6hQlj+ofeL7aW3Fe+8kvOA/BybE8yADb76n+1T7w1rW2wDe61TTSqZ7xmzXC00wXm85v8I74rNJ23mHMqM1HFEWszSJnIBI1fD+1lgny1MflhR8CFxSwesoZrsQMxzP/3cmUvy1dLtE2VnTEV6AihgntQGZS4TWtFvPltqv9zTW9Yk39TuWvM0xcompW9ESieL4maNAA4+so84dyi0H22hVTSgIUZBIlkL9nZyYOY04OePYOUsCnAMz8KSSldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wryrN+6zDX0+opTc+11vGaBvNSjL75/1MvCLZRcX9jI=;
 b=XINjydsO1Yw/xmZMmRt2LompSeTJxQ5oWP9pIvvg8tiGuMTyRG7FJcgu+7NK3Kmh9IwrfLMd56fEF8qwLJBtznVrJNTzvgGO3DF5D/P5cUf+wS0pNrAT/ghD9rgp/oJ1w8D0cM5ilikyJOfFZvqgUVKRZcuzc29XBEyAsVaP/I6R5jv3vBaOJ9oqxRmd0uwYPEPkmJ22UeSlYwk7jmkBWOS+uMGWOMcvwlAhLluSJfXDQDdLGEjZ/jdiueK37fDKf9mfelSIpOLMFRqZRvFRu6BnYYk3/6j3TQ3BJgV9iLPwWQW9hD2SVZwKDZblWCqHBJ2Fr0SFO+x7gDr5+Kbxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wryrN+6zDX0+opTc+11vGaBvNSjL75/1MvCLZRcX9jI=;
 b=PW2qqo0OTOiL/qpmh2hU8LA00A8HgOdWj4NNaF7rZhC7+npCnJ2DnGd7ZWgcZ58jsXhUmrZ5lqCsK3mAhNsV49FhRf4qRAA3/F7lduEW0DQxcHyDFlf0gF7VHluO6lqwpz/8K/4eWhS68GibqFWaAgpOEPqiwP5uXPlwd8CFKcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by AS2PR02MB9262.eurprd02.prod.outlook.com (2603:10a6:20b:5fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:45:47 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 14:45:47 +0000
Message-ID: <e6b13c2b-68dc-7740-eae4-aee26fc1ae6b@axentia.se>
Date: Tue, 10 Feb 2026 15:45:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Content-Language: sv-SE
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton
 <jon@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
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
 <CAMuHMdUEZZ+p+yaQDWhVCRNEQUygR2j=HpCp5LuzFU3E=qVNXg@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <CAMuHMdUEZZ+p+yaQDWhVCRNEQUygR2j=HpCp5LuzFU3E=qVNXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|AS2PR02MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 646bcef6-29aa-4bd3-8b29-08de68b313e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWkrWWRzdFRNWWhxQU9OL1VKT2RrSjRJYlBDSUQ1TWpjck80eVRxUnFWeC94?=
 =?utf-8?B?WVlrZmhaQmNDV21XQXUyeHBjcnpUb1FmSWVFa2hiMGJhQkJzRHgzT2ZBZkdB?=
 =?utf-8?B?MW9RV0p4U3RDL04yRm9EN0VxK3g2UG0yODQ2WSsvV29YQnZIaWlNZkpiaFdh?=
 =?utf-8?B?R3BFUkJVcUJnYWlQSjdqdXFqb096TVY4NlVzR3hOYXhpdGpwV21DZmdTRTNw?=
 =?utf-8?B?T3BGRlRLQ3YyM1EzenA1Rk15bVpXQmdwa0MwUnluaTJmZjlWbUFlK2FyQ3VP?=
 =?utf-8?B?Q3cxMW02VU5Sb0U3VEhmMW92RVBqWmhVeWJ4UzczSk5idUhPRC9vSDBiWnl1?=
 =?utf-8?B?S1p1UElHc3h5S29pYm85anJXWnM3YTdIOGpsemIxY2xuSnhnL0dHUFg3aldX?=
 =?utf-8?B?NFZhVGt0TzlnSVJCbmpjc3Qzb0UrNHpLWmx1WFI2d2dGdWp3Y2hrZjdwS29E?=
 =?utf-8?B?NWlZVDhyS2VPejYvZmsvOXl0Mk9ncC9zMEdaUTFJT1Y1djdGTDlQSVUrODBK?=
 =?utf-8?B?VlJUQURSOS8xU3I3SXZqTlZnMURiMzJzZUNnUkxCakVrMWU5ZkF2NzUrcTUv?=
 =?utf-8?B?SWJaM2JmNGQ0Tkd5clE1dGlsbVdEckI3cmxoMFFTcFF5Q3VOWkl0NEpMWnZR?=
 =?utf-8?B?K0RDSXVhNXkyUWFOaHRGb08rbXFjRjNMM0kwVG1XRkdza3A0ZFE0dUxTZDEv?=
 =?utf-8?B?L0YyMkk4bWNocmw4a08vTXhVSHdkekI5bEx2VkxPc3N0bTFCZ2o4cDlmMWlR?=
 =?utf-8?B?WDVjU3FLNFhFZlNFVWlpejYyNW9HeVNlbGk3Tjg5N3RIVzJTOUJjWHFWd0Za?=
 =?utf-8?B?MldzdmNrWFYrNVFhbkFrWnhucENPbVQ2WUovMHNKNzI0V2FYQ0VrTFRWM2xX?=
 =?utf-8?B?cGNQdURIeloxaTN6RFRxdlJQckVCTWhLM0RsUStLME9aaGYrcmRFWWZHbjB5?=
 =?utf-8?B?Q1U1TFk2cTFYcitQbno3dUp3cVkrcmhjSkF1SzVSMHBaZEw0dkp1NkoxVURY?=
 =?utf-8?B?R1NFQ2RuVzduajQ0OXhQSFpRNDZWRzJIeVZHdDFjUlB5Nlh4bHFPbDVvR280?=
 =?utf-8?B?UFNteXBkV3BKc3cxWVZDakhTMW1ZV1UwclpZWmNmWDg0cVdreVVzZGpjZG8y?=
 =?utf-8?B?bm9mZ3o3R1A4MUF1ejVZczlPalEvcWRsU1hCT2YwdlcyYTF4Q3NEQkhYRXhZ?=
 =?utf-8?B?ZWd3S1VqVHR5MXlwUnFRUjhhbWkva1NGbW5yZ2VkbnlYUFlKanowbGw1Zll2?=
 =?utf-8?B?bHkyMDNBcGpmb3paaTc1ZzFxRGV0ZGtNZUJWSUZXMFgzQTR3S2dxWGNKUGM3?=
 =?utf-8?B?YzArWEdoTm91YW1OZXVJOWphYmhEZ1BLRSsyamtvZldQeGhsK0Y2dXprb0FO?=
 =?utf-8?B?M0RFcWE4cUwzNkk1cUtRZVlIbGlhN204Rml0bjBmUys4NTJSWnBhUkd0cjBF?=
 =?utf-8?B?WEdpOXlIZWxPQllDZy8yaTRZQnJaWmx4eDBpcWtNMWljN1FJNDBJb3ZCcTJu?=
 =?utf-8?B?WWo3WG5XZ2NYVmVENzU1cmJUWEkxSnhsTUlTR1BTOUtoUm11OHpVWTRGVmRF?=
 =?utf-8?B?QThvNDl4b0VyM3VDdTlFZUZiRXVZVWRHSEg3QkM1VjNIMndEdEJldFlPRUFR?=
 =?utf-8?B?Q1J1UGZzSjA1TjU2VmtXUVpSTjFJMUtaSmRsaFdjbkl5QlBFbUVrUGN0eVRs?=
 =?utf-8?B?eXBISUlZS3dOK21FOGNTdGxibEt5TlZSdjl4Y0U5UWJLdHpGbWM2ZEwyL0pa?=
 =?utf-8?B?ZFEvcGtNS2dXTkFaTU9TUmdRZXcwcnRKUGJ6NzJLcjAycHUzS3dpL3MxZlMx?=
 =?utf-8?B?L3Q0b3RGOGlFRjRoYnVMS2lvN0F1aHNFZmpLNDVuOFplUHhPNnNOajJlQllr?=
 =?utf-8?B?WGJZQXNhbGl3ZnZ4TTBnK2pZWGhNci9wc056R1FHdUYrSldSZkw2N0hxSlhh?=
 =?utf-8?B?Q1ZxZ3lUekxTd0ttbHBjZTNjbFEvbUVDRFREcFJXTDZJT3MyMnRoeGluK3B6?=
 =?utf-8?B?S0RnR2h6d0JSTG5rU21BQXp5WUJSd3NzK1RUTkNjdndaR3FHUmRXUlZYeklW?=
 =?utf-8?B?ZEhScURTYlpXRmNkbTFZNVJNZFRUUFE0SzY3Z1lpWERZYUp1Ni93UXNpeXcr?=
 =?utf-8?Q?aJAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm12WUFiZHd3VEJWcllLK0lwTjgvK0pEcE14NjRGNHFWL1QyVmJRWFJOTE1X?=
 =?utf-8?B?NlRDK3paTVNraHRaSmVTMzBUaU1nT1c2ZmdtSTRESFA2bG1tcHQ2bHgvbndz?=
 =?utf-8?B?SU91ZXRNWXM5ZHdndC96MUxTZndUSnR0VTVzMGgyNzVSeHErcEFLMnhKQ0ZF?=
 =?utf-8?B?VVhEbHpRRVVXb2diaFZtM0pSQkFmdUExUWV2Vk05WjZieWxEbXMwME5wWDRK?=
 =?utf-8?B?bVpVNCtFU2g1R0UzWXgzT3dEVkNWQlh0R2x2VVFRRGhuY0FyemlNNStNaklB?=
 =?utf-8?B?NHRqZGhCa1FMT0ZUamRWbWF5RE5jWmIzcUJicWNoRW03Ti9yWTZtalhvWTQw?=
 =?utf-8?B?anFZS2lvcjZBK3djcnR5NXVzTzBWdk12d0xPVVU4RC9aUWN5K0U3bjlDZ1o4?=
 =?utf-8?B?akNWTlpjeTlnd1ltVTY5WW5CUnFtNm1obnAzWEw4NzB5WU4waXEvSSt6aG9h?=
 =?utf-8?B?c1RIcU00Y05IM3J6czhOYjY4UGFBM3RlVEI5Z0tNSlIwMDk1eWpYNWJIUGd2?=
 =?utf-8?B?YmtvSi9USkJxNXc1eFk3dEVqc2dueFd3b2xoVWo5TnJ1NnVHOUpaa0ZRSGZk?=
 =?utf-8?B?WjR4dWJlTEpaTjFtb2RMTkV4ZmtoczFaM0FDbU5aVDhnWXRoTXVlNkRvL2Z5?=
 =?utf-8?B?c2xyd1JKR05tWXFtWXJoeVVDazl1OGRzUGZic2hEd2N0SXI5MnV2RGpCcG5W?=
 =?utf-8?B?Wk1hOGF4Tm5VL3JLN0kzanhZM2srRzJKNHBVQ0ZvTVB3OVdHVS8wbWQyZXEy?=
 =?utf-8?B?N1gyWEE5Rk9STGtlWWQ1RGViWUI1blhKb09RTk5hQjE2SGhNcXc1RjdzWllh?=
 =?utf-8?B?ZElzbTIxZnlhZGxWZ2llUzhDYXQ3YnRlLytHZlBGQnBuSnNpK2ZDOUh3ZGJK?=
 =?utf-8?B?U3lkS25kL3VQZTh3Rko2eHVobU5MTHpDVnBoVFBjWjRQanE2SnhVcnNWSzMw?=
 =?utf-8?B?Q2hDTnZXTFowbitMYU5JM29oRG1WR216YTM0dmR0ZVNFUHdzV3Z0UzNrMDg2?=
 =?utf-8?B?aEZUbERjMm0wOXRCODgvbDFveloyNmtPUW1IcHdZTUdJOE90b3owMjVzUTFY?=
 =?utf-8?B?YlZWRVFESENXYXpBaEN1RjRTc2pjcDZpd0Jib2pzblhFcTgxRUtIcmIvdUpq?=
 =?utf-8?B?Wk5Jb3pkQkZqdGZXU1Q2T3JGRzN1MHVFa1ZCMmtnSno0TjhrUE51MlRIZnht?=
 =?utf-8?B?ZGJkbEdCa2U3RVJPYXh3TmhjdXljN0MxN211RnJhVXlGczFlSVpSZ3gwRXhz?=
 =?utf-8?B?VGVuem5hc3o3RXc1eEo0ZEJCUXQ3MXdtRlowdTdPclZCRlNoV0EzWi84aVFQ?=
 =?utf-8?B?cGtJcVBlM1MwWHhqQjVOcEdCN2hDcG9Fd2dhaGNyeXh3UHJTL1pvdDFFb0k3?=
 =?utf-8?B?b1F1cFF0blh6TVd2WkRQK3hWZ0kzckhDUEl0RnJ4blJTTDF2Uk5XSXlaZSt4?=
 =?utf-8?B?b3RTdFBnZ3ZjTnlIU1hCb2lURm14WmZQenFJalJvOWFZNFNWcXhmMHZZQ1VI?=
 =?utf-8?B?ZlNDQnhVT2NzbVV2Rnc2VXhGbFNhSWFRWEhYVFpDY1Q5bVJYdG9iaFRLZm1x?=
 =?utf-8?B?UE9YYW5GRkdBZWdPUGxFdGlhSy9ETWxFT096aVJtVFB1a0RDSHgyTmFEWk4v?=
 =?utf-8?B?YzdhcStZL2VBQVZmY0tPWGg5QnNZQnpVWkYwWW5ja2NnTEJiQlJJVFF3L053?=
 =?utf-8?B?RWdaZ1pvZ3NYK1pKSFVmR2tycytHNjEzSThBVUVsbG1aWUNPZ2Eva3VmMGNN?=
 =?utf-8?B?SUVkMzVMVFhKTjdKWGhkNktpQVQ1bi9KMGpvQnB5VlZ0Qks1NldLMkhnR1BI?=
 =?utf-8?B?VTMzVU40OE1CbWZEZmZvaVoxU1YvQTREK1B0R2RIQkNpTEk0VHAyelFTMWN6?=
 =?utf-8?B?NHVoOGozbThaSUhkWlJHK0J5VFZuRVVJVUV6bFpoaFN5Qy93WlhkRXo3b1ZK?=
 =?utf-8?B?d0VsN0hWdFI0VDdxNFF4VkcxcVBSelZ6SDNCR2ZHRG15U2JJQmNGcTlHMW1Y?=
 =?utf-8?B?S1RwdnRzbDBCTzdpUVYzV1BNbEQzVGY3NWRWNGR6WEdmM3hPN1FDeUloeHZx?=
 =?utf-8?B?NWZUb3Y1SGErTkgyRk5qMkVtOHRyNjNVdURsYVBvd1pJWEFBV3lqdThqcm0r?=
 =?utf-8?B?bnRDRU5RYW91SEZ5UE5RMElnVVlmTkZwOFExOW9oY3BFcFgzeS9ZSFlFdFpF?=
 =?utf-8?B?NER4Zk9HRTBWd2RnMzBFUmVzdVB2b0hmb1g2dWs2Nm8rWlhFWE5VNnRHdHky?=
 =?utf-8?B?ajlmMHo1SWdKVVpvR0dqZ3hGZW5jMnZKdTdjZkNHWnp3SHhPakxCdWtyaGhr?=
 =?utf-8?Q?RxVTKQ3StPPynfHPmv?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 646bcef6-29aa-4bd3-8b29-08de68b313e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:45:47.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCmXPutlWyhT4nXesRm+F9OFFUEBGWfryZsZCv2yfu4yqJiVgqWKpyvAFL3JSFtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[axentia.se,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[axentia.se:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6535-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[axentia.se:mid,axentia.se:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A620211C098
X-Rspamd-Action: no action

Hi!

2026-02-10 at 08:50, Geert Uytterhoeven wrote:
> In the other thread, Josua pointed out that there are already several
> drivers that cannot be enabled if MULTIPLEXER is not selected by
> something else:
> 
> drivers/mux/Kconfig:
> 
>     menu "Multiplexer drivers"
>             depends on MULTIPLEXER
> 
>     config MUX_ADG792A
>             tristate "Analog Devices ADG792A/ADG792G Multiplexers"
>             depends on I2C
> 
>     config MUX_ADGS1408
>             tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
>             depends on SPI
> 
>     config MUX_GPIO
>             tristate "GPIO-controlled Multiplexer"
>             depends on GPIOLIB || COMPILE_TEST
> 
>     config MUX_MMIO
>             tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>             depends on OF
> 
> While MUX_MMIO is selected by some/all(?) symbols that need it,
> the other three are not.  Are these three really dependent on another
> symbol selecting MULTIPLEXER?

I think you have the gist of it, yes. It's of course not ideal...

Cheers,
Peter

