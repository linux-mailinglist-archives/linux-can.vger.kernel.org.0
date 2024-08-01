Return-Path: <linux-can+bounces-1098-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C09439D9
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 02:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E439285D07
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1432714A4DD;
	Thu,  1 Aug 2024 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hkVenUqD"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089A1494D1;
	Thu,  1 Aug 2024 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470451; cv=fail; b=Vj21oCg635cbIaQFIXTV/Eoo01HVmR8J8c0/86yTmec9DQSTPWcx2HoKN91TkPFGUMDf0rMusrYrMBxFJDTGQY+lh3VAwYm6uFji0rdMtdh2LnZCqVlth/SEvaxOFB66w+5G1OV27G4N2YuA7ZJhrE20O2cAyUiW6zNBgPoMhKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470451; c=relaxed/simple;
	bh=IVSQUSfBDeaesbJm52M4rmlYN3OmCbE5ouiCrdgSVOk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oKoQk50tQkloaaMfpwCHu8Dh14eIh3E8ErgJjh7n9b91l8faHKUBkV4VmadD2hu/e1/uU9hFQ8jtgu2JPKuFMEeqjIA/Q3j0ILQdWPcLAxH28c8gDmxRQaQS1C3HeFGBjJqoPSDn9575r3IPLxHh/gilKeWszSCb5lQJxyhPskI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hkVenUqD; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1ulSn3yUytN0Sq2w78oPUYfDV7CRte8Ka6bxQClSHOnmYyz159t+aQpu8o3V9GwGsJ/5Md5u2gVRyqaBmIJvgydGhuiAGhAhZd1TZ8wJ6QTRog4zNpDc5rhs9mrL1nL2tf7JTImQ7ZHt+PbdTQOY8s5HOrHlkx4/0giMba7WlDedSCfSiMB2jBx8EKINufcytipKs/6XkB+NHir0Tm45lWkx6SAZztd58FSIPhwOJ4vmfZ4Q2jyuYNdIH23tNeBgJeqltjtznXQma1U8nR1gIpGs3LpEZhuKW3/W+/ZRG6WRavNDw7ucTMRmr5vK5DdqQ3lgo66LlDf4JUldVKNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St4NJuio65wQSfmzYa86IyNljHrNbq7WpnUr3BaOoQo=;
 b=Jsj+yoeOaDE3K8LwvxZdSYV2SlZACdOW9Un+x7KNDs/x7Vz8eFP4piSA4wbURuBxIlJoqsZriP3aHzQnhfteJ3nMIJdYTH3oXC2TKJNd+lSGg+IwNwQOvv2Zo0A1YClhF9XwYDupN69+tTi9HSASA9uvMsPxbhaLjW6EKh5OF7mXXiLU8Azkvb6DR4Z0ij40TbQlARc1a7NNIem3hib6IKk8LDjTBXbFgSIqSNlwnuyzRS/Myae7QYcG1j2S0UJoc8sgCLxxWcAEOT0YIUnBltrNyki/NjPZ9v7RjxpjoeoxdyviPIEnyXW9LSPUVyYYyZUws4/GXq5tzqjdrCWaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St4NJuio65wQSfmzYa86IyNljHrNbq7WpnUr3BaOoQo=;
 b=hkVenUqDhqYfDD96vdZ+iWrNe5PDtEvkhtvfpiQ8+XdV5QKW02m0iD9XP5y3mgoVTlOX+J49E17r83643ttIdp3qWbB6X62uA1h31/PAzZPmNvONH1nmy6YPCWdLoXuo/H70jbhKLkHEqjT4pe3r+0lwvh73oaDvSkxoaO2xXsnaQPCW9Xswn60zLXuUF3YtMobyWLn37eCJ0qnH2L0zydwqLflnNfoFyry0XMBTO/jFgLWMoNPgI6JUy8Qi8SiCC1qkq8BrFh+hPlxhrxQ0QwI7JLc/ynPEpYbjGL66tAraYdQsXStRRKzsP4zV+2VUiRkxxtA4CBGmtazC3IeZoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10406.eurprd04.prod.outlook.com (2603:10a6:150:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 00:00:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 00:00:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 31 Jul 2024 20:00:26 -0400
Subject: [PATCH v4 2/2] can: flexcan: add wakeup support for imx95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-flexcan-v4-2-82ece66e5a76@nxp.com>
References: <20240731-flexcan-v4-0-82ece66e5a76@nxp.com>
In-Reply-To: <20240731-flexcan-v4-0-82ece66e5a76@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722470433; l=6676;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DZF8lRBk1z5gCbtmnlwiLvTEP638d+rt+ccnMOssc7U=;
 b=WgyEiLBek2oI95DkWOwlYosG1t33YnBjHQYtg1HnULg/kBaYbREDwlk5VEpY31g7qReUTSFkh
 xXfajy4zZaTBzVBArwtjx0YFQZIiS840kKL2nG1I2sFJqpYSUR4Jpvt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10406:EE_
X-MS-Office365-Filtering-Correlation-Id: d792edf2-3a7e-4ae3-c973-08dcb1bcfe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2dVYW50T1M2clVxTXBSTXdwQmlleEh2REMyenhaVFJmeXIrYVg1NGlndHov?=
 =?utf-8?B?czBpNFlnVjM4Znh1MDMyTDZCSXNmbEZjRTVrSnFHVFVKSTArL05Xd2k5bldM?=
 =?utf-8?B?WVpRQTV4TVNCaFZmb1F3MDN2YUNBbStVbWtjRTI0a0E0NE9LSk5RSWY5aGdM?=
 =?utf-8?B?WFJFSFdKYVhTUTVpemVOakdnL1hWcGpPV21sZjV2THl1amFCQ2ozUG9GYmxi?=
 =?utf-8?B?M0kvNHB2YUxmVlZRYzIveGpLSncyajgxbGxOdnVBei9vaUVtZjZyNU13N2pN?=
 =?utf-8?B?SjNEU0oxeGJaUE5pYUhlNE5uVHlhMFdlY3lmYnZwa3ZCT1B4dG5uSklCcDl2?=
 =?utf-8?B?YUc3ZmlYUXNKdElWZ3BUa2EyUjlxY3hqSXgrTHlob28xNHhqSEdlTU1xSmh3?=
 =?utf-8?B?WjlvSlBQRDdKU2dRR0xaZTBvc0ZBY3B0djlQa3ZYSk5VZnhDRHJvcGlQcVE3?=
 =?utf-8?B?UnVMWEZ0cURMaEtlYlhHYUNvdzIwd2taYjA5RGtvcTMxMXkrcUlmWnBjS1E5?=
 =?utf-8?B?dmdnN0hUY2JFcWRWRERPUFFkdk1yQ1ZveURpUHVNTHdqUVNNMnVDN00yWkor?=
 =?utf-8?B?UWpBNXRWeXJNMjBIek5KUkdCbnZuTkV3SUcram5vdzFFdEVRaVZDSzBHMUpM?=
 =?utf-8?B?WE1wN3RVVWZCU2N1Z0NRTEtXVUVBQS9GTnZ5aWxBelJGQ0EydlpWbVNobnlO?=
 =?utf-8?B?L2VaNW1CL2pxV1VlSG83eUxlMnNuVUJ6OU13ZHA1azNuSHVmRmpyTm96ektH?=
 =?utf-8?B?N0lmUkk3bnZyTmdJSE9LK3lqRTdreVJHdVNjcFgwcmc0NjVwNjNjZ0hQVzQ0?=
 =?utf-8?B?SnppWk5ZTG1pbnVOUkE2RjNYZDJsUnQ5ZElibGdoVTFnWFFFSFFwT3pHeCtB?=
 =?utf-8?B?TDlCalluV1ZjVCtZV2ZWWFhENjB3ZmkvaW5va2xIckVGU1BXQUpxdDlrdzh0?=
 =?utf-8?B?L1BSUjRhUzlqSlcrS3BIanF6SmlTS3llQ2VDVktlUlNVWWhJOUdmMkhIaGZ5?=
 =?utf-8?B?NkhOV0pOS2hmT20wZFUwclFmZWpEV2NRUnR5WEFnTWpmV1VxVVhPazdsZ3Yr?=
 =?utf-8?B?OU9JdmtnYmRkcUhyL3FSLy9zZjlVV0grbXhZZnFOQUlLMGcrZDBkblBuUTY2?=
 =?utf-8?B?ZmdseXRyQVZock9wRk00WC8zYVRkSDF3dS9nZWFJNEY5cUJ4QmRUSDBLUDhG?=
 =?utf-8?B?Z05BQWdlem10OUZzYURiaDFyMnAvb1U0RlNiVHFWK2RHTmE2RlpsbTIrOU5E?=
 =?utf-8?B?Y3ZQL3ovUlJ0cDNsLzltbmZLY0lMcmptTUc3cWZUUUxpeGhadnBIcGNqbWF3?=
 =?utf-8?B?SXIxVUw1aENDSFpSWmEvSGVEaTAvOVpvWjgrc2lHTHRIMVJOcGc3dFZrcHI3?=
 =?utf-8?B?ZnUzU1FSMElQTnBNZEdxeE1wQWFaMTVUL1B6b2EyYXNDT2dIdFcySmZrTy9H?=
 =?utf-8?B?bTlWd0lPKzJnMEdZY0hpYjBhY21ubXUyWHUyZG9uZWZaU2RaTm5HUjFpWGhG?=
 =?utf-8?B?NWtrQUpXSjhjZkpYQk5IcGlDR2JxK05TWjJtZnpQT1graG1WRFUyUXlHaGVY?=
 =?utf-8?B?Uk54eVBYQzF3SEgrcWx6RTc4ZnprYWdSUjdzUG03QmpTdXRVSzZsaWNVWG5j?=
 =?utf-8?B?VDFZUjk5NUpzYlpxUGUwWWdxVzloZVVGemNtbmFzeHhyWkdkVXczV1diQndP?=
 =?utf-8?B?eHZDRDdPWVBBSHNNNGZaUTVUQXR3WU9hSS80ZEFzZEEzS2RGa2d3RFp6ZXN4?=
 =?utf-8?B?MzdqbVFZVktoZzdBS2U2SHQ1TllyZ2FPelZKRWQ4L3N0MXJPQWxuMmxIRzRU?=
 =?utf-8?B?L2VBbUFDb2JKMlJxZVZraStBWDUrZVhXV3J0ZWxiN2w0WnVmdVVQSTZVQlRD?=
 =?utf-8?B?Y0NreGM1VHNTaEFMNEpUN0l0VlFXSVBxcDFVV0h5TUc2VWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCsyY011UVhDWTk3ZmNKcGlFT296Qk9RWVZjR0s3K29ISGp1c1hlck0rOEo3?=
 =?utf-8?B?a3ZBdHZFdGtaOE5xcEJYNzRDYmhsOGhGRXkrNlhqNnFwNXUwNDVwbzg3cXBx?=
 =?utf-8?B?aXhPU1ZnK0lGVldhcUU1VlFhbVVYbldLeHpNRUZSNmR6d0ZTNnZIRUh2andH?=
 =?utf-8?B?RVNxUU9xeGd4RUVSamZLa2pvZE5TaHJjeUZwUnp2ZG5TYnVEMjFwamM3Smg4?=
 =?utf-8?B?cmkwdXdmbTllRzR6T0NKamRNTDA2VUNkZWJBNU4zSllMbU5kRVNzalo2UCtY?=
 =?utf-8?B?NnE2Z1IvU3ZiSVdTZ0tvcmRTV1pUbVlUeDlqSHJJTk9LWW8zRVBwcU92QW1P?=
 =?utf-8?B?VDBnZHUrd2puaExSN1JmeHFhWFVaNHREcFFlQkRHbGVmcC9hME9nSStJSFJz?=
 =?utf-8?B?TDczREdvYk1MSVdZald4aDk5aDJnOCtaVy9CV2NOZjg5NTk1TFRJUHdINnli?=
 =?utf-8?B?dmRhNlNlSUJMY0RoMVkwSkJpUXBnSWlZMUsyUjBzWFEvYnJqTkZrbnhyYVpv?=
 =?utf-8?B?dHpNTDA5R2puQTZWSUU3N2FyYmJFV2lZZCtJaE5kZ2tzbnpyL2RQV1lRKzJ4?=
 =?utf-8?B?L2k5NXpldVFsdEs0RytKSmpTZ1MxazVNWElQRHBEL054T25ic2RNRDdoOEpH?=
 =?utf-8?B?bEVnY1dPbmliK1gvVXplb0dXMElBaW9rQ1NmUGZSZWtDd1NxcElKRzlIQ2NS?=
 =?utf-8?B?d1NFamdQRFZxSG5NY2UxOUdSalI2MHlvM0s3eDVGWDludXh6bFBYTkVReFpF?=
 =?utf-8?B?R3hNRVF6c0U0VTBRSHpZaWZGejBlMC9KSlhLdTNSVks3ZzlVWVhGNC93YzV3?=
 =?utf-8?B?Nzl0UHJCRWxjcDVQWUN2ZWRKWjFsbEhycTNrV2tvRmgxQ0hQWkkxY2JsbGFo?=
 =?utf-8?B?MDRINU95WUoxUEh5NlFobXFaVjhtcUVxZklrKzZrZnBrQmRPREtUc3B5TDdB?=
 =?utf-8?B?bGVKNnBFVzJHQzhLdmhJQ1BwVnBpNGJjdHVtcksyQ3ptZVVEblpsakkwUVA3?=
 =?utf-8?B?ajhLZ2h0Q01ZUk5CcExQR1lFNnFWWitXSExaaUp1VnI2N3BvMU05Wm5tdUtX?=
 =?utf-8?B?eERwS05UWnlPSStGUE12eHJmVWREcDMxdlBkRnF5K3FlRTBqY2N6bFFsRlRp?=
 =?utf-8?B?MlZrMnFOYjgySHpNdnNPRCtkSVJZckl3Qm93THcxVEdzSEV6M3ZNNk5MNEpY?=
 =?utf-8?B?NldYYy80ZVhuNElXaHhjM1ZsRFUvaWlwTmdmMG9WaFQ3YlUyYzBZRld1aHYr?=
 =?utf-8?B?bS9MZ01xaUJya1dhaEVMRGw1VkpQSTRzZmxKM2gvZmdtQ2FIZ3lkbXJEaDdt?=
 =?utf-8?B?b0ZiZzVVQkkxUmV4OHQwbWRrcmFGZlloRXV2YUlsRzA2UFZqeklvSE1JV3Zq?=
 =?utf-8?B?aGlUeVphZ2lRWng5dlAwN1liMTNnRUlueHJkQm0yRFV1V0VKZUxDY2Q5ZG53?=
 =?utf-8?B?Uk0wZVB4TmZIRDJIeFVST0dpZjRzbVp3QW9rcFFSbloxTThaT1BJMDhCbk5X?=
 =?utf-8?B?aGRPTklYaWxIVVZiV1JFdXVDWlpscTdadU5oaTEreXdIQjBnbVFFQUVyUGhq?=
 =?utf-8?B?bnRaYVk0RmtoN3lTK2l5K1l1ekFMRnF2VUUzU1k2RVpwbHh4MTlnLzFnalpN?=
 =?utf-8?B?TmZ6aTdoTENaOWMzKyt2WDVyd3NKdVNIaDRjVStWWG5FU1oxVTZxQWZWZitw?=
 =?utf-8?B?RXRIWmdXd2h4UFZBL3FubHhmcE5yaERyNGU3MHBqdnBnQXJxeG9oZXczdmdX?=
 =?utf-8?B?UThKMisvYnhsbXhFck0rTmp1K2Rja042eDdYSXg1NE1xcnJRMTNIaGw2Y1N4?=
 =?utf-8?B?Rzk0MUJLSUY2Z2ZRdHRWRUQrSFhGMS9wVzEyd2NETUYrTStjSGZ0YTNWUThC?=
 =?utf-8?B?dmQ4MVFTYitsSjF6UmhSUnBHUmFCZlVpcXl3Q245TlI2MUtrUmNqaktIYzFM?=
 =?utf-8?B?d2FBY25hc1RFcGthbjh2YmxxK2M5dzdLNkNWMXU4K3RtWWRaV1VxT0RmNkNa?=
 =?utf-8?B?R1Z1VUIzN3I4V3BUR1BRSnQwUkkvLzErUy9UM1F6N05XTm9rTlhBYmdqa25N?=
 =?utf-8?B?Z2xkQkhMcWcyNkxta1ZlZ3ZpZUJ2MjlRcDlYdVV2bEdiSm9pdW9XdzhrQXBu?=
 =?utf-8?Q?goAGd9oLUxkPqeHCq4LklVC6C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d792edf2-3a7e-4ae3-c973-08dcb1bcfe5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 00:00:46.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YZFRrqE7WJ0Xs5IHKvRyw6JAfZwjmcFuf1g0i2Mlp3Ll8FbqlaXHovOyCthWk5/V+ejFEdcpf7fIb/uQ0OgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10406

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


