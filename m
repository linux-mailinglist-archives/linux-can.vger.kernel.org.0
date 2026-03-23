Return-Path: <linux-can+bounces-7226-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDbECdVMwWlbSAQAu9opvQ
	(envelope-from <linux-can+bounces-7226-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:23:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED82F4595
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7714E30774DD
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264A3B3BFF;
	Mon, 23 Mar 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JVYAfWNh"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78A3AF643;
	Mon, 23 Mar 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274326; cv=fail; b=fFasLs8/pWt1IJMkOaASbzGuyk0HhgMwoGecmdj0AJB3iY0D3n4/hEs+Huh7ytJ/CknRBlfCAMdW8TARdjsBoxWUhes3ZG6+yJNu/7dFrdZTFF40rEtgvqRTPE6u9PiOZgAMkK+wQISICYfXBVOw9CkEd0I25E5w9pTUmezP06w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274326; c=relaxed/simple;
	bh=AmkQXFLaAgioZXQr+kr0ifiAPUfa04f++MCQqAML8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t9455Veq/XkFN0nFarQSVJVVZetnfVco+z1er0V1FjfgXgz8/LWMBrlE2b0H8gjh6npzSvzbCazUgh3q8Lx1s5R0rKcvYSuaSlqoUhqZICf6TXRUs64ojKlkVz48oiNemUgEaeKNP/RMwaYug5PCE43Nlx2xRlpJCblBrdCXccI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JVYAfWNh; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCZFFvszgtWYqxMZmi7klQ+MdzLVzGoXUTkfb6yRc3R3DzX6NE/xs6meHepWNbOjiMg9ZwbvjFtvZxGpJgj5R471DeLgrUpyCartISZL+O/QOLigdwM2DWP9BBqub8TJ61di48qLjrQ7MhuYeL7cG4zCKrswmvb/gTO1kQZrQbhcW8Xp2YpGbZVzSNNwLr1KH2SraMEswW0Sg+dGrBCq2+Xh0eS896Qq304HnuKQ2UAzgCaDQJmDZIOQUMjFJm/n412HSvlPir+ECILA3Ht3Y5MxDLdVbxkv3khCUxD+0lDfe2YK+EMnAYuhqYO6hvzlhdcv+Qsl+v4YkD9X7MA2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=Rxm5U0ugNzP4NPc5MP5RFrUDS+n0NPpBCfP+w867qEhJAK9unkdM8xRoDQqyLhdmQ0UE5Z7J4X+xCGu+WhS3xwIIhqEkyHWiA86Dc36Zge+lVaMeH27ifB4hiZFK6pEGbGQeN/ubOI/gpOWfeybz9ANUeCrF+tblMeE0Wqi0wqJO41RGzK1m92sPjMjQw2p0mi3p4KGIBd1ywjXjbdrNXkmZdygm7MNGDqLJZRBAzgjTL5BZFaaEnmeUTx++h2Nc+xn09pd2nlK/4VvEWeJB/boR/dZ9WQpUxBJ0a1AA5iVYLaFlJkIXW2X5U0dohk6tXMvvUc+hoXJV2QIseCj0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=JVYAfWNhZoJ7ba5wIw0bUYdiaSI+A+hwQZhdkOtNLw0xGe7GzYvfrkwx9zOwYDR+g3iQrr57ZMoqU8t4/IwXKf39DviLknSffy3nnE6yPloD8dNtYu4l23ELfelVn4KosO3Cdyj2zPZKnfCNvPPmHxrUnfiwW1Kv/8hfhr0nRuY4HvBBgZx49qwT3Da24QZzUaLcfYa9nFBAVRCKd3DcsaWrznt/zsTdaPOASo1+v1B1GMk+PpVVwNTgX5SDJHf/1Uhn9uEPAN36JidKYajh6OCrt7Cf/zwGRjO2jgShZF+R6dVNmFpy1XGog2Mg6zJ3OzjWBrLERrngc8ozfZr2gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:58:30 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:58:29 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH v3 5/6] arm64: dts: s32n79: add FlexCAN nodes
Date: Mon, 23 Mar 2026 14:58:26 +0100
Message-ID: <20260323135827.2129371-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0055.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: ffc5a9f4-b52b-451e-67c2-08de88e44316
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9diPwgpnAfAzkjYAr+X+D6fjNWo+7lQQMLSARs7cm0xIPnQCDBTtpmNjghS9RVIktwTSjkOWW8O6NQmPFfMwPq0AMpEGhq8PjErP9MZnnOqkGD5lQpm4kfAbnbvgHNC+AfTv4d1g3embkdzzGiZ2vS2HbAJursQOY/CfhsEv7slLEG7LbIBgU98vu3DtlYee75rRwcnYYqK3S8v3ZwZ5jHFWno7iSoSVqn88kV72Ob5sMV3uvm95IAZTff4UPxW9t/ASnEJ35u6ZnjgfFgDTGmIoVOa18U0sDLEZqCWt2PAsMPMmAICiK9wZvhLRvjjvD/ai2UtMSJ5DIpEsyRmrQoWGMdIi7ilnsBIKk1XAXMlK+1i9BAkiS8yOhdJqbA9cntNjAhAIkojZkUE2jKTdk490Wbonhqnpg+Vy9ic9DEYP14A1Pe/nmVyIwYUq2Sffak6uJZGSGovoN6SIcBst+gron8MAoud18eEQojOPfwftjHKhe/B6sy2TOd5jrQ22tp7XZppUPX71KZaIHXcMkswkqkjSQBNtCrt4SnQzaz9B9yV4xmpZJcoC9ApF+q+JO4vDbqy8YsE10FNfPl72v05pgOK0zxBXgt94Ej3dT5p/rJ1jjvBxPlHThVXL9cgkkKdnSiJHej2gjYWwYatel+B9TYH5vbfSItigqUjEkOXvxkhWde5ahgeeW6VCvCPpCsJmU2kVH3GVXO7b8yV2SQHTzwPlJM3NGL/DQZbghRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE5xdnppQU1ySWFaRU5IT29JZjZ0T0p6VWI4Q2t1QUowa1pLejQ5cE1kTkdI?=
 =?utf-8?B?SmpoUTd0WURIckFSUmtMdy9RWDVxS2VYTDRocnBJczR6c0phV3phOWFDWkU0?=
 =?utf-8?B?ZUd1RytFN2l3cHltQkVTYmFPN0M1U2Y4dEJwTHpMZkp3dlZmN1IrZFQ3NUNP?=
 =?utf-8?B?UjU4T1V2VUVwTXVaSHlsM0V1Vk52diswYjhrQUJIcE5WSGNWdG5oSGUybklE?=
 =?utf-8?B?RmphUHJOa0pMSEhTOWQranJUa2wxQWxtTjhsbm5PR0t5R2laRHJpNUpWS0dG?=
 =?utf-8?B?WERVTDBDMlplL2hvN1NxRDdlR01Ja2g4VWxMUFFMWnkrTXZlVFpVbHhXNUN0?=
 =?utf-8?B?V0Q5V1dqdHNpL0tZNnE3MHJGanRValYzT0RoVUUwT0NEdTZMeE5oYTh1ZFJl?=
 =?utf-8?B?eWFobkJXY1pLNW4veDh3akYzR3NzaU11Rk4zdXN2NS9MemxmQ0p1anFvVDNq?=
 =?utf-8?B?V3pYR3Qwa3Y3b29IMDMwRWhqWXI1WTZkS1hmSWdnYzVyNzlFbmVrSU5uVzdE?=
 =?utf-8?B?V1hielBBY0ExQ0ZPeWVkWVlIa0Z2WXJzUEJsSTNyd0IvVzR2UnlkaXFMVHkz?=
 =?utf-8?B?WjRjQ1ozQWJRN04vWmd2VWd1VEV4cFdyeHdkRDZKb0kwcDhNTXNkTFUvaHVF?=
 =?utf-8?B?eEJVQUJESXJFS2pCOE1ibmlUWGxrT3dDM1Axd0llRndrenpCUE9pZWlicUlJ?=
 =?utf-8?B?cjVSeDB5VXZ0UVZCN0daenRwcTlQKzdRNGRaSWZhVktxQ1JrRzJyZHhrSDhi?=
 =?utf-8?B?QUxrcGNCcE82bkU1ZkJ6dzl1V1IvZ1pkdzdyTDBxOEdwVkE1REJIbEZVNkJH?=
 =?utf-8?B?c0svYksxNWJ2b3ppV0c1eUNLVmdhOEVuNVRLa09xZDFBRFJqQ21FYnlyYndF?=
 =?utf-8?B?LzdhNmpBU0NnczBCLzZjTzB5S2NvenMvYnJzT1dsdW1qV0NGWTdKa1VuazZp?=
 =?utf-8?B?c21JQXVXNXQyRU5iQ1JLTEhZQkluR1hSVS9TbHJ6bDN1RU12ankrTmFIZjNl?=
 =?utf-8?B?QmE1dEpHTWFzZ3BWTTZWT3pSQ2V0ZUVDZ0FQUXFZM2ZTaGxJN2dFTHZPYWFI?=
 =?utf-8?B?K25JaW9hOEp2UGZJN3J3aEQwMFlzK3kyNU01dkdvZUNXeFdQMHNvOGtnT0cw?=
 =?utf-8?B?eGREbmpOMGNQT2E2eGxLMGRndjhSOXRqdXZxYWdyTGZCUi9tajRQZ2dyMUhQ?=
 =?utf-8?B?NUgvcG1zZkkxZ29sL3RRaGJtSnUrOFZNL1JmQmZKRWdEQjQwbTluR1NIZVpK?=
 =?utf-8?B?THBVRDVvVjlDdnhmMXBwSFdrb2U4Y2tHeVhXNERsVGZVcTZyVk5DYmlicnly?=
 =?utf-8?B?OGpXb09lTFZRRXZYSk03VEVrRUFFb29NM3Y1ZmpPTkpJNnczcUtwTEFBMDcy?=
 =?utf-8?B?dXh4bUNwUm9WNVBNZnluYzNsTTdVWWVyZHhMcVl0YU9ENFQrNmhranA0bDRN?=
 =?utf-8?B?Qk5WMmxRNjdGdXRLTVZieTlvVUlpdElaWDlscXdLSGd0OWE3Nlo5RnJZbkty?=
 =?utf-8?B?WEtET1RmY3NJRFFIcXJrMkIvNWVzZ3UrNzMyVkhLWnBydWM2WnI3dFMrUHVy?=
 =?utf-8?B?RWRYdGg4MHUrcWZ0QUZBYnpMTllXR2xKMnUyUVpOV2ZhMXRmRmsxY2x5MFJB?=
 =?utf-8?B?OFZMYkpCS3NxeDJVc1lUQUdvYXV1RW5lc295NExra2hrYnE2MmRBc3l6WXFQ?=
 =?utf-8?B?M25EZGg2Y1BBVEVtcWtZQkhDMHBOeVMwNmRWaXlTNTlFcjVKbjZ2WHQzWDN5?=
 =?utf-8?B?Z3NydXZnd21EQTB5M3JUdnFCRitvcDJ0ZTFpNTdEWDVGWlhaeXY4RSt2QnFp?=
 =?utf-8?B?T3RVQUNET3ZtcERXdXArVDJtOThjNUhhanlPclV0Lzd6ZjFQR3dKN3ZLYWxs?=
 =?utf-8?B?QWcxRU5mU2pUR3hKOUxHWHMzUys3aC9qSUZHNVAraWZQY0NaLzZud0NrK3ZU?=
 =?utf-8?B?eGhuNWFTNFpGeHZJS3ZJdVprOXJ2Y0ZMRWo2VkNRNndicGJ0YkhiMmdvNHpQ?=
 =?utf-8?B?eVBJQVZaSkwzR3FuanZSaXR0VE1mVVRvVEwxRSt3RGpMQlUrS2VkTzB1QS9M?=
 =?utf-8?B?TUJrM0J1TnB2c012cGxsYklGdHFNSXpFRmtpTEpNckpxZlE5YWtwSDNlOUxP?=
 =?utf-8?B?OW53MDFaR295cWRKTmhxTEI3enJiSGVLVGV2azBEQXdvRGZmUEZkdmkwL3FF?=
 =?utf-8?B?L3Fvc2ZjSjBPa3lNbzRDY1Q4ZElkSDhZT3FaYU16eGhqRDRBYWFSR3diclYv?=
 =?utf-8?B?T1JLdW5ITCtiM2MyQUZIblh6SE1rQUpVMkVublA3K0VQMGRmMFVtWjdHN0ZK?=
 =?utf-8?B?SUNQak5QemRLME9nMCszSlB6MU16MGN0OGhJTFRlR3REeUpIY0RpL2Nod0ov?=
 =?utf-8?Q?y2Ph7eoRs9WxzKDU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc5a9f4-b52b-451e-67c2-08de88e44316
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:58:29.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijGpJyn4+Do3x3gQLbOxgeLEPK8Jk0h4dfC4JmUfwyRojfBs/6QABClJLHcIfKXEUr13EEk5Xcuj1Lp7nTfNSX2R+kYguqYshrnByvvRrQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7226-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[3.72.198.72:email];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,55b70000:email,nxp.com:email,55b60000:email]
X-Rspamd-Queue-Id: 89ED82F4595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The S32N79 integrates multiple FlexCAN instances connected through the RCU
irqsteer interrupt controller.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..c1a4fdead91d 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -352,6 +352,56 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rcu-bus {
+		compatible = "simple-bus";
+		ranges = <0x54000000 0x0 0x54000000 0x4000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		irqsteer_rcu: interrupt-controller@55101000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x55101000 0x1000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0xf9>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+
+		can0: can@55b60000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b60000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <0>, <64>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@55b70000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b70000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <1>, <65>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0


