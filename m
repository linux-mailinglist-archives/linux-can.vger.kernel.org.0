Return-Path: <linux-can+bounces-2313-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316529E021F
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 13:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24661165C43
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 12:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81D1FDE2B;
	Mon,  2 Dec 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q1lKZ5UA"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359241FA857;
	Mon,  2 Dec 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142324; cv=fail; b=pcbgJtQh2Cs/ZkAipuy7EyoAfSERzcs61o3K5NtsmXrIFXFk4fPrPYkvV/T80gtxsZr8gWQASg8tDRtff+HuPTcGt44y4FmrauV1LSNTvx/PCJxG7MPHfYSRTXCe1uhzE/IrU2bJin3OHnx/ABZTd4D4tGiOfgZIlSxc2NiKsKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142324; c=relaxed/simple;
	bh=nED8MkGzrd6eK5+RxTfwjsthdqQTF8M9CUw6LrgTbW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FB3SRQOGzVJX4oN2a/pY7vDNGeQX2wkM8b4HanzGFFraVOhjgUhqPneBXQ021JxsVJ6KPjI0CxfKdlZK36tcSYletIPgkVfkPhsOowoTJ4gOX2WuDfTZK834OlEmwRIm8PzaFQWjVZysy3h0QNzlHmk9DrRShIrYvbId+dNqRAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q1lKZ5UA; arc=fail smtp.client-ip=40.107.103.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymOM8JAA+b0dJFhHEnzW6IKxO7udI4FjUsWaaaizfZegIhocAGn/hSTMt2GZcIaLMVSa7XNn36+ijdjFpS/toHG6G0bMGnH5hQ3pbJ9cK48bELVaCZTwODeKaThW7VSANNLNhV6CWMeBYC3J44Y/E4ZKh48TI2/zevFeNXpRzcybA6fx+j815/xBNdODGgNHzogNHvkVtUV9DaUtwxDHzRIE/bC9VswOHoOb2JHeNpornWSvlVu/j1+77rHQ2d+GV+FV42OvhJVYwguEmxAtyFCbhexLolLc3Kmp43rfkB+/deBglst3jBDNOB91podRS6sLNDJO0TMpYqHgkQ3/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T2zFQbj/TrJCqm0VA3rp0V3U4AJ6HUSVSkbzQb8Zuo=;
 b=nG0HLmo5oStDREgDFf0LPNsxZNj2A9gUzYhHubtgn8NJSSkdr8uM9lNBd5c/se1/6U+yFiABqLQ+1uYvGbGEPzxuLT1a+BVYeYEDNdjJ0bc0Hd2DQYc+WVtbHrrNrUp3yN/MmB1DRUql/cf4Pq+FF0gQRJ1cesjxxh8k9bcw9px4IOtlXPkpoAWuAPggMcdOrA3eHPZYYpNbpiOMKELi7sl1AeXC1TKauojHkmXAY7ebu+EM/hqVG8MEQ3SNBdUemjhGV80p1zacfZC0VkkTD76g22PLFRA/aV4TsRnW2vivIg/Wo1PMB5wUhzswByG59YKkj0pWIwZ9GCBwNdQNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T2zFQbj/TrJCqm0VA3rp0V3U4AJ6HUSVSkbzQb8Zuo=;
 b=Q1lKZ5UAKdRO3J3X0MDELOYOABM1lCmUo5TijeH2z3PihozGfzWNvunJfFOiGDzPdGuKMhjA+Yl4mCz+Xi0sCy6bgJMTd57hvyM4baQtLrImUpPl+kUMj2ArsU2k5MIwk6Cns7Tgi34rcOgQ8F+4sk1NIF3Qmfy1dcs9m/VA5jZ+qblN10aKf4zfPv0vrwbNcnGR5ilwPc03puZXkw4j/8YX4PB5X9tdGyijgRxkS2S2MHeyf+7qkymhRv2ODB4ds52dIVS2ajjU8qEqeLaJ63k3slQ7aJhm6c3sYJInbU4i9zAFMErhK0I5zNe7/nCaMlrjJtcKjXH395IGDH1twg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 12:25:18 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 12:25:18 +0000
Message-ID: <d2ac47d2-3c7d-4d22-918c-12693ce1a60e@oss.nxp.com>
Date: Mon, 2 Dec 2024 14:25:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>,
 imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
 <20241129142535.1171249-2-ciprianmarian.costea@oss.nxp.com>
 <251054e3-f80c-4feb-bb07-b581d7433933@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <251054e3-f80c-4feb-bb07-b581d7433933@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0010.eurprd03.prod.outlook.com
 (2603:10a6:205:2::23) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB8PR04MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c4f901-8a8b-4403-70a8-08dd12cc61a6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlzOXF6WmQ0MjEydlBZRkpzL0V6OVhsRHJzWUpzWDJ5Q1F2NTlhNDc4SUVN?=
 =?utf-8?B?b2wwOStLb1Z3NXl6SjFURmsyVWNDeXYzZ2R4SG5JYy9HdkxlUzE1RXZMNE8y?=
 =?utf-8?B?ZFNwSU5maC9FVDVwKzZudWQ0Vm4xdVZPM3gydGZsYWNDYmk4TWRzeHVsWXcr?=
 =?utf-8?B?L3lHcHlETmExdWFvbGFIeTJJL3E4Y0EwSVNDSW5SOVFaODQ5YnBXaENabXRi?=
 =?utf-8?B?UWRhaG9QNXVBTHBCODd2WXN0bUM5Vm5SSjNBVzFTQ2hscjRmYjFKakgvbTlv?=
 =?utf-8?B?YVlrbkNEOWRVUnJXbFl4dGRIdE5NVFJIVUR6WVRKU1BvSVpMbEx1Smxramw3?=
 =?utf-8?B?OFR2WkYzZnNXZnVEdSttNGZnMlVJcW8xTkw5dHJzSng5b1RzZ0poeWQ5SWQz?=
 =?utf-8?B?dlRjWTk3bXJsQlovdjBiUE51WmFpcWtHNXlONHhJL2QzS2d0UXpSQ0Z4aWRW?=
 =?utf-8?B?VmVrQk91TWlMQUc5NGdMUHdNWEl2RkVxcm81YVpoSEFubTRXV0dLeWpNZUJi?=
 =?utf-8?B?QnhxRGR4bFZlem9vNitIaDY5b2I4Q2pWaEIvL3laRzZZcXhDTUwwejlzV09w?=
 =?utf-8?B?bGdFSHMyNmY3Q0FTUjdrN1RTZlEydW5tNzJ5UG9COE9qZi96Zm1hQ1E0ZUdE?=
 =?utf-8?B?NS84Nk03NHlqMlV5azRYTUxMcDJqOFp5R1dnTU5CbjBydFlTV2d1R1N3Mmdl?=
 =?utf-8?B?bUN5b2MyeU1HTGF6NTIzdnIwbXBpZ0dBZ2czem5kUUJLdEIzVlVjUXhiYytP?=
 =?utf-8?B?ZHErOWFpc0hzNnVKVTc2cTFMd0FFYllxYzk4aWVKRjVMVFVmV3UxOVVxRmgy?=
 =?utf-8?B?bnUvQU1rQ21JQlptbmYwVGNJVVdTWG90VHgwenhXajh6cW9rNitQUll3TkI5?=
 =?utf-8?B?bUluWVFYMEtwcUNzRjcxbEw2VkpqaHN3bmIvaFlkK0w1ME1mWG55YzlGaUl2?=
 =?utf-8?B?VG9NN2xhTmVoclRkVG1iRCtnUmlTVFBHdnBvWU15V3JtM29MMWdoNTg1dzdF?=
 =?utf-8?B?Ri9PeGM2dWxKREhEc3piWVdsTG95NUpqcjVhYVNtR2dKWWt3V0QxYm1OdlA0?=
 =?utf-8?B?c2Zndk1DQStGclFUdTc2SFBQME9EWStoNUpOYjlOMmtjUEdNNVpDMXY5blpW?=
 =?utf-8?B?dGRsVmhPT3JaQVpIcnNZVjlySWplMHJiY1dMV2s0L1BxRWg5S0pHY051QU50?=
 =?utf-8?B?UnJYZWo4ckplYnB6aU55Qm1rSlA4dVVPK0w5a3Qxclp2aWRMV1BneGdvKy8r?=
 =?utf-8?B?L2tMNWh4Y2tOSmprZkhITlFldTNoTmwxMEowU0gyM3dqZjZJbnNrTmszaXJE?=
 =?utf-8?B?QzlqMXd0aXE1YkNiUVlKU0YwcXQ3eUlvRmNpUFZuaVBkZFVNMGNsaGp5QzN1?=
 =?utf-8?B?WGd3R2JhOFE2M3lkL0hqam5rOURvalkzMk50U2RxckFUaDNyU0FhVzdKQnBC?=
 =?utf-8?B?Zm5zc3BRb1BUaWlGOC9wL3QwTXNoanp0SUJXTmlxQVhCRStiNlZvTXlZTllk?=
 =?utf-8?B?c3cvRnlZemZmK0xKYkFBNDZHY0FqeTVaRFZ5anJJd1R0ampVV0JkbVQrT0Nj?=
 =?utf-8?B?SWk5ZUZNbzFuRVFQa3JUNnEzek4rVXBkZHlYT0xaSmtXNG02ZXJjaGRsbEdJ?=
 =?utf-8?B?VE1EWjVYazJLdVdCR1doUGh5SUdBd3dTODJjY1VseldBSnhna3Y2VkZxM3lq?=
 =?utf-8?B?UGlQblBEUHFiV0xkMGdiN1FQSTJZdkVuZG1xUnMrU2R0U0tRSzJPWmNUcCt5?=
 =?utf-8?B?N2F3aUdqdmhKd0t2dExWZzlnTmRhK1dNemxCckpZWkMrL2FuOC9wTVV0MWdV?=
 =?utf-8?B?bXBHU0VxeW9SZ25hN043Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZ3RHNhN0ZwbWlZZG1jZkVzTkVEUUlNdTFHU1JFWTFvbWxyMjR3bmU0ZzVj?=
 =?utf-8?B?ZU5VMXc5alY4Q3Yyek1EZVEzS1ROV0hKQU1mUlhqVkEzQjJ2Nyt6c0Zndnhj?=
 =?utf-8?B?SHpWSWtPZDFYOExaVndsbVVuVFJoUzdFUTRNQXhSSTdsUmVGRE1CdENIVjR5?=
 =?utf-8?B?TkUxNitlNW1aWVN1UW1PQzFoOXNSS2g3T3pnN3loRXkvbmRITEdiTnFQZDNK?=
 =?utf-8?B?cXNOa0dsZjE1QW9wNkxjTWtWUzlmTlBuUTN4ejgrNElzUGlGSGIyeEdGSDlw?=
 =?utf-8?B?YkwxZDRmQUNQK1BEVFVMK2JTK3RVdUN6SmNuRHJjK3FQVEZHWEVNUy9QMDgr?=
 =?utf-8?B?MU9YVUtIYXZNNG1yejhpSngyR2dkZWVLa2xVbWFUSTBONUwvN0ZpVEZmL3RL?=
 =?utf-8?B?VmRmenYyVDU5a2o5emliamVvenE4ZVc3L1hReUZsVzhNd0NHMnlYL2UzcDJa?=
 =?utf-8?B?NjVyV2hOeThHdFJQVzlNNU9OUnBRcUNKM21ia3ZCSUJ0WVlsV0ZUekpUY25r?=
 =?utf-8?B?RE00MVpmcGhsajVOSEZkR2dUUGExWnJYUmpoU2Z0cVJLSHExSEFPK2dPMzdS?=
 =?utf-8?B?RGU0MXBMNDVEWWFTUkZVblJJRmNpNlgrWTFDT0lZTnA5MFFOZ1pqdnMwSk1W?=
 =?utf-8?B?WkR0NmxNSGZyMG5MYkNNc0U3UzcwN2VtSmtYNHNETmVNWTBKNUFGcmtNR3l4?=
 =?utf-8?B?TGJ4MkdUM1dLbjdkSEtua1hkL01veSswMFY0NEd4emovcDNzbHVIRWY3VlNZ?=
 =?utf-8?B?NHRJcC96Y0s5WmNJWXZmQ0ljTmxINE4yeFo5SWZ3cEwvSUtEbVBHVmMrczlr?=
 =?utf-8?B?dXRjYXYwSk9SQUpsWHd0RzI2STVrU1FWS2dCaHlqRkV0cUxsYUpiSkNLbzNW?=
 =?utf-8?B?c3lwRy93aW9ZM1NmL3pWcWpWRk1ERmlqQzFtMXpDeUZ0bmM2TkRsTXQ4SDYv?=
 =?utf-8?B?bkl6Z3JpSkJaNE40VElRQy9YU0RXQ3VKZE4vY3dOWEdMeThPNitRUFZ6a3o0?=
 =?utf-8?B?eEJJY3BaTjRRZ0Z3RWhSN0xXa05pZ2tzVytFM3FRRXNxQUUrWUxFRmxrSHRX?=
 =?utf-8?B?N2lxT0hBaHRwU0Z4WjY4QVlYR2twMlVMNzdHbjRpNFZPT2VFcUNlSGZRODV6?=
 =?utf-8?B?U3JrMnM5NE1iNzVQOCtwWW5iRXNGUkszN1JsUzRZTHRMQ2NwZStMMHp5OElm?=
 =?utf-8?B?YWxZNTRHcU1LaWZHWHE3eGNwQk9HdUIzeCt2UkdUUlZvOE0ra3JYTUx3WnFs?=
 =?utf-8?B?dHptTmhrekp1Q3k3NEdieUpZZWFWR3AvVlpCNk1tNlRka3JTT1lpd2FlRVRx?=
 =?utf-8?B?aUkxZXRaaVcySUw5ZnZ2eWJGaFlqdlA5Tm1ydGo1V29jUWhpVklHWlRFeDVt?=
 =?utf-8?B?VEhmcG5KSnNVbDZUOXAzWS9sQU9Bb1R6UjF4QWtFbSsxeElWemFKby9aQkpP?=
 =?utf-8?B?ek42SHozWnB3TGVJS3BHT09ta2FzM3R5Slg1MDRVMkhxZlVwdkM1L2RhcWpt?=
 =?utf-8?B?OUlERHNDWE1Va0phWFR6YTl4dFByN0dtZGRub2lIZ3hKejFoY0NoMDhPN3ZS?=
 =?utf-8?B?RTEwTGFGY0VSYW1LMWhlamJXdmFZMmhuZk9ROWIwOFN4cjJxSDhLTkdXd3J3?=
 =?utf-8?B?T0VGYmg4am80c1RHZWNoaXdNcW5TVU90NlNyZDJyc3krYlYxUzRSZlBSa1hm?=
 =?utf-8?B?Zmo1NXdHcFdFam54YlNlVU50NzJ2UkErNEVKbnhoUkFnbm14MzlBY3FYU0Yx?=
 =?utf-8?B?RkRxZGp3TkR1YmxmRWkzRGZkSGtBMHVmeU1OZ2EvWVJnblZHK3BXUG14b3Yr?=
 =?utf-8?B?U2xMV3FxVGh6dmRZeno3NE9uTjNJcHdtVXJoVWZZL2tKMEVzN2JwVytoS2gy?=
 =?utf-8?B?eTJTK3lOam0yemQxTjhyQm9MRVdRcjNETDRSWHRlRU9BKzlrSWtZM2F4TCtz?=
 =?utf-8?B?UnU0UTJxSFBIdFNQL1RHbGYwNXVJdy85dm1ycnpIL05UbEdyd1ZWSEc5M2ZK?=
 =?utf-8?B?K21rNGlac3VwWG5ORXhSSkpwT3NUWFlWb2o1ZWgxU25rcWJzS2xGWmFYRXVU?=
 =?utf-8?B?RkR2cTRjVC9oUlMwSU5rS2N1Y3FIdkZ3cUVsbTRzYXc3UitaYzFFcjkxd0Ix?=
 =?utf-8?B?dCtPeEd4L25GWmdDS0h0ZkE3R1VWMnh0NURMRmZLQWlOcms0Nnpka2pPWXRv?=
 =?utf-8?Q?dKyHaQrjw223vylt7XTaqEY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c4f901-8a8b-4403-70a8-08dd12cc61a6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 12:25:18.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIhPx/+d+V3hjtQodmiIWeQ0VoTjGGG50z9efMKbMxJPqJ7Rf/Yh8ohhKnWEmHp1uNRaD/i2I7UuKhnrD6eUHKciG47XHh9Mep0SoR0PCN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891

On 11/29/2024 6:05 PM, Krzysztof Kozlowski wrote:
> On 29/11/2024 15:25, Ciprian Costea wrote:
>> +      properties:
>> +        interrupts:
>> +          items:
>> +            - description: Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO
>> +            - description: Device state change
>> +            - description: Error detection
>> +            - description: Message Buffer interrupt for mailboxes 8-127
>> +        interrupt-names:
>> +          items:
>> +            - const: mb-0
>> +            - const: state
>> +            - const: berr
>> +            - const: mb-1
>> +      required:
>> +        - compatible
>> +        - reg
> 
> 
> Drop, aren't they already required?
> 

Yes, I was not sure if 'required' here overrides or appends the items to 
the 'global' required declaration.
Now I know it appends them, so I will only keep 'interrupt-names'. Thanks.

>> +        - interrupts
>> +        - interrupt-names
>> +    else:
>> +      properties:
>> +        interrupts:
>> +          maxItems: 1
> 
> 
> Missing constraints for interrupt-names, e.g. :false.
> 

Correct, I will add 'interrupt-names' constraint in V4.

> 
>> +
>>   additionalProperties: false
>>   
>>   examples:
> 
> 
> Best regards,
> Krzysztof

Best Regards,
Ciprian


