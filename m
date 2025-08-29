Return-Path: <linux-can+bounces-4388-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4EB3B3E8
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE56F1B256A6
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 07:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94C26980B;
	Fri, 29 Aug 2025 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h+RfjJhC"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A0267B94;
	Fri, 29 Aug 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451392; cv=fail; b=kUormkoBZh0UevjaHkOrTJqh4AUM+5uTlWWg2Ctb7Irn55mlVK1+tDhKUpuRP5XiQ4QDLA2QG7HIiz3qjyFk9Fg0Gjub6qvbTFj4XaXPFRn7+bmIUaY3RqUE1w2VRjBaZpzEWWArL8u7qK2Y4KYHSvYYKE55Nb2f6sS+sbW1rY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451392; c=relaxed/simple;
	bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XIY8uALf8SYgZkzoRcyfQSpR6hzUStWP+GqL3mjVY13SL29QApBe/Bz06TB7nr1DWCoxxnVl5TqOTvzIFomgnyQdh3UpVIiP52BPpWZTTeWoDtUxSgJZ3IJVwvyTsB5N2SqsyG2iSzK4S0/5SZDIRFnA7Cdo0MfgLbWB0KrL3wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h+RfjJhC; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL/apvEZl2FODlj9Z/ou67ctMQnSQ/ZVzspOLn1+r9xfbGabAfC+o/URX8Fskp+y++Za6Pv66qZ8y0CMl2WAeAFNTY5hpTaEOFKD2jWA/UX+8zQyXJGoz91zB1767G3YV15wH32C34dZMGfy6u2jGJb1bEb1d6boQ1pYuU7voJlLoygXy+mfM1F6P/77egenlp2fBaP8Ado7rE8zMn7O4F/4FYGrQo1fwMRwdOcC0BUR/gayp7wO80S8UewlJu9ghJ/1/oydbuhj/7X/Cffg6INhb6y7txIWLrricdTRUmM2XBMVc3lfqKK+1fe6WBTrGrQZy6b4nTqz8A1en/lsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=LRdXE1cXxzhNKs3Iv2reN3nGTLFrtZ9oTtszCsNOm0dFkMXB2qx/E3hMHANIzwpnrAKd3CrVx1LoDAa4iSm8RpS0jl/QJorhkRDt1ne2g7OWo9D58syqo9jw4oqh4mJIltA3B+WGj+7qg+I2r7wXpIYxMDPZ83eRuwOLoazb9y0n0ehSloGy1EM8WFw1HbKljW8hGtMr418ymzUdHYpq9865ThwnlUEE1O5z0cCj9ZR0EmbuLhcC7YKafs5L8tstoOSUt9VdeEU9zmwIrxdZT6vxHrP63O4PaAqouadDJ/tsBxphomL4ZsRi+uilUTvMt07ZI13xLmlU2LBidYeaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=h+RfjJhC9c2JYsc60SqyBbWzy7LVR5DFV0lS5RGB1HBTvlmK4nWDcwhM9+H68bxYXaPA5Zi7pARJyNmCUcb5o3AAOcdL17d57CI/wL0wop7ws9wvAXsS4OGW1dQQmA+ZdtrRy50tSi7H+AIDenO3NmIV9qhqZd2/QrM2QxFETzgSoV2ZDzEq2T8JVMqi1p9njc10xIoj5Exu5U+CkTLoWRa6Z/19mZyZB54OeuWjl3ATAdd2mz4tc1C12HVpgkj6jwoZMjnBM2DHDBmYC/oMPS4XJFVsAzSM32ysqPr5OrMtI/lAvLFiQFsLmqf+65cKOdP/uw5Rcqkjt+Y8vobvtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7752.eurprd04.prod.outlook.com (2603:10a6:20b:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 07:09:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:09:48 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 29 Aug 2025 15:09:00 +0800
Subject: [PATCH v3 5/6] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-can-v3-5-3b2f34094f59@nxp.com>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
In-Reply-To: <20250829-can-v3-0-3b2f34094f59@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756451349; l=2835;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
 b=ajj73AZQmq+Pl/bkYRoUDv8z4DurSpNpFM+m3QpBp+4bzNUyBA0BCJsVEQDpBzdXoXar3XYtC
 rT2bg1P2/CjCrIMeNLwYPsgxxPSrazy11duu8KjwcPExdSsrc9hMzB/
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: c56ca622-16d8-41b6-850c-08dde6cb0a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzVqVm5WcVFJQ2ZIMHNMSVZld1cram96WWptclVoa1E2TndzS3Q2SE1LbE1a?=
 =?utf-8?B?dmVmeE5JMnJCUk9mT012TFArUGFOeXpJd2Zlc1VZdWREa0FoOGIwWEJvb2F1?=
 =?utf-8?B?NGp4bTdleVpzQ2pTOEdKcncyT1l2Q3RXMFMzbXFQSVNRZ1FSTm5JUzFZYjJY?=
 =?utf-8?B?WjNQejQxWFFHbk01NXZydXNRMmw5Z0pqY3ZrMkxpWFU5NVhxSjJjcWIyNVlV?=
 =?utf-8?B?MUJ2blRrQ3B1TkdQeEFadnVLdmhzdkZBbnNrNDJjUE1mQUtRYWlkZFlhVXhk?=
 =?utf-8?B?YzVsdmhSY2RFQS9NR3JpeDZXMC83c2dEZTgzaGh1MjhvN2xSS2psQnVuelc2?=
 =?utf-8?B?TC80V25YRE1oc3FrT21Wa1dSaXo5bjk0cVBQemU3Ky9Kd2JmWkQwZmJZcExI?=
 =?utf-8?B?MklQVjJOc0xTL2Y3aHJyZ0dSekVKWFBrM2J5QjNhcEtieWNFMEZnWGRxRXBP?=
 =?utf-8?B?ZUxiOGJ6YnowWTZyM0VIdGZQbUF2R3AyRFNBSGp4L1hPcldtS1J5S0pnSXJ1?=
 =?utf-8?B?N01GNWFNY3Q1S3ZEWURrQUM0cm93VDQxRzQyZHRMYlNiKzBVczFiRjd3Zzk1?=
 =?utf-8?B?TDFHUkNlWUFVNHZ6Z1BPZGNOdTN4cTFpTWlUeVJibWJWb0Q3WE4vSXNDSXdB?=
 =?utf-8?B?N0JSc1Y3MUNMbjZSdDM4ZERDcllObkVSSEdhZWxKTTV3V1JRVC9TeG4xRXlj?=
 =?utf-8?B?WVlwK29DK0JhNzBNNXJ5STNiSVp1eTUrOW55blNUYjBPM2xEejBTcDdxdDdJ?=
 =?utf-8?B?aFVwYWphNnB0RmZPbXpNM0xENjloNlNkVWc2d1lGbEc1ZkRudjBjcU5BUm16?=
 =?utf-8?B?YWRiVUtJZFdTdjNMMVZzWVcrcHJpQ1J2UVJNR1hhd244NE43dVNiVmRpRjNB?=
 =?utf-8?B?eklnUWlPYkNDWGx0MSsvQWwvVkhHREFHSDA4d21YUnJ5WjRpOEJrcW9EbDJL?=
 =?utf-8?B?L2NCOUc2dzZUVWJJZFZESGt3Y2JTMGwyWndNOUpnUFJUTHB0b1QzbEZvNlpU?=
 =?utf-8?B?azhCZUdqSWZRK1VZR1Jmc1kwbTNhekwwSXZ0WDlCZW1aY0JpUDVQUUdXVDh4?=
 =?utf-8?B?OHlaS2htNFVNQ1pXN1Y1Um90ckdsSEVCNkdRNnE4SkdZTzAvZWRQTmxhUXdi?=
 =?utf-8?B?K1BwT1pYaUwrSFNmTm1qeWF3ZFJXU2RNZ1ZVVTB0WGkxdnR3a3ROUnhHNXdw?=
 =?utf-8?B?QUxSRlZUc1hSR0FxNnN4L296SVQvSkVubXFUWjZDbnpad2cydzM2dlpqQUpU?=
 =?utf-8?B?aU5tQTRhamVHWjVYdzRXMmhnZGptbWZBNFdQZ3lpLzlHUWhBdVNaTmU5cmF4?=
 =?utf-8?B?UzRYeWhMN1J3dTBmSFZ0T0IwblFadG16WGhCajY5K2Vkdmk1WlNrRWVuMW1F?=
 =?utf-8?B?ekoxL0h1Ui9sOUs2TFROYzB4bjcvT0gyZnZudnNGQ2dQNm1UczVXT055RVpN?=
 =?utf-8?B?RkhnclRjNm50RkttZkZ3eGEyZnpVS2VkTVhWWjZHWG41VU0yVEdwcllROWFR?=
 =?utf-8?B?b3VJdHhrYzR6dWZxZGtuVzRUeW9DVDVzSjV3ZktVdXE5b1JZamNoK29XeWh0?=
 =?utf-8?B?alZmQk5rN3g1SC9zcWtJMEVQVkI0bjVOSXd4REpZc1ZkbjBwMGNoelJTY2pI?=
 =?utf-8?B?SVMzVGFZWnBrOVBFUnNDa3gwa3Jodk1HdEE4QU8velA0S1NkMDYrSzVIMGYx?=
 =?utf-8?B?Rzk1RnZzVTNvTHFNWnY2Qm1ka1RTN3lFZElydHFkMWRzNWRVa2tRdTJId1JW?=
 =?utf-8?B?U1MvTDR4QkFFazZ5NVNtTjg1MTZuWHlONGUxelEzMmMyTGZVYlgya2RwQVh0?=
 =?utf-8?B?bjBGenVYWjRYdG1zUHBTbTZPaXgzQ0V5ank2Y2VMVjFYS2FHRE45V254VmR0?=
 =?utf-8?B?MUQwTkdnZkhaMDFSa2hFVXYvT2owb2ZwYm5idWJlaTN2SnFsMFlYYjYwSGZu?=
 =?utf-8?B?b2MvUmQ0ZWJlQmZ6MHZ5WXZRWFhXR2l6a0ZTUTYvS3oxMTlNY1Y4Q2tTNVNk?=
 =?utf-8?Q?edhJCpP3XZj8bykvipJodGtqzoVsbc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHM2L09acW1KeTNiMDRZRS9LU1NPc0cvbit1TGp4Zm80bEQ2d3dXYXE3dUpl?=
 =?utf-8?B?Mnh1Vmo0UWFETU0zUGh6Q3hobkwrT2VvcWRmWkpOakJYbmh2dkFWN3B0T0Jh?=
 =?utf-8?B?SVpMdFdXM0xveWswUzVxcHBWK1ZpMnBQbXVnL1M3eFkvNkdZMGp0RTZqcE01?=
 =?utf-8?B?b3ROa2YvQjZoWmtBSS9QekZxZVlybHFYVGdHZ1BpSk1oSmhNMUJZb0pTVVJS?=
 =?utf-8?B?bjI0SEhVQW95d2NHS3FWQ2JPWHNEUExVZ2hDcVhjN0dpZ2pRaDljam4vQWM2?=
 =?utf-8?B?S2JsaGptbGFhZUQzTytDaExDeDJ0YjJsNGwzZEpkZ0I3T1BnelBaWHhsNU9k?=
 =?utf-8?B?ZWtYNlZVaG1wLzVKSWtZaGZaL2RnaVVuOHlQSitxWS9IMzJicTh6RzMwQ0VW?=
 =?utf-8?B?N2FVZklaY24yV0hOVzRLd1NVSFFnWWFURHV1TW1TaHhLTS9ncnBzY2Q1bVVj?=
 =?utf-8?B?Ukc5dEVsYnEvT0x4OTU5WXA4TTVJQnl0bk9GbDZTMkFPV3h4cmRxc3J6Mi9L?=
 =?utf-8?B?SkQ4bncwMk5lRlZPMEZBTG94VlRJQkZ0NGFCZ3IzQW5OeWxjTDdwL3g4UUxi?=
 =?utf-8?B?OTJ1L0hVU21DcUJha1F0clhSbHl1Y21XY0Jna1lWdFpnUy9EbW1LVFhBeWhR?=
 =?utf-8?B?OUtyYUhsQXpvN0VadWF4TmZ5ZnptaW5tTkdNY0pJWEtUUDEzc1gvYUQxTUhE?=
 =?utf-8?B?Y2hEV3czYlJPSG9ZRlkzQUQ4QS95c0MwcHRJUFBrR29wSmUwNTkvWlJHWFpw?=
 =?utf-8?B?eDlZMG9RNW0xM0h2RWczZFFpMzdjRmdDS3ZwYnRmU1RRVmRzSG1ta1krMEFu?=
 =?utf-8?B?MExNWVU4c25DamhSNUs5TFE1Ti9TMHZSMmp1cXNDT01GSG5KZGtiam5vZDl3?=
 =?utf-8?B?UkhVanA3RFJzTU5wS1pML3ZVTFVNNVNBSEJlbjcwcUJSb1VOQXRqSXZIMmg3?=
 =?utf-8?B?bzBwYzdjNHVWdTNweTN1YW5RZW9STFBWeUhYZkJIU0lYengyZmxPTGlzOHBB?=
 =?utf-8?B?Y0VwUGtZMlBYeXhyc3BKV0QzYm9PeGNSQ0xqODR0QlBNODdVMmpSNGlROEVE?=
 =?utf-8?B?cGZwaDhLMWJBaGJqVVVXanYySXFBNk92Wm91YnFCWDlTd0ZJQTR6T2pDWlM5?=
 =?utf-8?B?MVdOS1Z4bllLakNGOHdDWXZRdXl0S2s0R0pkQ2dZcHRuOVNrVWF0S0R4V3pS?=
 =?utf-8?B?b0dTWHg2OW45V2hiZHJOK1dWM1BBQXFZb0tvV2FaK0FBcXU1TmU0WHVlOG5R?=
 =?utf-8?B?Y3hBV2VSU2VXbDF0bzJ1dDIwTEpRWG5rM3MxQ2lmc3puOTIzK3dWSmFNSW9O?=
 =?utf-8?B?Q1k1aFpEQlBqaW52cllmb0tpNlhzMjErd0FibnB4M2pCNE1waUljWE4vYXhW?=
 =?utf-8?B?TU95QXZRY0xpdUl2SFZBd3VCZ3M3Rld1a2d2WnpFdGFTT1hST3dYL0RvREdE?=
 =?utf-8?B?K211ZC9teC9INkNGc0pEaFBSVGNhdVh4NjBEa3lQVlRFaGRnVDg3RlBKbXd2?=
 =?utf-8?B?QStDWjRLbUhYNU9TQk5aUi9ac1RCalhaMWhucU5PNDEyNng2eS9ldk9yYTdY?=
 =?utf-8?B?dUdDYW5xdUdWRWpxaTJneTh4SktMUWw4czczZTJ1a255azRScFBmQjdQVGxJ?=
 =?utf-8?B?Z3l3NlBHbWR6M3JhTHZzSmVaWEdqMmlYUVJlaCtKWmRJMEVEaHpyd25HWmdF?=
 =?utf-8?B?UGlDYUN1WU50SnVudHI4eE52U2pXKzVtNmVIK1BtQ1REVW83TzlBZ0dncmhq?=
 =?utf-8?B?aCtuMkdyTW11T055djNpcXN0Qm9CeXNSN0kzZzNYSFJNNmZpTWtxQVh4aWJ2?=
 =?utf-8?B?b3UzTHBDQU9ZRkU1ajdjSjV3QVVLUmpBdHhxeWw2NkxybVJaT2IyWTNSaTFG?=
 =?utf-8?B?ZHpqeUFXbzRBaEpScEJqTWVTcFg4Vmszd3M4Z01WUUtyaGNkZHFuQmRBb1Ny?=
 =?utf-8?B?SzdPaktFS3p4QmpOZ2VmeCtwbHVXbzBBdnJWVS9TRWJ6MHkxSm5GUlFxSWdQ?=
 =?utf-8?B?Z3F6N1J4SCtpWjBXaDNnMUozNGJPdkNYdUFyK1VIVW14Rk1tL0VTT095d2ht?=
 =?utf-8?B?NHZ4UCtGbTFuL1VKeWhLN0xzTThwMHd2ZzBKZm8vN3Nua3BWUU9XLzF2Y0FS?=
 =?utf-8?Q?e1Q3rk7VCorPquO8zcuNPwmc4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56ca622-16d8-41b6-850c-08dde6cb0a58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:09:48.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7aF4PVxpN5nNeQAFOpT15ThL6uBq9Vr+tGvvlhJSnnyKxDFtlCcX2vj8iRFsCmBKz3dd+fwhSr0lBnM04K98w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7752

The TJA1048 used on i.MX8MP-EVK is actually high-speed CAN transceiver,
not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 43 +++++++++-------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf5010213cbb9f6869a8110ea28eb48a..59891627dc462d37dfd620eb68b893546cc20d6a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -56,6 +56,16 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1048";
+		#phy-cells = <1>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan_phy>;
+		standby-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>,
+				<&gpio4 27 GPIO_ACTIVE_LOW>;
+	};
+
 	native-hdmi-connector {
 		compatible = "hdmi-connector";
 		label = "HDMI OUT";
@@ -103,28 +113,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can1_stby: regulator-can1-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can1-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan1_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan2_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_pcie0: regulator-pcie {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -431,14 +419,14 @@ ethphy1: ethernet-phy@1 {
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_can1_stby>;
+	phys = <&flexcan_phy 0>;
 	status = "okay";
 };
 
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan_phy 1>;
 	status = "disabled";/* can2 pin conflict with pdm */
 };
 
@@ -903,14 +891,9 @@ MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
 		>;
 	};
 
-	pinctrl_flexcan1_reg: flexcan1reggrp {
+	pinctrl_flexcan_phy: flexcanphygrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
-		>;
-	};
-
-	pinctrl_flexcan2_reg: flexcan2reggrp {
-		fsl,pins = <
 			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};

-- 
2.37.1


