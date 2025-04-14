Return-Path: <linux-can+bounces-3395-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD04A8791E
	for <lists+linux-can@lfdr.de>; Mon, 14 Apr 2025 09:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D03A4747
	for <lists+linux-can@lfdr.de>; Mon, 14 Apr 2025 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8F258CC6;
	Mon, 14 Apr 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fkixBYcf"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B43259CB4;
	Mon, 14 Apr 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616217; cv=fail; b=cQyz6WNcV+l1rAuep7Yg1PUsOULkrua7BqRk70nLGLmTOkCfhrpqkdw3037R8QMn5oIxofvzr3HfkhMdRDONZW/t/cj/Z7ga0q5BuEqprvfUiM5O/NpdU9v1FPNXuwAltcJGEpf9sylAx2U+PMYtUplmbaTedL59G2Ym9srx3gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616217; c=relaxed/simple;
	bh=wUPT14BMEx5rx+Wvx2fK3OtrdpzAfbg96ZWJpHgUDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qLTdNyPtatuBLGnvSnArmkZ11qTuA4MHGXE1sf6jN1mEC8tGtIOgOGAr99Z62nc81ROtCmmf/mObuWlegfFU0KX2a20jNURWF17o4IqZMlrC2YX3kwRC5p44eoUF2YvvlL9ilSHImymHjVbfvKYv8pSZZICw0r1HeChmHQ7p0oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fkixBYcf; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYcirIVeRoACBSlyJJd4cFxMC3AqgUHDkZH1gDvG14zlMk0pAB+EF/LVJagufbSkp39ywQ7hYxqSy1r5WpDhClRBL8dLr5lxjvAbHf7mnBhC3gAM7s3BOnW5/O+JYrAcfxn5sZO+ChAvBvM5jwxai7VOlILm7BejMBIXSz5PCY3ppm8PzV1gpE5CjVY4N/pQopCUy4HZjBZe2hGt2Bmb8YkxquVRK3TlTL25IfYD2DhmVLMTIcsy7Btaimo+9N4NV64QUUxeGf+YaBIGS55Rr/eOrnUj8zp2xDiGd0blK2H12m46tl0elGNY/l5GenhBgnRAkpj5rUaiqCMTNftq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7fSoTKXavvdHX21LHLfKGVZVYFRq8E0bA/KNt9ddeU=;
 b=m9gzLYHG2ulMmifRAG9tmiiFzTuQBpqsgjGo4s08BAugxKNBRVwymLI41EnAyF773SQDTl5cgfNnDZpA8V4M2opJLB6UFLJH2t91KFC4Wdkz7LRgVF2t+is53k6wOCnwacnsTyaY8wzz3x7235nOGy5eQgh0KPaV+UQ6/ONWO2wfm0Yfm6ARJuYGqASWnAkQF3wu/QdB3ykeRrHNccoQCubxKzRNH40GXzReNo0wXMaDGq/kyL72EnapYlhw+n9an/5cA+Bh1PxuYN0SXCWU97yfBqoy0gIdvC1voDkjKPPNRAtZlIAm7Ab91N4h+CmNm5t9IPRLqiPvNwQqXqhbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7fSoTKXavvdHX21LHLfKGVZVYFRq8E0bA/KNt9ddeU=;
 b=fkixBYcfXiKg4Qi+1GkNxORzjUI0jXkeokbRIYtS8TToxIzBVPUjxNSMn5ctzn9Vm4z2oAV/fO13NL8ENGOKwficTjx/a7kwyKYfFAGES/KjTmk9R6VQpestM9KNMJbbAp4x0VhoYriVShr6GRJml384ZsHculLd4Q0dLPUghRNzKicFVjaanJjVJOTThY7dDROza9GfZ0T4cfT+cvonwwz5j8Oy+/gfHA+zFLPrdypxtP4MIKgT3A2M1Wbi3rP5RmIYFoXJZSlsA7Fjv/59ds/XBV4VjPic/trOVEeQ7FSvnb4ZWM9ONWuhItW23n0/tucIWUepX+9LHiy+GWKrmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS1PR04MB9286.eurprd04.prod.outlook.com (2603:10a6:20b:4de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 07:36:51 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 07:36:51 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Subject: [PATCH] can: flexcan: enable PER clock before obtaining its rate
Date: Mon, 14 Apr 2025 10:36:46 +0300
Message-ID: <20250414073646.1473157-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS1PR04MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 8603b883-55d8-422b-9526-08dd7b271eee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXEybnZHeWxwd3FCRWlNWmFrZUpiYUR3VXZqd2xLMHpXUFUyZTNPR2FQaEQ1?=
 =?utf-8?B?bDhBV3VwWVdhVzNYOVRVMXFJZnRmem02a09iMXlXdnZUVmx6dFJTWUpRZDd5?=
 =?utf-8?B?Mml1Z1g2SElaRjhjRFYxem9wZEdPY0FzR09WbkxJSTAzYkV2KyttVmxlSjNM?=
 =?utf-8?B?bnRKdVZPajBMaG5ocVVhSUh3c0hRKzFMVE1OSmIxSmdBQ2txVjdmcmRqdHM5?=
 =?utf-8?B?UThLcE4zVmJhNTVwVWYyUG5OOENNbHl0WUZCV2t2a0YwcWJ4L0dWS25lL0JQ?=
 =?utf-8?B?ZjdTV2ZkRTBsajlwZVlIQ0FSUnNiSTF0KzdOQjYyYVFlbXBDYUNDSERhRmdQ?=
 =?utf-8?B?Q1pkdnR6UUhWbzd6bi9DWjBwQjNhS2RHZWJ6eFhWVjJjMlQ0akJhK2xrakVv?=
 =?utf-8?B?WnhTU1JIeFlxN204VzhpSmNXR25FS1cxTGZJcnFsVVkvV1k4Mng3YldsUGtB?=
 =?utf-8?B?Sjl3MG8xVWZrS0l6bVM4QjNKdUt1K05WaWlLbHhmSWJ4a2RLdjdYcjNZYTJ6?=
 =?utf-8?B?YU5ZeDFHdVpscmJyZEw1a05KdzBaSDR2TnRsRVkyaGsvdWdwek5ZdXZnVmtJ?=
 =?utf-8?B?QkUxNmsyVjBrZWNoMDNWL2hmUGNTRUF5Y3JkSmcrTSs5OU5udnh6QzlYMmRD?=
 =?utf-8?B?Q29rYU1rUGpyQWVxSnVXQk43aWpzMFhiTTlTWlNXMGlGNjZIbldqR0xkR1Zt?=
 =?utf-8?B?ZHNiS3dNUTl0OFVnZ1dzcXRMWXlXN29KVFBZV2IwcW5lTFBteGhQMVNqNFZN?=
 =?utf-8?B?Wk9DTEs2czFqVWM5eUtvUWU3ZXRySWhPY1VuVnc4Nys1VkxHQzBGVVE0dUtW?=
 =?utf-8?B?MnYyUkVWSTV6cDVVU2pWYWlRYitWeHc5L0c1dldFdUdBY0l6VUJZKzI4bTBK?=
 =?utf-8?B?V0ppc3hVQllrTXFDZktaaHp4OWVoK3pKeTFUaXp5WHdFOVh6eHZUeHlJZXl4?=
 =?utf-8?B?bXN5ZWwvTU9UdkpqOGRsblRyNE8rRGpqejR2WHFheVc1b0V2azRlU2Y1SVJv?=
 =?utf-8?B?dmM4UnpkbWR1bGoxR05LTHhPTVBQT044ZkVpbE1HOTd5cUdFcTNhdkF2TzdZ?=
 =?utf-8?B?QVRWcTVvSDF1RklJU3dmM3hUVmpCdzVSWUJvenVQR1F3RGd1WjZqbFFmK2Nj?=
 =?utf-8?B?NDBaWW83OVcrcHNtek9TMzVhTHE3UnMzcXFEUEIwaUVldnJ0VHNSYVdJbEJF?=
 =?utf-8?B?dUh4VlBzZmROMkdLcXdNYmNXYURuRmpLeVprVDhxOGxwY3l4RWJIVGlhald2?=
 =?utf-8?B?NVVId3FROXltL25UQzhQY2did0d3YUdZbEdnak1LMkpNTFFpTitISlhtR1NM?=
 =?utf-8?B?VmhTOElTaS8wM1BqT0orL3U4ZkFTUjM5eUE2ZzMyOSt4TUxvcHBqcW1zaDBO?=
 =?utf-8?B?Yk5FcFpwcUZoTThwdDdxdjM1dkh1dGVvNVgzeGc5OXFQaysyTzNQZXNJUy93?=
 =?utf-8?B?TkJlTUx2TzRvMkRIL0lTK2N0ajJJUEx0ZnR3cVo4TC9HOUF0M1RZc3dwUVA5?=
 =?utf-8?B?Z0I3VUdWQU51TXhSdlNsODlqMm9VMDJQb1R0UzVGM1ZYU0QzalM4anVIeTRP?=
 =?utf-8?B?TFRvR3JNSWdkdEQxMzM3c0tGVzIxQkZrZTZ5d2RITGIzZ29WcFpkZHFIV21m?=
 =?utf-8?B?ZlJTdjRhdUxFMVplR3Q2K1FsZXpRbkZTSjlqbjdOU2pCMi8xUzVWc1JydkUv?=
 =?utf-8?B?NEVSZlA3ZXIrdFh0OTB1LytDR2xqaXhXSEJPVTd0VThTbm1rZUFPVFNJdXB4?=
 =?utf-8?B?cTdPOFVxbFcrTEtNOXZBNTRicGNFTjBxUnpndFNUYmhaZXRwc3ZyTWt4L0Z5?=
 =?utf-8?B?ZDlDYXo4T2dqaGpoK0RvZTJwRmJLVW1VdTR3K0pvVXczN1YvZDd6RFlHSGdD?=
 =?utf-8?B?OGFINElScmVlbjRVZTlBeU1ZOGtUQU9mQlpZRThSQW1QdU5HS1lEaHk3OGZD?=
 =?utf-8?Q?zUhBYAVR2ho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVBMUVhKVkFUUDR0RnVnRjhnWWtON3lwdHBVMVhWTzJlSXBkV3dvbVo4Y1c4?=
 =?utf-8?B?THVvZmJQYno5enlUOGprT3J3aE44OWVnZFNWdVN3cmx5Mk0rZ2NpWnplakxH?=
 =?utf-8?B?bGJkRlBTcXBEMXdFRlJ1b2RaZVRoVnNkMXZ6TTFjSHBFK3NuTWVqN3lFdmYx?=
 =?utf-8?B?cXFHaU93OGY2cEFlSllkcEZNUUIvT2MveEgwbkNTYTVhTExyMFZJbVhmc3ZS?=
 =?utf-8?B?T0V1OWk1bmNxUHEvWlVqb3JPMHNnL0JYMlBJZjRBa0ZxdWkvV1FDQ1RXZzZO?=
 =?utf-8?B?ZnMyQjh0bmZIS2hwWUFMUHA0dzdaeDlJcmYvWG1uL0RaTU5PUm5YamR5ODNw?=
 =?utf-8?B?U0FidXl2TUdDWDY3ZmJFeHd3ZXdDSVZwMEd1ZkZlVThPL1FsUWZsdjRJZ3JN?=
 =?utf-8?B?UVFESWxteS9rTHhuZlNBM1BuNzk5bmZ6QVVrVEQ1WCtmYTdUVHQvVGY3cnFK?=
 =?utf-8?B?czFXblFyZWhTRFUzQnpTb2hvallpZzRjMGRmOFBoaXBKV0o3bVY5bnZKRkd4?=
 =?utf-8?B?c2NxeXhxNHV2Q1F0TzhDb2VJdmw3d3NWY0k2RXNRYW1qSU01M3BiNTlFRGZw?=
 =?utf-8?B?V2Nja3c2OStPR0VxVVUzNCt0a2M5TUp1cmVjZktzRWhkNWZaSG80U085ZkpE?=
 =?utf-8?B?SVEvd1BDQTVtSG1NYVM4Wk9NaEszU2dWc0ZDbnBIUEdYNkoyak5DTjBlKzhx?=
 =?utf-8?B?QktVQkI4dXB1ZndXanVwOStQMHVuTjdPa1hwVWZtQllKNmlHTCtlWWxoL3lE?=
 =?utf-8?B?ek9PNGJ4NEtsTUNENUhwMXc4cnI3emxrQk1NaTdadDB3dDh6elk2WnVsL3dr?=
 =?utf-8?B?K2Q0WjY2MmlydGVnU3dHbXpNcnNneGdITCsyZjN5QTZ0VExxNi80VlE0K1pK?=
 =?utf-8?B?Yjl4YTJhd2JneXJXUkVvRjJCSmZvQXltNHVPMXh4Z3BjU1VheWdEaTluWlpP?=
 =?utf-8?B?M0ROTm1HeTVrdXdvVHpQcjYrUExpZEk3b3hFMEplUWc3WTNJVEFEWFFSK0Y0?=
 =?utf-8?B?dzJYcUlKcFZTZ3Zma29aY0ZLYUxOUkVsVkR4VDJ6clprek50OU9PT0JVQXFP?=
 =?utf-8?B?dzZvVTV3R3JWQWhVcGhGKzUzZGpiYlgwcGpuc1dKZ2NMYUZ1TldVbURTTzJm?=
 =?utf-8?B?TWhwREJqOHBiNDlGV0JqRUJiUjdsYWdLTHFjTmZrS3RVV3pkVlRzSzlSYnhi?=
 =?utf-8?B?UloyWUVKOEU3amtVM2ZqV3FvbkJHM0JadVVQUDd2R0VZSWpCUURtUDZGdG9B?=
 =?utf-8?B?Q01kY0U0d1RzR1FvVTJnWTE0RFBsZmhRUk5lY2ZXVVZmNlQwZkF0blJXbkVi?=
 =?utf-8?B?M3VFT1lEaHNSams3ZFZiUitqRU5yOHRjeWxJWjVnREdPRWdsMUJDWWFzd012?=
 =?utf-8?B?Y3Fua2lLenNicG4vSThnd0FsdEVDL3M0eEUwQ0NraWpWYUtYV3ZVUkNhMzBO?=
 =?utf-8?B?T2U4OEpJdGdCNCtUU1pOT3g2ZDl4VVEvTGQ3ZnVrNTFsNy9CZTFNRVhuNkpX?=
 =?utf-8?B?Y2pWZ1FhSjljQ2RSKzhQeTZXN0gyL0dpL1FRR2xKdUd4aTIrYUt2VDJRcWVa?=
 =?utf-8?B?b0kxS3I3MEoyQURMR0YyWmcyakh2bTVVQ000OUx5cTBTN0puZ0pFU0N4NFJu?=
 =?utf-8?B?UVhXc2p4anpWV0ZzS3FMZkdJZlNLVWdUTE4xUWhsdU50Wnl1ZXBDblYrNnNE?=
 =?utf-8?B?SkdiOW1GTHE1RGhkN1plbTY3dUxuZ2FBY0NvQkhQckRJWTdQYmlLUGVOOW5k?=
 =?utf-8?B?T29LQnRKaXpZZTd1TGlOb1Y1UWd6RG53am4rYkNvQlY4SUxQZU1jNXJQZERi?=
 =?utf-8?B?bTVMTHYrNzFDVUFmdk5EV2RKcUJrZ1c4SzVlcXFQZkNlU2czM0M1YTJPVHVM?=
 =?utf-8?B?cmoyZ3YybkxGSG5naFo5NGdDaS82dHpLTDRwVHJnaUg5djlqUFdSNWc3dGlI?=
 =?utf-8?B?ZkdtVG10eXpGMWhxTkRjdlU4UWFZSlB5M2t1eWFxUlo1QXBaZ21LWFpPenlr?=
 =?utf-8?B?bzBIMU9GcExpRlViRFNlMnFiMDZPSWd5Umd6cjBGMzRucExZTVVFT0N6OGlm?=
 =?utf-8?B?TWNnQ0JkcHMxRjQrek94N1RUZFdzVnhXZWRoSWZZeHRZaTE0ZCt5TS9zc09q?=
 =?utf-8?B?eExyZ2U3bDFsdytiQm9HcExSM1IvZFdVRTc1RkkwYllRM3JTbGlDb3BsckNy?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8603b883-55d8-422b-9526-08dd7b271eee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 07:36:51.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqIT13pKl677gC/IjmLRX+lyVJGt6XraVg1Ktin+qja8HZ3/FeLlbdb4MHp/EZ6hYIKQv8rLN5DAJxTqBe2P6pkHDYzS1nB/cVj08vPRn1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9286

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The FlexCan driver assumes that the frequency of the 'per' clock can be
obtained even on disabled clocks, which is not always true.

According to 'clk_get_rate' documentation, it is only valid once the clock
source has been enabled.

Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 6d80c341b26f..b142aa60620e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2056,6 +2056,26 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 	return 0;
 }
 
+static unsigned long get_per_clk_rate(struct clk *clk)
+{
+	unsigned long rate;
+	int err;
+
+	rate = clk_get_rate(clk);
+	if (rate)
+		return rate;
+
+	/* Just in case this clock is disabled by default */
+	err = clk_prepare_enable(clk);
+	if (err)
+		return 0;
+
+	rate = clk_get_rate(clk);
+	clk_disable_unprepare(clk);
+
+	return rate;
+}
+
 static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx8qm-flexcan", .data = &fsl_imx8qm_devtype_data, },
 	{ .compatible = "fsl,imx8mp-flexcan", .data = &fsl_imx8mp_devtype_data, },
@@ -2137,7 +2157,7 @@ static int flexcan_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "no per clock defined\n");
 			return PTR_ERR(clk_per);
 		}
-		clock_freq = clk_get_rate(clk_per);
+		clock_freq = get_per_clk_rate(clk_per);
 	}
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.45.2


