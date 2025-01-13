Return-Path: <linux-can+bounces-2611-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A6A0B663
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 13:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952811886B0C
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223E22F17A;
	Mon, 13 Jan 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Iyjn5sMF"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6658622A4F7;
	Mon, 13 Jan 2025 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770044; cv=fail; b=kUkThhhOFiW6VFXogTPJuuAtgYqKBiNlTgEIYxAqRWIa/DUsTxH74H6LFYwbrwn5OW5IJa8fsHXZNUB1lk+N6CXYqFaonS4pDKrEsmj/geDJe0YxzoZOPh4uSNUQJJd5JgjPfXhMQSPE5WmOUoZZSyo5QaGAiK+95DUHd1Jtr70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770044; c=relaxed/simple;
	bh=z7sgzUHJzovVRjZcaYrA+17RJo1kqu7VsOOZWWx1Ykc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnxuaFfuJm9XyLJHcJ7IEJGjmVZ2bNEX0+GmIaVZs6xp5Cnzp+iYifYGqylQV/c1vqUE4MDlrVad+FE7QO+0Y5sNfxcAjyEKsH/HZjQ7PI0LJHOMRMxFTeNwX0e4vjNsV+XbqIrcdDzASW1RJZCUSSx+uzyOzw9SqJvDG6RSpnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Iyjn5sMF; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrVKK5uNcvM/m7RKNRh/w6FEHCLW5Ag1OrANc1zN0cl80p9mWJsRqgpp15ffFRVLwmk0m0/DdqG49ZeNM89SKnQUd8vM6frIf94LQ8enBRMsM+AsIcPFfx28Uf7HnmN0uQKZcxaKPzNnna+MzwzU+lpMyjhkuKbmyChT5mxpKn9k7VxL+NtdUGT0IaBM4PmQsHJqn4ZB9pB1qrYBbzT4PAhIW+LJsvd5OJ0BWR9zqKUZMGCAHtQDVKXaIuuMtHtF4G4biOKGy3YQ/2CvNZjw61i8sNzvNZvKOyf6RM41rGx5FkpbzCY/drFWaRrITW0cBvQUS9V4nRX/WdMjW1Xxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifRbbYsxVD/S/XeUi1nthARbnHnUTln9zsV7Ng5LIrM=;
 b=ww7R7Yuavy3pyE7WfEL4eOORTIQNWqjKePkyfoVQzFXNPJOV7NlNspBw9KswU7kvQ+3AuFbXDlvvD3lxTakBVb89n4ZGT4Eu+SWdeNEX76dewZp937vDqD3vOR9v14NgvzyCaImK+LyEGx4q3gVL64Q0iYHB1e1FW+CuA/dQDRBpZVAbujJoqi5j4Ke+wI3wNHP2RgxS8YDN2kaVCmK6JKVukY30eOSSC+6SyAubSO5ATNmDBo7qzgeyUM7OrbVyd6JncilmtaCxam/4gA6EpANqVnMzCo5r8aNGOCof4FZU0jkcT+oIq2MrtXEyJd9NdObu8Gg8Ppo9qHCuVGpAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifRbbYsxVD/S/XeUi1nthARbnHnUTln9zsV7Ng5LIrM=;
 b=Iyjn5sMFtNCiwmcyjPvnE91pJxcfIJ+RHXtxdJ9Trv+nttJM14QBn7nmBmAANpqx2hrkt/EZiXcN/kqspQRj6dc85W1Howv/93ox/dZ5oHdraGgR26PBDh6ch7iz+LHW9EgOYpu1krx8RAY3L/ZnPYmJxKzQjEV8z8BRKq87MHO5thWt+mS1wZRLBl5bp5u9GF4CFcXaqjmIp8+fFe98qrmK4MidKANkhrOi4QooJrYpG6ZpHQ8JtYq7YXTRS7NbXnZoBjGmtusHn6s1I+awUdvXHjqZ9llJor1DOtOX9Ofpjv7sOhcPyAYGLTIB8XDPvKsnEYHrzGyOC9TMA5zKuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB8056.eurprd04.prod.outlook.com (2603:10a6:20b:288::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.15; Mon, 13 Jan
 2025 12:07:17 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:07:17 +0000
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
Subject: [PATCH v4 3/3 RESEND] can: flexcan: add NXP S32G2/S32G3 SoC support
Date: Mon, 13 Jan 2025 14:07:04 +0200
Message-ID: <20250113120704.522307-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
References: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::37) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ade785-d7c7-488b-98ff-08dd33cad30b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um45amcwRHV2MUNwWlpxZ1g1SFFWSjlHanN6VmNYZUlKS3lVWE93N3pLbFFT?=
 =?utf-8?B?bzd4NDFlTE93UnZzeFZKcFRHTlM3N2hyVHBHTjM2N0dWQWU5YTRibzJkNUZZ?=
 =?utf-8?B?bmRTS3dTOFZFQXd5TWVoTjFXYXhzbTlraUZWR2JvMmlmYVNud3h4Qkxqanlx?=
 =?utf-8?B?VkJFb29XaStJZlJPUEc5QWRDVjFxakJuSjNWT2VMUFlDeitRQ0JSWXZvbXgr?=
 =?utf-8?B?bXJrWVlpY2J2WEFXeElwRVl4azhOZXVMZDlJcVN0dGEyYUhhdGo5K2NyNUdO?=
 =?utf-8?B?cUoyUFRNTUlvOWVZaUhCYkh4cTFnVXFyVU1KWTNkVS9kWktyY0swTmkrcTdP?=
 =?utf-8?B?SWFSZGN5eFNWcVNHWFVTdEdSN0NZMEJhRzgwN2JuWTRnRHlsSEpHdk9lT0Mw?=
 =?utf-8?B?WVhVV0MxSlg3aXM1QkcyVWdvMEdNdzBSSGZxbTZIU24xM3Z6WFcvUkQ3cmpp?=
 =?utf-8?B?YkdNZFpMREJ2VTF4QnJXZ2k2U3loeTFkUys0dmQwRkViaG9WOWJTRUtKNEJ2?=
 =?utf-8?B?R1VkTUMzZkVNTFVmbUxEelJaWlp1b3NEY1MybHlCQ3FRN1ZqeGhPSml5RlJ4?=
 =?utf-8?B?Rm8wTG1aNm81WVEvMWxtelByQ0JyNFJCdlNDaDVQOWxpMjVyVHI5anRXT2Z5?=
 =?utf-8?B?dS9mNExnOHpKa3NnVmJrREJuQU5RVzNQRUUzZUg1a1dVRlJXZHBpOGYrUVJI?=
 =?utf-8?B?Y1dVS0toQndPVW13RHoyYVhBNXczQkJqQllIV1Q2V3FJQVBraTkxZ29YWU10?=
 =?utf-8?B?Unl4TFNpeFlNVGw2UnJkSjdTTmJwL3dHUC9wbWNDQk85cUxTTnR2SmhTWjd3?=
 =?utf-8?B?RStTVGdYLzJER0REdUpCS3hIa0swRkxxTFNENFV3bFpmbS9QUGpBS1lyN0hJ?=
 =?utf-8?B?dHd2aDRpWU5tYVV2bnZrOUVUUjE4bHJFSDdiMElUcjFqS1Zzb3UrUVJSa21H?=
 =?utf-8?B?RW5rRGVxMWhrMTg0Z1gvdDRDUExqUWNZL0ttRXU4RHdWZkpVWXREUWxYU2h0?=
 =?utf-8?B?ZUJPdENkdGhYRnlFSFlqdkQ2dWpMSm82ckxOUVV6M1RWQXg1ODdsUUxoQWND?=
 =?utf-8?B?ZkJSUmt0SlRmNzlDWTBTMEhoYTBDZGV5eUtVYkFRcDhWeGN3QjVCdW9INk85?=
 =?utf-8?B?ZEs3V1cwenVpbGwxNVJUMEFZQUhOSkpmYUFkZW9BckdWUy9BcjZZVDNDVjFi?=
 =?utf-8?B?bUJhSytUWVBwM2xPWHNMK1NoNDdxSm16azZKb00xSkd2T1FheCtEMFJ5ZUhN?=
 =?utf-8?B?cmhkTjlad2kyckc5d2JWd3FmbXlPSC9IcjNpZVU5aStEcmt5WHZxWXFYeUVy?=
 =?utf-8?B?YlBNaDQ4MTErTWZSVUFLQUhFSmtCUXlZa3I4VTFyNXBocm1xOFdQenFxYndB?=
 =?utf-8?B?M0k0LzlSaWYwVHEwMzZPUlU1cTlzaTJiSWs0RVNZa3lHN1AwK2FmMnFzOFZY?=
 =?utf-8?B?RUVzY2F4R2lZdHlpZmI3SU8vMGs1aEluSCtoRzdqamVFOGpsZ3hhNFVuUXcy?=
 =?utf-8?B?YTZoN0hab2ZoK2pLd05adnFqQVFoTmNxcjdHbDYrRkE2ZWlQaW9CVlhTdW94?=
 =?utf-8?B?eDFnRjRNbkswem0yem5VeS9QMEc1K05ZQmxqTHgzL3YyT1k4UVY3aHZJbENk?=
 =?utf-8?B?cU4vYTE2aXpGOWtMaVYvdUZEZ1M0TjhRRlllNS9pK3dzVEE4cHFjQ1k2VUJ0?=
 =?utf-8?B?OWMrRUpiMnRqL0tEREhuRjZNVjd1Q1h1L09XdW1nSUJSRlBYQ2UvT2lhaS9i?=
 =?utf-8?B?cy9Pek4wUjdoOTN5R3JpaHNjV01xSzdpMFZUa1M0a004Z2pERld1ckVYSkxm?=
 =?utf-8?B?bGRLTzJJalVWQW9JZGlyemt3WHZ3dGZ0TURsL1lxSU92cWlxMWF6MUJmUU8x?=
 =?utf-8?Q?T/INAZvQvag0n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei8wN2wyNDQ4M2RrN1NNT0dsemkzZ2Q5aHFyYi95alNMc3FVb0NXQ3BZdW5U?=
 =?utf-8?B?Sk1HR2NKOS9mbUVmM1d3SkxWc09ubG5LWGdiQThQUFJwL3piRWR1UGpDSXND?=
 =?utf-8?B?YTh4bkpJRDEvNU1LL0Z1dUIvRUtFejRNeHF2bUdwWVEzTS81MkVScWlzTmo4?=
 =?utf-8?B?VUl4UU9UNjNZbHZHaThhUGVlNUtTdzVEaUxjOE04TGZkYWkyOWVGZ3JsZXIr?=
 =?utf-8?B?VkxnS0hqeEFDTE5vc1FBZ3hhL242eE1lUU1GNlFjMUNqMGNwWXZ1MXM1bzdZ?=
 =?utf-8?B?YlhRMGVyL1pTYTNWNmFMeU5JQ3dYdzRjVmUyVlM2MWh6TWNGQTBpSXIzSVV0?=
 =?utf-8?B?RTRTeWtwYi9tbndvUFF1b3ZtcUlaVWJxYUZUQVVHSFZGTzJxVlVvemNyWG1M?=
 =?utf-8?B?VVQ4Ky9tK21WZ1VyVk1iSEwyblpmNzlxY0dnRmZxOEV5TXdIdGlLaThkREhJ?=
 =?utf-8?B?cHNKaU9nOU1TU1ZQNW8vUU92T1R6azZySWFCc1hKZkd3L0t2QUhXRE5CYm5y?=
 =?utf-8?B?YjgyTzZVS21RVk9sZEg0Q2pubkFUVU5lUWEyRlJFa1FhQUpza1JPaG9JSkNB?=
 =?utf-8?B?R2ZZdkFoSXlUZVhReS9uSmhKaXdnZ3h6UDZsWEw4RmJIUVptcjJCeHc0WnNk?=
 =?utf-8?B?eHI4QTg0bzVSNGs3TDRPUXlua1VrV0VKZ2JYczB3NGhmNDVaaERCV1E3SFgz?=
 =?utf-8?B?RTJwUzNnN3A4Tk5UMjlUYmRjVE5LMFdUbGd2VndVdW5VQk44TTFjQWZZM25Q?=
 =?utf-8?B?QzFUNlJ5aStOUnl1aWtISWx3MjRCSkpGbWJoRGJIUXpEOUduTFNuYm5hUmpj?=
 =?utf-8?B?TkZ5bkJ4R05RcEVaK0JJVmoxSUR6anplZTB3WkNZV0ZzT3RjRFlwOTJpNTAy?=
 =?utf-8?B?cC9WTytYVW1uWmpSdStqaXQ3a0dabXNkMXhVL1F6RTBsV2tiS3BHYTBiYXd4?=
 =?utf-8?B?UDFNb0w4ckhkVVNSU3lZZER4eGhyR21MNkRzR3JwYXhlanFsTzFWRHptcVM3?=
 =?utf-8?B?R05XQytuK3N3Qm5lS05UN3QzSkx0U2cwL0xNMlR1M2hEY0thVXVkQXpHQmIw?=
 =?utf-8?B?SzIwUFh1NXhuNFFqZ0kwaENlSHRTNlgyRWNRYUVJZzJTWE1wQXdRV2RpRlVB?=
 =?utf-8?B?Qys0bmhrckZnaUR2c3hZN0VNSmJoL1doWThhN2g2cUduQVVKZXNMTVFzdTlC?=
 =?utf-8?B?dVY2SGVYZ0ZnbkhhRnFNWkdLMVBuS2h4OUkxa0lXd0pZTy9KZUtNd240eDNi?=
 =?utf-8?B?RHlyTHJxMXUxejNPWGRlaEJWRi9VR2xLUFptQ2NiSjlsZ0QvTHF0QXZaOURu?=
 =?utf-8?B?UXd5NDVrejVQS0pHSVZBdEdOVVZYMGVPRXVLUHZNdnBaV25RM3MxWFJjVzBR?=
 =?utf-8?B?QWpEOXgwN2FVTlk1L2dWakxhcGszQ0tmaERxQUxFbHJiQjRlRkZLOEVIdklj?=
 =?utf-8?B?RzhpanFTNzdVYXZ2S1JNWC9obFNqVU9DcHMwalVQUVFLZGhaLy9EUVZYVFpp?=
 =?utf-8?B?SnFKS05XZHpGdGZ5R3lhbFk0MVA0SkJ0Kzk4MGZqcDJjN1FQanZweXRZczNP?=
 =?utf-8?B?NUszeHFMNmJBRHZndFEwV1BPQy8xaVc5Nm1icXR1R3pPbm5BYXJWRUpJaVA0?=
 =?utf-8?B?dkVlalNOdkZRVm8ydkVWWUppMFZzZTlmWjZJMEdmWG56NGVINlM1OC9SVDlh?=
 =?utf-8?B?QkYrUXd3Q01SZGpPT0h4SlYzVWRCMm5QQnJRY3FzYitWdjZxM1U0bkJuclli?=
 =?utf-8?B?RXVBZmdvQ0xSdUt5U0ptaXV4cU95eFhuajZKWlpUeU02dkdiUUVVUlpmeGlH?=
 =?utf-8?B?Vzc1eXVScUhTaWUrdXdscnlTbEp3U0QvbkhudmhkWGU5cCs2bzAyQnRpZVg1?=
 =?utf-8?B?bWdhVmtla1JzM1ViOWlOcXBhU214enlZa21PZ2oyQUlMT1IwbzFSaTdzYytW?=
 =?utf-8?B?d29ISWh1b0IxbUcrZUUzZUFvSW9IQlFRSHYwZVNTb01aMTJhK3hTcnJPcHBy?=
 =?utf-8?B?QUhDc1RTL3J5WVIrK3IrUlFPQ0kzZVcxRkZMWHBUYnUxeUYrcWh1ckFKQTVn?=
 =?utf-8?B?ZCtwejRtSUlsMWVGY2JLODlmRjh5YjduTG1NMUZwc3k5V1E2M1VhY1ZJejU1?=
 =?utf-8?B?ejBBamhkVjQ2Ti8wdUd3Z1BqcjN0SlRsVnIwdWZKSWlpa2d4L3AvNTA0cTBB?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ade785-d7c7-488b-98ff-08dd33cad30b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:07:17.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V15U4PvtqH0eLvpxHCeFdqe0+g7oj04qO4oON8qYCDsi3ElMJkT25NefaKgD9oiBfn60Xk5zXMfGGpHqsJXYrplgNRxNmuhQZ/uf73RDgAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8056

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device type data for S32G2/S32G3 SoC.

FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
management is different.

On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, Mailboxes 0-7 and Mailboxes 8-127 respectively.
In order to handle this FlexCAN hardware particularity, first reuse the
'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq handling
support. Secondly, use the newly introduced
'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk which handles the case where two
separate mailbox ranges are controlled by independent hardware interrupt
lines.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 3ae54305bf33..282297c55502 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,16 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2055,6 +2065,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.45.2


