Return-Path: <linux-can+bounces-7253-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGVKMAQ+xWn88gQAu9opvQ
	(envelope-from <linux-can+bounces-7253-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:09:08 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F74336907
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9823064E99
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164692FC037;
	Thu, 26 Mar 2026 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jgXdbKDO"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302C2FD1D0;
	Thu, 26 Mar 2026 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533516; cv=fail; b=VudypDJCbm7Xz256nSH0+B2NbbTurPASa1rAWl6oroXUmhED48gA8dC7Y6XfPbyEBL9fFHTCpIiDQ/n5cPfpfSEliLfEm6HBZ5iegba6oZump347T+DoAVGDUQIBU3k7EzzB/zmdrCVjvLPrKBAiRvmKB+O16gSzRViFdTnQDCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533516; c=relaxed/simple;
	bh=1uNSQ57psecLg2SCF2jWLqRqdRNQdYQPZxkFCeeShGs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X6JXKkItNtWRxIM3MKiGZeCB+2+Rqz3c2PQEZLvVIBxCbCIHX6SrCU7SaYRGjjCvcboGLKgTWN2oA2stkIS74nkFOenb6XJbUnulWcBO/osO3IWnsNxE/FZU7Q3dvwsww8S7QtNBdt8n7ZI9HjnXlfPO3xzWCopqAQ4bDEoVheA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jgXdbKDO; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAfKNHi7ykTdDcR4t9IJTordMFcVXTh4/ugTnYnBsy1hhizwkE6QnOLInQshWOgqk4Q/RRjFugixAyfuOIVJ7bkrmybV6NlcyVq5x0UO6jXMkFHDQjTqjnvNlaQ+QQ1SRHyIxeuzbcEhEz66HRCcxOm0EV0FK1DijXfYh8EPNNd+niQ/aMwMbkgbIb0czzS1c3/hQIzo7fG/LWAPEKiCrUIo4HU25qGnMZGOQ5z7IgDA1TXqXklQRpO4kW5d3YfLawLnuESPF/as8k7gsJrwY+DkP1LWW5M3zmictKpl/QW+8hLsAcz+BNhd7Y06IlEYW8qPguyvD/PJ+PtaSqPpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a94mf/AaDK65YaZuB4cZaoSfr34bB0QQrzQtQfnc74g=;
 b=AjwJwP7n7v8+vX8MAyj8A28P7qQ5yioT/+H7k7FKYYD7/tGkp25yKiTokmVJOead89wUKjDik6XxrMrBqn7gAtZNYzDyKnaUICZZuq3QpVGWMZiD+PSPDco+miHleqy/hgHM7UTINkn3gWNjJk1e7sPubo1T1o2DxXVfqg2qr46rnJouDTt64WasLHDUSiKLrJqvCpoFuse9jG0HxlJwQf6/+c+dG/WzNxp/sdDQPy60yZzKYe+pvcLsZ28ZmWowDn11nVW1ROo96dc4cYDgJzX0BEdTX9gTe3i5sGSkdnYKTreyeCVOplf+s2j/v7/Y+JwCpxd5giOS32acIjDymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a94mf/AaDK65YaZuB4cZaoSfr34bB0QQrzQtQfnc74g=;
 b=jgXdbKDODUidR9EsaQRZ6h03uQwLmtASCmzmQWwstPHZ3KlWpuaFm583T2T6xfhG6rxRd7TJR88EVQaIUSfZLmeJrgpI1F5aigdN/u5eMHb5BAvDPJabh3eS2SNr/JYJfpjPnbJ3lbyk9FEfBK7jx5MqCjamv+kkUbSH/G0fHMNPxNwvc1zTw9z/Q+lCKzo+9mJ2DBIlDeB7spUkjSW3OLiKcrhXWG9S7pG+1LSXJNC+r3ziR/Iq1tyqnPv3zjsiXDlCIb5yUPQbzyQQhhNHaDkFvH9rpBmWR1lGJxZWR0HC7uKWbq4dQLa+Jd9QUkbrMbgtCsj/TzMEGDqScg5i4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:28 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:28 +0000
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
Subject: [PATCH v4 0/8] can: flexcan: Add NXP S32N79 SoC support
Date: Thu, 26 Mar 2026 14:58:17 +0100
Message-ID: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0038.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB11261:EE_
X-MS-Office365-Filtering-Correlation-Id: 888d9626-9fe8-459c-940a-08de8b3fc19e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SDfp7/CpApVAnorbj67taWIBKBMMWERKxsdk3+hngpMY3SFJEVuXEJn8Si5mxB2t5hPL2PUj+/jfjQ4x3wwgRPBctl77vqxJ0yAv7k/2xZxkHD8vz3fSjBgHt9zuW8g4ay5X24Uny0ny1F5WUgJJVrj5Oc1XXWsH+vDk/HNEzgnuvMcvPDTSg9lNBnx2FgpafTYLZgpNGCNBgd0jF8S5C6KHtdduJAH9Zz0pcpbN2NobqEOj5ROFiiA1/nenMNz2mNS+8uT1u7DufhtHSqoZ6yN5AIrD7ls8aJ3aT2R85lWgyUyQGTzqP81oGV6V/q2gGIuUSttu3OfycB7pYjEIA7Mq03kXNfHnsZo5vscRqL4CAiahRcuWSahZleVeZ5GZ0ZEYkPBqVpil0s3tWWZc8FAgfuJ59bBxIvDtjoDTsqKYSDWa9S/DZBnfL2jJaIHFMsedwyuAVw1oNG7UM1kN2JObhdJ5xtEFUtFSugb8fbVnBTvNXnsjT8e0ge0/0FDoZL9yeBz7gL+jUd2DlGPWOXsIYAAJZABze891EV5h1YylgSScsnAqbahzcPzPIv8Gq52ZS1iKcf8NE1GTOADNozte+UTo/bg0pwEKES4mXtyCS+CW3xJoMTsegxLwZnnw1neywq6urvFczyI5OwENftwcf91gnLJ2aBfydlM6Wpskcoc/k010kXRswlwM/z1gzbBos4jnpb0WJNWN+gXrpgc3h3gh7pQpLBxeSRErF+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2hnR1h3R1MrN2J6WkhqNFNoNjVib2NaRWl5aTFYQjBJOUcvUTM3ZDJUUSta?=
 =?utf-8?B?SlB1SDhhekZBT0tWcHlYY0plNWtiTjVuMnlTZ1pzaVBiTnp5UUhFT2hkTzF2?=
 =?utf-8?B?MmhBYTZjWUdlYlR1bG54ZWt2SXZMb1E5azA4RW9SUjhWc01yeFBFWUllbEFR?=
 =?utf-8?B?MWdnby83TEFXK3h5TjBvVFZLN3hFSnJaekUzQjY3aGc2dW9rT0xQUkhUWFY4?=
 =?utf-8?B?dlRERTZOSnd1bDU3S0dvN1Vjcmh4aldQNC9XZzZkdG1kYVZqOUozakxrNFl4?=
 =?utf-8?B?TG9JNWszQnhFQTBjWlZzZlJPZGZLSDVMRVZISkc1NVI0dXNveUh6UGNZZFpC?=
 =?utf-8?B?NW5NcWdZSUJTK3BsYmVPZXQ5MzV5aGVWNDMvT0F5OVBXVWxEK2RJN0Z4dXlx?=
 =?utf-8?B?Um1mL1Npd0x2K3VOWWZQNkhyV2NaQ05yYXl0RG5UbDMrQmNBVzBFVE02aS9U?=
 =?utf-8?B?dEtpam96YUwwUUtNY084cVpqaWJHZnBzb3grRTlTd0pxSFZYNWgwSC9QanZ2?=
 =?utf-8?B?MHFYMTlwMlJpRDRSaEhiUW1OdEZNek9OU3RSN1dmVFV6dmFJdnhWM0l6TlJN?=
 =?utf-8?B?eld6RWRqb0FGcWg4a3ZxWHpBRUprTDRBTVFCVEJCMlg5N1U3R05EcVg3b1BS?=
 =?utf-8?B?ZW1hNmhya1ZEcUxDOGZMQkRjcmRqM1Rla0o1UTNlWkJXcUFlczBqd3dTb2xZ?=
 =?utf-8?B?MTk0WDNUaFdQQ0tsbzhud215VmxQYTNLZjhJN0JxaUZ0em9WVXJHZ0U4K0lt?=
 =?utf-8?B?anJYajRDenEyTDhTSVRUeGcwcnNTaEIwRDRjek1YamRwMTBMeGFyS2tuY0xj?=
 =?utf-8?B?d0M4ZXY2Rit3WU1ZbmFRZjl2RVN0WGhEaXVyaVkzVEtFdWdzQjhGNkVsZmx2?=
 =?utf-8?B?bSt1RGQyT2VqK1dwREc2UFRqT0F4bkhvaHZHWGlLaTAwNzFpT3NmM005eWRo?=
 =?utf-8?B?NS9MUUZTcU91N1lUMXlhZGx2QTZvaGhTd0FwTlk5d005YVJXb1Y4a3lqem4z?=
 =?utf-8?B?YUw3b01pREtxV3RDY3NiSFJScXpRODQ1RmFCTUljbHhYVVVXbDFqaHk4Z3hL?=
 =?utf-8?B?bnlCelhtbHlaNE1wTFpVdEt0UU9mY1FMSVZOTnQydk13cFhSNllFd045Y1ZX?=
 =?utf-8?B?ejJwMDdUM0d5Zi9iUkdwc3VsakZUZVV1eWJtY05qelBJTjBWUERnS0txT0pp?=
 =?utf-8?B?cE8xZVlzN0N2d0hOQnBNZEZvODZLQU11M0I4Vk9TdWgyc3pMTkdCQlJHTGNp?=
 =?utf-8?B?MFJvaW5ONUFnU1pCRkNWSnBodDBxak1NNlJZdDNQTnFtUkIyQ21GOHZpc1g1?=
 =?utf-8?B?b3dxTFd4ZVloN2R3bHY2aVlDSkpsQmY2RGlmclQxRzdERzVubWJSMWJwR3pL?=
 =?utf-8?B?dGdFbWpLQXFaNHNDT3QybHBxaGtBWFZrZlpWNFd4N3JnTHlVdFowQU4xRWgr?=
 =?utf-8?B?VGEyQnJVamx4ejkvU3ZKbWpPVnpmRlNXZ0NObDQrRjQ3MGRPVTJQekkwRVE3?=
 =?utf-8?B?bTZCOW9WdlRZV1Vsc3ZmS3pKWm1uNU85TFFYd1VKZjJZZXVFVFpwdHhIaThk?=
 =?utf-8?B?M0ZVVnRQYzRrRVc4aXN3UnV2YUc4S2JuTmhkREZ3K09MM3ZiTUQzanZLeVRv?=
 =?utf-8?B?Y25ZbktiWTBpREYzUHFBZUFNMnhKcHljTFlzc0w2Y1JSL0VqSSthcGIzQjFh?=
 =?utf-8?B?NXRaT1ZJdnZpT2RvVFRJb2tCSkJySTR3NHQxYzlyUmFDMnNNdzh3NU55Tm5Z?=
 =?utf-8?B?ZURzOWJGVEJsUFhWci9WNkt2MmIvZmkvY0Fya0dtd0dWdDdoclRXWUZTTWk5?=
 =?utf-8?B?Vy82WTJET3F1aFlSQnFGMkRQdWh5bHBQOHJoTzNKbnNVdk43a1ZFU09nTW1s?=
 =?utf-8?B?SktibmFxTVdSVTRrNkQxQnFyZ0cxSEczVHh0TXh5YWpBZi85R3hvd216N2Ju?=
 =?utf-8?B?MmJkU0NLS1Y4cU9TeFY5RDEycFRNYUtENXJtQnVXTlNZVGlPOTNJdjFqRUlU?=
 =?utf-8?B?dlkwNSs1d0hhK2ZuWnc3djJ0VWI1NENxK2hZOE9VUXFUSG9ZbytaY1JnNk9J?=
 =?utf-8?B?ajk1Y016VnZ3ZmVRQU82SGZwMEhKK29jMnduVTBTNHowbXNHNlRlaFg5aTg1?=
 =?utf-8?B?UExVbXcxSlIyNDZNSGdrTFNWV3MrSmg2eEc2UlZFODNvYnNXTDcvSTFXTTJQ?=
 =?utf-8?B?NHNlY2pUOUNuZGo2cWNaYUR4eHd2ekFrSHZEaHVvaGsyMXNFY1hoRm5Pb0FS?=
 =?utf-8?B?VmlYRlM2NnRvYkE2MHpRZURJWjRqUGNHUE9EMGxjeElhRjVkaCtvUkdtcDRH?=
 =?utf-8?B?cXRrd25GYU1UR3RGVVZGZlBZTlhwZDlwMGFGVmdGMTNDR0xYakplSDhIaDZX?=
 =?utf-8?Q?0xUkj9gztJzb2pNg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888d9626-9fe8-459c-940a-08de8b3fc19e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:28.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEL/Nx7cRirPERULaU8MrmKOUi/jyG7YmpKjNTgg7vvmVUGoZSHowmVj/ACk75lLfwGIyrxAkVOChVxd10UAaNRQ7VafL/o4AiEXDOZpHyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7253-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 67F74336907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patch series adds FlexCAN support for the NXP S32N79 SoC.

The S32N79 is an automotive-grade processor from NXP with multiple
FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
other SoCs in the interrupt routing - it uses two separate interrupt
lines:
  - one interrupt for mailboxes 0-127
  - one interrupt for bus error detection and device state changes

The CAN controllers are connected through an irqsteer interrupt
controller in the RCU (Resource Control Unit) domain.

This series:
  1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
  2. Adds dt-bindings documentation for S32N79 FlexCAN
  3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
     configuration
  4. Adds S32N79 device data and compatible string to the driver
  5. Adds FlexCAN device tree nodes for S32N79 SoC
  6. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

v4 -> v3
- flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
  (not just dev->irq) during IMASK register writes
- Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
  each handler on S32G2 only processes its own MB range
- Added received Acked-by tag on DT bindings patch

v3 -> v2
- Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
  flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
  processing when multiple IRQ lines run concurrently (new patch).
- Added flexcan_irq_esr() handler composing state + berr for S32N79
- Ordered quirks used by s32n devtype data by value.

v2 -> v1
- Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
describe the actual hardware feature
- Appended new quirk at the end
- Switched from platform_get_irq to platform_get_irq_byname usage
- Updated interrupt description in dt-bindings

Ciprian Marian Costea (8):
  can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
  can: flexcan: disable all IRQ lines in
    flexcan_chip_interrupts_enable()
  can: flexcan: split rx/tx masks per mailbox IRQ line
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support
  arm64: dts: s32n79: add FlexCAN nodes
  arm64: dts: s32n79: enable FlexCAN devices

 .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
 drivers/net/can/flexcan/flexcan-core.c        | 249 +++++++++++++++---
 drivers/net/can/flexcan/flexcan.h             |  12 +-
 5 files changed, 316 insertions(+), 37 deletions(-)

-- 
2.43.0


