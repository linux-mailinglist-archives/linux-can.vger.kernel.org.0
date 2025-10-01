Return-Path: <linux-can+bounces-5083-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97F0BB07CB
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4433E2A6208
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8D2F3622;
	Wed,  1 Oct 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QQMkATx3"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20D2F3603;
	Wed,  1 Oct 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324997; cv=fail; b=q9GXfWdtLQoTe7MifLN4TL6sPADjA+FKfNiRMYeEr9UDCWb5cYWjkcwYRHI0hP7kHLtLRZIsoUwwFIlom3x8ye3bY8sMplSD251LY4CM5V0Ijg0vjqwTZaLTzk35YwxiJt57MoT2vi5IbMSLlXmtS3K/TuDGvKwAlkvFr6llq88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324997; c=relaxed/simple;
	bh=NMMgAx0kck8ZZg/ElPJmqcxUoHomd61xg1QOBNSejus=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k5dc/onU5vvJoPgjyvCklzofAF6BMc+UpPua//f38JLPK1zLpglkzYcjl6jr26x4fdiWIai6IV/VZ0enXOPqd7deYaHeAiatnujiS+hKZ9qy5D4dEOFs8YfxJLBBdAgIIKGyC2/IF4M+7AvMt3SrfFNfrd5k2g9C9mxE9J46jto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QQMkATx3; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahF8VFLZqvRD6NLrbe3OW7XjvCPoBRdifbJa1PUTlVe75Ukt/reqU0Pi+p/G9xiwibN3jty5B8i4VhqcBhMW8I7JHNio7GamzqTifJQEV0oqs05SlVL2sSG6KuWvp95R/YxKUKItgWmzLFFBq7tT1LtxPaJdEzeZjLHEQSGM8iiz0UDJZYY+61gjwWd+UNve7O4pwgKSRVjLs6EHY6hT4UatOc9wm+XMim620PCJVGQGFR3Hnm4R7sm1dFxM+G/rnptSKLGZitTq4dHM0Ywnthjq71i4PoRKJYRduBFW1KVnFrhEZJIxtleJy88OKXp/wedp/EbTfmJ7mqo5dLoyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML0YBcApdSZwKh3aPnWRzg3eVrK8z05okaPELDJqpvw=;
 b=R7bhQcHVp7TfH5ZWoV5n7tHzFx0FIHBWL+/kfuqMV56rSAryo09x8B+Q5/HYsUddZchR1Mv3RSJLj43FllXcJZjX0t1KoZNAbUPf/lAIH6dPmHbo2xfkXkN8wyc8Qp2rGegbKufg7tL4sdCYUheN13yhpjOu1WiDrva62wVd7aco3DaAwbCuAQPRg7QLHXVlh131vA15FIMebiFJ8fuoQZNoJL/M9S1RjlAl41Qv6V1Hvigur+wVAEyuU599MyrcB5BcVa/Q0jNDZw0F1Ra4Qp2x4od8mXvCQj3NkN16H5BtTLnCkeuyDz/d8+9KwDyuEaZ91W9ITfn53uICdqexng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML0YBcApdSZwKh3aPnWRzg3eVrK8z05okaPELDJqpvw=;
 b=QQMkATx39Sej0aLx6Yy+k5IwfolH3/XBaptK+47yXE7bZQNvHMq9NYjEe2VjBBWSN/Ivn0yGKP9nCSoL2IbX9DKMAysu/zYJGx2kzAnxdZacz2Gve3jqRphSvkjcwCCcHpcM49B8zI8/GxZjY9B4V3PxIbqHuVfWHb6fJ5h+OwEAegNWGryi3eqpvf/jyqRpSZeBr8Gi5mlMiCJHwI6ueBJI3rdsGR017cv926M+4EvV/UzVQx3vFd+9pB1lIFNFjs1tqexPceJGUMaVItM129vokSf7Rb35ZCMvyN+4Xv8zJABvl/0KdlqnRmXWE8uisyLIEV4W/sZwrGOUhSCWhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 13:23:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:12 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:34 +0800
Subject: [PATCH v7 3/8] phy: phy-can-transceiver: Add dual channel support
 for TJA1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-3-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=5765;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NMMgAx0kck8ZZg/ElPJmqcxUoHomd61xg1QOBNSejus=;
 b=1yXyyElrEGEc/JA8jIt5nChE8+ptjgIs2U/+g6MqANNS28wwxopvFZKQXs1mHqGSYccFklmZ9
 cP11X5A6rkNBdtd+pakA5McPvyqWUC+xNkz6D2dNZxtao0c3s2v0SAQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 595d158b-fa2f-4bf0-39c6-08de00edab9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE4reWp4LzQwWS9od0t0SWJhWXVRNnJ4OVNPdVhURU9kdUhGMlh6RnErM0Fw?=
 =?utf-8?B?Rk1kdmdUMTRqRU5tQVhmTC93eUNESVV5bWUrVWxNWVUzY2xPZDVDRjd5Ym1Y?=
 =?utf-8?B?Nm1DSW1EdW5Eb2hwcjFEUmtONnlDQlNZZndRMy82VGRYWFdOV0l2VURKSHd2?=
 =?utf-8?B?VndjYzErLzFoUG1OMTNLMEpCYURZV0RGanAxeVc1VFNFNEJuSnVWQ2tpM0Fr?=
 =?utf-8?B?MTc2ZkErM3p5bVg1c1MzZ0ovOGRqRGo1dWtudVEwblNkRDlIR3hSTldpenl2?=
 =?utf-8?B?U3RLbmR3QTNnNnlrVmw3b0Vwc3JRNW5iaE8wOXRGNERqTmkvREJ2dGNFQUtE?=
 =?utf-8?B?ZWFwL0RTMlVwem9QMmgzZVhDNW80NUc2MXU1VFVlODdIaWpmWFRsWmxRQmxQ?=
 =?utf-8?B?N0hCVjdWMjBWT2RKVkZ2WndIYVhUcW9GcG1jWEcyaFZpd3JzVTB1ZnZlYm9R?=
 =?utf-8?B?b2NjWk5BUjFpMEdVK2ZKWnJLcTBlU29ENUhjQ2EwK3J4YlY1TmFFOG53emcz?=
 =?utf-8?B?WjlLNGk5WE1mTDF6b0dBRGczZW02Y3lzVmI0eG82aEF0S1pUVG9CUVZ0ZkVx?=
 =?utf-8?B?dVM1MmRkZWpxdTF6eGRPckYxeGgyNTArSlY3d0JOTlBDVnNTSzJhTSswRWow?=
 =?utf-8?B?QVRFOTRjc25ZTjFpaCtqLzdmZnE4bzNHS3N6RzZ2a05DNFJ6NXQrZld4aGhV?=
 =?utf-8?B?b1FiV3l6TzlDQWZlL1AwUlRZSGQzVHZNampqVVQrdEMwejZINHN0c0cxSDV2?=
 =?utf-8?B?UkJ6VENjN0xHNGJvdzNpV1J4bmtEaCtFZW16REpXU0RhZDFWaUNZTm5XSVhE?=
 =?utf-8?B?UlFlNTZiWmRVd0I4TUtwVXBheTViYmZSQ0RzRU11MlBnUG5zN0ZtK1NJNnNk?=
 =?utf-8?B?d29nRVFZbnhKMjJpT3F6WkZnRHphM0xobjZpK1FHVkZ6aDl4bENZc3lpWUlk?=
 =?utf-8?B?R001V1dNVUptMTlSSk4vYkpEM0dwR0FBbGVWbTR4U0szMENZOTZ3VWJZQ3Rn?=
 =?utf-8?B?SXYzMGhKamhTMmpWeGM1ZUpWc0M4bm9GRVBKOXNRc3pxS1NjK045b0dPVWlF?=
 =?utf-8?B?Q0szQVFsUkdDZ1ZnRUo3a1dYRGd0L1JCZ2g4WWxoV2txSWlFem5oQjRQZGFF?=
 =?utf-8?B?K0xRbDZudkREMUt3Q00vVHl5QlhDODlIV0M3ZWY2YmhhWDYyMHBMSTlBRmZO?=
 =?utf-8?B?Z091cElNd29DQk5idEdDMkZuRmhVK3N2bzV2K1VPdVkzQmVTNzlHM25zMjdD?=
 =?utf-8?B?MHZYcDFTcXVoWWxPUU9IY0NKN2ZNN2hvWHVjeTN4UnFzTFdlWTRET3RxaHZU?=
 =?utf-8?B?OXhHUXpEWURma2tkTHBqaVIxMUVGVjJxQkpIQ0RJWVBaOWpUVzJRM21uckRY?=
 =?utf-8?B?c3dyMXNjYTljZFNKMVpLQ2V0VG8xWmlRVkpaWXh1d1d0N2Rhbng1SFhhOHJ0?=
 =?utf-8?B?cDdGb1NmSWZlOG1WeklCVHAvMFpRSndVV1AzRFgyRjVUTzdFcGxORlFMbWdZ?=
 =?utf-8?B?WStPTFYyVnhRSW5EaTdXN2xlQWpaNWRSZ2xTUG0vQlVhK0dSNENDL0tadUhp?=
 =?utf-8?B?MnRiNnkzeXNoS2pPSXowWFJoSjRITkM0UjduNFJuYTkyUkdHckd6RENvWlFs?=
 =?utf-8?B?eFVYSmFKZFFadFRtM1J3dTNsTUk5bUk1T2pKQStSeFRxenJlWWwwQWNzRnFR?=
 =?utf-8?B?Rk1CekNkNTJWNkFxcnkxa1NRZUQrUEZ2OEFlSGtaZmVDT1orUWlDSGh6a1Ax?=
 =?utf-8?B?ZXpjRFF2SWhCR0FSVHZEYnNydGtPVGpZQVJCTGhrc0pDbzBTOEk3cEwzbGVG?=
 =?utf-8?B?d2ZxdjMzUlVGK3pnRWcvWGhuWHh6MUcxZnBUclhTa0F2T3RpZW1ueXd5M2RP?=
 =?utf-8?B?azRJU2xPMXd0N3dQa1FGeXA4cUFwRE1uLzNvNlBKVndRZVJvZGUxU0pvRlV5?=
 =?utf-8?B?SHdoTTFDQzFFQ21tcGwrNjhnOCt0ZlUyMVlOWUVQby9LaGpRNDF2eVc3aUNo?=
 =?utf-8?B?UnBsaEd5Vnp1YTZIMVN4elBuazR1bWxOMUpNQm1TTWJEeXNIYy8xRmQ0OXlK?=
 =?utf-8?B?cVVTNmZ6QmFzYmFOVlJkZEloOXl2c05jZlJRZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0ExRlN0WW1wUkRWSXo1WVRpdnJXRG1DYTBhaWprRUxTRkpkSnBhSzRxd0JK?=
 =?utf-8?B?elpyVmxVbGl2M0JrSDBNV1NTTFc0dzJIekZCeTBVWDNBVUwxZWtTcHVIYUxo?=
 =?utf-8?B?UmpHZzRRM3Fsb1Q4TEhSdnBsY3AwMGpPSm9kVnRIeSthc3dhZnZCQVZvb2VX?=
 =?utf-8?B?T3dxVmxxSjZtNjZKWFg3YkhsVVBtdHNIRUxKdEdBZDFQQ2NHODJDUlBjL2ZQ?=
 =?utf-8?B?dDlJVk5OcndEZUNhaEpmSDBadEVhbEFmaS9DdCsyczI2alVYbGZKeEdwU3Yz?=
 =?utf-8?B?VU41YXU4K1hSUXJrZjF0SUlmcVE5STVvQ01DUmxKUWtoM0ZOSG1RUVZWU1NY?=
 =?utf-8?B?eTRFZEZrU1Y1ZGZUM1gzamsyK1BKL1BwQVVmcTYySThPOGIxTDFycTJTOHdv?=
 =?utf-8?B?MGJhdWxkRWZEZ2lWUXBwcWxiRVFuQTFnUHExanZ4ZHF4OTZVa0NpUXAwVjNy?=
 =?utf-8?B?dnFEWEFubTFpTW0xME5oakNGcWxoeHJUOUdib203T2xEcGJmaHdQbDRYZG1h?=
 =?utf-8?B?eGYzMTF1L1NUODNrQWYvWUhaU244dDVNd21ZRWh5M3pnbTZDQlZ1OE54ZDRv?=
 =?utf-8?B?U1F5NXZpOElMaEFLaGxBV014eTVRN1lsdU5YWGtUZGgwdGF2Vzh4bTZ5OHNy?=
 =?utf-8?B?Z0tHU3E0WXd0WG53SVdUOHpUNlJjcEltcTVFMTloSE8wUStyb1lVY2h4R0tq?=
 =?utf-8?B?OUVKUEd5UUNrZ0RxZUE1NE9RQkdxejAvUmRDNUtBQXJOL2w1T3BOSUxSTjlN?=
 =?utf-8?B?MkdhRUlPVzlKUXZVM2pSbUpZa1RWdVRZMklOTDVpVDJtOTJ4azRwNSt1Zjho?=
 =?utf-8?B?a0FqcVdyYzErMmVPQVo3Qmhoam9JaEJ2MDVhbFZzWHhtekE4Mks3OTlTYUE0?=
 =?utf-8?B?VkhqdjdQaVRwWnllYUV4ajBkZ0IxQVFWRDZQZE1sOUkwVXhST1VFNFRBa3pP?=
 =?utf-8?B?aTVOM29SMXVtMzdwMkRHNTBPNHptR0gwdEcvTHFqbDg0cDNxY1hhN2hrSmdN?=
 =?utf-8?B?OWNqRlk0eC8zQktBbHRKRWkwbWgzL2dOYmY1YXBFVkRwSTdaK2xwNGMyblc2?=
 =?utf-8?B?TXYyZ2F6MHhnUHRUOEI0Q1kzeml0VzBuMUpjRXAraVF4b2dNUkRhYVRpckh2?=
 =?utf-8?B?OEpTSWtDam1vNng4Rk8yZ0ZVd0RVbGV2VE5YNWlRdk9OaUVsQ3hlaFFqTGRl?=
 =?utf-8?B?TjlwZW9TZUFSUUc0c2V5UHZtYmJZbWNJWmV1VzZkeVE1OEhVWXBCeW9UbXpw?=
 =?utf-8?B?NEtEdlhuYnlnTXhuRXltanhvYTlhMzBWcU04ODJydmdvWXRob0RKU0dWMEI2?=
 =?utf-8?B?SmE4VWc0clhhWFNrdFVNWlRiV2g0UUMwbHF0ajN2c1ZxdWlOYkhwSkdPUUNv?=
 =?utf-8?B?VU5ma3lUVzBKQ0g3d2ZHV2hnTHNKMlB5SmM2YmdtbURrZlNsVEZxbzE0WFNa?=
 =?utf-8?B?MS9hclVsUSsxZ2c3RU42cFhjTmNoWjI0V1FRSDRvTWtTKzlCV3lFQnFjRnNG?=
 =?utf-8?B?Ym9SWmtiUE9Zb0ROOEl1R3ltWnd6Y0M5NTcxZ3UvbXFoNksvZ2pzeVYxaFhw?=
 =?utf-8?B?VXR4Y3NsYzVXNC9sa0dDbzZQYjlsOFNHdGIxVlNQVkpJWklMSGpMYXZWcnk0?=
 =?utf-8?B?YTF0K2VDQkUyVVNMKzVYRFJ5SXR6SmVENFJsbFBhUkROUVRacUUrcHZuaVY0?=
 =?utf-8?B?OUtJWUU5ZVlmNU5yYnhnTEozVU5XUndlV2ZtalVaY0NOZmJNNExlazF3eDdt?=
 =?utf-8?B?dWNkWUVxZTBBQVZadEpublF6NTNwek4reXp5ay96NGxmN0hPY1ZFSXJUUUFu?=
 =?utf-8?B?WlRyd1RqQm5EQjRLakhna2hwZCtyM2tNZXY5RzNMRnNSQzNtQXE0UThPeFkv?=
 =?utf-8?B?N3lSajlpbGk1ODduMDZtM29idHhQZzRjTG9pQ1ZUQ3FUdXpIWEVZZUNOSTlF?=
 =?utf-8?B?S2c0S25QTTR2U2lONzE1V3lkbWFwU01ocUl1WjBYWXNldU5EYUZRdXZlNElT?=
 =?utf-8?B?UkhNWjYrOStPM2c2L1V1Vkg2WXFSYlByQlF1Tm1CYW5nZkpDNVQ2TU9NenNu?=
 =?utf-8?B?ajg5VU41Q25UWTNPa1BrTGZoa3ZsNUduZnVCV2dmZWZIUE5RTDJPZkdlaS9F?=
 =?utf-8?Q?lzyxaJY+BpTy0sRgYVWfuJL6v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595d158b-fa2f-4bf0-39c6-08de00edab9b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:12.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RniI3nfpYs7lT9ytZ/MtKo3tTngIf7BxQ91hXgCP7etxGL7q0FlZhyG7tFHy0FoLTnDJjwlURSWdy8EqSNKrJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

- Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy has two
  channels.
- Alloc a phy for each channel
- Support TJA1048 which is a dual high-speed CAN transceiver with sleep
  mode supported.
- Add can_transceiver_phy_xlate for parsing phy

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 88 +++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index b06ba42854c194b5aec1ca1a41db2c65862c4529..09d1684895568ba8bbad7cdb47bdf984966459c3 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -17,6 +17,7 @@ struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 };
 
 struct can_transceiver_phy {
@@ -84,6 +85,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
 };
 
+static const struct can_transceiver_data tja1048_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -93,6 +98,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
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
@@ -111,6 +120,25 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 	return devm_mux_state_get(dev, mux_name);
 }
 
+static struct phy *can_transceiver_phy_xlate(struct device *dev,
+					     const struct of_phandle_args *args)
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
+	if (idx >= priv->num_ch)
+		return ERR_PTR(-EINVAL);
+
+	return priv->can_transceiver_phy[idx].generic_phy;
+}
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -124,10 +152,12 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err, num_ch = 1;
+	int err, i, num_ch = 1;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
+	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
+		num_ch = 2;
 
 	priv = devm_kzalloc(dev, struct_size(priv, can_transceiver_phy, num_ch), GFP_KERNEL);
 	if (!priv)
@@ -135,8 +165,6 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
-	can_transceiver_phy = &priv->can_transceiver_phy[0];
-	can_transceiver_phy->priv = priv;
 
 	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
@@ -144,37 +172,45 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	phy = devm_phy_create(dev, dev->of_node,
-			      &can_transceiver_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create can transceiver phy\n");
-		return PTR_ERR(phy);
-	}
-
 	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
 	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
-	phy->attrs.max_link_rate = max_bitrate;
 
-	can_transceiver_phy->generic_phy = phy;
+	for (i = 0; i < num_ch; i++) {
+		can_transceiver_phy = &priv->can_transceiver_phy[i];
+		can_transceiver_phy->priv = priv;
 
-	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
-		if (IS_ERR(standby_gpio))
-			return PTR_ERR(standby_gpio);
-		can_transceiver_phy->standby_gpio = standby_gpio;
-	}
+		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create can transceiver phy\n");
+			return PTR_ERR(phy);
+		}
 
-	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
-		if (IS_ERR(enable_gpio))
-			return PTR_ERR(enable_gpio);
-		can_transceiver_phy->enable_gpio = enable_gpio;
-	}
+		phy->attrs.max_link_rate = max_bitrate;
+
+		can_transceiver_phy->generic_phy = phy;
+		can_transceiver_phy->priv = priv;
 
-	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
+								     GPIOD_OUT_HIGH);
+			if (IS_ERR(standby_gpio))
+				return PTR_ERR(standby_gpio);
+			can_transceiver_phy->standby_gpio = standby_gpio;
+		}
+
+		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(enable_gpio))
+				return PTR_ERR(enable_gpio);
+			can_transceiver_phy->enable_gpio = enable_gpio;
+		}
+
+		phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+	}
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }

-- 
2.37.1


