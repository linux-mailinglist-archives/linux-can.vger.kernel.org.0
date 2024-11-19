Return-Path: <linux-can+bounces-2101-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A129D2124
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1538EB212F0
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C09155C8A;
	Tue, 19 Nov 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XJBBRbjm"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC81150981;
	Tue, 19 Nov 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003315; cv=fail; b=J8DBBYT02aPBpzKLI+h6OokVPEZJHdc6Go97tu+OSdWd3TkCH/SgyAUpVrfXiLNwBpQq16DX7aFfslwxWri9U/sNR9Pbk1u7Cf+Tjtp6UWjUG7b73aEALY68lO3MUS8fLGHzyx4KQFCKrJex3GsUjSEBhikGu6wRW9dhp/9yI1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003315; c=relaxed/simple;
	bh=SFDyybxIqqvRnwZU45YdLb9OZgXYwxYALZpRrAceDoE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U2c9F71x/HEo1DQE2xHvkzGT/QKE+BKeLdG5mvJx9bjCbfzy4aktLfdKUGtQYQfu5FYK3SMN9ZYe6jGpmxFo6j4Yhdvjp7Xm5RQDujipb5k0jhrJkZbOmaEhdZyutzpDwUwO41FmDhnhWBfgJn3XBdmNY0MFf1qF2KCyxT15/fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XJBBRbjm; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF31cIbe3nGhVymPTTc8JKzJwQqy5foLLz/LTr6CZNEzQowvzLbIU6Od/LpLtPT9zw3YXmOeWYlLfqc0rVnHN0LrKFWyLvoPG+Ntu+Ltw8Z3qk5N0tpiVe36wtF+KLolHQBTrpzSf9Yevkt80OpdlNovHpq3KAhJ9hD53XtbZwStrRdjfQLexHi/Y8IlqN5ekJ5DcTgBHAc4lly/c/HFDSX5WO+Bm4UeM2MHngk7bvsoYP49gLRfjA7IcM7qeNVyrd8c+KBp8tFuCw6EjbKcpMSIHRBQhBsKEARgSI4IvZhedpBOYwAW6NPFNYdlIpBq1vdgd8sxPw98SlCXOeCwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9HIggWtGQPHvstCMbhGiWEhFkSX9Pets+CTyqjJVDs=;
 b=wSHyxz6+tsL8qQc26aQ/mZvlxjtsnbHlJhzfaBBX7SnvW980BOh3SlunPfwKJGYFfCZ35oCLs9l7mtR97fQegYl63Enweey204FDqk1v9CBnTEdD7EuTqPFvmILd3iQYwOF2HDIfdfMRKRtDD22itC9Sr34Iu6DQDtzcmbk8wSj8JXU/FPweshwHFxx1x2reGAFlGUj1/BZpP8Hh4rrq4971PmBvYMF1QKDHgiMSlo11QC0ffhOH1A55AMslTSonT4djbNp6GfRUou6bo0CuobM10T0X+pGVZH/hPa13wLPqId/PkKSIpzxjeiBotmQZna3t0SVjFf/baXFIWlBmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9HIggWtGQPHvstCMbhGiWEhFkSX9Pets+CTyqjJVDs=;
 b=XJBBRbjmeSZSG0K1EZs0bHUlU8AKPK03CVwk0YwE7gtjqlVU2be8Pn2h1LdQ15pNeoDxwlqGlND7Dj9C08CgWS9rWYkVi8acFaTk3Z3kiP8zgir0Z0h5i1crPSLUwgcevUCeC29TXTLWOuDJ734iF+oSz6XXPS+1N3o2TOqn0VwlAuKOkq67gXuphPtYu/pWLXBcQ3602+VVsrWWODc7dS5JQN/adkfODnNrD6dCfBoG4+/OPdFBWZiin3PE+yUS88f0Z5+Ht/yWHwJQu5qRhvpbb2AtfBOCJo8+fk4OlRr1ypGMs6ha4akPdiW1q6tqCrXjyPGth7NbY+fQzMdgvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:01:48 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:01:48 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 0/3] add FlexCAN support for S32G2/S32G3 SoCs
Date: Tue, 19 Nov 2024 10:01:41 +0200
Message-ID: <20241119080144.4173712-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0042.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::21) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dd3102-2540-41a7-036e-08dd08706aee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFEySjhNa0ZjbGJhK3ZIVER1WDhEOFJjZ3E3cmxGRXYvcFMwKzl6c3QvU1Q0?=
 =?utf-8?B?bjFrd2U0bVNUNTk3eEU1YzQrUkpFaEM4bFhsZm1OUW1oWk9ja0lTcVpOcFdS?=
 =?utf-8?B?aEh3N0paMWd5Ti9tdDdTSnVZdnd4RjF1aXFDQnVJMWxqNFowWGNwckV1VkN6?=
 =?utf-8?B?VTZER1l5SU5IT1hUUU8rM3M5T3RnMU1haGRQNGkrdDNnbGYyQmRiNkJvZktC?=
 =?utf-8?B?OXFnVWJaaVloNmhuZVpXOFFwZFE0aDAyMlE5d2dLUGJSa1FwREFlOWJadWRz?=
 =?utf-8?B?bjMzc3lNQTZmaHZTRFVNZkVHTWFzZ2FCdG0rL0xZNDRETW9pakFDYW95Q1Y2?=
 =?utf-8?B?UHlndGE2MmhUaU1SNTcvNHEyOHVFbDJmeXZkNHVlazhTSGZselM3b3ZCREhh?=
 =?utf-8?B?OWVZSE9rTHZZYTVTb0VKN2dkY3dibFN6UE1FK0kvWGhvNGlnOHdjRGlVZjRm?=
 =?utf-8?B?ZUV0Z01sOU5ZUTY1NmZXMExMMHUra0s5Z2FqSWt6UFRZK3E5dU44azhSRkZu?=
 =?utf-8?B?WlROQ1paMnI4U2FIMUxQVzZadHA4djBEbEwwMFN5eXJuVmpUUXBjcFVIV2Q5?=
 =?utf-8?B?anFaY0Vqak1pRE1PdlFXOTJ1RUtmTHV3VGxuUi9jZ2MwL2hVcXZUQTVEcXdw?=
 =?utf-8?B?TXVZMEpwRStxQ1pLWjQ0M1BER2p5TEdEZ3RSZnJlL055eVVhSmlsYmp1S0tH?=
 =?utf-8?B?MzB2M1c0ZjhxakREeUVBdiswVWNLLzlBNWZzOWVGUGVlRzA4K3JFaXRPa0RC?=
 =?utf-8?B?Y01sNmhxK2pubmpOazIyY0puNWs2NDYrVGpWWWpCaHdFL3o2VGZhekF1MHNt?=
 =?utf-8?B?eExzYlU4Ynpod2VMeForeHIrbVQ3NzBEcFRWcUhlVXFweWU4MEh1T3ZlUjNp?=
 =?utf-8?B?VmNBR3RCS0dxakhyRGg2WHp1QmtWSklhL1UvaU43TWhDZUg3V01pSWlvV0dF?=
 =?utf-8?B?R1Q2UzNLN3YzS2Y2VjVlVXQzYVRNWWJvanZwSUxlKzVuVktHbFlhRHpJTzMz?=
 =?utf-8?B?WmdubXVqK3dnK1JVU1NqVStQMlc0NXdVTVNRYmtkbjlwQ0x3WFd1S2RxTFlz?=
 =?utf-8?B?c2JhQ2ZXekRJRUxvV0NVZWdYYTVQOHk4K25tQkIzU2xKVG5RQ3hERUd2YTMv?=
 =?utf-8?B?MU5UOWUza3lGVFhkQ1grMWdpV3liMlc5U2NQcTM2dHVkdi94RnJTUkd6STVF?=
 =?utf-8?B?N1I2eEwwTHJrL2tWdzN5NkI0ajZTc1ZpU1hxRHhFZzNWbEM2NmhBaUpUZGwr?=
 =?utf-8?B?anZ6YlI0WXo3aXBqcXo5Z2R1a0FHbit1d2lHL0p2RmdqcENSZFlobXJrNHgz?=
 =?utf-8?B?NXgyak0zcTgrMkQ1QzJSN3pzVGVzQW1kQUNKaG9MS1hmcFNPRWIvZERtYzZE?=
 =?utf-8?B?NmhnSHNoSnlEanpKRnJWaU5LcDBPOWlUQldKWVcyVVA2STA0cFhGU3c0MVRy?=
 =?utf-8?B?VWJ3dzgrRVJqQjZpZnZYRWxzTTVLZ2ZQSzN6N1ZicTIzL2lrMVpnOUZmOWRy?=
 =?utf-8?B?dVVPMCtLWmN6UVJwbmp4Z1I2Vi9GbjRDUEFxVHNxb3BuWDJSMXB5REd1cmxj?=
 =?utf-8?B?V1phYkxEQlpIdmVRU2pIcElBTG01VUlmYzVGbnZuWDVsU0hId2pFR25WZ25K?=
 =?utf-8?B?TlZ5VTBXUVd3Tm1EUEpJMjZDemU5WFNTWFVZZlFLanZwZ3QwL3A1N3pQTStu?=
 =?utf-8?B?NVplNmNBczAwVzB5K3VPNGN6STNHWjZENTJ4WXk3UjZTamJVL2M0ZE5GRlFi?=
 =?utf-8?B?TEdGbWRSZkRrTkEwWDJ4V21JUXJ3SFduSVVRR2RZN0tGQ2VKNXAzaCsvc2I0?=
 =?utf-8?Q?2eNYJt/RHhPFAvT+lxZGv+WaR+kTWn/VVPa3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkc4K0Ntc0FXc0N5eVNjVlIrbERxbXNPbVpFZllSYlVrOXc5S3lCTElkZmNU?=
 =?utf-8?B?YTBxWnFCL2dteTlDcUh5dlc2SkNhYmpHWms3SXBMZjZCemRTTDlIZFdyYXdh?=
 =?utf-8?B?dTVkRTVQRGo5Zm0xYnJEcTBMYklVdXNHKzVwWWZiUkg2Z2twaW5mMEg5Wmlj?=
 =?utf-8?B?QU9LSkUwNFFUZHJCZDI1Z2MvbFpCbW4wVWJvdmVPZjMzV1dZSFNlb2FWV01x?=
 =?utf-8?B?d2YrWVZ4ZFRKZFhmMWRJYVhoaThQczlxQklwbDhzelZzRjVUTk9ydXU3ZFda?=
 =?utf-8?B?ZUwvbnFEc2JwYStsc3FwZWx2Z09MemNmL0k1WjR2cGp3Tm0vOFpjSGY0ejIy?=
 =?utf-8?B?MjBOQjRIcklVaFZmQWtUYTV3M1Z4anZWdUxycTdRNkZLd3E5S0JMNnNNVFZS?=
 =?utf-8?B?ZWdTcUdHTktpM3pQU0xxL2p1Zm5mR1UvQUhvMitBMFlYb3JBRURuQUVQNDBZ?=
 =?utf-8?B?RGUwTmpGNWVvbHNoVlF1UkNLR3BQd1ZPYjhtQmtJczR5M3ZNcGNrU2w0dmlT?=
 =?utf-8?B?Y3lTbkVDMjdzMnNZUzY3YkcwektlWU1DZW1XY08zVUgrWnJSSlMwK284NGZj?=
 =?utf-8?B?elRxQ0huT3dESHg0YS81WFh3STRDRkYrQ0FyTjR1b1RGMGxxeHlPMUdEcUps?=
 =?utf-8?B?SzNqVlFycHZWdkF1WFNiK3lIdTFMdUdla3E3K1NxVkVJUDN1Yk5NbmI2aWV2?=
 =?utf-8?B?UjJ3TmlZOUh3VHFTdzd5UmlXY3VnQitGZnRNbmJ5SmRlaWlvbytkNHB4UHE3?=
 =?utf-8?B?VzR0VFpjUU5Hd3crZUJIUkQ2bEMyRGZmWG84RW8wTnJzYnRsNkMzbHF4elFF?=
 =?utf-8?B?cXpqRlJaaHpSRFRGd1RGMHJHWStFWUV6OWMxSnFHZGN0ZjRudklNYVBpVW85?=
 =?utf-8?B?L2xxbFJqT2ZIeEw1SU5td1dsRmIrMUhVT3ZoL0p0OFl0UVF5OG45bE9xeTMz?=
 =?utf-8?B?T2NxbTVLdURvNzBpYm5ROXBRelBwaTlnWkhmZzNJMWQvSVIxS2tZTytMekZ1?=
 =?utf-8?B?bXVONzZLMFFBVlF0eTlkK1psSHB2Mk1RYnZUSlhMUW41a2gzanJXbkl6L0Iz?=
 =?utf-8?B?eTB3MzB2N2tZVWQ4UDgrZmtLanF3QnNydlBQMzRYeWRmby9DQUZKZENsTEdK?=
 =?utf-8?B?bkw3MGNqcTU3bDhTWTJ6bDN3MExFM1FLNnd1dTRCTVJQaW53ZXhmS0RGR0Fw?=
 =?utf-8?B?ZnRYWlVqNmJOTXJSaUhYMnN5MlhaSmtUMTltbDhpSldnQXhwbFdSRlJWY1U2?=
 =?utf-8?B?dEF5b0pxUU9LVk9HR3liVGpHc1NaTk51RlRUQ1gyY3NuTjNhcVVxZCttZG1N?=
 =?utf-8?B?SXpGblNSQW51U29WUnkrLzBtWWRpT0JySmpIKzdydXFNUDBURWg1QVlJMkFn?=
 =?utf-8?B?M0RieTBXd2dvcCtRNG9ZV3VONXlqV0FNUXhrbit4NmFzSmpVU3J6emluUUJL?=
 =?utf-8?B?V0xpQkdSbTUxaGZpYWpFdytWelZlQ0lLbnFFdTM1bVFWN1FJVlRFazBxenFV?=
 =?utf-8?B?elZ6djUxUnQ0dWdjcmlQZk9PbE84TzkwdDhxak8xQ2poZnFmYzdTUzJ2R21x?=
 =?utf-8?B?VnV2N1c1ZS9Kbm5ycG9pMWN3VHV1Z0k2N1ZzdWVsOUx4cHd2ZmkyN0tOOUdy?=
 =?utf-8?B?eTc5UFo2c1VlcDl0ZmF0U1pMU1RRSDYra0M1SVFXQXlHUjZ3Sk5ZQTR5cTV2?=
 =?utf-8?B?cjJmMXVEWld6aHd1MERuaERBL2lSZ3FvQlFJUUppNTVlNWVzcG83VUVVOEZi?=
 =?utf-8?B?cVhOWXBrUExtMmtZb2dPNUlBWlJEVDltTllXcFNOQStWUjAybUxKSWJCMWw4?=
 =?utf-8?B?b05tclU5OUkyM2V1Um9zVnhOVmxqMU1XN2dIdXV6SkRCZjB1ODkyOUlTSnZ3?=
 =?utf-8?B?Ky8vRTB5OWdRMW5YZFBVcFJtRmRSMjNCTG9jM3g5TGRMV1dBOHBKSGU4ZGQw?=
 =?utf-8?B?TWhzQWZWbjJJSkM1c1dNOUNLV3NtdGtEZGphZ1pIb2hXU0F1Q1Z2Uy9DbXQ0?=
 =?utf-8?B?K3BZOWd5YnhjanFsT0MvQUxCSEVONDJBek10a1hwdzc5TUc4Vnh5Qjg0Y0VW?=
 =?utf-8?B?VnVQU0U1YmVtb2o3YUNOclZzbm15dUFCTHdCaUFXUlA3MkhIVGtGQ1hPY1VK?=
 =?utf-8?B?NjBObjF0b2p6dElQQ2p2VmF4WTlReUowcEFFaUEvbXFMY3piZUlFK2YzYUhB?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dd3102-2540-41a7-036e-08dd08706aee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:01:48.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TT/o6j2Ly7iFrVG0wisO7pKlti5CNBP7p3EWtquXoP6cWcVZWdJ9bxfzNDwXQSKT9YAlQ5BDuFT3mX6N+oSqfMc6KgdHUiXAVLAne0yIeTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

S32G2 and S32G3 SoCs share the FlexCAN module with i.MX SoCs, with some
hardware integration particularities.

Main difference covered by this patchset relates to interrupt management.
On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, MBs 0-7 and MBs 8-127 respectively.

The intent of this patchset is to be upstream'ed on the official Linux
repo [0].

Since S32G2/S32G3 SoCs share the FlexCAN controller with I.MX platforms,
we find value in an allignment on Linux Factory tree [1]. Hence, we are
looking forward to integrate any feedback which you have based on your
expertise on this proposed patchset, before finally submitting upstream
for review.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
[1] https://bitbucket.sw.nxp.com/projects/LFAC/repos/linux-nxp/browse

Changes in V3:
- Refactored FlexCan binding documentation changes
- Rephrased/Clarified some commit messages

Changes in V2:
- Fixed several issues in FlexCan binding documentation

Ciprian Marian Costea (3):
  dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
  can: flexcan: add NXP S32G2/S32G3 SoC support
  can: flexcan: handle S32G2/S32G3 separate interrupt lines

 .../bindings/net/can/fsl,flexcan.yaml         | 25 +++++++++++++--
 drivers/net/can/flexcan/flexcan-core.c        | 31 +++++++++++++++++++
 drivers/net/can/flexcan/flexcan.h             |  3 ++
 3 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.45.2


