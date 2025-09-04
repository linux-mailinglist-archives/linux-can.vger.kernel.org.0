Return-Path: <linux-can+bounces-4474-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3073B4360C
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271107C1A15
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C02C3278;
	Thu,  4 Sep 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="w79uMu55";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="UHiDMHpM"
X-Original-To: linux-can@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040932C17B2;
	Thu,  4 Sep 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975139; cv=fail; b=b7wlR5SqVJNMl+VdNo66UYD7nK1v2utJ/fbQzHW14OdfAeL2sLh8kEVpqLXcNcC0C/JgVzlW6fTAhQz1Vm9J09ocJS/Zq2fbE4wlSyjQ+fk7LusCtTI5Pwm1a4uQewJXozdopNqXbD6f6Rt2isIzNuHWVXwg4YQMWBwxPOBXCAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975139; c=relaxed/simple;
	bh=pfJYSif8sj56sqw/GwoI83K4FSXW41iaWhxu/Ot3nRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hPYvtsmiKsNNoJT1yPI8aGSktvU66+iftWlSqx3fYmDjoJOijZVAt1wilR+rWdczk3WPWL/80zBxH7yLdJe3i39MaELKa0YFXTslMfEReMoLMlWbNbEqqu7KHKphvCeT3GsTpe00LepmOb+T1EBHAzTcg6GSsSQaagVlPfXMOk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=w79uMu55; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=UHiDMHpM; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5847sFgD026097;
	Thu, 4 Sep 2025 10:38:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HWjPSjPGXPzVoFaA5u9PKjCQGy0GjZpaw4XeDCJxXeY=; b=w79uMu55dpMg0TIC
	pH6AzLMtGzgJgEBevFj5pSdOcHJjmVwd1C4uze80CQPCkDPBXdLiqoKvzlNRkUpz
	M5IpKnt7ZfL6P8HEueNoTZiAUkic9qJEgikikpYw34rjUpHEfsyk4zZDBGXYWmIe
	N4FbElsIYrgbzpIA79vHZjvTUzwomb+U9uwQxX0goa4SMmCwSWrg813tHYq3C479
	bVj+k+6c3AdWOqFiP8fhf5l4C5wpxABcL2fFp+EvXN8SG/qMLEMzJTJe9CbCub5x
	JGPZeQe38/ey6iCxoYTGOjKmurB2KM6dQL41u9K219RYRw1zUlLGvL/+SoYOHBAl
	CH/x3Q==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48ur6fv5g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:38:44 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdAzhUZA9kuhOnqpY2iX3IT/DdDwGiFvb3eGwEwk0GmXP0r4VPPWvquwa2tk23YvF1ZrfzS2HvUXj8T/IVAk5t7g3GojxQquD+OrMP4LU0xWvCjdT+dsaxMU6TfCiPVFEdkTmJLu70b3iAOfSP4h1s4B0HPigw5zPO/srwsCkC2xUKSsnf9oMgo7EtG59MyZWfZIIyf6kpQvjEJI7V/Otvg0ivOU/eu5vDiJeAoQ6Pi1kf5WlAlDW7LepAJpJ87FWba/nwS8x00rTHobRwE5JniOairfM7yJo2umhPHq61ldcpxU/7qs3yZ/x4HkpB3WVpEMBDROu1YBpT2167fs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWjPSjPGXPzVoFaA5u9PKjCQGy0GjZpaw4XeDCJxXeY=;
 b=HWdPjA6mYdbSfAcj4LCYDvGksm8N9Wfgpc5m56ox+KzdmVJI+wJr32xdl1gR+g6eo2i4hrZqGRm9trNR8gNoRaQ6Th23v4qSrbwin7M/qX7Jb0WKJ1kWdU+pPtPNEfxpBR6LtqzjCIXgqs+FwJUwGE1+4Y0/LzHu2yKRVlEeXa/n84PuyBuQn5+RwZ4GyTCJi0HmqOVxe70+UkefYiK+tB2W9dJ+rifrX3Yypl4fW7QWvJFb/foWF5Ye8Mb3j5acJ/GxNJ9knwr1Uo4/Zuts7DYelfb+3tW9KwHMF/Qat5H8Hz3n9f99Z0yluPljeKe9lvTv/B5m1Tf5eaQkk0+D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWjPSjPGXPzVoFaA5u9PKjCQGy0GjZpaw4XeDCJxXeY=;
 b=UHiDMHpM82mlJKKPD3HetDjsXE5okynCsZgJVi0NeU7DtfJENXWTpbYNc0DE1rlBo9LaGikOP2yibref9Mb6EcSspZgie3aWq+UEikn+ApCFb+c7RlcfYwNoQO+DEiQOipSNrQYyVw6TAf5q90UL1uZnsUWopfZMpivc0LLlNvc=
Received: from AS4PR09CA0021.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::19)
 by AS2PR10MB6398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:556::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 08:38:41 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::3a) by AS4PR09CA0021.outlook.office365.com
 (2603:10a6:20b:5d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 08:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 08:38:40 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 10:36:21 +0200
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 10:38:39 +0200
Message-ID: <e42dbe09-f86d-4a40-a76a-af2e24ac9de7@foss.st.com>
Date: Thu, 4 Sep 2025 10:38:38 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] can: m_can: document and add external reset
To: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chandrasekar Ramakrishnan
	<rcsekar@samsung.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>, <linux-can@vger.kernel.org>
References: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AS2PR10MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: b7586fb8-b31e-4ec3-f933-08ddeb8e7305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGxRRExWT3V2dHNiaXBJdGJ3aEdWRWVBRGZUaTQzODByV2RjM1pTN0gxeHY0?=
 =?utf-8?B?MFdwRE1WeDJkQTJxWnFJQlllOTEvU1JOdWVkSHNQWUgranFiR2pBbWNYQkRJ?=
 =?utf-8?B?TDRpV0Y0bWlHQXQ4eEdlUkoyNXd5NGJRbEgvTi9sWFY1aWwwcEwvQWgrc2Q1?=
 =?utf-8?B?Z2pzTWw0SDFWeEZDS3ZpN1NPNjdvRnR2eDRaU3lKN2RsRlRLeVF5eW53SW5t?=
 =?utf-8?B?YXpEVk16UzFSTmQzMFg3RmlaTkJpc0VHYkYxSjRLV3MweVF1a2pGbE1QSFpT?=
 =?utf-8?B?bk54TnZETEswZERKVkJiTzU1aGRpKzB6Tm5hOFlxMGxLT2JCTk1ZUUUvc2E0?=
 =?utf-8?B?RTJVNGR1dTlINUhxMVZGYjhEb1V0ck9iUHdvT2Y4V1pCaFhaaHFocjF2Qi9S?=
 =?utf-8?B?eGdvSjN1SDM2WGdtVUxGYjE5NlJxN0JmcGxQWDBTL1UyWllNRkhlOTdmMWxU?=
 =?utf-8?B?enZGNEtxQUc4djRaSzk2dXM0MlhqZW9iT20wU1JRQ2ZTenJFUy9GdHAyZzhy?=
 =?utf-8?B?VGJSa1Z3VkQvRHJZVGwrR3BvVEZ3Nm40Z2I4UUZ1TDFMUy8yQldpTkUxR0ZP?=
 =?utf-8?B?Q0NIUWxqME91SVhjT0draGlMQmNiOXR6d2tKMEdMM2wvY2EreGh6UnNYSElN?=
 =?utf-8?B?bzZuZEx6bG95MUJSUjhuYTJkN0hWK0E1T2p5QmFxTEpMbGZwT1kzZEhuSFZ5?=
 =?utf-8?B?L0dyK0V4VFZkUUt3TnBNY0NYakQ4R3JaSXNQQW0zUzllRUdyUU1WN2REVmJi?=
 =?utf-8?B?alJOeFJBekV6SWs1c2Q2ZllkRDhHTGx1Y3NmZ1R2TFlDNllxTmxvSnZaZWs4?=
 =?utf-8?B?REpOV2pndDFGK0tzd2tWSXo2WjlDa0lWZVBSUmIzaUp4TElWWHk0bHhWN0dQ?=
 =?utf-8?B?b3poVjNUSHNSVVNLTE81TTdVOTZGaHM2bXkxdzd6UEVHSjhnU2pZQURTUjJl?=
 =?utf-8?B?SVh6cC9kUU85S3dRZ29JTER4Nm9IUkZCLzdqQ1NhMWwwYmdxdEM0UktOY0hO?=
 =?utf-8?B?NUQ5dVVCai85dzd3SmZEU1JtY2hWZVp1anJpaExieEY0a3ZkWVJrR2RyV0Ru?=
 =?utf-8?B?RnVESk1TZjJpMnpxOUhXU0F0M1hWSTlIZ3VSNDQ5dnAwRjFVdlM0VWJKdjAy?=
 =?utf-8?B?R3BtL2c4WlpSd2JOeFpxZjc4akZJb2FlRkVUUExMMitGODFRN2lxREw2N2lU?=
 =?utf-8?B?cGVDQUlsZll3dVVrZ0pMWWlIcFMrdGM3VnA1SElnNjNiYlN3N2l0WEpnRFBH?=
 =?utf-8?B?Rk9RaHdYRi8yQTdxdStrTzFjcVFsYnNueUpmRUhiQ0VjODdhZ2xSVTVUdUNr?=
 =?utf-8?B?a1JObVlwZDVvSlhOeXBRV1I5bklwdFdqZkFiRnpaYTF2QWhPTlRiL3dDMWNK?=
 =?utf-8?B?REt2ZWRlRjhVdXZRb3RuakFpd0RoZk5YWWgzOXJzZjZFcmxPbW5oNE94WU5E?=
 =?utf-8?B?TS9LZkU3MDNYZWdDQ01NaGtXVTlLUE1GS2N6c25YSHVMV1lyRHlsdFlkQTJF?=
 =?utf-8?B?OENlSVlJdyt0YmxMKzFDOHczTG1XNkRTWTZDejNEcERvKzM0MFh1T3l5VlF3?=
 =?utf-8?B?NmNKQ1dMbTZYM0kramVnSWVMdWFVYW0wL1BuSUZGM1JQOWdubmk0WjI5aTIx?=
 =?utf-8?B?QnB0V3YwNklpdkRHWnJobzRHKzFtV2VZZWliODUxbW9vNjl6UXdYVUUzcXZp?=
 =?utf-8?B?d3NmNUFkSVZOS2VMaUcxdzU2dGNkZUpNeTgvdHQwUXhNTG9jRHUwM0JKM0NG?=
 =?utf-8?B?UE5xcnkyanJnRk4rSDk2NG8zUVJpeG5kdjFmbFBiTTl5cHl5bW1BdEhZUUpE?=
 =?utf-8?B?VFBPc3dTWGROWis5WDlscXphREQ5aVlDanlIRmxodkVqdmlHdCtONU9YTjFv?=
 =?utf-8?B?cVluQlYyWCszQk1NMy9SemhkOWJWRTZZanZmRjUwWVYzZ0M2ZnRXa2JYR3d2?=
 =?utf-8?Q?0NQcI+PoKCaFhDjzZlZTWbCXG1K0l0Js?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:38:40.3166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7586fb8-b31e-4ec3-f933-08ddeb8e7305
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6398
X-Authority-Analysis: v=2.4 cv=Ts3mhCXh c=1 sm=1 tr=0 ts=68b95014 cx=c_pps a=WIKKr3Q+Zo2wxA0Am9cKlQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=bC-a23v3AAAA:8 a=805NyflqAxIXXG6U488A:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: NFIPWGNg9amDR394azZT4QPSqjGhM4ca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOCBTYWx0ZWRfX48ZNiqUoptDf uAWmb2Jm4VE71/BvAgFJlfavd211rCOS2GpXezdWk+HkqKsmMPyL1OtvtLFaF08hW8hzKjW8Qre s+ef/adcXTn2vZQ/k9IzUhdUsVCQvbTlj0WfqnIyj+EuertGM5x37fvFlBRLfpDrZ6iBVf4Pvcr
 ABOM5PyrDCtJqs6yOxQ0jvSypkRf5BLISQBn1g6NyIxUe3B2Zxd6+9nYKhBrokHdoUbZDgY26Oi nIGEiTF5pqhUz/68sV/HK5L9yxjSn3fmewnrKwV7Qt2qyOJxBvGLwANwJFZA1NlS7IKKSE7asEH z/RDJyCM6+xRoT/x8yDzl0PmhUlNj91Ib/fLOTpkU4AzFXhYX0kMvNwUh2X0sgkW2tGfIwYHo8j 0PBhv4tT
X-Proofpoint-GUID: NFIPWGNg9amDR394azZT4QPSqjGhM4ca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300018

Hi Marc

On 8/7/25 08:09, Marc Kleine-Budde wrote:
> The m_can IP core has an external reset line. Update the DT bindings
> documentation accordingly and add it to the stm32mp153 device tree.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes in v2:
> - add dt-bindings update as 1st patch
> - move stm32mp153.dtsi update to 2nd patch
> - Link to v1: https://patch.msgid.link/20250806-stm32mp15-m_can-add-reset-v1-1-9d81f9c29d65@pengutronix.de
> 
> ---
> Marc Kleine-Budde (2):
>        dt-binding: can: m_can: add optional resets property
>        ARM: dts: stm32: add resets property to m_can nodes in the stm32mp153
> 
>   Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
>   arch/arm/boot/dts/st/stm32mp153.dtsi                       | 2 ++
>   2 files changed, 5 insertions(+)
> ---
> base-commit: 1a32f7427eb3d1248bc64cd745b93f88cc838933
> change-id: 20250806-stm32mp15-m_can-add-reset-ccfc47213ba3
> 
> Best regards,
> --
> Marc Kleine-Budde <mkl@pengutronix.de>
> 
> 

Thanks for your explanation.

Series applied on stm32-next.

Cheers.
Alex

