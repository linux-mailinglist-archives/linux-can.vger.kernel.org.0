Return-Path: <linux-can+bounces-1002-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715D93A84E
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 22:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7BB1C2207F
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A6C146D42;
	Tue, 23 Jul 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iD5dHPXn"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBAB1465A3;
	Tue, 23 Jul 2024 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767753; cv=fail; b=t6tR3KUTI57do/PH1/6IU+q7qgpiwS+g+5vAeIaKyNaOO91gNXSHIxEaE4/7avPgA4s2b+Hhmc8oUQ5Da2EBTOjnvETipfaBMhiLk4NailNRFSGrLy7EySZGMw+L2qWnDz0lYGtyjMpLD7Fr9XpAgojKUOrdCF+OPW4mhHdsdCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767753; c=relaxed/simple;
	bh=IVSQUSfBDeaesbJm52M4rmlYN3OmCbE5ouiCrdgSVOk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n9GhK/WlyKn3/xWcYbP5xx1F2lpKl++u2py67WogUBOJrUVZlOlIw1B8MfMTIVbvkvsntJ0jj1H5XbcuRNO3RZ5SYzJRYe3ytQsvpaPZzVNqv5xSxwuFTt7iDG6/pYB9Qzc44ycdoku3v4709UrGRke6ZOzm2kxAyRrxcBec4ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iD5dHPXn; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTK5OiN41Lfwb2ZcjU0UPuwnrzCYADqB8lpdQr50UhCoisnr/nnFnXyXXST3donzN9CejJPRDt0Pi/S78lgGTc3IUPGYEkBFmVPo5aFwgZ4qK8zrPZwb1R2tjlm9v98A/hWEGj7flqw/Ap901t2Egp69WadSePxUF/DPoMzyVSei+C9ZiEOTBREoKWvJNQlDJsCtwgWinZbC7qkc39KP6kr4Z73CtIHoLVZQtw5YGAt/dljnCAbcYmlfhHU553jwCJ1qCDRNy8LNTZvEN1Dn4xRHZEt+82TJNR942mlPv6FIkkHdsX3uPle3YqFrzd64hdZ8Q/hhDzmlr5DWOuIsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St4NJuio65wQSfmzYa86IyNljHrNbq7WpnUr3BaOoQo=;
 b=DCYaO/RXNSncpeV/H2xYjLFkr6I0scx7l6siJu9qWBNJRq+k0pUA36K9tEQwTfZ6ksQS6klyN+0VtT4kXBCTcmOJPR4ek9yBjKGvPMbjCHQnVc59L48xV2a5V/MBgQtAyk/MteWQyzd4o0eow20Fixul5GPX1mn1YdbGXdlfHqCah2aV5960BzSTLfZij6raFeqZs5fJlPmBlYIIMWkpHcf8TZutvlLEERnosXsxr83w8mZda7ow5pNpROgfjVsf2+9FRvvk84zH+rNtNHR464UR0spyWHDenm0MqVavbXz/TWY9FpoJKBKeFKIGQH5sp+DskYK/B6sEUhMzohbEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St4NJuio65wQSfmzYa86IyNljHrNbq7WpnUr3BaOoQo=;
 b=iD5dHPXnKFn67aXoEI/AfbXpebJLbdT6U8+N8wONj7CjltvhqWjWtl4Mz2Sf4JCNcaw7H33xfcxIdN4etBkMBR3hmBgRc4Y4ygrzx6oghe+N3sRqWhvFpNo2AVd98FAQWHV7wOmCphpEZPzsPy6PrKrsWRb+KOYA8Z7ZRqijA8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7470.eurprd04.prod.outlook.com (2603:10a6:800:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 20:49:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 20:49:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Jul 2024 16:48:36 -0400
Subject: [PATCH v3 2/2] can: flexcan: add wakeup support for imx95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-flexcan-v3-2-084056119ac8@nxp.com>
References: <20240723-flexcan-v3-0-084056119ac8@nxp.com>
In-Reply-To: <20240723-flexcan-v3-0-084056119ac8@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721767734; l=6676;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DZF8lRBk1z5gCbtmnlwiLvTEP638d+rt+ccnMOssc7U=;
 b=2PGjp3nrhOHz+pKOhG0BHZXpfi4xP2i/PEJAEjEA0C+QGF/GRQt9gfcx6ztozxWeebCtUOTAS
 lGb9oz0pxP3AVhvLBuLExicikHCdFuFQuVBh9+HZ3Bx2egOt4R3AmNg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 740d3e29-d6ef-41af-8d74-08dcab58e52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak9hdTE1TVcxakFHMTlyVXBkdW90Q3owdHVvZ3dlMmVPUFY3SUUvTi9ySE5p?=
 =?utf-8?B?ek9NV1pnSE9FWWN0aHdaS2xuNjhyQ2ZpNmtJNE5QWHVMcW0rcjVyY2t2UStm?=
 =?utf-8?B?bVlqRldRYzhXenozcXdaK1FRSjZlZkE4TWIwaFVlMXR6ZVFiNVluYmJMcDhm?=
 =?utf-8?B?NUlsaVJtR0pmVmtIb05UWk9JL05INzZLTFJKelJEbWJqYmFpbEpwM0V5dkhu?=
 =?utf-8?B?VjcyQUlTOCs3cHE3MWpORERvanl6azlYSFEzV2JldkVWOW9mcXZERDk1WHcz?=
 =?utf-8?B?Q0J6Wlg4ZGJhSGRtdTdsTGROdnh5N0xLMnBhZFpFVHVMV01aSzVucDBIcXZJ?=
 =?utf-8?B?RGhoU292WXk3RWhvaGkvNExuSDdGMVNobERnUW1hSmFHZWRSaGVFdzdySUdQ?=
 =?utf-8?B?WTFQLzEzS2YwWlpVV2Y5VWo0TFhtY2w0Y0sxOGlrUXBpekhXZnlEUnl5N0Mz?=
 =?utf-8?B?aUt6d0p3Y0hzNm5jUlBodDBXNjF3WUlKTDlZRndaNmFCb3RpNXdzUmdYNFI3?=
 =?utf-8?B?N0d6MmVOMUJNc1E0YXVudmE5dnh2ZlRVRWlUUmFxRHhhSmhwYUoxZjBpUEtY?=
 =?utf-8?B?UWFSQlllUWN5UFhsYnVzZEY3eEtnS3F0WjdkWGtLSTZpbXpGTTZ4aTdUQitJ?=
 =?utf-8?B?Vmw0cEl0Q3NuMHQ4QVRqaTI5YWhOcnlBQVlNUktBQzd3YUJqWHZkRnVOTTVZ?=
 =?utf-8?B?Vmdzd2lFODJZaU5XaE5NbEFhQzBvZXBCTitYVGJqdndzQ0lscXFPd2JzRjJH?=
 =?utf-8?B?aG15Z21IclY0SXJvbWVLOStad3V4cW51c01jd1NMaWQ4cXRqb1luek5xSGJK?=
 =?utf-8?B?czR2ckU5SC9UN3hKMkRKUmY1Z1VQalphOXc0TTJCSGZxRldYOU5QOHNJWWdM?=
 =?utf-8?B?bk5LcVBsaHkyQWNHQm1hTCt2bVhzd25TQlRpNUhQelFwMUZlOHY4OFdrdXUy?=
 =?utf-8?B?a0cwU3lvbWdlSXUrWHlaS3BTMTIxUGJaWWdKaXpQTllVVUJtRlBrbStjOGh5?=
 =?utf-8?B?S2lFL0hsRXRPYXdVSldobU9CdWhva01BV081cjZGRXdDNW1tdkJmV0pTTyty?=
 =?utf-8?B?Q0x5Z2duYTBrVmNpVUhyRXpCcTNONXZyU3plRDVuaE9JN3FvbllRQ3huOVZC?=
 =?utf-8?B?OStKOE40RURXcHdFSHdYNU9DeDhoQnY4UVZIRk1EbnpHMnRVS3hvbmRyZE9Z?=
 =?utf-8?B?WGJnVEdrU3BkSkErcENTY2wwV2hJTWl2dDNXYVc2dVo1VWhwT0JyRzBEdWgw?=
 =?utf-8?B?T0pURGhCM3ZlN1o1M2dYZHVSdEhBRFdBMGQray9veG1LTUxVLzlOVXFaSDdP?=
 =?utf-8?B?a21hMm9jbXBlVzRxWThjY25LN3FMZ2N3Ky9BYmYwTFF5Rms0ZVdGZThocUFU?=
 =?utf-8?B?TXhMekE0UWVOQ0l0aXdBM3Z6aTNpUGZSN1ZaVkNSL1doWGdhUkZlV0RUeTY0?=
 =?utf-8?B?QlpLeWZnVy9WMG54a0FjUElEWEpHS1VCbW1wVDV2c0NYdzJaRVBKc0IxNzc1?=
 =?utf-8?B?UlgvSCswcDZuUHFUQTZBS04yWU9ReUVtK3Y4NCtUQTRnYXZiV1FReTlUYkt4?=
 =?utf-8?B?bXlOSUpwa3FqVTljZ1dMWnFvZU1BckZjN3h0d0lKa2YrdWpBVWoxdmZNN2kv?=
 =?utf-8?B?aXFvOHcwdTEwRUl4cUp6V3FBbTdwTUFjbVdnTUFKM1psYkZiUUNVbHJGMGVZ?=
 =?utf-8?B?SGx6bmhlbGxoZXpiT2JXWXJpcjlsQUtKdXJLUjVTdjByWXE4NXVXUmc0clhn?=
 =?utf-8?B?dHIrbXdFWnpXejRrWkl2VWVyYnhJeWhJY25GWFluWkJsZmtmUFU2YUtlNFNB?=
 =?utf-8?B?TC9iWmE4ejFEL0xlbnBweEcvUlFkcCtuSit4aC9vWlhMNHc0V09Ga2lHUUlD?=
 =?utf-8?B?SE1OYXpRMDg5QThqNWdNa1A4THc0SStLNjhneXYyV09OUnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVNXTUd6UGZIa0FrRjV5UVllTG9nL3Y4VmgvVndPM3VSUFhiQmhpcVRtWVA3?=
 =?utf-8?B?MlJOVGlsV3h3ZFBKbU9rL1B3NzZ4VFhPeDZqWTU1K2YxN1BkaDI0Qit3V0VQ?=
 =?utf-8?B?dlFUaFlsSVJCT0NMTFpCYjhKWFF6VDVpZzl2TUZjTWhVc0NHRjNaYmR4TzZh?=
 =?utf-8?B?bFFsWmUwMExxbEtTUk9Xc2VYdHhjL3JOUW1uV3FVaDI0Vk5wWEsyNzNEMjB6?=
 =?utf-8?B?V0JZdGM1a3c2UWZ0VGRZVCtDbGRnb2lCdWNTTG9oR2ZVN0JsYzRCK1E5UzlW?=
 =?utf-8?B?NW85aWRTUXQ0QlVQcldYUktSSWFoSXZoeEladlZCM2o1T2FPZGtjOFZNdWlR?=
 =?utf-8?B?SmRzZ1E4cy9pK0pscGJXbm56OGx1VDgzNlczN21PWnlMb0xmMDVwT1VzaVRM?=
 =?utf-8?B?NDV6aGQ4Vkh3TmNYa29tc2tpZEVvZ0NMWno2cHpVZlh1RW1LOWgzL3NNWWRO?=
 =?utf-8?B?WWE1bzJYRE42TDVnN3hTQ0c1MmZYVzZ2RTlHNDZpY2grNncvOWJkbUhIeHNi?=
 =?utf-8?B?VmRYdFJJNzUxa1Qzb3A5aGtNVVpDaFJDdW1BTnQrVVBJVmNlajZ2Vk9odFhJ?=
 =?utf-8?B?Mjg2c2thNm8zeFJ5Q2FjL2hUU0xQWThsd3drWU5KZTZqWVVXclpoRjVmaHo1?=
 =?utf-8?B?ODFaclpqdDdPcVNLQ2grbXVnbTZxQm1TdzB0MlJGajZWWGY4NUpXODlEbWNN?=
 =?utf-8?B?azNacmwvMWFJa1diNlhtN3Nza2pxbXlrUmttNGhlMk4rWExrMXRSYWtWcFBG?=
 =?utf-8?B?dVJkb1lja1BOZlZzZWM0MXhJZEtBRmR4U2RsVDljbVhIOWplb3VsUjEyZkJx?=
 =?utf-8?B?SUNMcXBvN1U1MVlZeFI5Q1Zvb1FVUUhvd1VmS0NXK3ZtL2ZnNDJJUVN6L09m?=
 =?utf-8?B?d3Vxc05lY2xWdmVWKzk3eWdwVittazBNMUxYeGNYanhNVjNtV0tEL3I5em0v?=
 =?utf-8?B?N3lTZVQzaWg3VHpZMDZPY3grNXk4b3ZVUDI5Rkh4RDlEUlYyREtkdFlhaU9u?=
 =?utf-8?B?MkNLME9xUEdDWU9MZlh5Ym00S3Q1Vk1haWNLenV0VWdUeWx6aHJRdFVaWkhh?=
 =?utf-8?B?cGVzQmxQVDRwNWhlK0NVMXFlMk1QVUNTL3VEUHVzUVpNd1BEeDFPQUNxREkx?=
 =?utf-8?B?VEszNG9sQlFrUzY5cy9MdFVYVmpHdjNlUHFPREx2ZEgwTGgzd25tbGdnUDYy?=
 =?utf-8?B?VXF3S3lHVmdBejJzUFJXU3pWREdQZ2NRR0dneTVTV2QramZjY040ekNLYnBB?=
 =?utf-8?B?YVB5OGZNYTlzSStsTEtyVG5UeEYvTW5tMEl4bWtaWG56S0N1aldCQURzZ3BC?=
 =?utf-8?B?cGM3Mlplc0RqSmxiK09nYk9QdmlJWVBJYmNpQnZ2UFNORUVpdU1yWVpSQnBy?=
 =?utf-8?B?UXNMSDNOUmNtNHc3bFM3K2NqbzlYakxrbS9FQmRCZ2o4eEQ1RGNUWE42WWRi?=
 =?utf-8?B?MFoyTXFadTN3M1hrUGIzSEp0UFBzZE5NTk14K1FoNEQ0TjhnM2xBYUVFMlQ0?=
 =?utf-8?B?Q1FuckQ3YjFqd1NScGt1L0lCNVBaRW1tekUzL1hWaEJKeHZReXdIWWs0cEFG?=
 =?utf-8?B?VnFhbURxT0IvU2owc3BPWHJBcTQybmRhODByajJpZ282MC9ZcHVtSkxWTkpO?=
 =?utf-8?B?L1hCYUJKSHFBTVg3Tlo1SGd2aTUwcy8xVnAybCtqZVoyb0M5aHdHQlM4ekcr?=
 =?utf-8?B?KzNiK2VwaXNMM2VkY1M4T2lsWnJlU1ZONUd6dmpHdFBUZHNRZ3hLdnFLNFI2?=
 =?utf-8?B?Y2JoOGZ5bXlMVElEV1prQXZQN3N5VnFNZ3RnUUpvMVhDRU1jdkF5YmdXZkpm?=
 =?utf-8?B?MEtueDJEOWVxSWFxQURJTkJlOGdFdnpsSmVoMld0ZXBUVytVWDBDaE40MG5x?=
 =?utf-8?B?RGx1ZUZsR3k2eWVDa0VmNlFkSDNyTGcvUTR5Qlhlb011dnhRMXJkZWxEMFQ1?=
 =?utf-8?B?T0d0a3dKdzJpRFltdzloelNINU8zLzRPcFVXWGRES25UZGlteGk1UWJ4akUv?=
 =?utf-8?B?ejJvWlI0VEFEVEFyZm9XdGpCekZ1RkpncGJiR2xRVHQzM0dPT2c5QUtZcUhU?=
 =?utf-8?B?U0dvUWpsSFNHSWZNNnQxYWVqbHZmR3Y3SGZENURtYVMxbG1rdnB1MUJmcWp0?=
 =?utf-8?Q?mcOl1uI8NFXaC3cQn12a3xrEe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740d3e29-d6ef-41af-8d74-08dcab58e52f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 20:49:07.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkLRdZwe7wZUzEhEyvoxgKfBDcZjE41obLw+01Bl8W0DybARAK4jS76qo0/bJ8fc30v80O6lzppFczhEt6bOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7470

From: Haibo Chen <haibo.chen@nxp.com>

iMX95 defines a bit in GPR that sets/unsets the IPG_STOP signal to the
FlexCAN module, controlling its entry into STOP mode. Wakeup should work
even if FlexCAN is in STOP mode.

Due to iMX95 architecture design, the A-Core cannot access GPR; only the
system manager (SM) can configure GPR. To support the wakeup feature,
follow these steps:

- For suspend:
  1) During Linux suspend, when CAN suspends, do nothing for GPR and keep
     CAN-related clocks on.
  2) In ATF, check whether CAN needs to support wakeup; if yes, send a
     request to SM through the SCMI protocol.
  3) In SM, configure the GPR and unset IPG_STOP.
  4) A-Core suspends.

- For wakeup and resume:
  1) A-Core wakeup event arrives.
  2) In SM, deassert IPG_STOP.
  3) Linux resumes.

Add a new fsl_imx95_devtype_data and FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI to
reflect this.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- fsl_imx95_devtype_data keep order by value
- Add empty line after fsl_imx95_devtype_data
- suspend/resume code look symmetrical
---
 drivers/net/can/flexcan/flexcan-core.c | 50 +++++++++++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  2 ++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f6e609c388d55..3c98231e25898 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -354,6 +354,14 @@ static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data fsl_imx95_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
@@ -548,6 +556,13 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
 		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI) {
+		/* For the SCMI mode, driver do nothing, ATF will send request to
+		 * SM(system manager, M33 core) through SCMI protocol after linux
+		 * suspend. Once SM get this request, it will send IPG_STOP signal
+		 * to Flex_CAN, let CAN in STOP mode.
+		 */
+		return 0;
 	}
 
 	return flexcan_low_power_enter_ack(priv);
@@ -559,7 +574,11 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 	u32 reg_mcr;
 	int ret;
 
-	/* remove stop request */
+	/* Remove stop request, for FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
+	 * do nothing here, because ATF already send request to SM before
+	 * linux resume. Once SM get this request, it will deassert the
+	 * IPG_STOP signal to Flex_CAN.
+	 */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW) {
 		ret = flexcan_stop_mode_enable_scfw(priv, false);
 		if (ret < 0)
@@ -1987,6 +2006,9 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
+	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
+		/* ATF will handle all STOP_IPG related work */
+		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
@@ -2013,6 +2035,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx8qm-flexcan", .data = &fsl_imx8qm_devtype_data, },
 	{ .compatible = "fsl,imx8mp-flexcan", .data = &fsl_imx8mp_devtype_data, },
 	{ .compatible = "fsl,imx93-flexcan", .data = &fsl_imx93_devtype_data, },
+	{ .compatible = "fsl,imx95-flexcan", .data = &fsl_imx95_devtype_data, },
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
 	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, },
@@ -2314,9 +2337,19 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, true);
 
-		err = pm_runtime_force_suspend(device);
-		if (err)
-			return err;
+		/* For FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, it need ATF to send
+		 * to SM through SCMI protocol, SM will assert the IPG_STOP
+		 * signal. But all this works need the CAN clocks keep on.
+		 * After the CAN module get the IPG_STOP mode, and switch to
+		 * STOP mode, whether still keep the CAN clocks on or gate them
+		 * off depend on the Hardware design.
+		 */
+		if (!(device_may_wakeup(device) &&
+		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)) {
+			err = pm_runtime_force_suspend(device);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -2330,9 +2363,12 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		err = pm_runtime_force_resume(device);
-		if (err)
-			return err;
+		if (!(device_may_wakeup(device) &&
+		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)) {
+			err = pm_runtime_force_resume(device);
+			if (err)
+				return err;
+		}
 
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, false);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 025c3417031f4..4933d8c7439e6 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -68,6 +68,8 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
+/* Setup stop mode with ATF SCMI protocol to support wakeup */
+#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */

-- 
2.34.1


