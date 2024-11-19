Return-Path: <linux-can+bounces-2105-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D49D2149
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C31F21EB8
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440F19753F;
	Tue, 19 Nov 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lAeS7BUF"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FFE7F460;
	Tue, 19 Nov 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003863; cv=fail; b=OTHfQg1XPjw7BJrc4bhRazI5AxGDViv8auoEFsHPuSleh5LYKfmiui+x8k+IO8vFT5ojzP/z9l7FTG/jrBYhmTplFHIo5ZD6U/bWe+eu4agfSY5cjDqmxeclk+a0X6sNDzpJujf2pevP4EScEtsRJg9kJuac0XzhhkdVUqvOV3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003863; c=relaxed/simple;
	bh=N6vPTJyMoVRLNgSgFd1HYli+mm9ImXhxZT4ZL8koEWw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dwKqIczPKsDwXHesxGJHWeXTa5cOwzaqD4W1p5XtzXGShIR05nCTZdm6QOOHF8/Cf8Sxrd7uYvzyTgC2fSU6eQOYGplI9+sHZIX12ZvTpeFgYR5mhmEk5tRrmuYEdNmSa/cu9ZmZu+ZXMsMWEC6wgZolMaLMvtagjSLACb5/W2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lAeS7BUF; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFtczy1TPLprmrEMEMrO9auv/9fggQS+6uRst65Wdop3nATE4NElxMOfhjBwaKMx1i8SxRCCdxBJWYqk1lmSM0nNozBL9FGWM2VgHBowfbUvsR/20fu7o+wXM8jK1SGToxhF0xGspgao05kSe5q28zgfPNhTPTUrhYI4/SL2t3VxaCBxDH/l+4mquY6COkRPsU7xeyI8muHH7SNLO1c3DqtmNqFH6KeznSZETAkjrUI1xu7wtNJ049KtVnM4wp2RrBbhYrflKqtojA+/TA9rQLXuyrMS7yelfHazoDh0H8HTrzl7CA6D2aHLpZkdTMJd1AZfQEK6uvXrk4/r9+e+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw4+ypKFhmCIoUFpVi+i99140MkGOBC2eI2d4ZpaQQk=;
 b=pYjB60IwvOX2/1Cxm/Om3+t2HI0f1BxNFTxjhfJTr8TwfBLteAQ0efdTkJ2T7+xXqdP3mFDxNyOHUODr4/DApRm5T3NLkDd2r+rPb0IaAUUcxYaVocffh8DlhknbpItlgQM0HnnfWxylKeEWxYd7mTg49lsi5+JlmkwLeT6M4IyVMll2aLBrWf+QI8LDPUw49xYFsg9WrZ1flNudeJFGE1+QcF/dMSeWRwgbJNkVIdj1AHL7sQyVaiaRVBaJGwVelyLDBbWvF/j0wXebSappwmnR7xamCyAbhkGMwIpntfNSqXRdowasYlZ8PnIZabMgRlfvvC6pKqUm4ritrdQdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw4+ypKFhmCIoUFpVi+i99140MkGOBC2eI2d4ZpaQQk=;
 b=lAeS7BUFR7hHxnBFlb23Mu/kPkozdZZ8bdWwxkBc7OHg1LDl93AgvDRogXMx6f8JWoza5xnkcGDEw1fBB1Tsu3ORotB6lg1bUBvHiNOqaz4shncfTMxGVbg1wchLYqe9LUeNtPcxSYKImyE+lqYZv394+gBdckO84xpFi1WanYZA1jTN11l+uPvGPSeo5Y2zq3ga+77rphkK9mheXrmKSS+Ocoj1092tepvl9wtl0XexMCbc5h6sTlc/v4WPRf/7ZdqRw6YyXmz9iVhTFs6tNBsocj3h5514Mtu9L7LlxLsNwz+IBeqM0iWFfauTGzD+or+IHnnHFwHkwrAiE1ysQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9058.eurprd04.prod.outlook.com (2603:10a6:102:231::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:10:57 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:10:57 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 0/3] add FlexCAN support for S32G2/S32G3 SoCs
Date: Tue, 19 Nov 2024 10:10:50 +0200
Message-ID: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15)
 To DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b98e7f-d435-4cef-a0ac-08dd0871b251
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHFUZExYbnNlSmlkallWa3BTS1JvaXNpNnAvNnBXdlFMNUwwYTRLL1V0MEtu?=
 =?utf-8?B?bGVyTzhsVCtZd2Y3MWkzYXFaTkM4blRLWHg2dVVKRXMvcUorelFGcUVlRHNz?=
 =?utf-8?B?V2JyU1NkK2ZyeGcvVXNyeGJRR1kvZXdLS0hmRHlrd2sxUFE4VlVVell0aHVu?=
 =?utf-8?B?ek51QW5SNkVGK29jVitlMjdpTjk4ZTRlWGZqdVpyL0poOUJialpIM2Rvcm9i?=
 =?utf-8?B?enFmMGkwUHdQV3RQNEg3QUpRRDBtVmFML1kvbEk3VzZpTHk4cEhEMkVsZy9i?=
 =?utf-8?B?UVdIMEI5a1g2WThnYStDaWF1K3JqT3VZZjBnZ3NqYytpZVRDUjREenZ0VDFj?=
 =?utf-8?B?bmlVRjZXM1B0SmdHOC9VTkJSMXNsQmprNFloaU1aUkFxTWMyeTNEdEVBMGRW?=
 =?utf-8?B?M1F4U1JBZUVESk9rQ2wzMUp1T05SbGxsdTd6ZzNNV0prU2FNVXBwVGhrbXdn?=
 =?utf-8?B?dTgyZ0lCMVBlWXZDenI2TkxaUExKZ0dVNUxoazVkaGcrUS91aUNFZk5PYkZl?=
 =?utf-8?B?cFdXOElEMFQ2aU1hZjZNcVBoalFBbVg1Z0YrOUJlZjEwUWw4L2R2QVVxUndQ?=
 =?utf-8?B?V0g2THJQbVJoSHRobUxPajVNeFFsZTFSbWNMRUpSRi8vQzl3RUZ0MUdjVFk5?=
 =?utf-8?B?Y2VQdzhHYnA5Zng4bHByV2pvL2NNME1kVjhRUEpWRlJVakRrM2wzWDNjVjRJ?=
 =?utf-8?B?Q3IrS25SY0MybjlQUG1yQi9WOElML2ZSQTRsSWlMZDc3c2I4WElqRlZrSklV?=
 =?utf-8?B?YlJMdGVYa2RoQVFsY1I3TWFOQ0wzOFpyRWJ2aXE4VWxpZmhqOTJ0VDloZ01y?=
 =?utf-8?B?b3ZqbE5QZUNBVldrdk5Hb0VabHpOR1Z3VzdlRkVURGk0NUFLZ0ZpSnIvaVlZ?=
 =?utf-8?B?NVFCc2pGOFJ5a1JpQUgzallQZDdYQ1Nyd3pjMmpGdDhLL0JZcWg0Z2ZXaHVu?=
 =?utf-8?B?NHhqU0pTRVpEdlBXcmlocGRxclhUTHRIL3ppL2tHT3NvQmk0TE9iTmpGMm1V?=
 =?utf-8?B?c202S0pMcFIrTmpkeTFCZ0dxaUg5MS9aSFBHcE5HN0NKUkNEaEIvVWdFWEE1?=
 =?utf-8?B?a0R3djJiQWdjei85UFJ3RWNBWC9pdlEyWlZPeXN3Rk1kaWpOY0ZXb2Q1SHRE?=
 =?utf-8?B?TjI4d2J5c1h0WDlYa0t2elRZdlRzeWtlL0ZHZnlaWlp6emxlVFhaMi9PUTNF?=
 =?utf-8?B?T283WVZpbERBZUhKSjNhbkgrREpnc2kzeTVNNFRIaTVnUlFZUkJDTVZEaWZn?=
 =?utf-8?B?VEdRZGw1azUwaWdYRzhGM25mQjlpa01kcDVVTnJuc01RRFkvdlRUZFE3TGVN?=
 =?utf-8?B?WlNaUk1qQWpuRnl3NHNZa2llUVFUN2hFNGJKMFhXMDJ2NUlHWDV2UEtVbWJ3?=
 =?utf-8?B?eVhuR1VHVEI2V04zN2cybjY3M21rTGo1THloYksxRUIxSnViZ0VpUTRDRGpi?=
 =?utf-8?B?NHFmQ3VmYU5Yak1mdm11VXJ1V3g2U2RsOXlEVTFKSzc5c2cwZmF2a21zV3cz?=
 =?utf-8?B?VHE2MVE0KzQ0TmJOb3Fua21QajYwL1lJUjRVTWVTeEtSL2lOdGRSQ3U3UHM2?=
 =?utf-8?B?RmQ0bjZqTXBpOEFoUitWbzVYZk9teFV1azlPT3ZUTTgwSjQ1TVRONVBPWjgx?=
 =?utf-8?B?N3pZZ0dOeHBMdkQ4clNXRUFvcHpNdUFtUGJqcnd1emJ6bkR5U0Z5V0k3Y1lv?=
 =?utf-8?B?NktnenpYaG1SY3FVRVhBR1RtZHlBZGdqN1owZ2dkZXBJeXdCSEJsT2h1RVpv?=
 =?utf-8?B?SERkZjMwR2dnY2NSZmtoRDdXTmhHTnhWaVNMczZHWVdhbHpaaVFTbm1FbnZJ?=
 =?utf-8?Q?jZZD9YSYU0TtDE0zUzMED0qwIuwWCkJgw9vww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE5VMHlZdzRGdUgzcnJwU3M5UU02RmhqWFB5VGhEd1NWcURJb3VveHFyNS9v?=
 =?utf-8?B?elBJMWE4ZGZpV1oxZjJpWWx0and2VTBXNW1iZG1mQzE5NmdRL2VUd0ZoLzY3?=
 =?utf-8?B?YjE0eWZrdGJkc0tDYnR3QTkybzZGSEtuZU01Y3lublA1bml2cjNvR3JOaHRC?=
 =?utf-8?B?OHl1dEFXakljSnBKRWxhbDJUbUFaV2dFSU5xOGdEQkhSQXI3Q2owSDBpcDFk?=
 =?utf-8?B?bGJCK1NCbEFNamRTSFVTOUt4VEpoRktHWFJ0ZFQzNmExQnlJcVFMcmFXVjd3?=
 =?utf-8?B?MUdKT0dhb0QzQk9SbHUyWEZLdGJYd21Zc2xCMllDTGxZRGhKbkJyK1F2Q3RP?=
 =?utf-8?B?QzhaUnppQlcrMFpWRkZpYlplSU5BbGdYZVZOSWRZQ1NPeitMb1pFKzEvcWxK?=
 =?utf-8?B?cXl5S3A4bUw4aWk4akdZY2RueWUyZkNkV0pWNXNqM0o5SjZDNjBoT09zbmJB?=
 =?utf-8?B?bjBPK2pUMDVoVmkvbi8zL3h6c3pTaU9YMk55NkFzb0JTRTdiZVc5L3BaYVgv?=
 =?utf-8?B?SzRvWFN5TWs5c0hwWnk2b21ZdFFOejQzRkhISUMySmZMb3o3a2hYWC81Y3k0?=
 =?utf-8?B?SFRNcFViZERUK0YyUmNtZXAxc1FhdUJ0NG5qdG5zVVhPZDl1anV0MFBuQjRB?=
 =?utf-8?B?clhrRnY5Tys3UVA0M0xOSE4xT2ZaTEZwb2d1cnRZdWZJSngxS2hlNFJuei85?=
 =?utf-8?B?NnhFVGVrZTNtUitpZmp6MmxiOEgvU25DUFRpYXJGMHpXMk9PcnNmTmsxZFpP?=
 =?utf-8?B?TjRFc3hIdGpxMDJUQWJTMVpVM2xZek1TVUJyeitMUEswL3VlMDlmVUd1Zk1v?=
 =?utf-8?B?WXI2dWttQUVCU0hIYTZRQWpWSUE1OHV4bVNnalNaUlg2L3l6YzY0MWxhZU9o?=
 =?utf-8?B?VUtkZWQxZ2xtbU1GbEhMbzVrUUxyVmdoMFpsSlpSb0tlNlBWUjBNVTlxdWZ6?=
 =?utf-8?B?MkRVeDJTSVdvSkFOSXk1azJvNFdwMEI5V3J3ZGRCYTNmQ0pqVDFVRkdVbmd3?=
 =?utf-8?B?SGg2RnlLeEx3Vkw1VzZFd2hUNUFuYmdNaHdDVkhDNTBGMTBKNjdQZU1KdU1y?=
 =?utf-8?B?NWpIc3FISHF2WFV4SHRmUGgwMWMvTi9CZXUyejZhYVpQc0pscTNjOS8zZTBO?=
 =?utf-8?B?SnFhVkhNS1AvS0tOOFJXcldpRjVVYWFuZE5BZlpseHE3Vzk1Rlppc2NSeC9R?=
 =?utf-8?B?aEpoUzZHeU8vMlE2RSs1RlBYL3hhazFIZjhDVVQ2Zkp1ajFINzQrM29KblE4?=
 =?utf-8?B?VFNianBBM1grS1NpMFpoUnpTakRXL2NjdUxPcVFtcndELy9ZbkpxYzJCUDky?=
 =?utf-8?B?VUcrOXhRUU9HcHUwcWlzaWxyZVJCOUtZcU1ncGRZMDUrbkNhQ1BtUllnTzVt?=
 =?utf-8?B?S0liV3Y3RnVac2hVY3lmd09sbk1wVUV1WFQrY25Wc3hZdHZpbFRramhYN2wx?=
 =?utf-8?B?SUJHeWVVVHo3dlloc2VBeVNkTWUvdHJzV1Z4TVJWWXRxaHI0cHBqYUV1dWlK?=
 =?utf-8?B?SnBVcXFld1dnZ2M0S3JaUTFTZDNodmc1a2NhRDdYK0FrLzR4bFdYdkpwR1RJ?=
 =?utf-8?B?WkVrWU1zNmVla0ZRRWUvOUM1bkM3N2hDLzNYOGtYSXdXZ01nUURZcTYvMTVO?=
 =?utf-8?B?dm9BRW80V09iZDhkazhDeEh2Y2hXRjhNZnYwZHpPTUM3MXhwTDRjeWtpNCtQ?=
 =?utf-8?B?MFQwYTViUTNaM1RselIzNXhOTEcxT2Mxak1YMGQvNytRVThwc3YwanlUSmJJ?=
 =?utf-8?B?TXdJMlh6UFhTU3BIUi9GUkc4RHZpWlZUSVY0OHBiZnJOb0ROVkR3U2R6Rmh0?=
 =?utf-8?B?ZnJHdGpKWkVwbExoNzI1ODM2Snl6SzhkdWpieVpyeGhLOFBQVGZXdnpvc1JP?=
 =?utf-8?B?SlJDcEZFci82eFJlRWlTRzN4b3h5dEJsWHVITTE4UzZoQm5NWVpnbUZEVnM4?=
 =?utf-8?B?c3RGNjBFUnV5ckdSTmdib3hVWEkyU3VTb3hSSEpoVnE3SjdGZmx2S1hQWlZ3?=
 =?utf-8?B?VGFpSmNoVHpkVjdySHN5K2dMcWQ0Y01yaXhwenc3c0NJLzk1c1lXRVIrbldj?=
 =?utf-8?B?U2V5ZG9QdmhUSERiWmlWRU9Pd25PMFpFWjliWmsxazZrdVJXZlh2YWQvZFlO?=
 =?utf-8?B?UVZ3cWR6V3lENzJsQmxlS1UxckVMTmJYdjZDMGpoVUg4R01mTkI4L0RnZEdM?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b98e7f-d435-4cef-a0ac-08dd0871b251
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:10:57.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUc29ESc7kDVA18wg2kb8Q+z2twbv61AtyDSzgMC7UiGl0jd6+nR1ALJpkUOaHlKDnWXXOSCi3bvIFGFUB0NNtO+nYdICXFjgJEcF3fxxBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9058

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

S32G2 and S32G3 SoCs share the FlexCAN module with i.MX SoCs, with some
hardware integration particularities.

Main difference covered by this patchset relates to interrupt management.
On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, MBs 0-7 and MBs 8-127 respectively.

Ciprian Marian Costea (3):
  dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
  can: flexcan: add NXP S32G2/S32G3 SoC support
  can: flexcan: handle S32G2/S32G3 separate interrupt lines

 .../bindings/net/can/fsl,flexcan.yaml         | 25 +++++++++++++--
 drivers/net/can/flexcan/flexcan-core.c        | 31 +++++++++++++++++++
 drivers/net/can/flexcan/flexcan.h             |  3 ++
 3 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.45.2


