Return-Path: <linux-can+bounces-2217-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DFB9D8A5B
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B8D285F16
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5F1B6547;
	Mon, 25 Nov 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Auqn4V5k"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED051B4F0A;
	Mon, 25 Nov 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552278; cv=fail; b=XMcdRnNXWdLh561pI1yTy7oDy4it5FsJwH47i8O4P7+4d+iwqlHap2JeotNjV1lq1AcpcuFbxEFGhUloZosycxP1Csd8mC/GgStxkQ4KBQ3qOWm6TYibpZwHIg9MhqRVMIaBf5kWF5J3AS5VP1JU31IDulPJlW9vHPwpoMa+PjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552278; c=relaxed/simple;
	bh=R4cigYs3WvxA18SHZWDLkmPrTPBp80c5KL4PHc/KKdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwonYthHxIf+htQuc140QckSip2e2Oyt+d2y53YO72gqIrHU+WhO7ObHjZV1TMJBGoK9tRIgDvFiui5JAnEVF5dppMSRNtchoGOUf1QCmhw0qFVtDaioIc/AZHMJW2cyytSKXkTwQb6VrV4rV0og58U/Jym8CkicT0OHVEbawx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Auqn4V5k; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdRrbehseQPpX3IMgXWFJNfBRKQ/3Zpxejth4zoWWHGw1K/1Y+P/M8wSzDPKMkFKm66jyF8bG+DBx1AiwUE8PupfSR5fVihn9JrSax8+4V+2JS384KO4dHRFCLrxFDZ1Efffh6+i49PQriGS1MrqEBHZv/dLjQKKsOjLikgwN7tlRlxEYG9+kiLaY/cqLp8EQZi2jBzVEwj1lFk0WLsVnT1I8NF9X5lc/DnZ/6GYrmGCmosdx9qo7fMBySrBK+Y3OoYYbVOewl2t9bsBVSjw4x1F3ltqfxOrdtfma2CiWfLsPs6kd7bexnaMrmY287sIJUYVWWxz/K6+r1QSa2yzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXKfRfRos/K6nkIpe7cPHuVxoJKUztfgDSE7u8Mi6Xo=;
 b=uL+4ifmrr2uVCfh2RzLi3g9gxObst/Wu4ij48zm11NPuN1T2X8biHMG9m67F22Uf+XsaGWoZQyXwxZD0EdJDw7G56JRWuuJhW3yBvwcKucd9F3V7sXmrvk2J7577MPARbeL1YOuQMmugA1JSaNbqBSJetThQLfnBeJwp48iXeRAmQfx7VmXuH6UzLeGJtVlFkB0a4VSJ+LDs67gfZxhfPkQ6hrh7HxP6WWdX0d3YK0gbs35D/dJ+JgcSnourvIJ7RtLNqgNQjjoUb5g4kSG6m4htBSGKZoxsEioJyPWWRF+IcbbMrxcT/Kg/d11neyXStWraf8He6mCYG469AdG8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXKfRfRos/K6nkIpe7cPHuVxoJKUztfgDSE7u8Mi6Xo=;
 b=Auqn4V5kNj3ICmql9UOewiwPJc8uOVZtFdQivljCDVCz3WQ/VqolLkgVLQmuzJU5raq6ktJJ45HV5CvmESAhFaH7kH5zOuaII+1ecTvgrlZybjWmOSeY4taH7nG4LW0vV4JPOX7dUzwDb8Hst28nvB5kMxNiNo/rEiDo23a9Om4cxePbvA89uH7MNF8fphX9eWdvhvikhbRMsyE8WO0NOlOo1bj3AoSKpzj/dvbbGf62uNjfWGrYmiQ+3xx5PFao2JRG52DRSZquNdwN8dzE9yKmuR+hX9tkg6AR0TGCcMHXjBi4aGlIvjL77DVHfsehlB+O65N+HtlCxuz7YZ4oXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 16:31:11 +0000
Received: from AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb]) by AS1PR04MB9261.eurprd04.prod.outlook.com
 ([fe80::7b16:7596:6bb4:c5fb%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 16:31:11 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 2/3] can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
Date: Mon, 25 Nov 2024 18:31:01 +0200
Message-ID: <20241125163103.4166207-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::10) To AS1PR04MB9261.eurprd04.prod.outlook.com
 (2603:10a6:20b:4c7::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9261:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: ec47abe8-062c-4d91-8998-08dd0d6e928a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3cxKzNqdyt5MkE2bmRHcFhUQWM2aGRnYXB3TGJqcmtKcUU5enB6V2IzYTRz?=
 =?utf-8?B?U2RrYkg3VHFXNk9IRXVrdmNFd2tPbFFSUm1oUlRlcjJxMndNQVdwWDIxUitk?=
 =?utf-8?B?eUNObU9wYXRsUUxPRDhiSzl3S2xaNUpZOUQ0dW5SdXl0bDY1QXEvSUlOS2FC?=
 =?utf-8?B?RDVWcnNWS292c1IzMVJxUWZmUDNrVGJtT2pla3IzbVN0allkSlM4S20xTzYw?=
 =?utf-8?B?ZnBOMHcvU2ZPZENwRGt6QlU1TUZLSXNic0VjVGtYM0ZTUWtJSmJpQXhodld3?=
 =?utf-8?B?WmVESms0MjJwRVhhR2hhdEZlUVRCdmg5cWIrKzB0TmNEWnoyQ294QmIrYUJi?=
 =?utf-8?B?UXgwb3pRVjhMeDg2dEZXckZiQll2RnRMWDg3TEp1Z05iNEZYZXNNTmpzbng0?=
 =?utf-8?B?dTgwakU3ZTdFcEpIbEdkSmo2WDVYaVFNeDFLNUlkeVhHcnZhV0hROUQvdW1R?=
 =?utf-8?B?UGJucmJ6UThFQ2hETkRocEZtK3QvNEk1a3dLeE41c0wxNVhFU0w4ZFZnMXh6?=
 =?utf-8?B?eU9EcTE3VGM3MVJJUjR3WThnVnlWSXphcXZiWVNSRDdoajl6aEhIT212MlRp?=
 =?utf-8?B?emhKS1VDbTFnMzlHU3MydHZLWEl0SUdENFNlamdobXNocWNiaTJ0MCtlb09C?=
 =?utf-8?B?QzdBMngwZTFSYXRzNi9JdVZJMnVRZjRKb3NDU0ljRnExU0hyTENUUjJOem93?=
 =?utf-8?B?eHEvNHQyVWZzcEdlTkhIMU9VOXdncDcwMG4yVHJXSkhiSitXVTdWMVZBT3Nt?=
 =?utf-8?B?c1R2Wlp1c3EvM2tFQitFL1BvSzd6aVhzZXRGMFJvRitxQU82QmNudjBQbnZO?=
 =?utf-8?B?MFJ2Q0FVcmk5TDFWb2R3TVhWNzAxZENJTVZqYmN5SVBvMWN6MEs4QmtBc0tp?=
 =?utf-8?B?QWM4T1IxRVFTRld4b040aFZTZ1NPSm83cjMzRWs5RnpCM1VOV3ZPK2V4RFo4?=
 =?utf-8?B?WFFZOENtRW9jV1MwV3lVbVZVNlBCNFVCR0dhVHZsQWN1cXk4UUxmbHpZK2tZ?=
 =?utf-8?B?UVhHTEJlOFBHS2VWcW1PVmpLVVYzTXFpOU5OMUtydkpvL1BmVERYNnFSS05P?=
 =?utf-8?B?MEV5TWk3SnBLeDdNSFBBbFY4cHhhWm1NR2s0ZU9HamNxRTEvMld5aFRDRGU4?=
 =?utf-8?B?SEVSYXpadTYwUnVYa0wvK3dTeWhWREhTY0JIcktnbHJWUEJhZlFyb3ZrYXlV?=
 =?utf-8?B?ZXFkNWRPaEJubUNPK2F1aFYyVmcvaWxuTFNxejJGdjBGUTB1bEUwZ204ckhY?=
 =?utf-8?B?T3VFQTJLTVhzQ2cwME5BVjR6M0Evd3dvbnVXcnhYL2VSRlRVQW1XZlRUbVBr?=
 =?utf-8?B?SEFKb21iMTg2WnUyc25OV2hmTURoUFJLYlN1cjVQbGhCVHRrb3gxdU91WEhJ?=
 =?utf-8?B?K0FFcGMvL3N4ZXg1Q2dtZisxMHVETDBDUDlmc3V0MFdrT2NSM0s1QlNJTlQv?=
 =?utf-8?B?SlpWMExLbUFOTWorSnpnSi90Y1Q5TDRmL251djZRcVNHMWNPa3R1L0h4SjBJ?=
 =?utf-8?B?WE85T1FZNm9PQ1MrczRKckFQL1oxTEs1QVBRYzhNTkQ0N1hxemFHSTN5V1ZR?=
 =?utf-8?B?eHBLRUZOekhlKzVKTUZFMW1LYmhob1Axa0NFR3gxRFBPSVB2TTVIN25yM1Zo?=
 =?utf-8?B?SWQvSVloRTRiZngxL1k3Wk1jTVRUdXFRQ1dCS0p3TFh0UVFYVzlCWURseVVO?=
 =?utf-8?B?aE9YenNnNG9zcXVsVXZZajE5a3hHQXErUWlVY29mWEpiSGlsMm1vOWZBK2FS?=
 =?utf-8?B?azR1MU9JR09nbjhUb3lMYmVzYnZnOXlLc0NqL05MeGFEYTZHclUzTnhuR3d2?=
 =?utf-8?B?ZW9idHFUemE1OXYyUWthdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9261.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UktjKzdVRXBmZzU0anRqaVFRUzMzY0hPS0hCNFNhRVY4eHFBcXExa0xIeWtC?=
 =?utf-8?B?OXpZRDdEb3pVamdIb0ptQ0ZqRXhWZ0RnYVlZdnl2bmhlelZkTWErTyswWDJL?=
 =?utf-8?B?dmMyb1VjLy9QbndnTUtzL3E3TGk4d1ZXRU1Dam05ZlVvb2IrTW1nVkIvbEdR?=
 =?utf-8?B?bW9FR1NEK2svMjdLc2VDY2dEcEpRbTVoRW1LUmJGMG0xNHpkNk9OSjA1aUtL?=
 =?utf-8?B?dUQvMzUvWTlzd3FZTFVKREtsdk9YSVhrSW1PMnFLWXBxK3dNNHNTSWpqSzFt?=
 =?utf-8?B?akFhSlFiVnpGQmNQZTZqUy9Vb1ZvSXlpTStHWmJtTm1QZ1lVaDN0YmFxK2px?=
 =?utf-8?B?eHFKWm40NU5IV09VTFpVajhOYjVnL1lFczZWQWl3TGFhNmNVdWNTK1ZxWDRK?=
 =?utf-8?B?L0JyU1lsV2NEbXJwWWJDMHFTd1lvZnFrR0JJT3NlNmxlVFZkeEkxa0FEZ1B6?=
 =?utf-8?B?V3ZpYzhuT2J1QVJ3ejN2ZnJEdWNLQml5K3BZU1BUWVIwQzBTRjdzRTFmS1Qr?=
 =?utf-8?B?TlFQdGVuN0JtcVhDY1A3YzYySGFyZjhSMi91N2lvWjlwQWgydjJ2RW96bWNu?=
 =?utf-8?B?TEFackhJN2prRnkzY3dsTkdld2VJZDFKWFpzZXV1b0I5VW1WUmtZMXBzdDlD?=
 =?utf-8?B?NStjTGIyYllSdkIrWVN5U2duM3g0ZnVoTjV6bG9nd04vcyt2cVlUTVkwakhH?=
 =?utf-8?B?WUliNHFFMWNsRXNBcUpYTlhHdlhWQnhNVGRDZzNidVBCTzZIc0RyQ3g0MVIy?=
 =?utf-8?B?WFZlRSt5cldhNDdTdHBvdFFObUdLc0JZcEN1QUFQejFKK1A3T2tmSEcyQ3Z1?=
 =?utf-8?B?eGh4WFNRNExsN0xyR3d4WDk4MnBGeGM2RnFpK3hpOGZ3QjFrZ1diNXprYVND?=
 =?utf-8?B?RE5YdFpUWE1DRUVTWVNqUmc5Tk1BMGhIVlZ0SEtFdy9KaHB4S29oOWo4cGY3?=
 =?utf-8?B?VU1Mc241Vk50OHd0S0lCbURPbzg1NW1PbVpGKzhsajU3WXlkQnd1SEtoK2pq?=
 =?utf-8?B?UzVrMnNaMEZNUVNvRUpKL2Q2K1JIY0RzL3hhem1Ka2s1K3lDU2pKRVZUYitM?=
 =?utf-8?B?TjVQMmhFdUJWS0ZjTDV3a01Xb3NqZE0wQnRDd1Uwc09MYzdJdW44WFVwME5p?=
 =?utf-8?B?ZUUwclZ6aEtiUTlQeExDcnpoblFzKzNxTVVPbi84NXdWSEZVbjVKMjE5aHlG?=
 =?utf-8?B?eGpGQmdjb2VQTFBYWTBSVUJVTnFEOUoyNW9xR3JZbWQremk5U0drQ0hkcmZY?=
 =?utf-8?B?QjVNckhOdHVwVGJnc1ZjL2Z4bmQxL3RjNkUrQkVhRldhSUNERm15cnVYaG9S?=
 =?utf-8?B?TkJDTG8yYml4am92NmZER2lxYmdWdVJSdVRPYTJvOE9PWk1UUTA4QXNDM1E1?=
 =?utf-8?B?RnZkS0wwckdnMEloYTI2RnRyczVldTBmSWFiVjliTXVQdGlXZkJhcmRTRFR0?=
 =?utf-8?B?OG10TlF0cUdNVmJMNnlDZGtqazZiRitLNjdPOFJPeWNvbzZ2RWZoOHZqZXJP?=
 =?utf-8?B?L25NT1IxUUxjM0dFSXRieFZ3MkFUSDlpeFkzQ3pueEowVHVKN2ZrZmRHUEtI?=
 =?utf-8?B?RjdUN0YzRVFkWU5acWVoKzVCQ01sUW5TNE9HQWU1dkl0Q3FjbjRwbXNZL1JC?=
 =?utf-8?B?OHAwNlNJcGNaVm1CekFMZElSN1k2a25pR2JNb0JSM3pnZEhWZnBVOGllUm4z?=
 =?utf-8?B?ZTlxTVN6ZEZLcW02L1ZZSzdldndQYWZVWTBzTmgwS1djcEpLUXVENzV0Sm01?=
 =?utf-8?B?Nmh3ZDRLajQrbWRhemRrYzh5anltRHRkc2NIUmEvUEFpRytQL0cvUzY5RzlM?=
 =?utf-8?B?WENmL2ZWUzJoREJKaFZLcmt4a2NubW45ZEh0Ly9ZdFBtbml5MUJITlpvM1Qw?=
 =?utf-8?B?dDE0U0REQ1FSNWRlWEk0YXF3Y0dBMUxERWNXdThMdWxPUDI3NE9HdDh4TFdQ?=
 =?utf-8?B?Q25Zamp4OGYyWk4wTzRxVXpxalRuMW9Bb3E5cmNGbStVRCtiK283dG9BK3Jt?=
 =?utf-8?B?eHVRckJIVENocmV6YVhVRUgydklWRmtIQlhxd2lQcGU2TEVmaTlLRlVGZlZn?=
 =?utf-8?B?RkE1OXgvUXA5R3JLN1l2WWxSRkRTV0xNb0NobFNLVFBlckFCbmg5SHNoSjJ0?=
 =?utf-8?B?ZExwUHZ5SExjZWI2YnYyRkxKTTBUNG5qYnFKY01CRFJ3RlZqdUZjaGlucFhS?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec47abe8-062c-4d91-8998-08dd0d6e928a
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9261.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:31:11.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIR7VFoXvl8jR6/Dhm3JfXHJwpFdrBXI6y+DTlY5/junkz8U4ldqjvW6tO/IXWjrFLq9ol5bPH/vciK0q4VS4aojcUSZdTvfx2a6cVQOPQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk to handle a FlexCAN
hardware module integration particularity where two ranges of mailboxes
are controlled by separate hardware interrupt lines.
The same 'flexcan_irq' handler is used for both separate mailbox interrupt
lines, with no other changes.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 24 +++++++++++++++++++++++-
 drivers/net/can/flexcan/flexcan.h      |  5 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..7d7f3fa1d67b 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1762,14 +1762,25 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = request_irq(priv->irq_secondary_mb,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_err;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	netif_start_queue(dev);
 
 	return 0;
 
+ out_free_irq_err:
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
-	free_irq(priv->irq_boff, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		free_irq(priv->irq_boff, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_can_rx_offload_disable:
@@ -1799,6 +1810,9 @@ static int flexcan_close(struct net_device *dev)
 		free_irq(priv->irq_boff, dev);
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		free_irq(priv->irq_secondary_mb, dev);
+
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop_disable_on_error(dev);
@@ -2187,6 +2201,14 @@ static int flexcan_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		priv->irq_secondary_mb = platform_get_irq(pdev, 3);
+		if (priv->irq_secondary_mb < 0) {
+			err = priv->irq_secondary_mb;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e..2cf886618c96 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -70,6 +70,10 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+/* Device has two separate interrupt lines for two mailbox ranges, which
+ * both need to have an interrupt handler registered.
+ */
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -107,6 +111,7 @@ struct flexcan_priv {
 
 	int irq_boff;
 	int irq_err;
+	int irq_secondary_mb;
 
 	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
 	struct imx_sc_ipc *sc_ipc_handle;
-- 
2.45.2


