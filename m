Return-Path: <linux-can+bounces-2115-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1ED9D2511
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062521F25523
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54CA1C9ED4;
	Tue, 19 Nov 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fq0Mz12l"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C161C9EBF;
	Tue, 19 Nov 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016484; cv=fail; b=Aq6Ejpze8ltVUJB6/mTJ9o9d5P+/w/v5WRsQZdUr/W+W6mMVKe4+7cXZGJLYBr84JnjUS1eq1MkddS50a/5Xd3xzP3PEMQ7ttzk4z2qqXID8dCawS2b2x6jCHj+yoOMD0+Q9DXMTTgzOfBegk5jBCpQWWD5hc6AB9UFP6nXL7BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016484; c=relaxed/simple;
	bh=bP3SWjoQiJ4ynOxJN64BOroPXNDPYAsL2qO0YuoaqsI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWHaTSIt1vxBBXJfhC3ZZ4WbInjJ6GdmrfD/+qruNRGJ9ld80CMl9vbbPAv94rnMK/tx8NLAYPoUHww3ggmvik9dfDZRUPZqo3J8BEEJxVnaIL1Ckk96m9DiFRA8u2QyRn+lPbKY+9ShS/KkvlSxCABkurDQ2VjfbvDN1aWkpOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fq0Mz12l; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipkLUPAHKlXYeskIuihr1yBNNDGwNBeEcfcpMvmDct6TPpjxnrerHCmH6sZk56ORvRxHFQQ0q/M8k8qzhgWmlEp/zOB6o1ofV3o27oPjRoNeVno4je2e2OcEp9ykLB5hOmCsj3/6HFJVv4kRsCLC9L/FL2PutdHh4akViwRoJkSqgdSfm7qzYWt4LJU5zFxCOm/ng9++diw5ctNIubbUl0BlNORBcJWTUYI6YBYcf3RsmOXn0CtarwJ2o2yfVCAKxwQ4JkyLqOyILuKn47E0VmDU7/nMuwmexZFDivTdNgDiI2DI5pyYawKxTl775yfPIX1/d1+Ek+P7Ssafbf+Trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXIf5BwEw/hX3T1sOfh4S/jA7b/0R+u462cbD/nIbGE=;
 b=kQmbcXDtOj00kxek1YuxRXaaqX4/lmfOWUN4qu7ObhdJz3oYsDm1lDfjsiqlGEiIWQKYxCKVdzdNMM1S+PqWC+F1Bcv0rUA7R9JdCXvqjpAV7ENZT713xiXLnhdpeF79a8g0FWRHLFG/aP8ybtuQlkgqApMA5gvtgQ3OcXviCt463vAIAm212iB/B/waEeLoIQA9iOYro3pVHzd5+EY5FtaotRnr7gbSyQelBCJqYPIpezTh46hiFA2XXcGrwRexOV8aJBHHWyu+CYzkJk1dKwhOZCUetBC8XfZfQWylbkObj0Q5aZoM+n7fmnj7cvA3yxhb7fvsLFqaGGc0SX2nDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXIf5BwEw/hX3T1sOfh4S/jA7b/0R+u462cbD/nIbGE=;
 b=fq0Mz12larU50P/Px/tJXFJnKs176wgUbYnoVtNbsDPz4fbgOobjY+6eBuCPmlHhvWOsHMtPz77aP9prJb6XXl62KUEmRHSzY46w2R3XUDPrWFAZGvg8rpfF6+JiAvSHae8mMbj+PR2cBbqAFg8Ogac21X4ZimPwqYHAaMHjVY6GMyi8vW0I4Yg66yJ0UCA2NfNEwzlncjUiXkADM4PPFBLotr4ZvPvjUV9iyp+VB06q9+tGPVUzSjJTpVSdf9lQqANx9310DuNKfg+274NUqrz3VDTYfzE34KBj41O+DSwQqbX7h14gH3aXdcJjDKpG9eg86T/+qTHerOwE3PfGQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 11:41:18 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 11:41:18 +0000
Message-ID: <9dcc883c-0990-41b3-ae9e-eb1afdabeb65@oss.nxp.com>
Date: Tue, 19 Nov 2024 13:40:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <57915ed9-e57e-4ca3-bc31-6405893c937e@wanadoo.fr>
 <bfa5200d-6e56-417d-ac3b-52390398dba2@oss.nxp.com>
 <f84991f7-66c6-4366-9953-b230761b6b7a@wanadoo.fr>
 <7a91c06f-6ea3-4262-82a3-9a1daf481f82@wanadoo.fr>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <7a91c06f-6ea3-4262-82a3-9a1daf481f82@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM8PR04MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 248a8b72-3bf9-454a-a059-08dd088f1507
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjBrQ0RiOEZrNWw3NUhiY1VuRzVFWmp5VW9kTkpiZ3oyMWhWMElna0JDM1kr?=
 =?utf-8?B?WjdNU0NMOFFJeXkwWUJ1NlpBVng2SDhFc2FLazNDZWc4MXk0VmZqQTNySldm?=
 =?utf-8?B?YkFSem5Ec3lnZEFNZUordm9GU0xvMW13aldZMkd0bmpHV0owaytIVi8zV0pB?=
 =?utf-8?B?STFCY0taME5UVXNxc3E5Z1VndlFlclpTMUpMQVM3ejZCSGN3MElBbmxXd29o?=
 =?utf-8?B?WHZxRWkxZ1NVd3FFbnhXbnJxQ0t5NHJlLzhud3NtQlNIdUNQVFNtY3l5RWVT?=
 =?utf-8?B?R3NNZ1pkZFFlMW5FdktqeGkzSFMvTEY3cG9qRE91MmxhTjB5dWNNMXJxaVRR?=
 =?utf-8?B?Qk1LdkZZWVhldUxXb1huYTdacHBCRlpRaDBQeGZmSGJuaThNSHlJbTlENTJ6?=
 =?utf-8?B?dlBVODY3K2pyaWprRFA5QUdMK0ZPa0IySmNDcmFDL3R3ZHdtUlR0ZzJrNE4w?=
 =?utf-8?B?N3cvS0Y5Ukp4bjBJalhOaXF0MEd0TlFjTnZQMjFQNnd1OXZkZUJKd1BsS1g1?=
 =?utf-8?B?QkJqbnRtUm5YQ3h0VDAxQnMzc2Fyc211L0NGREhMbmlRTVR4cmF4YWFOeVZU?=
 =?utf-8?B?MmFReFU3enl3WStQZGk1WDNidllYeEYrRGcyaE5EOWFRc1VFUTAxSng4b2Rt?=
 =?utf-8?B?SUVId2hJV3RKbVg0VGl3U3VJWWNVbE1xZm9ObjhzNzFCVkxaaXh2bVh0VnFu?=
 =?utf-8?B?ckNOa0kvTUJYaHhTOU56WGUwUnU3bGovSy9hYUduOVcvVi9PTUJZZUYvMzg1?=
 =?utf-8?B?d2g1eHNmL3hTTTBxNjlIcUlUNytUWmQ5NDVqT2JYV0tZT2wyQjVOdXBWZlc1?=
 =?utf-8?B?RU1SNW5wN0NNNFVXSHFEdWlSQ1h5ZVBBVS84a0dpalhJVC9Yd2E1eEJiYjN0?=
 =?utf-8?B?OFRZSnVLVEROL0JrdTdTcUNpVkVwVkc2d1hoTG15Ty9VdjJ2MEZtMWxrMi9k?=
 =?utf-8?B?ZW9md2N0NmlmeldVQTR2MmV1YWNFejVJcGh4S25IdzZWWWEzU0szTDBuRnZW?=
 =?utf-8?B?eUUwcGFMWkE3YkJjYjZ2UGNhU2kxNExBNWR1bWMyMFRJeEJlWWRXcElGWmFh?=
 =?utf-8?B?RURoRVNHbEpUVGZwVXVCbzNSbmpoVmRpR2wySUVUYm8rbVNETmVpVUVQSlRw?=
 =?utf-8?B?OGc1cnJ4MnFER3gvSHc5OEpYQURDS3Q2b1B3RjN2QW1FcWJrRlIzMUJtcndX?=
 =?utf-8?B?SUhOd2tBTUNBQmYxRDJHR2dQZStia2g3amN4Z2JLaFh2U1hPZWdYWXJSVVU2?=
 =?utf-8?B?WU92MjZOMzBLVk01eVZOamgyanNIRmhUZEM2bFVGUWFkUXBrNVZ5dG4yTzBT?=
 =?utf-8?B?RFY0VkVzK2YrT0dtdWN0UnZ3bVBtRlRXRFR1SFBQaDZLaml5UDZiYXBTUEZL?=
 =?utf-8?B?dXlvdjQzN0taeXF0aXpGYi9ianJMUkhXWXoySTROSDlQaFowMmhMNUwzN1Bi?=
 =?utf-8?B?QitWS1JjTms0Yk9aMDRiTWdMRUw1SjdKRnM3R0hXNllmYWxEVWdMaisvVE0v?=
 =?utf-8?B?NTkvd2k3RE5CbHJHUmtjeXJPb2NZTG5XQ3VPRTFyR20wOGZOeFBvKzIwMVd5?=
 =?utf-8?B?ZmpoKzBmVzBISXlpYTZBL1FiM2xXZUM5Vktzb25mOTR1c1NCc3l4SDhNUTVM?=
 =?utf-8?B?bjFlN0p2NlBLRklSSlRYQmNoSEJOT3V0MjMwbDJQWG1uZFNwZlFBQWV0bHdO?=
 =?utf-8?B?Um1Ja242bzdocForN2lDM3c5empPTi9Kb0V5b1Q4MWJ6UFJFc1lGZnhUbk90?=
 =?utf-8?B?bmZ6UlBFVlBzVUlyMFdueUx6bnBJU1NrbUlKV0xuUXhna2RQNDQraGZ4dHc3?=
 =?utf-8?Q?45E5nDx8cKDV9TWwdJjFuHxXhi1QMBCRuQQZk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWVkL1FTVHUrTmkvTVBKUEJhSitFNEx2R21Odjh5WStzRWFvTllHbU9aQk1D?=
 =?utf-8?B?eW9HQitkQ0pIMFFPazBnakZQejhWblk4WjFyS0dwbUpmQWJhSWd6T1lFM1pL?=
 =?utf-8?B?Ky9aeGg4SXNkU1lJZ0Nudml3STVPQ2VXSW5VVkZLQngyYXdwL0ZlRTdhN0Nu?=
 =?utf-8?B?cDZncEIwYTRuZHR5Qk91cWY3NktWTlBuL0dMRDlKVmZGM3V3NHVsZ0VKSWg5?=
 =?utf-8?B?eHFWUDBWQXRTT1E5cXhQcEZZTW5tcmJrbWlFMys0eTJsU21EdDEzbkpuNGlu?=
 =?utf-8?B?S2x1a1l3RUFLYytXaHFwRHoyQXNtck1sMno1Qm1zdnlrN1Fsby9XRWIyV2Jr?=
 =?utf-8?B?THN1S1BjWm5hL1pHb3l5eUxNR0k2TmhLbTNlZVpTQzdTTVdJckZrWjZOWG1K?=
 =?utf-8?B?YWVpTTh6VjUzM3ViakVvc2d0cTJRRmd0dk54K3Q2V0hVM3YzRzV0eHlydWN1?=
 =?utf-8?B?WDN6amZSdWY3dGZMS2NGcEJJN3FrQmM4WXVDTUFycEZzNnc4WVRhUzZub2Jp?=
 =?utf-8?B?YWNFS1BOcGtsbTRHTld6ZXFpN0Y3SkdJeHFJbVk0MnVzTG9TYXJZQUxHSXNP?=
 =?utf-8?B?YkJzdmVzOU83aVlRM1Q1SzlUaHg5b3M5Zm9zRjAxeGFBcnVDR1hqTDFTUkpY?=
 =?utf-8?B?Z1EvOXpWMm5ISXZuRElIQytwN1hFdUpyemJSL0syc0lCbmdtOTI2eTd5eUpM?=
 =?utf-8?B?VGxLdHhPTmNTZlRPdkJGOFphVE5rKzNKTjlmcWVjcFlvdzJGaUVzVGVBTGsw?=
 =?utf-8?B?Yzg3bG5PRDNYdU1BQUhobGZoOGlCTmpzUEFPSlk2QVkxdU1CRENIbzRJTXZo?=
 =?utf-8?B?Y3pkYzBPOEsrU1pTSGFYbllVSkFSam1qbGZ6TGZqNTlHWlhHeGNjcTdKMlQy?=
 =?utf-8?B?azk3RFJoazJXQkRITmUyY21Bc05rNUJrbnpTeWs0d3hFeTkydmdndkl6bnNY?=
 =?utf-8?B?Z1ZSN0RqQ1pocW5KMGJaWkpobTY0STVrSWhsb1ZoZ0t5dGd5elZTS3h1WGgy?=
 =?utf-8?B?eVF2b3RxemtxZE5OcndZNTUwUHhJMmFaM2Vqb1BiZXF2M1ZNakJ2UDdrS3Jh?=
 =?utf-8?B?S1kyRjA0ajd1SmJISjZKekcxeFZYWFdFMlpLR3BSQkg2WHlDZFFVVUxZS3Zx?=
 =?utf-8?B?Wi9HclFWY3VOZnczVzNGYnFkTWlWTEJEWkFvTm1ub3hPTjRpQ2didDY2SlpH?=
 =?utf-8?B?dnlYbDZOTWl1enJ2UWtIZTI4Y3lIdUhuUk0vSjBCeDBwdytRZkoxZ1hmdzNy?=
 =?utf-8?B?UnlWVG0vdzYyRUpzZjRXN1UzOVJnemdWK0YxbnkwcllyQkRwODREYm9hNUs5?=
 =?utf-8?B?eXR3bUNOZlU4bHRINFB2eFI5bGxTSXdLRi9KanJ2cE5Jd2srdmN1MGRWSC9F?=
 =?utf-8?B?OExYZk5lWlRRbThsNVZZWnZITzdFWmtsRXhhSjdReVd0a1JqdE42ZnJscVBu?=
 =?utf-8?B?WTlWcXpFWEtKVTgrdUVtTzNBbmdPM210RHgrVFJ5ZHdBNEVNR3BIekgzWWsx?=
 =?utf-8?B?ZDFQclVTbVlIakh4Q0drcm1VanZ6d0cxWWk4cnpHbG5oaWROOVJxdE95TFB6?=
 =?utf-8?B?VjlGTnR4N29GTUZOVXFzbVJJQlhjUWxXMFhDWlpBZ2hwS2E4VzZHNmZZaWJs?=
 =?utf-8?B?Mkg3K0RRWDJqZytEUG9KczRDNXIwSWZkUDZMdzNBYnowdnhpSHJreit3ODNZ?=
 =?utf-8?B?SFVwcHBiUFJQTTJLQjZSWXJCcWMySkJDRlAvNEU3dzRyY050eC9XdVVaRGFF?=
 =?utf-8?B?YlpEY2pya1NSa1B3aU9WMWJqeUhBcEJ4SHN3bk9VUGFTK0NKNU5hbXU0dDV3?=
 =?utf-8?B?YzZPWGhzY3RxdGR5N0J2UThPS3FURnBCa3JDR0Q1L0xPUXNSZUtyUldsMU1O?=
 =?utf-8?B?M3V5TzdlR29jNkhnTDMvNTNZN2ZMRXN0WGFBQk9FWVllT1c2d3Z4bVJXdXA2?=
 =?utf-8?B?eFlTWDdiYk9iZFB2VG5zcWdvMzdBS0N4NGZZSWVGc3Y5aFlyd2huN2FvYmo4?=
 =?utf-8?B?blhTV25kamEzbkIyY3k0TWdZZVJwQ25PUFFQZzVNbTNsRnFHRzk3VklmYmpG?=
 =?utf-8?B?MU9JVW4zcTVpeUkzL3BGS2JWeCtWNEF4T3ltMWxZUjJ2N1Z0NnNQcDFoT28w?=
 =?utf-8?B?ODhRdHZkNS9jM0piNVVLWkxsNmZrK2VoUFRxUDBsQ2IzOURrRUpiQUpLVm9l?=
 =?utf-8?Q?HCpbtABHucsKRdQaV4FHVHE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248a8b72-3bf9-454a-a059-08dd088f1507
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 11:41:18.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/a5BHuHo9e+FUSkW50hYanlitBHxwnr1XdKiTFTur7Ud6wSc5EBs1ngu0w5Hex+zALQN5YKsp+wlFPokqMsFX8Jiqd0kWWd02Vc3liXHwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409

On 11/19/2024 1:36 PM, Vincent Mailhol wrote:
> On 19/11/2024 at 20:26, Vincent Mailhol wrote:
>> On 19/11/2024 at 19:01, Ciprian Marian Costea wrote:
>>> On 11/19/2024 11:26 AM, Vincent Mailhol wrote:
>>>> On 19/11/2024 at 17:10, Ciprian Costea wrote:
>>
>> (...)
>>
>>>>>    +    if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>>>>> +        err = request_irq(priv->irq_secondary_mb,
>>>>> +                  flexcan_irq, IRQF_SHARED, dev->name, dev);
>>>>> +        if (err)
>>>>> +            goto out_free_irq_err;
>>>>> +    }
>>>>
>>>> Is the logic here correct?
>>>>
>>>>     request_irq(priv->irq_err, flexcan_irq, IRQF_SHARED, dev->name, dev);
>>>>
>>>> is called only if the device has the FLEXCAN_QUIRK_NR_IRQ_3 quirk.
>>>>
>>>> So, if the device has the FLEXCAN_QUIRK_SECONDARY_MB_IRQ but not the
>>>> FLEXCAN_QUIRK_NR_IRQ_3, you may end up trying to free an irq which was
>>>> not initialized.
>>>>
>>>> Did you confirm if it is safe to call free_irq() on an uninitialized irq?
>>>>
>>>> (and I can see that currently there is no such device with
>>>> FLEXCAN_QUIRK_SECONDARY_MB_IRQ but without FLEXCAN_QUIRK_NR_IRQ_3, but
>>>> who knows if such device will be introduced in the future?)
>>>>
>>>
>>> Hello Vincent,
>>>
>>> Thanks for your review. Indeed this seems to be an incorrect logic since
>>> I do not want to create any dependency between 'FLEXCAN_QUIRK_NR_IRQ_3'
>>> and 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ'.
>>>
>>> I will change the impacted section to:
>>>      if (err) {
>>>          if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>>>              goto out_free_irq_err;
>>>          else
>>>              goto out_free_irq;
>>>      }
>>
>> This is better. Alternatively, you could move the check into the label:
>>
>>    out_free_irq_err:
>>    	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>>    		free_irq(priv->irq_err, dev);
>>
>> But this is not a strong preference, I let you pick the one which you
>> prefer.
> 
> On second thought, it is a strong preference. If you keep the
> 
> 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> 		goto out_free_irq_err;
> 	else
> 		goto out_free_irq;
> 
> then what if more code with a clean-up label is added to flexcan_open()?
> I am thinking of this:
> 
>    out_free_foo:
>    	free(foo);
>    out_free_irq_err:
>    	free_irq(priv-irq_err, dev);
>    out_free_irq_boff:
>    	free_irq(priv->irq_boff, dev);
> 
> Jumping to out_free_foo would now be incorrect because the
> out_free_irq_err label would also be visited.
> 

Correct, moving the check under the label would be better. Thanks.
I will change accordingly in V2.


Best Regards,
Ciprian

>>>>>        flexcan_chip_interrupts_enable(dev);
>>>>>          netif_start_queue(dev);
>>>>>          return 0;
>>>>>    + out_free_irq_err:
>>>>> +    free_irq(priv->irq_err, dev);
>>>>>     out_free_irq_boff:
>>>>>        free_irq(priv->irq_boff, dev);
>>>>>     out_free_irq:
>>
>> (...)
> 
> Yours sincerely,
> Vincent Mailhol
> 


