Return-Path: <linux-can+bounces-967-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C456092EECA
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 20:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9CC285861
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599D16F82C;
	Thu, 11 Jul 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Li+gK0FC"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4F16F0E9;
	Thu, 11 Jul 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722040; cv=fail; b=cY1Rqltky134TTwO8oq9GdV3q3ewd1UTMdBrXb/SDMifCfT/9KCKiJiW8QWNWz1xrZKsF2FpvXZ5xM7DrdFY6lDziF6McIaQ3bHScaCOTAfFC6kU4E4tjOnl6jd8uQ15IqQAcM4mFtwbR5hD5Y1mD8uK0okKPENfcms9wnPdjFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722040; c=relaxed/simple;
	bh=wV6jeLzg3g3yedL24p0+Z/VLhNR2E9IdG2mdphSZULM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YYZhMUm+KdpboONCUq9ZbMcBt8FrW8JVlJKhfrpnQI7xVH7cw3/GsjG504BBJS16yqJ5jqZ7boYmcSr3o7OVUrrqEo/iWwmym4CuSDFV/ViPlGqbzpfaTvBS7X9DqZeygHBSbKQRcGPdO4B4J36YTi7ss8wQVSNNnXJeB9Xo56g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Li+gK0FC; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v//+/jBXw93W5qJ3AQi5/VcIoteGJii6AzOXSyG9jLL8eInvHQmXAI/QQodPMIwToahJIUenmPRK8ko0ZWxivqXcVjqAUrQrEujUOTkLK8/rfVzSQspuCzz7LGxFHJ47rzAFdRBh5grm1jvrX4/S9QvsRwLquEATcFgsCKQ/vDDVmBY0BHL3aOUKoUl32lW8XqvyXAu3SUDgZkQ+uLUHkrftjPOChG/zjY8fJwXBddQAvT8f9fzsQUAZ/3DyzugWouvFDpW8C1vI0M1YAa2fwKMYq4DvRmeOHna5oP0+EJ6Xbw0Lb6IZ65LZz1PRJTYts3go77KRQCw8vI/YFHO+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf4R1w+IFfREDDFzcckD+cSjnRzgbLiQXklZJaK0WWY=;
 b=J1tytqAa1SUoEt0Tq5dsqMLxc84iu9Jc91wW13xTs4S7oTq+EEFVGq1HVGqOb0hkNoFysw36EUq7dfnu5jTOLyu3NX0wp+bqvS+YBEBoOcmmjT6CVOV5lVRNX295tybj3IuDqiTEA6zGKFb9+srN8rPmc0sqRbZITraQyD7yE42DV5JeSfDHx+EDo2hmaYGpsxiQ44QMBeDeHvY9Ty541bCLu7IIDppzgO+KgDvKssP/QflLJrAmzfWi98VaexTrt5htN9CG8o5DR+QGNwuDR/3cb0MnQCEOUqGIW6hMParXATHwPTLs7OfwZweF1OBKgKyXzpneDxchZvFNGsYWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf4R1w+IFfREDDFzcckD+cSjnRzgbLiQXklZJaK0WWY=;
 b=Li+gK0FCsDIDbqV08Rufn95yofDlGtqX2IUZ5+G8vJZJYBIQEbEgH6ThJ5RvlNl5cbpwqUas+VhgL+05N58lSAx/RjgM2jirj8OjQnvJTCx6014CpCBe4d+M4vscTaztwOmcr44+g+3zu6mdNQUx+BGaCvMsxrA6ukmtLUfD7Ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 18:20:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:20:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Jul 2024 14:20:03 -0400
Subject: [PATCH 4/4] can: flexcan: add wakeup support for imx95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-flexcan-v1-4-d5210ec0a34b@nxp.com>
References: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
In-Reply-To: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720722012; l=6386;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=laFLVimb0DeJWbLI/AkKxnSps+vsZInKqjqapoJfi58=;
 b=2e4qM6H54zsC1usa6wNIsJtCGafFUQWK9SYPoJR2p1OaaClFEOMPW6TBBgdKEm2Vymhn4E/jX
 Q7v5Dm7pHT8BmzCQ4f8OPBqyNeczJUyAeKlxa1mRnkSUTvlrhCtKAkm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0134.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b426703-d4b1-42c4-30ee-08dca1d62829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW83dlZCT2NVQzlEQTFhS3gwTjZHU2h5SERGckdudThjVjJhZVZiT3g0b2Qx?=
 =?utf-8?B?bHZjSld4OEtpL3V1aStMNWNpaGRLOUZnVnY3R0xaZTlGT0s3K0piZUZ5MCtp?=
 =?utf-8?B?bFZGNXAyUU9hTW1uTmhTeE8zbUlrdmY0MDdXUTM4TVV3RG1qYzU1QnZxaCtl?=
 =?utf-8?B?emdMRlRiRHZZNzNxakZnOUNtSitjQklvUi9wenhlZXNmMWRSd2xQbVdDYkgr?=
 =?utf-8?B?WE1ZTFNwVzRsd0svTDhjdkQ5VjVCb1A5Szd4dHBtVWRvMWxkRitFTW9IdjJP?=
 =?utf-8?B?azFlVXU2blpnUmwzbGNMRzJlNy8wZFA3VmtrcGp5aUlEc2RhV0NlbXgzSHow?=
 =?utf-8?B?LzhFZW1PeWc2SnozeHhaZERXZHNXWDJ6OVIrYmM4N1MvVVI5T3d2VUh6YVVX?=
 =?utf-8?B?ZXdoSlk0aFVLRUpXM0t1SlZETWlFZVYwMVVQNmpYcGNmUTlpVTRFWDhqMCtW?=
 =?utf-8?B?b1Rqak5UNTg0SmZONUxsK2ZLWm5XUHg0S2JaNUw0VDkvWnhuRk0vQk0vY1h3?=
 =?utf-8?B?MUI5cnJWK3dhZS9EamsrdWhlNjdEbVNlUjNIeUVXeEVDbVhodkZFZmN0WWNa?=
 =?utf-8?B?Yjgwd0ZuNmowM2JmdDlOS1ovSEUxY3g2SEU2VzBxaGVjN2JHQjc2MDB4Q3ND?=
 =?utf-8?B?dXFENk1IVlVKMC8vNm5yL3dMT3hERnNEN3NxRlhwZmRoQnhCTVRXcnZHbFVE?=
 =?utf-8?B?NzV4ZW9GOGdiOXg3aXVSa0g1dk4xZWZ5ZEtuSTBPREFiR1A1ck9qVTVkazBJ?=
 =?utf-8?B?d1Q2VmE3bVBHNnZSeGNIazY1TExocXZCa2NxWWRWczFCQU15OFAxZCtXYnUy?=
 =?utf-8?B?dWs0M01sVEVVL2R4Qndudko3WHROZzlZMVVFN0R0VWwzRGdSRkJIWlQ3ejNt?=
 =?utf-8?B?Z1RsdWtyVis0OXJjalhiMGltdXc1eG1UQnk4dHFSZFYyYjh4OHdqbkI4czZt?=
 =?utf-8?B?dEZ6dEtudXFUSjZEcHN3bU5VcVhiSlA4ZnVwcURnRXpIb2RUUzd1VjNldUdH?=
 =?utf-8?B?YzdSUVY5YVBxM3VubTJsTjNnYi9CcVlhTktoVWtpWTdSVGNhQlh0WXZLQWo1?=
 =?utf-8?B?d2xvL2xoVHUwUWdUMmV2aDFrT1Y2cnNLMmNOOExxeHMyR2N4STQ5OXdMWjJu?=
 =?utf-8?B?MkRaWW9NMHRvT2JYc0NqZDRyWnVzYk5PZHVBKzFYRmM5VlZIQlZkZlo5RHhj?=
 =?utf-8?B?SmVkeWdrQXlQNWJ1dzQweWZWa09zb2x0MEZHQktSczE5L1FBZEpHaEZnMjNU?=
 =?utf-8?B?L3BFNzNuRWdicDJvQll2RmtrdFBDQWNnVnIweFZOa0QwQzdrVjZzNDJuZzFL?=
 =?utf-8?B?dFQ5R2J4YUdsTVAvMmt0Z0kwNUxQOS9NYU02N0lSVVZSOU9wODBWY1VkRGJ4?=
 =?utf-8?B?dyszSmVCWFYxd0RXSkswM2FEMWwreWhUN2dSYkVqT1VIL3pMeWg1WHNlVnpG?=
 =?utf-8?B?QTY2cVI3R2RYeWdITCt1NGtUTHhMTFc0UjhrYVc4NGYxd21vWG1Oa1kvWGJu?=
 =?utf-8?B?K2Nla2MzVCsyejM3cExEWW1LVDY5L1EzNE54L1hpaEJXcDJnd2Z3SFQycG5C?=
 =?utf-8?B?ZDVVUkdCVDBMczJ6Sm1uUHc5NXcyV2Fjb1IyekM5ZmgwVWx4ZURXQmhlSnNE?=
 =?utf-8?B?UkF1ZDdHaDd5SWhyNEhDS2s5WStEVElwVUNXeTFTR3F3VzR5YS9jaFdCV200?=
 =?utf-8?B?ZjRIdXMvUlUrNnlYUnRBaDlvQlRIc2FPKzBuTVMzcGdNOThrcUpINzV2ZUZq?=
 =?utf-8?B?OWRLVUR0N0E5cHFERzF4RC9QdjFFNGtEcDhObVM3SzEzNnNnRHRnWHRTZjQz?=
 =?utf-8?B?QXFiK1lobHAvOTJBcTNhQzA1V0tyWmU1OWkyMXcvWi9zVjRsTVhxVzk1djlO?=
 =?utf-8?B?T29DczYvMnlGS1craHZZLzhzSUozY3IrREUyWmpGb0l1V0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWJPSkEzVlJ4aTNHVi81TWRNOXZnZ3gyeW9sRkZiTi9Sa0hWblpNUnJQOE12?=
 =?utf-8?B?S2pheXU0R1B3MmVRWC8xa1FkSHB4TjhhWWcxcUNvdGhmNFhXVTBjYUxXMHBM?=
 =?utf-8?B?amZaZVBzY1ZqTStya2V6R1kxUXE5R3h1WFZlUkVOWGsySSs4bVpTUitVcmFC?=
 =?utf-8?B?UXREa2pjR2ZubzFUNlBZYU16a2syVHAvL2dKR1R0S2d4bmQ5RzlFMHpzQy8x?=
 =?utf-8?B?UG4yb2QreTlYSm1IalhHQ0hMQ1FocWozdnA0bU1FY3RtemlwM3dudEVTdmZE?=
 =?utf-8?B?RktDTWF3aUZ4OTdFeXRic2liZW1LcmF1U2FNVHdFdFBBWEVUT2hodzY1MURU?=
 =?utf-8?B?QWJOWXBhTVR5QmFIN01MWEVYdjBQUmZmYnh3YytqdEt6STVaMTNmS2JlSCtk?=
 =?utf-8?B?ZnJRTCtUeVVkRXFBR0ZsaHNkUkk3MDhCc04vNEdUR2M1bHREemxBSURpU1JH?=
 =?utf-8?B?RkQrVmlUOGJVV1YvTjRkUTRJcTMyNlNlTEQ5RElvT1RQRTR6MVBUdDdYR21a?=
 =?utf-8?B?R0l5UFdDZWdjMmlPZWhibHF2UWhnOXpmQmRiNm1oQVNJSmRyajVGTi9jQ200?=
 =?utf-8?B?MzVTWGFnZnIxWkNtNXJSdzg4aXZGdU13OHJEbnR3VFNIY1YwbVZDLzJRejlT?=
 =?utf-8?B?dmNyNENEV1F4cDVMWkdWUVNOemRIN3kwZHNueWZ5OVdxcVZhdndtYVhBMGtX?=
 =?utf-8?B?R3ZVTlJkQVJJaTVvdGExWDlEMTVvR0syRW9MUWNVZTdPYjUwR2tZTmtNT3NV?=
 =?utf-8?B?YXBReWNTR1RQWENLT2dhVmd1WUcrMzZsNWQzVXRTZUNXbkd4K2tmRllsTWQr?=
 =?utf-8?B?T2hSMjFKb1hzZmxPWE1XWDY0S1FKdmpFVFVXbmtMTU41OEFCZ0ZOYXZuaDYz?=
 =?utf-8?B?UlFDZTVEZ1JWbHZGSW1xcVNQSXpaVUJJRHppY2F3WlYyVlZYNnNOc1lVRkkx?=
 =?utf-8?B?aGZ2d1ErSTJDeEpEYnpqMzJPckVxNDRkOTdSTXBZQ0tlVlVsb2QwaDl6WERi?=
 =?utf-8?B?WW9hb3dseDc5TnJNZ2tjVytmQWRrb3M1WHVMZnhBdXdCNHVlYTB4eExRYzZ1?=
 =?utf-8?B?NzFNd3MwdWV6dnRVS2tYc3BTdVAycHZ0dXJFU1BqSDRCbFRkZi8xSWk5VGNj?=
 =?utf-8?B?amJGT05yUUdnK1UyOTBBZXF0MnJiRXpDU2lIWm96VmJ3Mlo3dmNqR2t3Q0RO?=
 =?utf-8?B?WDJqeW9YTGRTbjU3RnR3NmU3ejRwREFSelYwMEQvYnBiaDNGdjdCNVAvZE5C?=
 =?utf-8?B?R3RQRW9WMnlnVGpTR3RmbUQwNWhDM21WMGVCa1hvUDIvYXhMOGtvZmE3NjR0?=
 =?utf-8?B?SHJ2UU1BVlRUazMydVFRTSt0UXVsWEE2ZXQ1NkptNW5Ic3AvR1JDeEFFMUZL?=
 =?utf-8?B?WWtQMGwxbmhUTGpTclp2Y3NVbU5hdVJiVnVDTTNZazVyaUk1SmZSNXNBY0I1?=
 =?utf-8?B?Y0JjOGJ2SEpwN21sU3RicngrOUVTSmp3TWs2L0hzSnNrZk9yekVPaERxcjBn?=
 =?utf-8?B?Rncxa0YxYlFkTnBDMHk3UVFaVkhzNloyK1d0MlNWK0tYL2ZrVFV2bWl1R29B?=
 =?utf-8?B?ZnZaVWlSSURmN042VTl3UkZyYzZjSnhXaS9haVFWZGVGSFduOWtMSVU3TzBz?=
 =?utf-8?B?eTkyMUhuUXl5bU03cXVnU01saWtNUjdCK1U0cXVjU2srUUgrNGplZkxkU0FR?=
 =?utf-8?B?aTcrN1d5Wkg0MG04VVVJcXZLZlQ2RmhZV3ZqaWVGUlhmSlplWEM5ZC95bzdD?=
 =?utf-8?B?Ykd1L0VhVVhwWitLR2ZjMVltV2l1OFhyd0xpTlpvc3Y4V28wZmhLd3EvMTdS?=
 =?utf-8?B?Nmp2YnR6ZEl3VnhmVmZIbUhNN0pQYml6by90TEc1L3greWdnQXBXR2RNVkha?=
 =?utf-8?B?RFJ0VjhqUkU3c0oyZlhJNXNxQzBmcUV5enE0M0dOdXgrdFZjWjY4R2FreXdS?=
 =?utf-8?B?Tjh0d1FHTTNtSnhoZVdRRmNBSVFQNk9Qc0JNd3ZsdTNnUUxZZjIrOEl6Qzcz?=
 =?utf-8?B?U3lKSzhqdklkYmpzMjFDaC93djBkaGJwd1p6Y2N6RUttbVRDUG1oeEY3YkE5?=
 =?utf-8?B?MXZNYS9FdHljVUhLcHc0ZWJ0c2lsVmgvNEdzQjN1dnU3RVFNV3dQeXB1aXh5?=
 =?utf-8?Q?ET2q6mkLFVZfbFZ0ajoD+jv1u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b426703-d4b1-42c4-30ee-08dca1d62829
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:20:34.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPQRGiGU3RORLam5sJbzKpIuFoZ20rG0W4DU/4nKvakObkXsbUTo1HeO8TXg0VtrdFrjI0CxLo/sQQGi80XJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514

From: Haibo Chen <haibo.chen@nxp.com>

iMX95 define a bit in GPR that assert/desert IPG_STOP signal to Flex CAN
module. It control flexcan enter STOP mode. Wakeup should work even FlexCAN
is in STOP mode.

Due to iMX95 architecture design, A-Core can't access GPR. Only the system
manager (SM) can config GPR. To support the wakeup feature, follow below
steps:

For suspend:

1) linux suspend, when CAN suspend, do nothing for GPR, and keep CAN
related clock on.
2) In ATF, check whether the CAN need to support wakeup, if yes, send a
request to SM through SCMI protocol.
3) In SM, config the GPR and assert IPG_STOP.
4) A-Core suspend.

For wakeup and resume:

1) A-core wakeup event arrive.
2) In SM, deassert IPG_STOP.
3) Linux resume.

Add a new fsl_imx95_devtype_data and FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI to
reflect this.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 49 ++++++++++++++++++++++++++++++----
 drivers/net/can/flexcan/flexcan.h      |  2 ++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f6e609c388d55..ad3240e7e6ab4 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -354,6 +354,14 @@ static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static struct flexcan_devtype_data fsl_imx95_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI |
+		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
+};
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
@@ -2311,9 +2334,22 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		if (device_may_wakeup(device))
+		if (device_may_wakeup(device)) {
 			flexcan_enable_wakeup_irq(priv, true);
 
+			/* For FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, it need
+			 * ATF to send request to SM through SCMI protocol,
+			 * SM will assert the IPG_STOP signal. But all this
+			 * works need the CAN clocks keep on.
+			 * After the CAN module get the IPG_STOP mode, and
+			 * switch to STOP mode, whether still keep the CAN
+			 * clocks on or gate them off depend on the Hardware
+			 * design.
+			 */
+			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
+				return 0;
+		}
+
 		err = pm_runtime_force_suspend(device);
 		if (err)
 			return err;
@@ -2330,9 +2366,12 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
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


