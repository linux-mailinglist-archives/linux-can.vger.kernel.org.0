Return-Path: <linux-can+bounces-2281-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1619DE86A
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225A7B221EE
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062944C77;
	Fri, 29 Nov 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pCJs/g+u"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6D2C18C;
	Fri, 29 Nov 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890356; cv=fail; b=fpTgqVjGEonjcIrWlA0+kKJdrFj3Ko84nCo9N60vp2kfwY+4nztQcmFzMMRh9UUMfK6FtONT+hPY4YDGSbcClBQiS/jRPFEsW1Yj+vN+ez8c4gfG3A9V+NxE1GudXzuXcRvwrOoNcK6q/V8qgKkWbf10THxo5kYRXBdYkY/kReA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890356; c=relaxed/simple;
	bh=B9//oYLecncFM9JB+D6PwaNQnd8OJ1qKAqW+qPmds+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITkQE+iUBsrUu+7UvnZi4E/j6B6o9b2UMkTiyuhi1NpiNnZL2FlIQBH8GXQfDOFnY+DumyNv2hUaCD8P9CVstU+X7DBfxWOR/UzcsXTq8ooXxnPuLH8jK+3ofMmfYR2KrP2U4n3+jgON1mq7Fzc7aWJTxlD0NCguqTYJQPTbcRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pCJs/g+u; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtKVEizSq9Ric4LH27Dut0NncHlBis9eaUYIf5naqX2VyUYeJPsUnbnkBoURuJlYNi1GiXee+hrUC5WHeu+oQ8EiSjwmfzVsPBmoN/LtcNWrs2/493BTR+ziFcdqIzB/BoE67/l+dejnGlSEA5lFn9pf8EeBaaofnwgDeKywktdcz/01P9OSAA51DrwFtlglbTEKIwNBxxrVGpZbxJ2m9+vp/1q57JuT2Rj7yJ8RAm8dPIk2YlAUgXotMUbH6jC34GVB9fnOT+l81LFwJ6NHotUeeg3YTMFj63XoIb2s8FrfZe3JXE4vH3XWZDA39AEOaTRwNaRN4as2Q+zQ1JZOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5loT4JFE+/+1p4Njux9vpoFNLWjwdIiY3CI20LHZTo=;
 b=cEYSffaikN4sXudjiwYfz2Sl+XdKd3Qz8wDLyXeK+dAMX15F1BXe60rSFZpPW7GLjTb/MpJ/POPRKqAjMHertO4x+ceNo0uvkZgmFcnlmUAk2D2WQ2HaJUG4dj6mCME2T8KIabJDyzIf5ZDSNYy2XJE7xgy/bx5EiGkFTjTcVUxuI0sy2DUVc4knMg4jatayTxCmGhl9wcFZafh3neARHO8RBx7X4isNZofnAKjOyPV7jmA8IW+0nA0zocYX2kSTyojMs03yca9LZbrhfdxPHtXXBEJJ0pVG8/XzOENMqF2+bNOMaExzDydn5Mvhr6zdyrR7F4C76kNN9pkpI0OEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5loT4JFE+/+1p4Njux9vpoFNLWjwdIiY3CI20LHZTo=;
 b=pCJs/g+ubBeHo07u/QQiUTE/vrA65kv4T/3vWS9Y1XtQdVS4VrFlQVsy3nW6HFFMTtfClzFqAQ1QS9ciHN0gX73+wkWc2cDcPaHsxlj5PB2MwuyYlVWbFqhUSbkRGNsS+h/vKb9wZecociF4SQ9wYdKIw7BLul6OQ5rS/0+/hddKgEWo/KuPS3sQeEfYhTFcDnd5iB88aCGl9EZDiMeN1E2ALG86YxdNar3iwElzpK0f+HEssmEDjt7TGaOtztoAkwiOZKNux6tO48Lqqk1vXeOgJNNZYsAItI5eeeUd0a4zuwlLmxpkdUmbhu/tGGPrtTRnGphqkORrHm4AxC33Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 14:25:50 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 14:25:50 +0000
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
Subject: [PATCH v3 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
Date: Fri, 29 Nov 2024 16:25:33 +0200
Message-ID: <20241129142535.1171249-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
References: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::14) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d82681f-a064-447e-ff7c-08dd1081b95e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alJoYktoZ3ZzTFpVOHJlendmYVVmbkgrUDRUTVRQdlBQSVRrTTRzWWQyV0g5?=
 =?utf-8?B?WmZSaURiZWYya1ErK0R1dWRaM2VrdzZGTnUyNmRZOUxBY1k5K05xRjlxUEdC?=
 =?utf-8?B?cnE3cmFvZTdrTFRiYWdZd1BMOU94Q2hxWkhRQllIQTdieitJS1ArbkpYWlJR?=
 =?utf-8?B?OEQ1dE1MSW5WOVBqNFRCMitHbWIzdFpvR1ZndDJzSjhnYS9SRVByeW04R05w?=
 =?utf-8?B?RUJnTHROdEsxTG1vbmZCMUYzR3ZPU0dTZnl2RThpUnRieXVzams1R3R6ZDNP?=
 =?utf-8?B?dmdENVY4SFdYdkV6SUo1clUrS1VCbnYzQTE3Q3dTa0htd2M2bjJiakRxcDNY?=
 =?utf-8?B?NE5jcEd6RStEUVFGcENUOWdBRzdna25zT1BubEdrajNWcjN5SGp6dHlibDY3?=
 =?utf-8?B?RkFleHl4WWx6Y0M3YS9FeVU1TGlSelF1WW9ySEdKeGVremJKcGxIQ0FTVFNt?=
 =?utf-8?B?Y0F2RE1UYytOTVRVejJsZ2NNaWtjN0JPcFo4eldObmU2VlRGNkROVG5mREc0?=
 =?utf-8?B?TjhrVVk2QTIySmNWWlFRU200czBkUWJWRnFEa28yanB1MWkvSk11QnNwekN4?=
 =?utf-8?B?TXd1blBHMDFwanVmT0l6dW5ZcnVmdDVZakVjenBPSlNIQ1FSMW1sbitNNlox?=
 =?utf-8?B?cUwzQXlacVhsZE5hbHdOYVFmRHpNd1ZhOHNEdis5eERBaEJaNFpjNVo1L3la?=
 =?utf-8?B?dUtkUkpDMjRPMjMvUzh1bHdJODFxejVGMllQZCttQ1hRNUNxT2xpTk5IMWcy?=
 =?utf-8?B?N2RZTlF6VXIyVk42ckpsWlVPemdRSkhGdGkyOHB5SkllaUhpY1M0Z1B3eXNy?=
 =?utf-8?B?Qyt6cjVBUGVLN3VJYjlzR1lzVXlRS0ZvbXplQlRJeG1FYUNtT0RraEE4aUFR?=
 =?utf-8?B?QU8wQlhFZ1ZObGRoZytYNXloU3F3d2VTNHI3L0lOc0pGZ3FJR29hdk9Sd1NF?=
 =?utf-8?B?ME1iNWw1WmVtT2xlaTlFMHB0aktjTlVNMFNvdWx1dDRmS3A5NklxNDZzQ3l3?=
 =?utf-8?B?OVRvUVMvMWY0T1BVQTdlRERQM0N3elZhcUUzNFpwV2NJOVhLVWNjeWpsMTJh?=
 =?utf-8?B?T2ZtUzBGN0NQZ1hsRE5MNWZqc2FkR2dKRllkbU4wR2dncXNvT2RvaFNBVHRM?=
 =?utf-8?B?QkpXbE9uL1dtU2tsN01CTFFJS3RNMXBWWklvdGpzMm4yNEpKVFY2OVIzaWJE?=
 =?utf-8?B?aEN5cEo4QytZODlyU09SOFpNVTZZRUZPMnNJeFZ0d3B4OWluMVF0MUI2STNx?=
 =?utf-8?B?SHJXbFA4N1JvQTlWQnVhOFNENk5CaWdhUVdvWUdNNEV6RHBvSU5FbUI2WVFU?=
 =?utf-8?B?WVVjYVhTZzArVHZISVdnUzNNSnJtZlFJTC9yRWpjbmJSblBGYkdHYTY1djYy?=
 =?utf-8?B?WUNsOTQvRFVlYkdzRGZhTDJOeW1CNzhVNDB1MURRZW00WDAvTVhIOVNMNENj?=
 =?utf-8?B?MFUrZ2xaZXVIZVpWVjhvbkxHb0pKSnVoYUpuZ09nUUt6d053a2lHZ3BrUmx6?=
 =?utf-8?B?YkR1UXBhbFdMWXRUK0cyUFlhMXpTRGx1c0xxMDc5VzBoYVFYRjhTMkFFNUxk?=
 =?utf-8?B?QS9mL3drU1dmclZzTXNuZGJ4YjMvRm9wMEQxRzdwTXd1OCthT3pOL0ZrN3hy?=
 =?utf-8?B?ZVFFOUxYSzhQYzA1ajB6QS9ieVVVcUxadWJEMjZWYmlTN3NYZy9kdnVmNmla?=
 =?utf-8?B?L1F4b0Z6S2VxajU4VHkxTmJwMzRHeFk2UTBPQ2xHUHEzOUI4WHBDVzVORHd0?=
 =?utf-8?B?QzBSaGgrMU15UjMzVkM3Nmg0YVRYOWNVTnY5VWlaZDE4d0pXOU1EQjJsRDFY?=
 =?utf-8?B?Wi9mNThvU2V0QmJsZjdIQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3RYc0VJejQxNmdqZlVNTkJJYlNFYklsaUo3RHUvR01wem5aM1U0QzFWdVdy?=
 =?utf-8?B?akE0YkNvS1dhaGJOalZIMm1SRjlrK0ExM0pWWXlSNi9HSFFFaEpWQjgzSjY0?=
 =?utf-8?B?UEswclVHZW9RVnVyN0J4RWQ0R29MYUxsSmsvM21DVVNaaEhDelQ1aTFSUEJ3?=
 =?utf-8?B?T2UzZGlPVjJKWWxON2U0U0ZmeEN3STVSVU9jTHJIbnpKYUNycFVOdGlaeGFK?=
 =?utf-8?B?UnVvSjd5RHJsb2E0NjZ1UHhzVjc4WTNmcFljWXo4TGlLblM3L3U0cm9Cang5?=
 =?utf-8?B?MTJOeVRzdFZwbXdlVzBZNFZVZDhTcENBbEY1Y0FpbUQ2VXZTdEFnL0pRUkdL?=
 =?utf-8?B?Wi9COGtyRDdBNjRmS3g3V1JKWjVybjhUeEdoQzlSSHcyT0ZRYTIzc2VSSC9w?=
 =?utf-8?B?NWFHRFJoU08xaC9vWFBsdkF3VVc1QVJwOWhGL1MrSTBOYWpyZDd3ZXNJc1A1?=
 =?utf-8?B?dG83ZTVKM3BPM0U3WVZIUGxDdEFNOEVja3Faem9BU1lTOExpQXVOUjNsYlRV?=
 =?utf-8?B?dytMTlVsTlR3WU5JR0crODlYcmIreU5UNmdjcXQxTW5WbmdSU1lkQlR6emJY?=
 =?utf-8?B?R3BqMWd0VERRY21OajI2OU5yT0IyZ1d1MyswK1EyY3NmeWluQ1BtV252cXVt?=
 =?utf-8?B?bFkzeUVReERuZ3FDKzcybkQvRzN5TldvWHU0bml6dW1OUjVucWN3SU43M3pG?=
 =?utf-8?B?a01CUFJWNzRsNVRDVUpjTnRQOCthR3pJVFovaW0vanhFdHpUOEY4a2srK0Ja?=
 =?utf-8?B?ZmtkdXIzek1ZcDdpcGFHd0lVSmhHUUh4Wmc5OU1ia0FPSTRweFZubzVrUnl5?=
 =?utf-8?B?YStESG83dk5mTG9ZRFpiNzdWTUE4NkUxeUM3d0RjZ1IwNzNycEh2c0wvdmM3?=
 =?utf-8?B?S0FZMkJaTkdKZVpCRDVRSW5zYXFHRjFWTDNNd25oU3BSelR2SCswL2NjTkN0?=
 =?utf-8?B?a0RlK0RmWUUzVGphNnlzSjA2dXlWakdUeGdSTnNhbUxTQUdZWU1zT0NHSmYw?=
 =?utf-8?B?Y0U2NGFwdkhZaU1vSHhMY0tsMkM4SnV6N0pseHFtNkhwZmZabnVUbUQ2RVRk?=
 =?utf-8?B?OEtsa1hPd0pFWEVXeGZ3MUxXSEdFbHBCSmlPWS9JMElxeGx6YVM1Qi9ZL2lq?=
 =?utf-8?B?Yzl3ZFZiMGo4SDZ4ci94akRtU3lOODd3dGVuYzhSaXZYazRDZFZOejBEMGxv?=
 =?utf-8?B?WlZldmY1L1NOZEwxcEJVQXdZenoyT0pKVmhaQ29Ybjd0aTR1eFNVS095ZGJG?=
 =?utf-8?B?N2VaeklnODIxK2llSCtacHhzUVpSWFZmdnR1dTNXYUQrdllaRnVGVlFJM2k5?=
 =?utf-8?B?cGNqZ0Q5cWQvVjZUQ1laQ0RwUk9tdHlTOG55ak5aejhja1RUR3NPWVVpOG1m?=
 =?utf-8?B?Y1pHK0ZWYXhHOUoxVkVzdTZ0NDNvQ0cwZEhpZ1h4Y0c0VHlxRG9kR0o2c3dh?=
 =?utf-8?B?YVZaZlRXc0lmbU5PUFVaNFptMXpYSTJaUEkyUnZtUzJYSzdCRFc5M1dXVEJx?=
 =?utf-8?B?QWUrYVo5N01Ga25wYU1sU3o5U3pVM3A5ZFRJZnExMXVuREZ3eWNvcDZINWRw?=
 =?utf-8?B?ekV0cll6OW1ja2d5d1I5WFRRc3pOYjBpcXo4YmVpcHFEQndpa2pnRzV1cTdk?=
 =?utf-8?B?aGJNTENDcy9mVlNOTWNWck5yRTVDQStuaWt5bmU4N3QzRk5TKzRIV3A2dS9T?=
 =?utf-8?B?NVpCU0ZxSm9CVnFjalNYUGdocFBkbEVYMGhtZ0ZOZ1BZUlA5TEhSbHp3OFVQ?=
 =?utf-8?B?S0NmS3JzbFdsV3ZYazRkNVBDL1dBV1pwTFM3WEprQlN4SzRIYnRnQWxnNFlK?=
 =?utf-8?B?OHpWSjUwWW5Mbks3amtBd3l6US9VSVhEMWx1RytNMWtZNmFrQlVPTkYzUmRB?=
 =?utf-8?B?dy9kZlNndE5TTnluZlJCcFpoK0dXL1BkUmN4dWxUM3dmSllURFBtVE5EU3NV?=
 =?utf-8?B?bTJmMHVmL1RNZ21NczVlYUlITHRPRk5PdElNVThFckVvKzJ4eHRsUW54M0Fx?=
 =?utf-8?B?N05qQzdRNTl4YkVkL2RqOFhYMUM2TUx6QTEvcG95ZU5iVHlMY1BaajhNeDNF?=
 =?utf-8?B?M3RONWFHMGVyYkg4TkxrQmtBdUMwckgvTnJOeFAwMllkbC80ZmU4Rjg2NWw2?=
 =?utf-8?B?WmNOaGNNeDdybFQ0bEV2bFkxaEFob2JRYkFVRVlZaEdYeEtmdkNsRjhBbzhu?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d82681f-a064-447e-ff7c-08dd1081b95e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 14:25:50.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQU9VkB+2ttfYLzaEikoylktfXhdTHPk9HVRjZkPIgZpzcXaUb5FqF059EcXDj6ctOmuAW54EoEMTFiuAXmAOOxAeEWFf6C/V0adk+YzWVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add S32G2/S32G3 SoCs compatible strings.

A particularity for these SoCs is the presence of separate interrupts for
state change, bus errors, MBs 0-7 and MBs 8-127 respectively.

Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
same restriction for other SoCs.

Also, as part of this commit, move the 'allOf' after the required
properties to make the documentation easier to read.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 97dd1a7c5ed2..10b658e85ef2 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -10,9 +10,6 @@ title:
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -28,6 +25,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - nxp,s32g2-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -43,12 +41,21 @@ properties:
           - enum:
               - fsl,ls1028ar1-flexcan
           - const: fsl,lx2160ar1-flexcan
+      - items:
+          - enum:
+              - nxp,s32g3-flexcan
+          - const: nxp,s32g2-flexcan
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 4
 
   clocks:
     maxItems: 2
@@ -136,6 +143,37 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO
+            - description: Device state change
+            - description: Error detection
+            - description: Message Buffer interrupt for mailboxes 8-127
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: state
+            - const: berr
+            - const: mb-1
+      required:
+        - compatible
+        - reg
+        - interrupts
+        - interrupt-names
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.45.2


