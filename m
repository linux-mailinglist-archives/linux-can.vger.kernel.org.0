Return-Path: <linux-can+bounces-7222-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HSwCK1MwWlbSAQAu9opvQ
	(envelope-from <linux-can+bounces-7222-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:22:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A02F4503
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 428B8310B5C1
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BA3B27D7;
	Mon, 23 Mar 2026 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WfcxIQ/J"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B23B19D2;
	Mon, 23 Mar 2026 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274317; cv=fail; b=EqcINoGSZGYmTayRu1v1GuUGTDaITaE+1Rlm7jVu0LmNCyTMFXkHBnmKZ10qF2KF5quz9rQ33+peuCcM7th0cLq6ivllUUdFtDUlemF6cGrOde6n3XfiTW0ti6+BZxoc6fBWBS/8WICym8II+Pjmf+4jmZRMTykVMcq5GCMncgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274317; c=relaxed/simple;
	bh=xXKZ5Al11cmgGmTjbi0OaETJ8qhQ2J+Psknv9FHksMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NFq4pCSlTW72HAQwuIUP4UUUgc8SzaTFRmbJ8Pt34vBqL0e6q2frKoM3wbc0ZfTSCD9Pjqg14+5xH+snOID0a3iAxCIQRayE0pNHh4Vqn8wf1rsXGs1dw1SLpgdFU1JuTvBoZeClloZfhqXBlg3qBXZcahBLu/bai76wqb0f7GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WfcxIQ/J; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITwO3vrpnGiBonUqmtsQwtH41Z5AAQiD/ohYXpdKx/w9FddX0GxL7rrr0OzW7/D27IlZ+RZgDqHXudhbbKE7zStn1x/eXrShzleYn1/eqZVSMjl/vimXUEkeO23Hl9aEfcy1H7m6z56WLgyQFlGhWA0ussySitkp6rD/xBF4NdXkhJsftDpmy+NTvwVdhIjUOQ0MW4Q4sDb49ppyQxtqsO41CGPOaO90kt+GiSbSjIfHH1rTOzlGnuYfROnf/U2zZO2SO3R2v3tqaBN60JBQHkzuqKyIiZcM3xXXY97lb3xsgmS/wVaCLCBAcTBdUliRcuQb7wyBQ9DU12mSFb1kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDJ9VBWOVDn5mmykLp+Y3WkXIpGo2WL955vVurEj15A=;
 b=ftqOl5IXz+O6CRU5YWup+uawNm+qtBrn/CFfsQsQsBIn0C1x/ZfD8tWOfb3XJexpYFIZ2iAietXqB9QBUiRORC1vX5VOMZRWINHGP8Dh/L/9L81DC0J3kbAkOpJzp+MfN06NarcfYHRg1rGQ55+LRHp9UVujlHYae+9JGRgvMJuqsUH7roqmXnX/doEf5Gfev8fASKnNvePXQkXb3khTK2UeX2s1sYxNSwVKJ+8mYb7FYNLgVI8KcHq9bzLbqXRYWnjUpKRtzB6IgtUjqf4EgeSvd613pDCs/wUmiWMS8n8n9LwZb6koqN/rhBiH1UUnwRlu0Bcvm+7ViKOYYUbZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDJ9VBWOVDn5mmykLp+Y3WkXIpGo2WL955vVurEj15A=;
 b=WfcxIQ/J5rLMW7J77yK9b35jwRv3xtVjK06wFbfzEvZk7WtBfAxkuy0GdzFikgrg5Js4guCQfww6dYgy+0cOs47OggKBhnVs6n5QPZqid/g+s3CkyaxuhCz+YJdDII645g1EfPIRcgn+4kVtj7X5FdUSXr2Qyvmqk48N/4scXlhwzL1eM/a0lans+0S7S5jUzr33Fumjs37SzHeU0gKJkCZ59Q5TN5Lzg6k9N7AdTnjIqpGNELctS1QPrS2OkPYcohyoxyY6s6F7vEW54pE9x1ljMMmnfBeYqGgFS5VilHA/aUEqGzz82vIDiJsoQoWzVDiDwuGKBFaFHzF5x6eHAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:58:23 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:58:23 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 1/6] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Mon, 23 Mar 2026 14:58:22 +0100
Message-ID: <20260323135827.2129371-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0067.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 19977e16-b20c-400a-881e-08de88e43f4f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WyGYWXabHNXLaZ8toNh38HxcN/V+xEONRTr73t4yF5mKWgmoxfFVUwX5t8l3wQXjrhAzCS1BkC9LOgTrWYBQKkh/FfqB1XeCALnpQXT3d/CEHG8lL/ng1b8+ebl66WpBpZnQnztLouH1wMJomK64LhNEQJi6UXZPr2MAuEcm0LcaXhEOSS1vGekrT5CsfY0murQYXWhLsPq9eZYVW5NgObO1cP9wR/88lRB6IyC9D9Ajtx9lj89DCLBYFPRDURfiASL/drlBJL4qLhWV9S7mXaUxXkDABoxtPHgVVhq48fzpQr/TRjFWF7S+4wUE892boItGCeH55wMW3h62hh5LxWlNcA1coa5ORCInHRODqfRYAqxrVlU4qWWWheJX0fYu2YvTdeDpenE2VhqN1SLiSygxDJkTzIi8yJfnKl96AMOEe8UuEC6shHe690QDNST3IAGNA6MqJl7Hqq3YxS/p27z0CjzKtBVJ0gizpcBjmjND1y2ITW67ObT2WXmT7bucsZzm21sdLIdwxsGnJBppMKG1wY4MOJj5YJwUanFAmo1mT1lM4OHakO/UjilOGkm+XHPLXl/Xm6IWAOEA9CnLYMz5FHLPm58TcexqESdhkv+Mc/mziKg3E/Eg4RQmxrJaPePDNOZSLcKTSXcYfGlK/n8s3buiwZBr53hp1awlT8qPd9Xcu2wgxCpMSjnpsgOY9WTpSDHDc5nibjoRFk/VBWes0VwCtcsDuXo5N4jpCjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9XL0JSUTl5UTJFa05zVE80c2ZKdWI3VWdENHQ2em0wbHM4SjhXeEJ1Nk5j?=
 =?utf-8?B?VWNyVnNSblU5VWw0TU95dlhiRnMxTTlUSnMyWnQrMkZQbXBiSGhHRGYwTXJJ?=
 =?utf-8?B?UDdOTm9PbzdRblRWdjVDMFQ1VDBRRTRsZytkYkxIMWNxdnBWMmU0cHM5ZXMw?=
 =?utf-8?B?cWVuU0xzSjJoa3Vkc2U1UnAvZUFBNElRSFJaMlRVRnpmRkFaUEt1Vnd6Q2hx?=
 =?utf-8?B?WFhyU3dWRWQ2eXFZRkRhUGkrOTlaQkl6cWxnakdDSE9LamRQanlWWGxVVFRZ?=
 =?utf-8?B?ZVlSdUd4VjdxVTI2c3BTdTFuYlJmV3RmZUlBWUxVMnd2c3Y4Qnd4d3Y0RDZS?=
 =?utf-8?B?SStDNWZjOTdFNVN5eDE0aWg3eTIwL0gyRzRucG9kaGRSVVhmMkNzUHJrajd6?=
 =?utf-8?B?Y3BpcFRtVkw1VTNIZ1loaWU5OUxydlEzWVpMaERmZEVPOTArV2h4aTlSbExw?=
 =?utf-8?B?TTJucUdxWXlYNUpQdHYyTmh1YTBFaEk4NU5vYjY0Z0hoN1V3UGYvL2RJSUcw?=
 =?utf-8?B?S0tPT2pqWjdKaTRyVnA4UWd6WG5hY2ZNd3NoV2w5dnllZWJJUk9xbG10UEtQ?=
 =?utf-8?B?Y3RVL1R3VVd4STlMTFA4N2ZxT0h5OTRqRU9mWjR1MTJKbG1qSStDUmp5Z2J5?=
 =?utf-8?B?THFEMno1c2QzcFlMUi9XZ29SREN2SlZyRXpUQW5tUUFwbWxmUUJvaGJaWGgy?=
 =?utf-8?B?WWZFWjBYeFJyWVRGdHMzN004V2M3VFB3MGNPUUpHTVFSanp1eG8wUStOUzV5?=
 =?utf-8?B?eFZGSE9qekpEd2hXYmVVMzJ5WVFuMHdqcjF1OU1uaFBzNHJ0RVMwWFJJVUlG?=
 =?utf-8?B?OERNYzFDdnM4UDl1R2x0SDJpS3RDUWh1WC9DM2NJMlFWdjJaV2UzV1k3NXFQ?=
 =?utf-8?B?R28vUkNyQWtHdDNjb3VJdnFYMGlmb01TMm1FVmJwOVJBVXZRRy8zVUJTaVBO?=
 =?utf-8?B?TGZBekhheGk4bmlObHRQbDI3UHhQRHJHcTI2TFNBclhmRVhtbEJLUU14V001?=
 =?utf-8?B?eHZuY3pseHNGSlNSUWs2SEM0YTVuaTVrd0xsaitzWHVuUi85bUVpdmFiaGJD?=
 =?utf-8?B?SDNaNEpDUGh4SUdOa3dHdXJTR1Q4Yng1TzdGbEZkOUdvRlJOK0N0WkJDU3pw?=
 =?utf-8?B?TnVPR3JIN3lMRlZjb0xWb0lmVDFvOEZIVC9qb01Fc0RtbTU3ZDlnTXFFYW9D?=
 =?utf-8?B?MjFRVksxTmJYODlKTXljdDdNWHBtd1JudWFUbkRnZ0FETldqdVYvekdyVnc3?=
 =?utf-8?B?TkY2ZlJ3a2szMVU3TUlDbTVUNzhpclpSMmQ3REFScVFHd2dVdGFpSUszZU1F?=
 =?utf-8?B?dkRuTTEwekxqeHdBdFp2cFNXNlppZkVhcVJ2MXFzMHpPLzQreXR5WW9XaEIr?=
 =?utf-8?B?K2RUbFdKV3pGY1c2cFJTVFZzNTh6bWRrOUh6TUs0blk2cTVSdkVDMFZLQWEv?=
 =?utf-8?B?UXlhb21xVVdlRVNQN2t5aEIvTk9iTFBtbVdIOGlqQ0hjQ3o0dE80blNjQWRR?=
 =?utf-8?B?NWpSRzluU1FPbVZvVzNMbFZ0dFc3WW9QZkFlYldob2NKVm1HNm5RdE9uUlFY?=
 =?utf-8?B?ejIzbmIwRlFOQ1QxS2dMV2psWDdhTHZKcFBtcjgya0JnSXhGYjRKM29DS2pm?=
 =?utf-8?B?UDRBQnhwK3ZObmpScXlzWFI5MEljV0o5b1dDWkQ0ZGdLN0NXaURYMkJXRUJQ?=
 =?utf-8?B?cyt5Tkthck1PQm5WbG9EYWkweWtYYmVqN0JXKzVxbXh0bFVFRUYxR3pKWXNX?=
 =?utf-8?B?RFE0NTZTb0tsWmdHRC84Qm1oOXgrQ2JwVHJMUGFDQXRnTDYzcElISG1mZExX?=
 =?utf-8?B?b1lIMHVXRFdYV0dZRzRDemVoWkNiQ3NJNTFGTC9Uc2NraEdvN0FBTmZuYzEv?=
 =?utf-8?B?eEU3TEo4Rjkwa1YwV0tzRjJkL0gvZzZudHE1NlFmdGxpS1RjZVN3R095V3Nn?=
 =?utf-8?B?UzBxREVmajZsSkVHdkpLLzBaRFpraDVYZ3Z0a1ovZXF0YmwwM1FsclFzand6?=
 =?utf-8?B?UDVJaTZMRDdSUHhKVmt2NTZmTUhqVXRpR3FaT3doZjIwbVVpdVZtbGVqUmcz?=
 =?utf-8?B?ME1tNWVuaExuQ3JkS1l3a2xjclF1aml3MWhFQlE1M21wUE9JMWtEQU1VSDZ3?=
 =?utf-8?B?Yk1pVDVNWS90SHUwaU1LODFkT3NtdGkwcHdaMlVvSTNJQ0xYTi9XZkx6M0sx?=
 =?utf-8?B?em5QQzNLM0w3aG4xMVRkcGZFc1pZbmFua1JaMXNyRk9rQ0R5NVRZVlBPL2xB?=
 =?utf-8?B?S2RLUGJoYzIrR0pqUU15Rjdwdlp2bVFFZ0N3d0JJRXl1UVVEOWZhSEJCYk16?=
 =?utf-8?B?ZnhuWjVWeUpNV3JMdUhqK0Z1dnVVTGNaVzNIZWFrNDZkNmhyQ3pQOFJwT2FU?=
 =?utf-8?Q?PauthoJtmwmChyLc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19977e16-b20c-400a-881e-08de88e43f4f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:58:23.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xzKV9PTh3SKd14NKuB5jJTAmKma9/RlQNIaPde26JiJ4jsCt8gCGb/9ZyPFhQ+/fwvLRFh5ZFttAMF/SSN61HbIL0xwLhIVukA/mcYic1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7222-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 894A02F4503
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events

Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line

The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 128 +++++++++++++++++++++----
 1 file changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..da712972d5de 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+/* Process mailbox (RX + TX) events */
+static irqreturn_t flexcan_do_mb(struct net_device *dev)
 {
-	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
-	u32 reg_esr;
-	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
@@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	return handled;
+}
+
+/* Process bus error events */
+static irqreturn_t flexcan_do_berr(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error, state change and wake IRQ sources */
-	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
+	/* ACK bus error interrupt source */
+	if (reg_esr & (FLEXCAN_ESR_ERR_INT)) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
+		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
 	}
 
-	/* state change interrupt or broken error state quirk fix is enabled */
-	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
-
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		flexcan_irq_bus_err(dev, reg_esr);
 
+	return handled;
+}
+
+/* Process device state change events */
+static irqreturn_t flexcan_do_state(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+	enum can_state last_state = priv->can.state;
+
+	reg_esr = priv->read(&regs->esr);
+
+	/* ACK state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT),
+				&regs->esr);
+	}
+
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data.quirks &
+	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
+		flexcan_irq_state(dev, reg_esr);
+
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
 	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
@@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	return handled;
+}
+
+/* Combined IRQ handler for single-IRQ platforms */
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+	handled |= flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Mailbox IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Bus error IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Device state change IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
 
@@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		err = request_irq(dev->irq, flexcan_irq_mb,
+				  IRQF_SHARED, dev->name, dev);
+	else
+		err = request_irq(dev->irq, flexcan_irq,
+				  IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_can_rx_offload_disable;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		err = request_irq(priv->irq_boff,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_boff, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
 
 		err = request_irq(priv->irq_err,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_berr, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_boff;
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_err;
 	}
-- 
2.43.0


