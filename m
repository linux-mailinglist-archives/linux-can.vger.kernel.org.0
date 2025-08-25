Return-Path: <linux-can+bounces-4346-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE788B3399C
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AA41B22E80
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB522C0F89;
	Mon, 25 Aug 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="amSnf5rq"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DF2BF01E;
	Mon, 25 Aug 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111037; cv=fail; b=ail3UFCu6/UM0nqt1HE8yOBCG6weKJPfoZyVhOUSqTpIOfvGdH+f4fF88QFBeLwCknrQxKE3z58V8kulM1iKvqWFBUG4LZgXjbetnEY6dEPxQ/rwr6GdRfu6NmrqI+VxaL3Li9o1TAdEUJ75fVF9v+c8d/Uxx/qXDpdzPYq/7wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111037; c=relaxed/simple;
	bh=0xq8xJnbzWnmufCXB7ORLj2VzNK6iybNeDzkoCvPE4c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AKNq1h30SBN6avEiiIbwQ4E0dbIXCIzXKiVO/y2pXI/7jRCtMhsDMO0jK7aPAQgjPh260RbY7tnvE3A+jSY7/E7daXxku5BAeq6fWPFtPmSMnZCzLgQiPP3sMpg+RgtsK7kvsQqlJAuTfCXjqm/g8L631E4iDYO8EPwJg9NTg/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=amSnf5rq; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYGTZr3yaoaBGrQAIpeasynY3TbhXP8KvHRgFelCHxyQjogRYWJhHHkmBtOT+fZhfVsWOlnnNO74aY0lfWmzIU8FOUzHvch5ha2WjDbkJUR+2/8IoMflHu6lefFSydnrJXlVQz9DCPG8936/zwRSdFM52UdkR+mlELol9x2K/gqF8DMcYImfaASeldieOD9003donzX3Mv2lhkzR9j2PvMzlzG0Mo9eliY7boW3bITdsDrgYi5NNUomeZVFNlY3S48NsU0BhOW7eDOzp4hbUTklfnKdVVQtUklbL+vqKWE6Q/tPSaiHthqhsQgZoqsXIJt0cY9vgUeiNEq4buLWFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzQrQXi1w80U7yLaO6A+fzmfuzAhC6iNF8rD2rF+ULQ=;
 b=uczhKOCmyOv7OyNoQko2k2y20GQ9KK5HJqcPSWagaOZ0fQ32GCEwcOTh7Fcp1tiE4IKKOvBuSJ7OhXgU5fr2TY1q/NQI8k817eGFE2UVqaSGpJG5pX6cNyRwPi23XW/pe+dncGfpjEXWH1U2S7IglNQ0WfWhp7a0ey+G0cgJgJyirlJJAgRYWjqa/vOVEVuV3nmrGRbGrGUrK8gwp1kFZ3tlfunHmXMcXcUCVqEFoy+kuOqqIiXP3VA/EtlnshmlZNEuySy14e/tF27Sr/3MjhW5jE0WvdMGcNt7BgLi1NvCmoEwEjSxk7D0965IW0Q5ejLtKcp9jV02TQbQFH98GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzQrQXi1w80U7yLaO6A+fzmfuzAhC6iNF8rD2rF+ULQ=;
 b=amSnf5rqmymm0MJHa9sPP5h0N1qmgHOzHF52DCRCe/AfQqJ4UwB//5V5Qlz64eb9yY2PSVFBWmbohCAtLs0Z3eAAuVfszF1Xxt5vrVokRixtfHCrivqbkk4IoXYNhHFlJla1iADIM8cSOXE6fJ8r/yLB20OPAFa7EnbfwML1fKhj54dqTuS3DeoGn4o2gOzv8fCI9VbdBAtS7NW7Mspy7fgEsxaTqvJN0EhmCNVvPzIeLLVAAPoqgxGwAxKawKAM0P/WzE16dVAiWfjHbCianw/FBP+w/SbZHyJR0sKsH3gde0Whm812ArN6pl+zxj/x0vLSh4y36x6TP66Y1kYOCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 08:37:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 08:37:12 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 16:36:43 +0800
Subject: [PATCH v2 2/5] phy: phy-can-transceiver: Add dual channel support
 for TJA1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-can-v2-2-c461e9fcbc14@nxp.com>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
In-Reply-To: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756111013; l=7283;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=0xq8xJnbzWnmufCXB7ORLj2VzNK6iybNeDzkoCvPE4c=;
 b=Un1LNadRJfoyRWR8u/ZY3ny1uoPIc6RjPFFTY8BJf0IuZupZLWZG2ntM4254ncHIavCFTHvzS
 qEB7BWArWW1DNodbBsVkP0u1YKnGkmpoeSQJ/Yv77t8sr28K908yw9C
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 964597e5-af4a-4f59-d4a3-08dde3b29643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnlvWjBrZkFROWE3V09BUGY0YjNlbUtXb3lPOGh5TndGMUtwdGlmVktDbFJn?=
 =?utf-8?B?emJGMXRmaWlzb1ZYUVN4dmxybE1QNCtwODcxSHZYOEdYc3hIbkl1Y3R1MnFB?=
 =?utf-8?B?YWxONjdzaDk5RDlRaHl1WEZCSkFpZFZZTnkzQWMwaEVUa3AydE9qczFxUkVS?=
 =?utf-8?B?d0JJU3ZUSnZxR3ovV1NUVi84NVJUNlIwYUtxVlMzdmpwTHdYNG1hSGZmZTNu?=
 =?utf-8?B?ZWJ0R24wOG5HY3hMekhWd0VLQ3A5T0RhOTZSZXFqaGhPbzJCTWlPMzRsSWNY?=
 =?utf-8?B?YXYrVlhTd29xNmZya1c4SzVOakF6NE9PWS9TMVJKdmk1SkFYcDRjTUU2ZUc4?=
 =?utf-8?B?NXFDZGQ2WHhCUmRPMkM1WmZ3SGNDZkJGVWNMSUt2bzZyTzdCdTV3RjdndXBM?=
 =?utf-8?B?N3hOU25uOEszSTRlSmhNRURRdVdMUU1mV1Q3MU00WHJ3OERPbVIwYzQrcTlM?=
 =?utf-8?B?U21xQ0EzelpmeDJKNk5abHhqM2crNjhhUjZvOW9GTWQ0LzFqYTdHMUVnbWs5?=
 =?utf-8?B?eVN0Um5sU0FNU1BRcS9rSUw5RXVFblRjbjlqTkFVUXhDeG9aeG1QL0RmMTRp?=
 =?utf-8?B?MGMrZHFtMUpBVVVSMGJTemg3bVcyWUxUaldMNndROVZnREMwbHBQTDEzZ1RO?=
 =?utf-8?B?QXNxZWtiZ01wYXFYZnZJeFoxY2JyMU94UGJqeEQ1T1craytoZGdZU1ZwZzlr?=
 =?utf-8?B?STRnS29oUGc2eTlnamorTTJzOGxBTHZtZFRGa0dtTlBodTRrZCtvbi92K0Vk?=
 =?utf-8?B?Y043eUlRajNWM0ZpRFRlMW9LcEtWV2tBaTNXdlgvU1FiVVhjem9rQ2RyeE9J?=
 =?utf-8?B?SndLYUdKZ1hBNk1zNUdVTHJ4SWFUaXlURjRuNzVPcXZNa2tMS2lnWlFBT0xy?=
 =?utf-8?B?QVJyYzA3a29BVzhhNjJYV3EwVjF1SDJLblcwdzNMdWRidWJxVkpUVDFLbVdl?=
 =?utf-8?B?WVNZeWdidnpkTmlYZC9QQUZzSGx3ZjBYcVpRZms1aVM5TEpxcHMzSGtmV2Y1?=
 =?utf-8?B?V0lsbmVnVlJYNmJBYWFxL0tCTW1OTFRxK2lUSTdRNFYrYXJNak5pdGhxZk03?=
 =?utf-8?B?cHE1ZDZpc0VKQlUwd2JFOVBDbjF1WTBZdWVVUCtFUmhmdkloUjhta0hxSUNj?=
 =?utf-8?B?N3lKMkFGQ0ZYazZ3NHpjQmRXOFhKQ2xVNWRRZENnTVRuSDUwZmlNS1pQQ3R1?=
 =?utf-8?B?ditIWmxRRXlEQjRDblJwWTdCTDhkNmpIYTZQWTFiWWphckRYSnNHVXhzTVRz?=
 =?utf-8?B?blF4c3RuVER3bVJKeDIwYTdtNklyYkJNbW96dWpCUDliZ1JBYkxBaXdUQmps?=
 =?utf-8?B?Ly9nTFN2aEl0WHVVSkdONWhLNnVQSmt1S1NtMllaUTUzaTNuNjk4VDlLSkJy?=
 =?utf-8?B?Si9mcEluSTF0RmduUWZ3bThyeGhLLzhpWU92WFZzNzlCeE1PSCt3MmtvRVNl?=
 =?utf-8?B?d04yZmdpNjJYenJiTXNvOGxmRmZWK2VSOWdoYU1qUXZiZkIvTm5USzlRY2Vk?=
 =?utf-8?B?OWxjZUtJZDVtV3FTaWQydE5CWStOUlVLMzQxU25DWFFHNE92SUhyQ3RjbGJV?=
 =?utf-8?B?Wmk1RTFnNGxQa3JqOVBWYVNQeDNwL3o3QS9Peityb1RqN2xFZXRtT1pTSEN5?=
 =?utf-8?B?QzJXblhENkhDVG1kcy9seENmNmNKRzNoM25rM2xzT2I2SGlwck5adnpsOXVT?=
 =?utf-8?B?cmtkc3B1NGo3UXMvTXA3NWI5TVJTNnFodTJtc1V1eC9RckY0VHBxN1BaVW93?=
 =?utf-8?B?MVFlb2JPdi9mNVh5a0J0dGtYUUdkYk5ZZmtwUFNiSTh2QmdUalRmREt0NldK?=
 =?utf-8?B?b3N4dmtwSE9MY1BiYS9IZjU3cjZGVTBKOUpKNTNPVDd3UERSVU1vbXlTcTR6?=
 =?utf-8?B?SXNJRXMxS3EwbiszNHJIRUw5bVRyLzZFWHVPVUtDMloxVnIzQTI0VGxKYmxX?=
 =?utf-8?B?Vy9HR1VxWlZ0dDRkVEY4ODlmMUZaZWJPS01STmNkRnkwUk5xV1J4a0VyaUZY?=
 =?utf-8?Q?8aEfNvbZ3JuA7znlVm/z684t5aWp8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZhTlVvOHNEcDdDZTRheUxVV2VhUjNNV1ZiN2gyRDkyTHdRcWV2d21zQmtY?=
 =?utf-8?B?QVYxVmh4cERQRncvYUR2ZDk2T2dZM0tRQk1odkJBUUcwZHpsS3lmdFJzamxj?=
 =?utf-8?B?bWRQZS9TelhnME1TSXJrNzFnTnNlais3WDJCL2s0Q0QwTG00blVSQWRMcTR2?=
 =?utf-8?B?S1U5RzdKZzNGeUMyVXBYeHZ3dnFqMHlEWnRDMnI4dTd5b0h2MDYvb243UE5m?=
 =?utf-8?B?K0I1WjdDVTZhS21LVjNGb3BhSUg5ajFIRTJVMlIxVXJrU3RhN2xyckxBWXVX?=
 =?utf-8?B?YmxNQm9lR1RoY0ljQTM1OTRweUNYS0doTVNpSFN6OVYzQ3p1R3gvM0Z2RDl6?=
 =?utf-8?B?V1o5NER0K0dvaGdLRldYVm8vRjNxbEFQRHY4RWZOZDI2emFYMjJ1dDBOcHl5?=
 =?utf-8?B?Q0NPMGpMYTM1MlAyVktkOGp1U1dvTWhMcDBLMnBZbDRua2FCUzVMdVArUVAr?=
 =?utf-8?B?OEV6MldtKzE4VW9NNnI4eVozQ0diNk1yaS9BWExMQkxPTTZ4QUdUQVAxT1Qr?=
 =?utf-8?B?eUdNUmRobk9ZMnJGK3p4cFdIdjd2Wmt3LzVkMlpKMlloUk9MT2srNzV0SjB4?=
 =?utf-8?B?aGJZTENrWDg4aUQ4V01walYzYzBRSmd4K0hjZFJEaml5Q2FmRWVxNkhydW8v?=
 =?utf-8?B?OVg0VzZqUzdINjc0dm0xa3JiNGUrNlNSNm8va1FQSVA3KytNYTRTbzdnbExW?=
 =?utf-8?B?NGdWOGt0Sk1sRkdWZTYwd1NhSEl4TnJHWTNybldmREVJZUl5bXRUbEJzblNV?=
 =?utf-8?B?dCs1c1dVakhkN0lGUDREQ21QYzJLVGVreFhEeG1oZUR3NFN2V0RYTkswSmhX?=
 =?utf-8?B?dGFKbGZFc3ZiOVpYVk1GR3NPVFZ4WjZxSFRIME83Yll1SUpuU3BCK0RCM0FQ?=
 =?utf-8?B?VlB0aG5ZbGdjb1E0YmZJd3BnaXdqSTNEYU9rNjc4Y2l5eUFnYlhIcXROZXNB?=
 =?utf-8?B?YUZabk1CdHVmQzdDOWdabUpiSFIzWUFlaTBvVit3MXdieXBKQkFOK1VDcytz?=
 =?utf-8?B?S01Ra1VyWkVRWUVnUTRTQi80RmljdTl1UWJlSWNRKy9xODBVZ0k1OFpUYnV4?=
 =?utf-8?B?UEdlRi94ckRqQStTWHVVbkIxamhBTUxYSGMwdTh2c3VnMFlsT3NBS1RvYVZZ?=
 =?utf-8?B?SzZCbWNUTlZQb0toOElnYkdXNGxlMGZpUVM5WmZkbVJoY3ZwdW9HdE1jRU05?=
 =?utf-8?B?WXVNTmdyV1BGVnBPSDFPVlowSUU3Y3VuazFKckU2MXNoaVlWdERZamk3U0N6?=
 =?utf-8?B?Vk1PNE1NMU02RU8zRlliTS9NR2t6WDVmenVxWXVNWWtMY2VMS0Zsblo2dnRN?=
 =?utf-8?B?em1PamIzU2c3dmc4U00rbHV2R0JuMXVRa3RZSFNrNUdvUVNKcThOMUNNdWEr?=
 =?utf-8?B?MHlTL2dKRXViRzVvcXF6UGdVdG9sTy9kNU1GT0NPRkhRRWlLaEtxY2h4Mm01?=
 =?utf-8?B?UjVYNXR0Q2UxdGtZM0hWWEo3WFByeWVvT1ZOR204aGNoRWFwRXBOM0tJdkRy?=
 =?utf-8?B?dTQvaGRvRUxQNVgzS3YyNHdIdWI3dnhMVFpURDduT1ZPbFlLYmdoZmxJSGdz?=
 =?utf-8?B?RUhjS0Z4OGZMbFpveXU3a0VUNGVvZmlVSUhUemk4eW4rV0FsaWtoeE9YVTJH?=
 =?utf-8?B?SDRrT053NHFtTy9BQll1eVRNRWNHMnZ3V2E3M3FWMThKUXhDSkUzK3kxVG5j?=
 =?utf-8?B?MkxOSE1jK0orb2tjMGdGRXBreFRhM1o3QTlIY3B3a0Nub1o3TnBab1pUaDBW?=
 =?utf-8?B?ZG9TT2s4d3NnVm85eGZGSUZuemtOZW9uaVBPaDBrZUxRQ0haK0xUUURGVFJk?=
 =?utf-8?B?UTh6V1g2ZWRGSlhkcFEzQXJLWWxQQlVRV2UzMTVRZVdkbndLVHRSOXhrc1Ni?=
 =?utf-8?B?Rm9SVG95R3hibWkzNVVXRE10dlZ5VHo4ZStGQkJTRDQ4bDczWHNmZDE2bmty?=
 =?utf-8?B?U1d2R3RTQ1B2MG9mQTlrT3p6V29OcE9xWGNkYzlXVTRYd252VkFnS1ROdytS?=
 =?utf-8?B?aGxFSDZPQlh6eFlCL205T3RwUlJnOHp4Vk5CR1BCaXFuTGg3Q1lJL0JwSklT?=
 =?utf-8?B?c1FVN1lnV0wvTEg1MVRQaXc5WStucXhYWm9ZKzJYOGgvNHRPeTNtTWxHSklk?=
 =?utf-8?Q?rpaCtYAJWuYjec1B2Y8Hvfn+t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964597e5-af4a-4f59-d4a3-08dde3b29643
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:37:12.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W51eIKolk8H/ihnr/INQphIwCPVX6+5UrgAorJvfn0MlaB/Tc0GQeMxbBFYvdXVou9ETt3aoP7nKOm3+fwdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

- Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
  has two channels.
- Introduce can_transceiver_priv as a higher level encapsulation for
  phy, mux_state, num_ch.
- Alloc a phy for each channel
- Support TJA1048 which is a dual high-speed CAN transceiver with
  Sleep mode supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 117 +++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f59caff4b3d4c267feca4220bf1547b6fad08f95..8f0baf0d29536d2b18c5839d6275f020f9af7e45 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -17,13 +17,20 @@ struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 };
 
 struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct can_transceiver_priv *priv;
+};
+
+struct can_transceiver_priv {
+	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
+	int num_ch;
 };
 
 /* Power on function */
@@ -32,8 +39,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
-	if (can_transceiver_phy->mux_state) {
-		ret = mux_state_select(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->priv->mux_state);
 		if (ret) {
 			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
 			return ret;
@@ -56,8 +63,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
-	if (can_transceiver_phy->mux_state)
-		mux_state_deselect(can_transceiver_phy->mux_state);
+	if (can_transceiver_phy->priv->mux_state)
+		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 
 	return 0;
 }
@@ -76,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
 };
 
+static const struct can_transceiver_data tja1048_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -85,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "nxp,tja1048",
+		.data = &tja1048_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -103,11 +118,27 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 	return devm_mux_state_get(dev, mux_name);
 }
 
+static struct phy *can_transceiver_phy_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
+	u32 idx;
+
+	if (priv->num_ch == 1)
+		return priv->can_transceiver_phy[0].generic_phy;
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = args->args[0];
+
+	return priv->can_transceiver_phy[idx].generic_phy;
+}
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	struct can_transceiver_phy *can_transceiver_phy;
+	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
@@ -115,52 +146,70 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err;
-
-	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
-	if (!can_transceiver_phy)
-		return -ENOMEM;
+	int num_ch = 1;
+	int err, i;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
+		num_ch = 2;
+
+	priv->num_ch = num_ch;
+	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
+						 GFP_KERNEL);
+	if (!priv->can_transceiver_phy)
+		return -ENOMEM;
+
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 
-	can_transceiver_phy->mux_state = mux_state;
-
-	phy = devm_phy_create(dev, dev->of_node,
-			      &can_transceiver_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create can transceiver phy\n");
-		return PTR_ERR(phy);
-	}
+	priv->mux_state = mux_state;
 
 	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
 	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
-	phy->attrs.max_link_rate = max_bitrate;
 
-	can_transceiver_phy->generic_phy = phy;
+	for (i = 0; i < num_ch; i++) {
+		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create can transceiver phy\n");
+			return PTR_ERR(phy);
+		}
 
-	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
-		if (IS_ERR(standby_gpio))
-			return PTR_ERR(standby_gpio);
-		can_transceiver_phy->standby_gpio = standby_gpio;
-	}
+		phy->attrs.max_link_rate = max_bitrate;
 
-	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
-		if (IS_ERR(enable_gpio))
-			return PTR_ERR(enable_gpio);
-		can_transceiver_phy->enable_gpio = enable_gpio;
-	}
+		priv->can_transceiver_phy[i].generic_phy = phy;
+		priv->can_transceiver_phy[i].priv = priv;
+
+		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
+								     GPIOD_OUT_HIGH);
+			if (IS_ERR(standby_gpio))
+				return PTR_ERR(standby_gpio);
+			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
+		}
+
+		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(enable_gpio))
+				return PTR_ERR(enable_gpio);
+			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
+		}
 
-	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
+				&priv->can_transceiver_phy[i]);
+	}
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }

-- 
2.37.1


